using System;
using System.Collections.Generic;
using System.Threading;
using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// Spawns a <see cref="StreamedPlacementSet"/> over many frames instead of in the scene's load
    /// frame. Unity integrates instantiated objects on the main thread with a per-frame time budget
    /// (<see cref="AsyncInstantiateOperation.SetIntegrationTimeMS"/>), but only slices *between*
    /// instantiated roots — one prefab with 70,000 objects is one indivisible unit — which is why the
    /// baker splits the authored groups into tens of thousands of small items in the first place.
    /// <para>
    /// Items go in nearest-first from <see cref="m_priorityOrigin"/> in distance rings, so what the
    /// player can see through the greenhouse windows fills before the far side of the map. Items with
    /// colliders wait for their collision meshes to be cooked on worker threads first: cooking a
    /// convex hull for a 100k-vertex root cluster on the main thread is a multi-second stall.
    /// </para>
    /// <para>
    /// Registers as <see cref="IDeferredContent"/>: behind a loading cover the scene loader lets it
    /// use most of the frame; in front of the player it stays under the live budget.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public sealed class StreamedPlacementSpawner : MonoBehaviour, IDeferredContent
    {
        [SerializeField] private StreamedPlacementSet m_set;

        [Tooltip("Root the set's group parent paths are resolved under — the authored Prefab World "
            + "Builder root, so the runtime hierarchy mirrors the authored one.")]
        [SerializeField] private Transform m_groupRoot;

        [Tooltip("Integration budget per frame while the player is looking, in milliseconds.")]
        [Min(0.1f)]
        [SerializeField] private float m_liveBudgetMs = 2.5f;

        [Tooltip("Integration budget per frame while a loading cover is up, in milliseconds.")]
        [Min(1f)]
        [SerializeField] private float m_coveredBudgetMs = 40f;

        [Tooltip("Items per instantiate operation. Each operation's results are finalized (scale "
            + "applied) in one frame once it completes, so this bounds that frame's cost too.")]
        [Range(16, 2048)]
        [SerializeField] private int m_batchSize = 256;

        [Tooltip("Instantiate operations kept in flight at once.")]
        [Range(1, 8)]
        [SerializeField] private int m_maxInFlight = 2;

        [Tooltip("World position items are ordered by distance from — put it where the player first "
            + "sees this content (for the exterior, the greenhouse exit).")]
        [SerializeField] private Vector3 m_priorityOrigin;

        [Tooltip("Width of one distance ring, in meters. Within a ring, items are grouped by prototype "
            + "so each ring spawns as a handful of batched operations rather than thousands.")]
        [Min(1f)]
        [SerializeField] private float m_priorityRingMeters = 25f;

        private struct Batch
        {
            public int Prototype;
            public int Group;
            public int Start;
            public int Count;
        }

        private struct InFlight
        {
            public AsyncInstantiateOperation<GameObject> Operation;
            public Batch Batch;
        }

        /// <summary>Item indices in spawn order; batches index into this, not into the set.</summary>
        private int[] m_order;
        private Transform[] m_groupParents;
        private int m_spawned;
        private bool m_covered;
        private float m_appliedBudget = -1f;

        private CollisionPrebakeJob m_bake;

        public bool IsComplete { get; private set; }

        public float Progress => m_set == null || m_set.ItemCount == 0 ? 1f : (float)m_spawned / m_set.ItemCount;

        public void SetCovered(bool covered)
        {
            m_covered = covered;
        }

        private void Start()
        {
            if (m_set == null || m_set.ItemCount == 0)
            {
                IsComplete = true;
                return;
            }

            if (m_groupRoot == null)
            {
                m_groupRoot = transform.parent != null ? transform.parent : transform;
            }

            DeferredContent.Register(this);
            RunEntryAsync(destroyCancellationToken);
        }

        private void OnDestroy()
        {
            DeferredContent.Unregister(this);
            FinishBakeJob();
        }

        private async void RunEntryAsync(CancellationToken cancellationToken)
        {
            try
            {
                await RunAsync(cancellationToken);
            }
            catch (OperationCanceledException)
            {
                // Scene unloaded or Play mode ended mid-spawn: nothing to finish.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
        }

        private async Awaitable RunAsync(CancellationToken cancellationToken)
        {
            ScheduleBakeJob();
            ResolveGroupParents();

            List<Batch> live = new List<Batch>();
            List<Batch> physical = new List<Batch>();
            BuildPlan(live, physical);

            await SpawnAsync(live, cancellationToken);

            // Colliders create their PhysX shapes on instantiation, which uses the cooked mesh if one is
            // cached and cooks synchronously if not — so nothing with a collider goes in before the job
            // is done, however long the grass took.
            while (m_bake != null && !m_bake.IsCompleted)
            {
                await Awaitable.NextFrameAsync(cancellationToken);
            }

            FinishBakeJob();
            await SpawnAsync(physical, cancellationToken);

            IsComplete = true;
            Log.Info($"Streamed placement complete: {m_spawned}/{m_set.ItemCount} items from '{m_set.name}'.", this);
        }

        private void ScheduleBakeJob()
        {
            m_bake = CollisionPrebakeJob.Schedule(m_set.CollisionMeshes, m_set.CollisionConvex);
        }

        private void FinishBakeJob()
        {
            if (m_bake != null)
            {
                m_bake.Complete();
                m_bake = null;
            }
        }

        private void ResolveGroupParents()
        {
            string[] paths = m_set.GroupParentPaths;
            string[] names = m_set.GroupNames;
            m_groupParents = new Transform[paths.Length];

            for (int i = 0; i < paths.Length; i++)
            {
                Transform parent = string.IsNullOrEmpty(paths[i]) ? m_groupRoot : m_groupRoot.Find(paths[i]);

                if (parent == null)
                {
                    Log.Warning($"Streamed placement group parent '{paths[i]}' is missing under "
                        + $"'{m_groupRoot.name}'; spawning '{names[i]}' directly under the root.", this);
                    parent = m_groupRoot;
                }

                Transform group = parent.Find(names[i]);

                if (group == null)
                {
                    group = new GameObject(names[i]).transform;
                    group.SetParent(parent, false);
                }

                m_groupParents[i] = group;
            }
        }

        /// <summary>
        /// Orders items by (distance ring, prototype, group) and cuts that order into batches of one
        /// prototype and one group each, split into those spawnable now and those waiting on cooking.
        /// </summary>
        private void BuildPlan(List<Batch> live, List<Batch> physical)
        {
            int count = m_set.ItemCount;
            int[] prototypes = m_set.PrototypeIndices;
            int[] groups = m_set.GroupIndices;
            Vector3[] positions = m_set.Positions;
            StreamedPlacementSet.Prototype[] table = m_set.Prototypes;

            int[] ring = new int[count];
            float ringSize = Mathf.Max(1f, m_priorityRingMeters);

            for (int i = 0; i < count; i++)
            {
                ring[i] = (int)(Vector3.Distance(positions[i], m_priorityOrigin) / ringSize);
            }

            m_order = new int[count];

            for (int i = 0; i < count; i++)
            {
                m_order[i] = i;
            }

            Array.Sort(m_order, (a, b) =>
            {
                int c = ring[a].CompareTo(ring[b]);
                if (c != 0) return c;
                c = prototypes[a].CompareTo(prototypes[b]);
                if (c != 0) return c;
                return groups[a].CompareTo(groups[b]);
            });

            int start = 0;

            while (start < count)
            {
                int first = m_order[start];
                int end = start + 1;

                while (end < count && end - start < m_batchSize)
                {
                    int item = m_order[end];

                    if (ring[item] != ring[first] || prototypes[item] != prototypes[first] || groups[item] != groups[first])
                    {
                        break;
                    }

                    end++;
                }

                Batch batch = new Batch { Prototype = prototypes[first], Group = groups[first], Start = start, Count = end - start };
                bool needsCooking = table[batch.Prototype].HasColliders && m_bake != null;
                (needsCooking ? physical : live).Add(batch);
                start = end;
            }
        }

        private async Awaitable SpawnAsync(List<Batch> batches, CancellationToken cancellationToken)
        {
            List<InFlight> inFlight = new List<InFlight>(m_maxInFlight);
            int next = 0;

            while (next < batches.Count || inFlight.Count > 0)
            {
                ApplyBudget();

                while (inFlight.Count < m_maxInFlight && next < batches.Count)
                {
                    inFlight.Add(Begin(batches[next++], cancellationToken));
                }

                for (int i = inFlight.Count - 1; i >= 0; i--)
                {
                    if (inFlight[i].Operation.isDone)
                    {
                        Finish(inFlight[i]);
                        inFlight.RemoveAt(i);
                    }
                }

                await Awaitable.NextFrameAsync(cancellationToken);
            }
        }

        private InFlight Begin(Batch batch, CancellationToken cancellationToken)
        {
            Vector3[] positions = new Vector3[batch.Count];
            Quaternion[] rotations = new Quaternion[batch.Count];
            Vector3[] setPositions = m_set.Positions;
            Quaternion[] setRotations = m_set.Rotations;

            for (int i = 0; i < batch.Count; i++)
            {
                int item = m_order[batch.Start + i];
                positions[i] = setPositions[item];
                rotations[i] = setRotations[item];
            }

            InstantiateParameters parameters = new InstantiateParameters
            {
                parent = m_groupParents[batch.Group],
                worldSpace = true,
            };

            AsyncInstantiateOperation<GameObject> operation = UnityEngine.Object.InstantiateAsync(
                m_set.Prototypes[batch.Prototype].Prefab, batch.Count,
                new ReadOnlySpan<Vector3>(positions), new ReadOnlySpan<Quaternion>(rotations),
                parameters, cancellationToken);

            return new InFlight { Operation = operation, Batch = batch };
        }

        private void Finish(InFlight done)
        {
            GameObject[] result = done.Operation.Result;
            Vector3[] scales = m_set.Scales;

            if (result != null)
            {
                for (int i = 0; i < result.Length && i < done.Batch.Count; i++)
                {
                    if (result[i] != null)
                    {
                        result[i].transform.localScale = scales[m_order[done.Batch.Start + i]];
                    }
                }
            }

            m_spawned += done.Batch.Count;
        }

        private void ApplyBudget()
        {
            float budget = m_covered ? m_coveredBudgetMs : m_liveBudgetMs;

            if (!Mathf.Approximately(budget, m_appliedBudget))
            {
                AsyncInstantiateOperation.SetIntegrationTimeMS(budget);
                m_appliedBudget = budget;
            }
        }
    }
}

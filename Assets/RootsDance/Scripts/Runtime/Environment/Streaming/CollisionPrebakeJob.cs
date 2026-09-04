using System.Collections.Generic;
using Unity.Collections;
using Unity.Jobs;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// One scheduled run of <see cref="Physics.BakeMesh(int, bool)"/> over a list of meshes on the
    /// job system. Physics.BakeMesh is one of the few physics calls that is legal off the main
    /// thread, and the cooked data it caches is what a MeshCollider created afterwards picks up
    /// instead of cooking synchronously. Owns its native arrays; always <see cref="Complete"/> it.
    /// </summary>
    public sealed class CollisionPrebakeJob
    {
        private struct BakeJob : IJobParallelFor
        {
            [ReadOnly] public NativeArray<int> MeshIds;
            [ReadOnly] public NativeArray<bool> Convex;

            public void Execute(int index)
            {
                if (MeshIds[index] != 0)
                {
                    Physics.BakeMesh(MeshIds[index], Convex[index]);
                }
            }
        }

        private JobHandle m_handle;
        private NativeArray<int> m_meshIds;
        private NativeArray<bool> m_convex;
        private bool m_scheduled;

        public int Count { get; private set; }
        public bool IsCompleted => !m_scheduled || m_handle.IsCompleted;

        /// <summary>Schedules cooking for every mesh; returns null when there is nothing to cook.</summary>
        public static CollisionPrebakeJob Schedule(IReadOnlyList<Mesh> meshes, IReadOnlyList<bool> convex)
        {
            if (meshes == null || meshes.Count == 0)
            {
                return null;
            }

            CollisionPrebakeJob job = new CollisionPrebakeJob
            {
                m_meshIds = new NativeArray<int>(meshes.Count, Allocator.Persistent),
                m_convex = new NativeArray<bool>(meshes.Count, Allocator.Persistent),
                Count = meshes.Count,
            };

            for (int i = 0; i < meshes.Count; i++)
            {
                job.m_meshIds[i] = meshes[i] != null ? meshes[i].GetInstanceID() : 0;
                job.m_convex[i] = convex[i];
            }

            job.m_handle = new BakeJob { MeshIds = job.m_meshIds, Convex = job.m_convex }.Schedule(meshes.Count, 1);
            job.m_scheduled = true;
            return job;
        }

        public static CollisionPrebakeJob Schedule(CollisionPrebakeSet set)
        {
            return set == null ? null : Schedule(set.Meshes, set.Convex);
        }

        /// <summary>Blocks until the cooking is done (a no-op once it is) and frees the arrays.</summary>
        public void Complete()
        {
            if (!m_scheduled)
            {
                return;
            }

            m_handle.Complete();
            m_meshIds.Dispose();
            m_convex.Dispose();
            m_scheduled = false;
        }
    }
}

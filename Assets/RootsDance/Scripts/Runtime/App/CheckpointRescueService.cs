using System;
using System.Collections.Generic;
using System.Threading;
using RootsDance.Core;
using RootsDance.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.App
{
    /// <summary>Destructive session reset for test builds; no save data is written.</summary>
    [DisallowMultipleComponent]
    public sealed class CheckpointRescueService : MonoBehaviour, ICheckpointRescueService
    {
        [SerializeField] private GameBootstrap m_bootstrap;
        [SerializeField] private SceneLoader m_sceneLoader;
        [SerializeField] private RescueCheckpointCatalogSO m_catalog;
        [SerializeField] private MonoBehaviour[] m_participants;

        private RescueCheckpoint m_checkpoint;
        private ICheckpointSpawnTarget m_spawnTarget;
        private Transform m_anchor;
        private readonly List<MonoBehaviour> m_activeParticipants = new List<MonoBehaviour>();

        public RescueCheckpointCatalogSO Catalog => m_catalog;
        public bool IsBusy { get; private set; }
        public bool IsModalOpen { get; set; }
        public string CurrentLevelName => m_sceneLoader != null ? m_sceneLoader.CurrentLevelName : string.Empty;
        public string LastCheckpointId { get; private set; } = string.Empty;
        public string LastCheckpointLabel { get; private set; } = string.Empty;

        public event Action Changed;
        public event Action<string> Failed;

        private void Awake()
        {
            // The generated setup includes participants on Bootstrap's separate UI root too.
            if (m_participants == null || m_participants.Length == 0)
            {
                m_participants = GetComponentsInChildren<MonoBehaviour>(true);
            }
        }

        public bool TryValidate(RescueCheckpoint checkpoint, out string error)
        {
            if (m_bootstrap == null || m_sceneLoader == null || m_catalog == null)
            {
                error = "Checkpoint rescue services are not configured.";
                return false;
            }

            if (!m_catalog.EnabledInPlayer)
            {
                error = "Checkpoint rescue is disabled in this build.";
                return false;
            }

            if (IsBusy || m_sceneLoader.IsLoading)
            {
                error = "A scene change is already in progress.";
                return false;
            }

            if (checkpoint == null || checkpoint.Level == null || checkpoint.Level.ScenePaths == null
                || checkpoint.Level.ScenePaths.Count == 0)
            {
                error = "The checkpoint has no loadable level.";
                return false;
            }

            bool inCatalog = false;
            IReadOnlyList<RescueCheckpoint> checkpoints = m_catalog.Checkpoints;
            for (int i = 0; checkpoints != null && i < checkpoints.Count; i++)
            {
                if (checkpoints[i] == checkpoint)
                {
                    inCatalog = true;
                    break;
                }
            }

            if (!inCatalog)
            {
                error = "The checkpoint does not belong to this build's catalog.";
                return false;
            }

            IReadOnlyList<string> paths = checkpoint.Level.ScenePaths;
            var uniquePaths = new HashSet<string>(StringComparer.Ordinal);
            for (int i = 0; i < paths.Count; i++)
            {
                if (string.IsNullOrWhiteSpace(paths[i]) || paths[i] == ScenePaths.k_Bootstrap
                    || !uniquePaths.Add(paths[i]) || !Application.CanStreamedLevelBeLoaded(paths[i]))
                {
                    error = "Scene missing, duplicated, or excluded from the build: " + paths[i];
                    return false;
                }
            }

            error = null;
            return true;
        }

        public async Awaitable JumpAsync(RescueCheckpoint checkpoint, CancellationToken cancellationToken)
        {
            cancellationToken.ThrowIfCancellationRequested();
            if (!TryValidate(checkpoint, out string error))
            {
                throw new InvalidOperationException(error);
            }

            IsBusy = true;
            m_checkpoint = checkpoint;
            m_spawnTarget = null;
            m_anchor = null;
            float previousTimeScale = Time.timeScale;
            Time.timeScale = 0f;
            m_bootstrap.Commands.BeginReset();

            try
            {
                Changed?.Invoke();
                CollectParticipants();
                ResetPersistentServices();
                await m_sceneLoader.ReloadForRescueAsync(checkpoint.Level, RestoreSnapshot,
                    InitializeScene, FinishSpawn, cancellationToken);
                LastCheckpointId = checkpoint.Id;
                LastCheckpointLabel = checkpoint.Label;
            }
            catch (Exception exception)
            {
                Failed?.Invoke(exception.Message);
                throw;
            }
            finally
            {
                m_bootstrap.Commands.EndReset();
                Time.timeScale = previousTimeScale;
                IsBusy = false;
                m_checkpoint = null;
                m_spawnTarget = null;
                m_anchor = null;
                m_activeParticipants.Clear();
                Changed?.Invoke();
            }
        }

        private void CollectParticipants()
        {
            m_activeParticipants.Clear();
            for (int i = 0; i < m_participants.Length; i++)
            {
                AddParticipant(m_participants[i]);
            }

            // Dynamic inspectors can temporarily live under the persistent camera. Capture them
            // before any reset reparents objects or the outgoing scenes are unloaded.
            m_sceneLoader.CollectRescueParticipants(m_activeParticipants);
            MonoBehaviour[] ownRoot = GetComponentsInChildren<MonoBehaviour>(true);
            for (int i = 0; i < ownRoot.Length; i++)
            {
                AddParticipant(ownRoot[i]);
            }
        }

        private void AddParticipant(MonoBehaviour participant)
        {
            if (participant != null && !m_activeParticipants.Contains(participant)
                && (participant is IRescueResetParticipant || participant is IRescueStateRestoredParticipant))
            {
                m_activeParticipants.Add(participant);
            }
        }

        private void ResetPersistentServices()
        {
            for (int i = 0; i < m_activeParticipants.Count; i++)
            {
                if (m_activeParticipants[i] != null
                    && m_activeParticipants[i] is IRescueResetParticipant participant)
                {
                    participant.ResetForRescue();
                }
            }
        }

        private void RestoreSnapshot()
        {
            // Teardown may issue audio or dialogue callbacks; clear persistent services once more
            // after every outgoing scene has completed OnDisable/OnDestroy.
            ResetPersistentServices();
            var report = new List<ReportEntry>();
            var targets = m_checkpoint.RecordedTargets;
            for (int i = 0; targets != null && i < targets.Count; i++)
            {
                if (targets[i] != null)
                {
                    report.Add(targets[i].ToReportEntry());
                }
            }

            m_bootstrap.RestoreCheckpointSnapshot(m_checkpoint.Flags, report,
                m_checkpoint.OverrideTimeOfDay, m_checkpoint.TimeOfDay);
            m_bootstrap.Commands.EndReset();

            for (int i = 0; i < m_activeParticipants.Count; i++)
            {
                if (m_activeParticipants[i] != null
                    && m_activeParticipants[i] is IRescueStateRestoredParticipant participant)
                {
                    participant.RestoreAfterRescue(m_checkpoint);
                }
            }
        }

        private void InitializeScene(Scene scene)
        {
            GameObject[] roots = scene.GetRootGameObjects();
            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == "_Anchors" && !string.IsNullOrEmpty(m_checkpoint.AnchorName))
                {
                    Transform anchor = roots[i].transform.Find(m_checkpoint.AnchorName);
                    if (anchor != null)
                    {
                        m_anchor = anchor;
                    }
                }

                MonoBehaviour[] behaviours = roots[i].GetComponentsInChildren<MonoBehaviour>();
                for (int j = 0; j < behaviours.Length; j++)
                {
                    if (behaviours[j] is ICheckpointSpawnTarget spawnTarget)
                    {
                        if (m_spawnTarget != null && m_spawnTarget != spawnTarget)
                        {
                            throw new InvalidOperationException("Multiple checkpoint players found in the level.");
                        }

                        m_spawnTarget = spawnTarget;
                    }
                }
            }

            if (m_spawnTarget != null)
            {
                ApplySpawn();
            }
        }

        private void FinishSpawn()
        {
            if (m_spawnTarget == null || m_spawnTarget.SpawnTransform == null)
            {
                throw new InvalidOperationException("The loaded level contains no checkpoint-compatible player.");
            }

            ApplySpawn();
        }

        private void ApplySpawn()
        {
            Vector3 position = m_checkpoint.Position;
            if (m_anchor != null)
            {
                position.x = m_anchor.position.x;
                position.z = m_anchor.position.z;
                if (m_checkpoint.UseAnchorHeight)
                {
                    position.y = m_anchor.position.y;
                }
            }

            Physics.SyncTransforms();
            if (m_checkpoint.SnapToGround)
            {
                RaycastHit[] hits = Physics.RaycastAll(position + Vector3.up * 50f, Vector3.down, 200f,
                    m_checkpoint.GroundLayers, QueryTriggerInteraction.Ignore);
                float highest = float.NegativeInfinity;
                for (int i = 0; i < hits.Length; i++)
                {
                    if (!hits[i].collider.transform.IsChildOf(m_spawnTarget.SpawnTransform))
                    {
                        highest = Mathf.Max(highest, hits[i].point.y);
                    }
                }

                if (!float.IsNegativeInfinity(highest))
                {
                    position.y = highest + m_checkpoint.GroundClearance;
                }
            }

            m_spawnTarget.ApplyCheckpoint(position, m_checkpoint.Yaw);
        }
    }
}

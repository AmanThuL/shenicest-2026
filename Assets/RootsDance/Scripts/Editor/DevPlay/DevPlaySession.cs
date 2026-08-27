using System.Collections.Generic;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Investigation;
using RootsDance.Player;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.DevPlay
{
    /// <summary>
    /// Starts Play from a <see cref="DevCheckpointSO"/>: opens the level's scenes, enters Play, and on
    /// the first frame the bootstrap and the Player exist, teleports the Player and seeds the world
    /// state through the command queue — the same path trigger volumes use, so nothing here bypasses
    /// the ground truth. Editor only; the pending checkpoint survives the Play-entry domain reload
    /// via <see cref="SessionState"/>.
    /// </summary>
    [InitializeOnLoad]
    public static class DevPlaySession
    {
        private const string k_PendingKey = "RootsDance.DevPlay.PendingCheckpointPath";
        private const string k_AnchorRootName = "_Anchors";
        private const float k_ReadyTimeoutSeconds = 20f;
        private const float k_GroundProbeHeight = 50f;
        private const float k_GroundProbeDistance = 200f;

        private static DevCheckpointSO s_pending;
        private static double s_waitStart;

        static DevPlaySession()
        {
            EditorApplication.playModeStateChanged += OnPlayModeStateChanged;
        }

        /// <summary>The checkpoint waiting to be applied once Play is ready, or null.</summary>
        public static DevCheckpointSO Pending => s_pending;

        /// <summary>True when every scene of the level is loaded in the Editor (extra scenes are fine).</summary>
        public static bool AreLevelScenesLoaded(LevelSO level)
        {
            if (level == null || level.ScenePaths == null)
            {
                return false;
            }

            for (int i = 0; i < level.ScenePaths.Count; i++)
            {
                if (!SceneManager.GetSceneByPath(level.ScenePaths[i]).isLoaded)
                {
                    return false;
                }
            }

            return true;
        }

        /// <summary>
        /// Opens the level's scenes (first one Single, the rest Additive) unless they are already
        /// loaded. Returns false when the user cancels the save prompt for dirty scenes.
        /// </summary>
        public static bool OpenLevelScenes(LevelSO level)
        {
            if (level == null || level.ScenePaths == null || level.ScenePaths.Count == 0)
            {
                Debug.LogError("Dev Play: the checkpoint has no level, or the level lists no scenes.");
                return false;
            }

            if (AreLevelScenesLoaded(level))
            {
                return true;
            }

            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                return false;
            }

            EditorSceneManager.OpenScene(level.ScenePaths[0], OpenSceneMode.Single);

            for (int i = 1; i < level.ScenePaths.Count; i++)
            {
                EditorSceneManager.OpenScene(level.ScenePaths[i], OpenSceneMode.Additive);
            }

            return true;
        }

        /// <summary>
        /// In Edit mode: open the scenes and enter Play, applying the checkpoint once ready.
        /// In Play mode: apply it right now (teleport + seed) without restarting.
        /// </summary>
        public static void PlayFrom(DevCheckpointSO checkpoint)
        {
            if (checkpoint == null)
            {
                return;
            }

            if (EditorApplication.isPlaying)
            {
                string failure;

                if (!TryApply(checkpoint, out failure))
                {
                    Debug.LogError("Dev Play: could not apply '" + checkpoint.Label + "': " + failure);
                }

                return;
            }

            // Read everything off the asset first: opening a scene Single unloads unreferenced
            // assets, after which this reference answers an empty path (observed 2026-08-27).
            string checkpointPath = AssetDatabase.GetAssetPath(checkpoint);
            LevelSO level = checkpoint.Level;

            if (string.IsNullOrEmpty(checkpointPath))
            {
                Debug.LogError("Dev Play: the checkpoint must be a saved asset.");
                return;
            }

            if (!OpenLevelScenes(level))
            {
                return;
            }

            SessionState.SetString(k_PendingKey, checkpointPath);

            // Entering Play in the same tick as OpenScene(Single) starts Play but skips the pending
            // checkpoint (observed 2026-08-27); one update tick later it applies reliably. Not
            // delayCall: that waits for a GUI event and never fires while the Editor is unfocused.
            EditorApplication.update += EnterPlayNextTick;
        }

        private static void EnterPlayNextTick()
        {
            EditorApplication.update -= EnterPlayNextTick;
            EditorApplication.EnterPlaymode();
        }

        private static void OnPlayModeStateChanged(PlayModeStateChange change)
        {
            if (change == PlayModeStateChange.EnteredPlayMode)
            {
                string path = SessionState.GetString(k_PendingKey, string.Empty);

                if (string.IsNullOrEmpty(path))
                {
                    return;
                }

                s_pending = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(path);

                if (s_pending == null)
                {
                    Debug.LogError("Dev Play: pending checkpoint '" + path + "' could not be loaded.");
                    ClearPending();
                    return;
                }

                s_waitStart = EditorApplication.timeSinceStartup;
                EditorApplication.update += WaitForReady;
                return;
            }

            if (change == PlayModeStateChange.ExitingPlayMode || change == PlayModeStateChange.EnteredEditMode)
            {
                ClearPending();
            }
        }

        private static void WaitForReady()
        {
            if (s_pending == null || !EditorApplication.isPlaying)
            {
                Debug.LogWarning("Dev Play: Play ended before the checkpoint could be applied.");
                ClearPending();
                return;
            }

            string failure;

            if (TryApply(s_pending, out failure))
            {
                Debug.Log("Dev Play: started from '" + s_pending.Label + "'.");
                ClearPending();
                return;
            }

            if (EditorApplication.timeSinceStartup - s_waitStart > k_ReadyTimeoutSeconds)
            {
                Debug.LogError("Dev Play: gave up applying '" + s_pending.Label + "': " + failure);
                ClearPending();
            }
        }

        private static void ClearPending()
        {
            EditorApplication.update -= WaitForReady;
            SessionState.EraseString(k_PendingKey);
            s_pending = null;
        }

        /// <summary>
        /// Teleports the Player and seeds the world state. False (with a reason) while Play is not ready.
        /// </summary>
        private static bool TryApply(DevCheckpointSO checkpoint, out string failure)
        {
            GameBootstrap bootstrap = GameBootstrap.Instance;

            if (bootstrap == null)
            {
                failure = "GameBootstrap is not loaded yet.";
                return false;
            }

            FirstPersonController player = Object.FindFirstObjectByType<FirstPersonController>();

            if (player == null)
            {
                failure = "no FirstPersonController in the loaded scenes.";
                return false;
            }

            Vector3 basePosition = checkpoint.Position;
            Transform anchor = FindAnchor(checkpoint.AnchorName);

            if (anchor != null)
            {
                basePosition = anchor.position;
            }
            else if (!string.IsNullOrEmpty(checkpoint.AnchorName))
            {
                Debug.LogWarning("Dev Play: anchor '" + checkpoint.AnchorName + "' not found under "
                    + k_AnchorRootName + "; using the checkpoint's Position instead.");
            }

            float groundY = 0f;
            bool groundFound = checkpoint.SnapToGround && TryFindGround(basePosition, player.transform, out groundY);

            Vector3 position = DevCheckpointSeed.ResolvePosition(
                basePosition, groundFound, groundY, checkpoint.GroundClearance);

            Teleport(player, position, checkpoint.Yaw);

            List<ReportEntry> entries = new List<ReportEntry>();
            IReadOnlyList<InvestigationTargetSO> targets = checkpoint.RecordedTargets;

            for (int i = 0; i < targets.Count; i++)
            {
                if (targets[i] != null)
                {
                    entries.Add(targets[i].ToReportEntry());
                }
            }

            List<IWorldCommand> commands = DevCheckpointSeed.BuildCommands(checkpoint.Flags, entries);

            for (int i = 0; i < commands.Count; i++)
            {
                bootstrap.Commands.Enqueue(commands[i]);
            }

            failure = null;
            return true;
        }

        private static void Teleport(FirstPersonController player, Vector3 position, float yaw)
        {
            // CharacterController.Move fights transform writes while it is enabled.
            CharacterController controller = player.GetComponent<CharacterController>();
            bool wasEnabled = controller != null && controller.enabled;

            if (wasEnabled)
            {
                controller.enabled = false;
            }

            player.transform.SetPositionAndRotation(position, Quaternion.Euler(0f, yaw, 0f));

            if (wasEnabled)
            {
                controller.enabled = true;
            }

            Physics.SyncTransforms();
        }

        private static Transform FindAnchor(string anchorName)
        {
            if (string.IsNullOrEmpty(anchorName))
            {
                return null;
            }

            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (!scene.isLoaded)
                {
                    continue;
                }

                GameObject[] roots = scene.GetRootGameObjects();

                for (int j = 0; j < roots.Length; j++)
                {
                    if (roots[j].name != k_AnchorRootName)
                    {
                        continue;
                    }

                    Transform anchor = roots[j].transform.Find(anchorName);

                    if (anchor != null)
                    {
                        return anchor;
                    }
                }
            }

            return null;
        }

        /// <summary>Highest solid surface under the target, ignoring triggers and the Player's own colliders.</summary>
        private static bool TryFindGround(Vector3 basePosition, Transform player, out float groundY)
        {
            Vector3 origin = basePosition + Vector3.up * k_GroundProbeHeight;
            RaycastHit[] hits = Physics.RaycastAll(
                origin, Vector3.down, k_GroundProbeDistance, Physics.AllLayers, QueryTriggerInteraction.Ignore);
            bool found = false;
            groundY = float.MinValue;

            for (int i = 0; i < hits.Length; i++)
            {
                if (hits[i].collider.transform.IsChildOf(player))
                {
                    continue;
                }

                if (hits[i].point.y > groundY)
                {
                    groundY = hits[i].point.y;
                    found = true;
                }
            }

            return found;
        }
    }
}

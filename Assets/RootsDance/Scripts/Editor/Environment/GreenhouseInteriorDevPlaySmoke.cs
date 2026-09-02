using System;
using System.IO;
using RootsDance.App;
using RootsDance.Editor.DevPlay;
using RootsDance.Player;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>Command-line Play smoke for Chapter 03 to Briggs and back through Dev Play.</summary>
    [InitializeOnLoad]
    public static class GreenhouseInteriorDevPlaySmoke
    {
        private const string k_ActiveKey = "RootsDance.GreenhouseInteriorSmoke.Active";
        private const string k_StageKey = "RootsDance.GreenhouseInteriorSmoke.Stage";
        private const string k_StartedTicksKey = "RootsDance.GreenhouseInteriorSmoke.StartedTicks";
        private const string k_EntranceCheckpointPath =
            "Assets/RootsDance/Data/DevPlay/GreenhouseInterior/03-01_GreenhouseEntrance.asset";
        private const string k_CentralCheckpointPath =
            "Assets/RootsDance/Data/DevPlay/GreenhouseInterior/03-02_CentralGreenhouse.asset";
        private const string k_BriggsCheckpointPath =
            "Assets/RootsDance/Data/DevPlay/BriggsInterior/02-01_PlantResearchLab.asset";
        private const string k_BriggsEnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment.unity";
        private const string k_BriggsGameplayPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";
        private const string k_InteriorScreenshotPath = "Logs/Chapter03/GreenhouseInterior.png";
        private const string k_OverviewScreenshotPath = "Logs/Chapter03/GreenhouseInteriorOverview.png";
        private const double k_TimeoutSeconds = 90d;

        private static bool s_isTicking;

        static GreenhouseInteriorDevPlaySmoke()
        {
            if (SessionState.GetBool(k_ActiveKey, false))
            {
                RegisterTick();
            }
        }

        public static void RunFromCommandLine()
        {
            SessionState.SetBool(k_ActiveKey, true);
            SessionState.SetInt(k_StageKey, 0);
            SessionState.SetString(k_StartedTicksKey, DateTime.UtcNow.Ticks.ToString());
            RegisterTick();
        }

        private static void RegisterTick()
        {
            if (s_isTicking)
            {
                return;
            }

            s_isTicking = true;
            EditorApplication.update += Tick;
        }

        private static void Tick()
        {
            if (!SessionState.GetBool(k_ActiveKey, false))
            {
                EditorApplication.update -= Tick;
                s_isTicking = false;
                return;
            }

            try
            {
                ThrowIfTimedOut();

                int stage = SessionState.GetInt(k_StageKey, 0);

                if (stage == 0)
                {
                    if (EditorApplication.isPlayingOrWillChangePlaymode)
                    {
                        return;
                    }

                    DevCheckpointSO entrance = LoadCheckpoint(k_EntranceCheckpointPath);
                    SessionState.SetInt(k_StageKey, 1);
                    DevPlaySession.PlayFrom(entrance);
                }
                else if (stage == 1)
                {
                    if (!IsPlayReadyFor(k_EntranceCheckpointPath))
                    {
                        return;
                    }

                    AssertLevelLoaded(
                        ScenePaths.k_GreenhouseInteriorEnvironment,
                        ScenePaths.k_GreenhouseInteriorGameplay);
                    AssertCheckpointPosition(LoadCheckpoint(k_EntranceCheckpointPath));
                    SessionState.SetInt(k_StageKey, 2);
                    DevPlaySession.PlayFrom(LoadCheckpoint(k_BriggsCheckpointPath));
                }
                else if (stage == 2)
                {
                    if (!IsPlayReadyFor(k_BriggsCheckpointPath))
                    {
                        return;
                    }

                    AssertLevelLoaded(k_BriggsEnvironmentPath, k_BriggsGameplayPath);
                    AssertSceneUnloaded(ScenePaths.k_GreenhouseInteriorEnvironment);
                    AssertSceneUnloaded(ScenePaths.k_GreenhouseInteriorGameplay);
                    AssertCheckpointPosition(LoadCheckpoint(k_BriggsCheckpointPath));
                    SessionState.SetInt(k_StageKey, 3);
                    DevPlaySession.PlayFrom(LoadCheckpoint(k_EntranceCheckpointPath));
                }
                else if (stage == 3)
                {
                    if (!IsPlayReadyFor(k_EntranceCheckpointPath))
                    {
                        return;
                    }

                    AssertLevelLoaded(
                        ScenePaths.k_GreenhouseInteriorEnvironment,
                        ScenePaths.k_GreenhouseInteriorGameplay);
                    AssertSceneUnloaded(k_BriggsEnvironmentPath);
                    AssertSceneUnloaded(k_BriggsGameplayPath);
                    AssertCheckpointPosition(LoadCheckpoint(k_EntranceCheckpointPath));
                    SessionState.SetInt(k_StageKey, 4);
                    DevPlaySession.PlayFrom(LoadCheckpoint(k_CentralCheckpointPath));
                }
                else if (stage == 4)
                {
                    if (!IsPlayReadyFor(k_CentralCheckpointPath))
                    {
                        return;
                    }

                    AssertLevelLoaded(
                        ScenePaths.k_GreenhouseInteriorEnvironment,
                        ScenePaths.k_GreenhouseInteriorGameplay);
                    AssertCheckpointPosition(LoadCheckpoint(k_CentralCheckpointPath));

                    if (Application.isBatchMode)
                    {
                        SessionState.SetInt(k_StageKey, 8);
                        EditorApplication.ExitPlaymode();
                        return;
                    }

                    SessionState.SetInt(k_StageKey, 5);
                    DevPlaySession.PlayFrom(LoadCheckpoint(k_EntranceCheckpointPath));
                }
                else if (stage == 5 && EditorApplication.isPlaying)
                {
                    if (!IsPlayReadyFor(k_EntranceCheckpointPath))
                    {
                        return;
                    }

                    AssertCheckpointPosition(LoadCheckpoint(k_EntranceCheckpointPath));
                    string screenshotPath = Path.GetFullPath(k_InteriorScreenshotPath);

                    if (File.Exists(screenshotPath))
                    {
                        File.Delete(screenshotPath);
                    }

                    ScreenCapture.CaptureScreenshot(screenshotPath);
                    SessionState.SetInt(k_StageKey, 6);
                }
                else if (stage == 6 && EditorApplication.isPlaying)
                {
                    FileInfo screenshot = new FileInfo(Path.GetFullPath(k_InteriorScreenshotPath));

                    if (!screenshot.Exists || screenshot.Length == 0)
                    {
                        return;
                    }

                    MovePlayerToOverviewPose();
                    string overviewPath = Path.GetFullPath(k_OverviewScreenshotPath);

                    if (File.Exists(overviewPath))
                    {
                        File.Delete(overviewPath);
                    }

                    ScreenCapture.CaptureScreenshot(overviewPath);
                    SessionState.SetInt(k_StageKey, 7);
                }
                else if (stage == 7 && EditorApplication.isPlaying)
                {
                    FileInfo screenshot = new FileInfo(Path.GetFullPath(k_OverviewScreenshotPath));

                    if (!screenshot.Exists || screenshot.Length == 0)
                    {
                        return;
                    }

                    SessionState.SetInt(k_StageKey, 8);
                    EditorApplication.ExitPlaymode();
                }
                else if (stage == 8 && !EditorApplication.isPlayingOrWillChangePlaymode)
                {
                    CompleteSuccessfully();
                }
                else if (stage == 99 && !EditorApplication.isPlayingOrWillChangePlaymode)
                {
                    ExitWithFailure();
                }
            }
            catch (Exception exception)
            {
                Debug.LogException(exception);
                SessionState.SetInt(k_StageKey, 99);

                if (EditorApplication.isPlayingOrWillChangePlaymode)
                {
                    EditorApplication.ExitPlaymode();
                }
                else
                {
                    ExitWithFailure();
                }
            }
        }

        private static bool IsPlayReadyFor(string checkpointPath)
        {
            if (!EditorApplication.isPlaying || DevPlaySession.Pending != null
                || DevPlaySession.IsSwitchingLevel || GameBootstrap.Instance == null)
            {
                return false;
            }

            DevCheckpointSO checkpoint = LoadCheckpoint(checkpointPath);
            return DevPlaySession.AreLevelScenesLoaded(checkpoint.Level)
                && UnityEngine.Object.FindFirstObjectByType<FirstPersonController>() != null;
        }

        private static void AssertLevelLoaded(string environmentPath, string gameplayPath)
        {
            if (!SceneManager.GetSceneByPath(environmentPath).isLoaded
                || !SceneManager.GetSceneByPath(gameplayPath).isLoaded)
            {
                throw new InvalidOperationException(
                    "Expected both level scenes to be loaded: " + environmentPath + ", " + gameplayPath);
            }

            if (SceneManager.GetActiveScene().path != environmentPath)
            {
                throw new InvalidOperationException("Expected active scene: " + environmentPath);
            }
        }

        private static void AssertSceneUnloaded(string path)
        {
            if (SceneManager.GetSceneByPath(path).isLoaded)
            {
                throw new InvalidOperationException("Expected scene to be unloaded: " + path);
            }
        }

        private static void AssertCheckpointPosition(DevCheckpointSO checkpoint)
        {
            FirstPersonController player = UnityEngine.Object.FindFirstObjectByType<FirstPersonController>();

            if (player == null)
            {
                throw new InvalidOperationException("No FirstPersonController exists after checkpoint apply.");
            }

            Vector2 actual = new Vector2(player.transform.position.x, player.transform.position.z);
            Vector2 expected = new Vector2(checkpoint.Position.x, checkpoint.Position.z);

            if (Vector2.Distance(actual, expected) > 0.25f)
            {
                throw new InvalidOperationException(
                    "Checkpoint did not move Player to the expected XZ position: " + checkpoint.Label);
            }
        }

        private static void MovePlayerToOverviewPose()
        {
            FirstPersonController player = UnityEngine.Object.FindFirstObjectByType<FirstPersonController>();
            Renderer[] playerRenderers = player.GetComponentsInChildren<Renderer>(true);

            for (int i = 0; i < playerRenderers.Length; i++)
            {
                playerRenderers[i].enabled = false;
            }

            CharacterController controller = player.GetComponent<CharacterController>();
            bool wasEnabled = controller != null && controller.enabled;

            if (wasEnabled)
            {
                controller.enabled = false;
            }

            player.transform.SetPositionAndRotation(new Vector3(0f, 15f, -55f), Quaternion.identity);

            if (wasEnabled)
            {
                controller.enabled = true;
            }

            Physics.SyncTransforms();
        }

        private static DevCheckpointSO LoadCheckpoint(string path)
        {
            DevCheckpointSO checkpoint = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(path);

            if (checkpoint == null)
            {
                throw new System.IO.FileNotFoundException("Dev checkpoint was not found: " + path);
            }

            return checkpoint;
        }

        private static void ThrowIfTimedOut()
        {
            string ticksText = SessionState.GetString(k_StartedTicksKey, string.Empty);

            if (!long.TryParse(ticksText, out long ticks))
            {
                throw new InvalidOperationException("Dev Play smoke start time is missing.");
            }

            TimeSpan elapsed = DateTime.UtcNow - new DateTime(ticks, DateTimeKind.Utc);

            if (elapsed.TotalSeconds > k_TimeoutSeconds)
            {
                throw new TimeoutException("Chapter 03 Dev Play smoke exceeded 90 seconds.");
            }
        }

        private static void CompleteSuccessfully()
        {
            Debug.Log("Chapter 03 Dev Play smoke passed: 03 entrance -> 02 greenhouse -> 03 entrance"
                + " -> 03 centre, including unload/load and same-level teleport.");
            ClearState();
            EditorApplication.Exit(0);
        }

        private static void ExitWithFailure()
        {
            ClearState();
            EditorApplication.Exit(1);
        }

        private static void ClearState()
        {
            EditorApplication.update -= Tick;
            s_isTicking = false;
            SessionState.EraseBool(k_ActiveKey);
            SessionState.EraseInt(k_StageKey);
            SessionState.EraseString(k_StartedTicksKey);
        }
    }
}

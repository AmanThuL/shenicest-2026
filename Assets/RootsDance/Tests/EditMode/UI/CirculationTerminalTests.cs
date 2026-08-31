using NUnit.Framework;
using RootsDance.Interaction;
using RootsDance.Player;
using RootsDance.UI;
using RootsDance.World;
using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

namespace RootsDance.Tests.EditMode.UI
{
    /// <summary>
    /// Guards the wall panel and the two halves of stepping up to it.
    /// <para>
    /// Everything here fails silently in the Editor. A terminal with no read camera looks finished
    /// and does nothing when pressed; a player with no proximity trigger walks past a screen that
    /// never offers itself; a panel left in the middle of the hall looks placed until somebody
    /// walks the room.
    /// </para>
    /// </summary>
    public class CirculationTerminalTests
    {
        private const string k_Prefab =
            "Assets/RootsDance/Prefabs/Props/CirculationTerminal.prefab";

        private const string k_PropScene =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Environment_2.unity";

        private const string k_GameplayScene =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Gameplay.unity";

        private static GameObject Prefab()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_Prefab);
            Assert.IsNotNull(prefab, $"{k_Prefab} not found; run "
                + "RootsDance > UI > Build Circulation Terminal.");
            return prefab;
        }

        [Test]
        public void Panel_CarriesAScreenACameraAndAHitBox()
        {
            GameObject prefab = Prefab();

            WallTerminal terminal = prefab.GetComponent<WallTerminal>();
            Assert.IsNotNull(terminal, "the panel is not a terminal, so nothing can offer it.");

            SerializedObject so = new SerializedObject(terminal);
            Assert.IsNotNull(so.FindProperty("m_canvas").objectReferenceValue,
                "no canvas: its buttons would answer to whatever camera it was last told about.");
            Assert.IsNotNull(so.FindProperty("m_screenAnchor").objectReferenceValue,
                "no screen anchor: the hint would measure from the housing's pivot in the wall.");

            CinemachineCamera camera = prefab.GetComponentInChildren<CinemachineCamera>(true);
            Assert.IsNotNull(camera, "no read camera, so pressing the key does nothing visible.");
            Assert.IsFalse(camera.gameObject.activeSelf,
                "the read camera is live in the prefab; it would fight the first-person camera "
                + "from the moment the scene loads.");

            Assert.IsNotNull(prefab.GetComponent<BoxCollider>(),
                "the panel has no collider, so the centre-screen ray passes through it.");
        }

        [TestCase(false)]
        [TestCase(true)]
        public void Read_WorldPanel_OpensButtonsAndRestoresCameraOnEitherExit(bool closeFromScreen)
        {
            GameObject panel = Object.Instantiate(Prefab());
            GameObject player = new GameObject("TerminalReaderTest");
            TerminalInspectController reader = player.AddComponent<TerminalInspectController>();

            try
            {
                SerializedObject settings = new SerializedObject(reader);
                settings.FindProperty("m_releaseCursorWhileReading").boolValue = false;
                settings.ApplyModifiedPropertiesWithoutUndo();

                WallTerminal terminal = panel.GetComponent<WallTerminal>();
                CirculationConsolePresenter screen = panel.GetComponentInChildren<CirculationConsolePresenter>();
                GameObject contents = (GameObject)new SerializedObject(screen)
                    .FindProperty("m_screen").objectReferenceValue;

                // EditMode does not run these lifecycle callbacks on instantiated behaviours.
                typeof(CirculationConsolePresenter).GetMethod("Awake",
                    System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic)
                    .Invoke(screen, null);
                typeof(WallTerminal).GetMethod("Start",
                    System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic)
                    .Invoke(terminal, null);
                Assert.That(contents.activeSelf, Is.True, "A physical terminal stays lit before reading.");

                Assert.That(reader.BeginRead(terminal), Is.True);
                Assert.That(contents.activeInHierarchy, Is.True);
                Assert.That(terminal.InspectCamera.gameObject.activeSelf, Is.True);

                foreach (Button button in screen.GetComponentsInChildren<Button>(true))
                {
                    Assert.That(button.IsActive() && button.IsInteractable(), Is.True);
                }

                if (closeFromScreen)
                {
                    screen.Close();
                }
                else
                {
                    reader.EndRead();
                }

                Assert.That(reader.State, Is.EqualTo(TerminalInspectController.ReadState.Idle));
                Assert.That(terminal.InspectCamera.gameObject.activeSelf, Is.False);
                Assert.That(contents.activeSelf, Is.True, "Stepping away must not blank the status readout.");

                foreach (Button button in screen.GetComponentsInChildren<Button>(true))
                {
                    Assert.That(button.IsInteractable(), Is.False);
                }
            }
            finally
            {
                reader.EndRead();
                Object.DestroyImmediate(player);
                Object.DestroyImmediate(panel);
            }
        }

        /// <summary>
        /// The camera looks at the screen, not away from it. A canvas is read from the far side of
        /// its own forward, so both are turned — and a sign error here puts the camera behind the
        /// wall looking into it, which is a black screen and no error.
        /// </summary>
        [Test]
        public void ReadCamera_StandsInFrontOfTheScreenLookingBack()
        {
            GameObject prefab = Prefab();
            WallTerminal terminal = prefab.GetComponent<WallTerminal>();
            Transform anchor = (Transform)new SerializedObject(terminal)
                .FindProperty("m_screenAnchor").objectReferenceValue;
            Transform camera = prefab.GetComponentInChildren<CinemachineCamera>(true).transform;

            Vector3 toCamera = camera.position - anchor.position;

            Assert.Greater(Vector3.Dot(toCamera, anchor.forward), 0f,
                "the read camera is behind the panel.");
            Assert.Less(Vector3.Dot(camera.forward, anchor.forward), -0.99f,
                "the read camera is not pointed at the screen.");
            Assert.That(toCamera.magnitude, Is.InRange(0.5f, 4f),
                $"the read camera stands {toCamera.magnitude:0.00} m off — that is not a person "
                + "leaning in to read a panel.");
        }

        [Test]
        public void Terminal_UpstairsPlacement_ReadCameraFacesTheLanding()
        {
            Scene scene = SceneManager.GetSceneByPath(k_PropScene);
            bool wasOpen = scene.IsValid() && scene.isLoaded;

            if (!wasOpen)
            {
                scene = EditorSceneManager.OpenScene(k_PropScene, OpenSceneMode.Additive);
            }

            try
            {
                WallTerminal terminal = null;

                foreach (GameObject root in scene.GetRootGameObjects())
                {
                    terminal = root.GetComponentInChildren<WallTerminal>(true);

                    if (terminal != null)
                    {
                        break;
                    }
                }

                Assert.IsNotNull(terminal, $"no terminal in {k_PropScene}.");

                Assert.That(terminal.transform.position.y, Is.InRange(17f, 19f),
                    "the terminal must remain on the upper stair landing.");
                Vector3 towardRoom = -terminal.ScreenPosition;
                towardRoom.y = 0f;
                Vector3 towardCamera = terminal.InspectCamera.transform.position - terminal.ScreenPosition;
                Assert.That(Vector3.Dot(towardCamera.normalized, towardRoom.normalized), Is.GreaterThan(0.9f),
                    "the read camera is outside the window instead of above the landing.");
            }
            finally
            {
                if (!wasOpen)
                {
                    EditorSceneManager.CloseScene(scene, true);
                }
            }
        }

        [Test]
        public void Player_CanBeOfferedTheTerminal()
        {
            Scene scene = EditorSceneManager.OpenScene(k_GameplayScene, OpenSceneMode.Additive);

            try
            {
                FirstPersonController player = null;

                foreach (GameObject root in scene.GetRootGameObjects())
                {
                    player = root.GetComponentInChildren<FirstPersonController>(true);

                    if (player != null)
                    {
                        break;
                    }
                }

                Assert.IsNotNull(player, $"no player in {k_GameplayScene}.");

                TerminalInspectController reader =
                    player.GetComponent<TerminalInspectController>();

                // The offer comes from the one interaction driver on the player prefab, which
                // hangs off the head rather than the root.
                InteractionProximityTrigger trigger =
                    player.GetComponentInChildren<InteractionProximityTrigger>(true);

                Assert.IsNotNull(reader, "the player cannot read a terminal.");
                Assert.IsNotNull(trigger, "nothing offers the terminal when the player walks up.");

                SerializedObject so = new SerializedObject(trigger);
                Assert.IsNotNull(so.FindProperty("m_promptChanged").objectReferenceValue,
                    "the approach hint has no channel, so it is never shown.");
                Assert.IsNotNull(so.FindProperty("m_config").objectReferenceValue,
                    "the driver has no InteractionConfigSO, so it has no reach.");

                // One owner per axis. Without these the eye fights the read camera for the mouse.
                SerializedProperty suspended = new SerializedObject(reader)
                    .FindProperty("m_suspendedWhileReading");
                Assert.Greater(suspended.arraySize, 0,
                    "nothing stands down while the terminal is up.");
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
            }
        }
    }
}

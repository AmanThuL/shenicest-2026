using NUnit.Framework;
using RootsDance.Player;
using RootsDance.World;
using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

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
        public void Terminal_IsOnAWallInTheGreenhouse()
        {
            Scene scene = EditorSceneManager.OpenScene(k_PropScene, OpenSceneMode.Additive);

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

                // The hall's south wall. A panel more than a couple of metres off it is standing
                // in the open, which is what the first placement did.
                Assert.That(terminal.transform.position.z, Is.InRange(-14f, -12f),
                    "the terminal is not against the south wall.");
                Assert.That(terminal.transform.position.y, Is.InRange(1.8f, 3.2f),
                    "the terminal is not at a height a standing person reads.");
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
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
                TerminalProximityTrigger trigger =
                    player.GetComponent<TerminalProximityTrigger>();

                Assert.IsNotNull(reader, "the player cannot read a terminal.");
                Assert.IsNotNull(trigger, "nothing offers the terminal when the player walks up.");

                SerializedObject so = new SerializedObject(trigger);
                Assert.IsNotNull(so.FindProperty("m_promptChanged").objectReferenceValue,
                    "the approach hint has no channel, so it is never shown.");
                Assert.AreEqual(reader, so.FindProperty("m_controller").objectReferenceValue,
                    "the trigger and the reader are not the same pair.");

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

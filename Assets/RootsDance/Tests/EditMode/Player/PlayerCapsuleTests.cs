using NUnit.Framework;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Player
{
    /// <summary>
    /// The player's capsule against the tightest ceiling in the game: the greenhouse spiral stair
    /// passes under its own landing, and over the last tread before it comes out the landing's
    /// underside leaves about 1.67 m. A CharacterController needs its height plus two skin widths
    /// of clear room, and it needs it while stepping up onto that tread, so a capsule that is even
    /// a few centimetres taller stops dead there with nothing in front of it — which reads as the
    /// player being frozen by a bug rather than blocked by the level. Measured in Play by walking
    /// the controller through the pinch at several heights: 1.62 passes, 1.65 does not.
    /// <para>
    /// The root is the feet (guideline: checkpoints snap the root to the ground with a 0.05 m
    /// clearance), so the centre has to stay at half the height; a height changed without moving
    /// the centre leaves the player hovering or buried by the difference.
    /// </para>
    /// </summary>
    public class PlayerCapsuleTests
    {
        private const string k_Player = "Assets/RootsDance/Prefabs/Characters/Player.prefab";

        /// <summary>Clear height over the last tread under the greenhouse stair landing, metres.</summary>
        private const float k_TightestHeadroom = 1.67f;

        /// <summary>Scenes that place the Player prefab and could override its controller.</summary>
        private static readonly string[] k_GameplayScenes =
        {
            "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity",
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Gameplay.unity",
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity",
            "Assets/RootsDance/Scenes/Levels/ChapterHouseInterior/ChapterHouseInterior_Gameplay.unity",
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity",
        };

        private static CharacterController Controller()
        {
            GameObject player = AssetDatabase.LoadAssetAtPath<GameObject>(k_Player);
            Assert.That(player, Is.Not.Null, $"Missing {k_Player}");

            CharacterController controller = player.GetComponentInChildren<CharacterController>(true);
            Assert.That(controller, Is.Not.Null, "No CharacterController on the Player prefab.");

            return controller;
        }

        [Test]
        public void Capsule_WithItsSkin_FitsUnderTheGreenhouseStairLanding()
        {
            CharacterController controller = Controller();
            float needed = controller.height + 2f * controller.skinWidth;

            Assert.That(needed, Is.LessThan(k_TightestHeadroom),
                $"The controller needs {needed:F2} m of headroom and the greenhouse spiral stair "
                + $"gives {k_TightestHeadroom:F2} m under its own landing; the player wedges there.");
        }

        [Test]
        public void Capsule_StandsOnTheRoot()
        {
            CharacterController controller = Controller();

            Assert.That(controller.center.y, Is.EqualTo(controller.height * 0.5f).Within(0.001f),
                "The root is the feet: the centre must sit at half the height or the capsule "
                + "floats above the ground (or sinks into it) by the difference.");
            Assert.That(controller.center.x, Is.EqualTo(0f).Within(0.001f));
            Assert.That(controller.center.z, Is.EqualTo(0f).Within(0.001f));
        }

        /// <summary>
        /// A scene override of the controller's size silently detaches that level from the prefab:
        /// Main_Gameplay carried height 1.5 with the prefab's centre, which after the root moved to
        /// the feet left the capsule hovering 0.1 m above the floor in that level only.
        /// </summary>
        [Test]
        public void GameplayScenes_DoNotOverrideTheControllerSize()
        {
            foreach (string scene in k_GameplayScenes)
            {
                if (!System.IO.File.Exists(scene))
                {
                    continue;
                }

                string text = System.IO.File.ReadAllText(scene);
                int player = text.IndexOf("guid: 4cdd650779b6e4469b809afb940da5d6", System.StringComparison.Ordinal);

                if (player < 0)
                {
                    continue;
                }

                foreach (string field in new[] { "m_Height", "m_Radius", "m_SkinWidth", "m_Center.y" })
                {
                    string needle = "propertyPath: " + field + "\n";
                    int at = text.IndexOf(needle, System.StringComparison.Ordinal);

                    Assert.That(at, Is.LessThan(0),
                        $"{System.IO.Path.GetFileName(scene)} overrides the Player controller's {field}; "
                        + "size the capsule on the prefab so every level walks the same body.");
                }
            }
        }
    }
}

using NUnit.Framework;
using RootsDance.Core;
using RootsDance.UI;
using RootsDance.UI.Kit;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.Tests.EditMode.UI
{
    /// <summary>
    /// Guards the circulation terminal's wiring.
    /// <para>
    /// The screen decides the chapter. A button wired to the wrong flag sends the player to the
    /// other ending and nothing anywhere reports a problem — the game simply plays a different
    /// story than the one they chose.
    /// </para>
    /// </summary>
    public class CirculationConsoleScreenTests
    {
        private const string k_Prefab =
            "Assets/RootsDance/Prefabs/UI/CirculationConsoleScreen.prefab";

        private static GameObject Prefab()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_Prefab);
            Assert.IsNotNull(prefab, $"{k_Prefab} not found; run "
                + "RootsDance > UI > Build Circulation Console Screen.");
            return prefab;
        }

        [Test]
        public void Terminal_OffersTheThreeCyclesInScriptOrder()
        {
            CirculationConsolePresenter presenter =
                Prefab().GetComponent<CirculationConsolePresenter>();
            Assert.IsNotNull(presenter, "the screen has no presenter.");

            SerializedObject so = new SerializedObject(presenter);
            SerializedProperty flags = so.FindProperty("m_cycleFlags");
            SerializedProperty buttons = so.FindProperty("m_cycleButtons");

            string[] expected =
            {
                WorldFlags.k_CirculationCore,
                WorldFlags.k_CirculationRing,
                WorldFlags.k_CirculationOuter,
            };

            Assert.AreEqual(expected.Length, flags.arraySize, "the terminal offers the wrong "
                + "number of cycles.");
            Assert.AreEqual(expected.Length, buttons.arraySize, "cycles and buttons disagree.");

            for (int i = 0; i < expected.Length; i++)
            {
                Assert.AreEqual(expected[i], flags.GetArrayElementAtIndex(i).stringValue,
                    $"cycle {i + 1} raises the wrong flag; the player would get another ending.");
                Assert.IsNotNull(buttons.GetArrayElementAtIndex(i).objectReferenceValue,
                    $"cycle {i + 1} has no button, so it cannot be chosen.");
            }
        }

        [Test]
        public void Terminal_IsBuiltOnTheKit()
        {
            GameObject prefab = Prefab();

            ElectronicUIRoot root = prefab.GetComponentInChildren<ElectronicUIRoot>(true);
            Assert.IsNotNull(root, "the terminal is not an Electronic UI Kit screen.");

            SerializedObject so = new SerializedObject(root);
            Object theme = so.FindProperty("m_theme").objectReferenceValue;
            Assert.IsNotNull(theme, "the screen has no theme, so every element renders untinted.");
            Assert.AreEqual("UITheme_PhosphorWall", theme.name,
                "the terminal changed family; the kit's inks come from the theme.");
        }

        [Test]
        public void Terminal_KeysTintFromAThemedGround()
        {
            // A Button tints by multiplying its target graphic. A white ground would make every
            // state brighter than the theme allows; a themed ground keeps the ramp.
            foreach (Button button in Prefab().GetComponentsInChildren<Button>(true))
            {
                Assert.IsNotNull(button.targetGraphic,
                    $"'{button.name}' has nothing to tint, so it shows no press.");
                Assert.IsNotNull(button.GetComponent<ThemedGraphic>(),
                    $"'{button.name}' tints against an unthemed ground.");
            }
        }
    }
}

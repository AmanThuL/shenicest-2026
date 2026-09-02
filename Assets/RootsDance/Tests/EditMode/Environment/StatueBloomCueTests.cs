using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Environment;
using RootsDance.Sequencing;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>
    /// Guards when the statue blooms.
    /// <para>
    /// Every failure here is a story failure rather than a crash: the statue growing at the wrong
    /// moment, or never. The one that bit already is the driver playing on enable — the statue's
    /// scene is additive and loads long before the ending, so the whole 45 s ran to itself behind
    /// the player somewhere in chapter 2.
    /// </para>
    /// </summary>
    public class StatueBloomCueTests
    {
        private const string k_Prefab = "Assets/RootsDance/Prefabs/Environment/StatueBloom.prefab";

        private const string k_StatueScene =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_Statue.unity";

        private static GameObject Prefab()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_Prefab);
            Assert.IsNotNull(prefab, $"{k_Prefab} not found; run RootsDance > Build Statue Bloom.");
            return prefab;
        }

        [Test]
        public void Statue_BloomsOnTheCorrectCirculationChoice()
        {
            GrowthCue cue = Prefab().GetComponent<GrowthCue>();
            Assert.IsNotNull(cue, "nothing tells the statue the ending began.");

            SerializedObject so = new SerializedObject(cue);

            Assert.AreEqual(WorldFlags.k_CirculationOuter, so.FindProperty("m_flagId").stringValue,
                "the statue blooms on a different beat than the ending music.");

            Assert.IsNotNull(so.FindProperty("m_flagRaised").objectReferenceValue,
                "the cue has no FlagRaised channel, so it never hears anything.");
        }

        /// <summary>
        /// The water starts when the ecology does.
        /// <para>
        /// Water already pouring down the statue when the player first sees it says the
        /// circulation was never broken, which is the premise of the whole chapter. It is also the
        /// most invisible kind of wrong: the scene looks finished either way.
        /// </para>
        /// </summary>
        [Test]
        public void Water_WaitsForTheEcologyToComeBack()
        {
            Scene scene = EditorSceneManager.OpenScene(k_StatueScene, OpenSceneMode.Additive);

            try
            {
                GameObject water = null;
                CueSequence sequence = null;

                foreach (GameObject root in scene.GetRootGameObjects())
                {
                    foreach (Transform child in root.GetComponentsInChildren<Transform>(true))
                    {
                        if (child.name == "StatueWater")
                        {
                            water = child.gameObject;
                        }
                    }

                    CueSequence found = root.GetComponentInChildren<CueSequence>(true);

                    if (found != null)
                    {
                        sequence = found;
                    }
                }

                Assert.IsNotNull(water, "the statue has no water.");
                Assert.IsFalse(water.activeSelf,
                    "the water is running before the circulation was ever repaired.");

                Assert.IsNotNull(sequence, "nothing starts the water.");

                SerializedObject so = new SerializedObject(sequence);
                Assert.AreEqual(WorldFlags.k_CirculationOuter,
                    so.FindProperty("m_startOnFlag").stringValue,
                    "the water starts on a different beat than the bloom.");

                SerializedProperty steps = so.FindProperty("m_steps");
                bool switchesTheWaterOn = false;

                for (int i = 0; i < steps.arraySize; i++)
                {
                    SerializedProperty step = steps.GetArrayElementAtIndex(i);

                    if (step.FindPropertyRelative("m_target").objectReferenceValue == water
                        && step.FindPropertyRelative("m_isActive").boolValue)
                    {
                        switchesTheWaterOn = true;
                    }
                }

                Assert.IsTrue(switchesTheWaterOn,
                    "the sequence never switches the water on, so it stays off for the whole game.");
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
            }
        }

        /// <summary>
        /// The doomed choices run the statue red, and only the doomed choices.
        /// <para>
        /// Two ways for this to go quietly wrong: the blood already showing when the scene loads
        /// (the same lie as running water, worse), or the blood keyed to the good ending's flag
        /// so a right answer bleeds. Both wrong answers must start it, because the console offers
        /// two and a player who picks the other one gets a dry statue.
        /// </para>
        /// </summary>
        [Test]
        public void Blood_WaitsForTheDoomedChoice()
        {
            Scene scene = EditorSceneManager.OpenScene(k_StatueScene, OpenSceneMode.Additive);

            try
            {
                GameObject water = null;
                GameObject blood = null;
                var sequences = new System.Collections.Generic.List<CueSequence>();

                foreach (GameObject root in scene.GetRootGameObjects())
                {
                    foreach (Transform child in root.GetComponentsInChildren<Transform>(true))
                    {
                        if (child.name == "StatueWater")
                        {
                            water = child.gameObject;
                        }
                        else if (child.name == "StatueBlood")
                        {
                            blood = child.gameObject;
                        }
                    }

                    sequences.AddRange(root.GetComponentsInChildren<CueSequence>(true));
                }

                Assert.IsNotNull(blood, "the statue has no blood; run RootsDance > Build Statue Blood.");
                Assert.IsFalse(blood.activeSelf, "the statue bleeds before anyone has chosen.");
                Assert.AreNotEqual(water, blood, "the blood is the water.");

                var startsBloodOn = new System.Collections.Generic.HashSet<string>();
                var startsWaterOn = new System.Collections.Generic.HashSet<string>();

                foreach (CueSequence sequence in sequences)
                {
                    SerializedObject so = new SerializedObject(sequence);
                    string flag = so.FindProperty("m_startOnFlag").stringValue;
                    SerializedProperty steps = so.FindProperty("m_steps");

                    for (int i = 0; i < steps.arraySize; i++)
                    {
                        SerializedProperty step = steps.GetArrayElementAtIndex(i);
                        Object target = step.FindPropertyRelative("m_target").objectReferenceValue;
                        bool on = step.FindPropertyRelative("m_isActive").boolValue;

                        if (target == blood && on)
                        {
                            startsBloodOn.Add(flag);
                        }
                        else if (target == water && on)
                        {
                            startsWaterOn.Add(flag);
                        }
                    }
                }

                Assert.IsTrue(startsBloodOn.Contains(WorldFlags.k_CirculationCore),
                    "Core Cultivation leaves the statue dry.");
                Assert.IsTrue(startsBloodOn.Contains(WorldFlags.k_CirculationRing),
                    "Standard Ring leaves the statue dry.");
                Assert.IsFalse(startsBloodOn.Contains(WorldFlags.k_CirculationOuter),
                    "the right answer bleeds.");
                Assert.IsFalse(startsWaterOn.Contains(WorldFlags.k_CirculationCore)
                    || startsWaterOn.Contains(WorldFlags.k_CirculationRing),
                    "a wrong answer runs the clear water as well as the blood.");

                // The switch: the cues exist either way, but only an armed build leaves them
                // listening. An inactive holder never subscribes to the flag channel.
                GameObject holder = null;

                foreach (CueSequence sequence in sequences)
                {
                    if (sequence.transform.parent != null
                        && sequence.transform.parent.name == RootsDance.EditorTools.StatueBloodBuilder.k_DoomedCueName)
                    {
                        holder = sequence.transform.parent.gameObject;
                    }
                }

                Assert.IsNotNull(holder, "the doomed cues have no holder to switch.");
                Assert.AreEqual(RootsDance.EditorTools.StatueBloodBuilder.k_DoomedCuesArmed, holder.activeSelf,
                    RootsDance.EditorTools.StatueBloodBuilder.k_DoomedCuesArmed
                        ? "the blood is switched off in the scene while the builder says it is on."
                        : "the blood is armed in the scene while the builder says it is off; a wrong answer bleeds.");
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
            }
        }

        [Test]
        public void Statue_StartsBareAndWaits()
        {
            GrowthDriver driver = Prefab().GetComponent<GrowthDriver>();
            Assert.IsNotNull(driver, "the statue has no growth driver.");

            SerializedObject so = new SerializedObject(driver);

            Assert.IsFalse(so.FindProperty("m_playOnEnable").boolValue,
                "the statue blooms the moment its scene loads, which is most of a chapter early.");
            Assert.AreEqual(0f, so.FindProperty("m_startAt").floatValue, 0.0001f,
                "the statue does not start from bare stone.");
        }
    }
}

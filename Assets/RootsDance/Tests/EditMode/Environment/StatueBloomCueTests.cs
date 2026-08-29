using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Environment;
using UnityEditor;
using UnityEngine;

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

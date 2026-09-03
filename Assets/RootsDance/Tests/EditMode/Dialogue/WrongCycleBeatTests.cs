using System.IO;
using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Dialogue;
using UnityEditor;

namespace RootsDance.Tests.EditMode.Dialogue
{
    /// <summary>
    /// The wrong-cycle beat is a chain of flags across three owners, and the order is the whole
    /// point: the outburst finishing is what lets the deck go, and the player landing is what
    /// starts the chase. These pin the two links that live in data.
    /// </summary>
    public class WrongCycleBeatTests
    {
        private const string k_OutburstPath = "Assets/RootsDance/Data/Dialogue/DLG-009_TheyAreNotThere.asset";
        private const string k_GreenhouseGameplayPath =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Gameplay.unity";

        [Test]
        public void Outburst_RaisesTheReleaseFlagOnCompletion()
        {
            DialogueSO outburst = AssetDatabase.LoadAssetAtPath<DialogueSO>(k_OutburstPath);

            Assert.That(outburst, Is.Not.Null, k_OutburstPath);
            Assert.That(outburst.FlagOnComplete, Is.EqualTo(WorldFlags.k_WrongCycleOutburstDone));
        }

        [Test]
        public void GreenhouseGameplay_NoSequenceRaisesChaseStarted()
        {
            // The chase flag unlocks the exits and arms the exterior stream, so only the collapse
            // may raise it, and only once the player has landed. A CueSequence step raising it
            // would fire seconds after the choice, before the deck has even let go.
            string scene = File.ReadAllText(k_GreenhouseGameplayPath);

            Assert.That(scene, Does.Not.Contain("m_flagId: " + WorldFlags.k_ChaseStarted));
        }
    }
}

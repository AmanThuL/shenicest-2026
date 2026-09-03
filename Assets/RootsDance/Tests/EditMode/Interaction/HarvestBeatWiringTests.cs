using NUnit.Framework;
using RootsDance.Interaction;
using RootsDance.Player;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Interaction
{
    /// <summary>
    /// The corridor beat is a chain of four things that only ever meet through strings and
    /// references: the algae's <see cref="HarvestPoint"/> names a flag, the torch waits on that
    /// flag, the notice line is bound to it — and the player has to carry the component that
    /// actually takes from the point. Drop any one link and every other link is still correct,
    /// nothing logs, and the beat reads as "the feature was never written". That is exactly how
    /// it shipped: the taker was written and never put on the Player prefab, so the algae could
    /// not be harvested, the torch never got power and the "[F] 打开手电" hint never appeared.
    /// </summary>
    public class HarvestBeatWiringTests
    {
        private const string k_Player = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_Algae = "Assets/RootsDance/Prefabs/Environment/AlgaePatch.prefab";

        private static GameObject Player()
        {
            GameObject player = AssetDatabase.LoadAssetAtPath<GameObject>(k_Player);
            Assert.That(player, Is.Not.Null, $"Missing {k_Player}");

            return player;
        }

        private static HarvestProximityTrigger Taker()
        {
            HarvestProximityTrigger trigger =
                Player().GetComponentInChildren<HarvestProximityTrigger>(true);

            Assert.That(trigger, Is.Not.Null,
                "No HarvestProximityTrigger on the Player prefab: nothing can take from a "
                + "HarvestPoint, so the algae is never harvested and flow.flashlight_powered is "
                + "never raised.");

            return trigger;
        }

        [Test]
        public void PlayerPrefab_CarriesAHarvestTaker()
        {
            Assert.That(Taker().enabled, Is.True);
        }

        /// <summary>
        /// Every reference the taker would otherwise search for at runtime is wired explicitly,
        /// the way the pickup and throw triggers beside it are, so a rig change cannot leave it
        /// silently resolving the wrong socket or no director.
        /// </summary>
        [Test]
        public void HarvestTaker_IsFullyWired()
        {
            SerializedObject so = new SerializedObject(Taker());

            foreach (string field in new[] { "m_socket", "m_player", "m_input", "m_director", "m_promptChanged" })
            {
                Assert.That(so.FindProperty(field).objectReferenceValue, Is.Not.Null,
                    $"HarvestProximityTrigger.{field} is empty on the Player prefab.");
            }

            Assert.That(so.FindProperty("m_actionId").stringValue, Is.EqualTo("grabGround"),
                "The harvest plays a clip that is not in the player's action set; the director "
                + "refuses it and the flag never goes up.");
        }

        /// <summary>The hint goes out on the same line every other offer uses, or it is never seen.</summary>
        [Test]
        public void HarvestTaker_SpeaksOnTheSharedPromptChannel()
        {
            PickupProximityTrigger pickup = Player().GetComponentInChildren<PickupProximityTrigger>(true);
            Assert.That(pickup, Is.Not.Null);

            Object harvestChannel = new SerializedObject(Taker()).FindProperty("m_promptChanged").objectReferenceValue;
            Object pickupChannel = new SerializedObject(pickup).FindProperty("m_promptChanged").objectReferenceValue;

            Assert.That(harvestChannel, Is.SameAs(pickupChannel));
        }

        /// <summary>
        /// The string the whole beat turns on: what the algae raises has to be what the torch
        /// waits for. Either side can be retyped in the Inspector without anything complaining.
        /// </summary>
        [Test]
        public void AlgaeFlag_IsTheFlagTheTorchWaitsFor()
        {
            GameObject algae = AssetDatabase.LoadAssetAtPath<GameObject>(k_Algae);
            Assert.That(algae, Is.Not.Null, $"Missing {k_Algae}");

            HarvestPoint point = algae.GetComponentInChildren<HarvestPoint>(true);
            Assert.That(point, Is.Not.Null, "AlgaePatch has no HarvestPoint.");

            FlashlightController torch = Player().GetComponentInChildren<FlashlightController>(true);
            Assert.That(torch, Is.Not.Null);

            SerializedObject so = new SerializedObject(torch);

            Assert.That(so.FindProperty("m_needsPowerSource").boolValue, Is.True,
                "The corridor torch is meant to start dead; with this off the algae beat is moot.");
            Assert.That(point.FlagOnHarvested, Is.EqualTo(so.FindProperty("m_powerFlag").stringValue));
        }
    }
}

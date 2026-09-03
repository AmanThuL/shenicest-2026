using NUnit.Framework;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Interaction
{
    /// <summary>
    /// The pick-up offer has two halves — near enough, and still in frame — and they are measured
    /// from two different places: the reach from the player root on the floor, the framing from the
    /// eye 1.62 m above it. That makes the reach a geometry problem rather than a taste one, and it
    /// is why 1.5 m read as "pick-up is completely broken" rather than as "pick-up is a bit tight".
    /// <para>
    /// At 1.5 m the body already spends 0.55 m of it (capsule radius plus skin), so the band where
    /// the offer could stand was about 0.65 m wide — and a prop on the floor 1.5 m away sits 47°
    /// below the horizon, outside the bottom of a 60° frame unless the player is deliberately
    /// staring at their feet. The two halves barely overlapped anywhere.
    /// </para>
    /// </summary>
    public class PickupReachTests
    {
        private const string k_Player = "Assets/RootsDance/Prefabs/Characters/Player.prefab";

        /// <summary>Capsule radius plus skin width, from the Player prefab's CharacterController.</summary>
        private const float k_BodyClearance = 0.55f;

        /// <summary>Eye height, from the Head transform on the Player prefab.</summary>
        private const float k_EyeHeight = 1.62f;

        private static float Range()
        {
            GameObject player = AssetDatabase.LoadAssetAtPath<GameObject>(k_Player);
            Assert.That(player, Is.Not.Null, $"Missing {k_Player}");

            RootsDance.Interaction.PickupProximityTrigger trigger =
                player.GetComponentInChildren<RootsDance.Interaction.PickupProximityTrigger>(true);
            Assert.That(trigger, Is.Not.Null, "No PickupProximityTrigger on the Player prefab.");

            return trigger.Range;
        }

        [Test]
        public void Range_OnThePlayerPrefab_ClearsTheBodyByAWorkableMargin()
        {
            float usable = Range() - k_BodyClearance;

            Assert.That(usable, Is.GreaterThan(1f),
                "The player cannot walk closer than the capsule allows, so anything under about "
                + "1 m of usable band leaves almost no ground to stand on and take the prop from.");
        }

        /// <summary>
        /// At the far edge of the reach the prop has to still be in frame while the player is
        /// looking roughly level — otherwise the only way to make the offer appear is to look at
        /// the floor, which is not a rule the game ever teaches.
        /// </summary>
        [Test]
        public void Range_AtItsFarEdge_KeepsAFloorPropWithinHalfAStandardFrame()
        {
            float depression = Mathf.Atan2(k_EyeHeight, Range()) * Mathf.Rad2Deg;

            Assert.That(depression, Is.LessThan(35f),
                "A floor prop at the edge of the reach sits further below the horizon than half a "
                + "60° frame, so it is out of shot exactly where it comes into reach.");
        }

        [Test]
        public void Range_OnThePlayerPrefab_IsNotSilentlyBackAtTheBrokenValue()
        {
            Assert.That(Range(), Is.GreaterThanOrEqualTo(2.5f));
        }
    }
}

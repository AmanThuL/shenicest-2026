using System.Reflection;
using NUnit.Framework;
using RootsDance.Companion;
using RootsDance.Player;
using UnityEditor;
using UnityEngine;
using UnityEngine.TestTools.Utils;

namespace RootsDance.Tests.EditMode.Companion
{
    /// <summary>
    /// The two properties that decide whether the flower sprite reads as company rather than as a
    /// prop being dragged: she arrives where the look-behind will find her, and she neither crowds
    /// the player nor circles them.
    /// </summary>
    public class CompanionFollowStepTests
    {
        private const string k_FlowerPrefabPath =
            "Assets/RootsDance/Prefabs/Characters/FlowerSprite.prefab";

        [Test]
        public void AppearPosition_PlayerFacingForward_PutsHerBehindThem()
        {
            Vector3 position = CompanionFollowStep.AppearPosition(
                Vector3.zero, Vector3.forward, 2.6f);

            Assert.That(position.z, Is.EqualTo(-2.6f).Within(0.001f));
            Assert.That(position.x, Is.EqualTo(0f).Within(0.001f));
        }

        [Test]
        public void AppearPosition_PlayerLookingUp_IgnoresThePitch()
        {
            Vector3 forward = new Vector3(0f, 0.8f, 0.6f).normalized;

            Vector3 position = CompanionFollowStep.AppearPosition(Vector3.zero, forward, 3f);

            Assert.That(position.y, Is.EqualTo(0f).Within(0.001f));
            Assert.That(new Vector2(position.x, position.z).magnitude,
                Is.EqualTo(3f).Within(0.001f));
        }

        [Test]
        public void AppearPosition_ForwardIsFlat_FallsBackToWorldBack()
        {
            Vector3 position = CompanionFollowStep.AppearPosition(Vector3.zero, Vector3.up, 2f);

            Assert.That(position, Is.EqualTo(new Vector3(0f, 0f, -2f)).Using(Vector3Comparer()));
        }

        [Test]
        public void Appear_PlayerRootIsAboveFloor_KeepsAuthoredGroundOffset()
        {
            GameObject player = new GameObject("Player", typeof(PlayerTriggerProbe));
            GameObject companionObject = new GameObject("FlowerSprite");

            try
            {
                player.transform.position = new Vector3(0f, 6.154f, 0f);
                companionObject.transform.position = new Vector3(0f, 5.104f, 1f);
                FollowCompanion companion = companionObject.AddComponent<FollowCompanion>();
                InvokeStart(companion);

                companion.Appear();

                Assert.That(companion.transform.position.y, Is.EqualTo(5.104f).Within(0.001f));
            }
            finally
            {
                Object.DestroyImmediate(companionObject);
                Object.DestroyImmediate(player);
            }
        }

        [Test]
        public void ModelYawOffset_ImportedFlowerFace_AlignsWithRigForward()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_FlowerPrefabPath);
            Assert.That(prefab, Is.Not.Null);

            Transform head = FindRequired(prefab.transform, "ORG-spine.007");
            Transform jaw = FindRequired(prefab.transform, "ORG-jaw.master");
            Vector3 modelFace = Vector3.ProjectOnPlane(
                prefab.transform.InverseTransformPoint(jaw.position)
                    - prefab.transform.InverseTransformPoint(head.position),
                Vector3.up).normalized;

            Vector3 correctedFace = Quaternion.Euler(
                0f, FollowCompanion.k_ModelYawOffset, 0f) * modelFace;

            Assert.That(Vector3.Dot(correctedFace, Vector3.forward), Is.GreaterThan(0.995f),
                "The shared yaw offset must put the imported flower's mouth on the rig's +Z, "
                + "otherwise following shows the player her back.");
        }

        [Test]
        public void DesiredPosition_InsideTheFollowDistance_HoldsStill()
        {
            Vector3 companion = new Vector3(0f, 0f, -1.5f);

            Vector3 position = CompanionFollowStep.DesiredPosition(Vector3.zero, companion, 2.2f);

            Assert.That(position, Is.EqualTo(companion).Using(Vector3Comparer()));
        }

        [Test]
        public void DesiredPosition_PlayerWalkedAway_ClosesToTheRing()
        {
            Vector3 companion = new Vector3(0f, 0f, -8f);

            Vector3 position = CompanionFollowStep.DesiredPosition(Vector3.zero, companion, 2.2f);

            Assert.That(position.z, Is.EqualTo(-2.2f).Within(0.001f));
        }

        /// <summary>
        /// The whole reason the ring is around the player's position and not their forward: a
        /// player turning on the spot must not drag her around them.
        /// </summary>
        [Test]
        public void DesiredPosition_PlayerTurnsOnTheSpot_DoesNotMoveHer()
        {
            Vector3 companion = new Vector3(0f, 0f, -4f);

            Vector3 first = CompanionFollowStep.DesiredPosition(Vector3.zero, companion, 2.2f);
            Vector3 second = CompanionFollowStep.DesiredPosition(Vector3.zero, companion, 2.2f);

            Assert.That(first, Is.EqualTo(second).Using(Vector3Comparer()));
            Assert.That(first.x, Is.EqualTo(0f).Within(0.001f));
        }

        [Test]
        public void DesiredPosition_HeightDifference_KeepsHerOwnHeight()
        {
            Vector3 companion = new Vector3(0f, 4f, -9f);

            Vector3 position = CompanionFollowStep.DesiredPosition(
                new Vector3(0f, 0f, 0f), companion, 2f);

            Assert.That(position.y, Is.EqualTo(4f).Within(0.001f));
        }

        [Test]
        public void ShouldCut_WithinTheLeash_IsFalse()
        {
            Assert.That(
                CompanionFollowStep.ShouldCut(Vector3.zero, new Vector3(0f, 0f, -10f), 18f),
                Is.False);
        }

        [Test]
        public void ShouldCut_BeyondTheLeash_IsTrue()
        {
            Assert.That(
                CompanionFollowStep.ShouldCut(Vector3.zero, new Vector3(0f, 0f, -25f), 18f),
                Is.True);
        }

        [Test]
        public void ShouldCut_LeashOff_IsAlwaysFalse()
        {
            Assert.That(
                CompanionFollowStep.ShouldCut(Vector3.zero, new Vector3(0f, 0f, -900f), 0f),
                Is.False);
        }

        /// <summary>A drop between floors is not being left behind.</summary>
        [Test]
        public void ShouldCut_PlayerDirectlyBelow_IsFalse()
        {
            Assert.That(
                CompanionFollowStep.ShouldCut(new Vector3(0f, -30f, 0f), Vector3.zero, 18f),
                Is.False);
        }

        private static Vector3EqualityComparer Vector3Comparer()
        {
            return new Vector3EqualityComparer(0.001f);
        }

        private static Transform FindRequired(Transform root, string name)
        {
            Transform[] children = root.GetComponentsInChildren<Transform>(includeInactive: true);

            for (int i = 0; i < children.Length; i++)
            {
                if (children[i].name == name)
                {
                    return children[i];
                }
            }

            Assert.Fail($"Flower prefab is missing orientation anchor '{name}'.");
            return null;
        }

        private static void InvokeStart(FollowCompanion companion)
        {
            MethodInfo start = typeof(FollowCompanion).GetMethod(
                "Start", BindingFlags.Instance | BindingFlags.NonPublic);
            Assert.That(start, Is.Not.Null);
            start.Invoke(companion, null);
        }
    }
}

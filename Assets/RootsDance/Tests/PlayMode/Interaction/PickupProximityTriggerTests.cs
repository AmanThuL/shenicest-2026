using System.Collections;
using System.Reflection;
using NUnit.Framework;
using RootsDance.Events;
using RootsDance.Interaction;
using RootsDance.Player.Arms;
using UnityEngine;
using UnityEngine.TestTools;

namespace RootsDance.Tests.PlayMode.Interaction
{
    /// <summary>
    /// Proves the pick-up offer actually reaches the prompt channel. The wiring on the Player
    /// prefab can be verified by reading it, but whether the hint fires can only be answered by
    /// running the component, which is what this does.
    /// </summary>
    public class PickupProximityTriggerTests
    {
        private GameObject m_player;
        private GameObject m_torch;
        private StringEventChannelSO m_prompt;
        private string m_lastPrompt;

        [SetUp]
        public void SetUp()
        {
            m_lastPrompt = null;
            m_prompt = ScriptableObject.CreateInstance<StringEventChannelSO>();
            m_prompt.EventRaised += OnPrompt;

            m_torch = new GameObject("Torch");
            m_torch.transform.position = new Vector3(100f, 0f, 0f);
            m_torch.AddComponent<CarriedItem>();
            m_torch.AddComponent<GroundPickup>();

            m_player = new GameObject("Player");
            m_player.transform.position = Vector3.zero;

            GameObject hand = new GameObject("HandSocket_R");
            hand.transform.SetParent(m_player.transform, false);
            HandSocket socket = hand.AddComponent<HandSocket>();

            PickupProximityTrigger trigger = m_player.AddComponent<PickupProximityTrigger>();
            Set(trigger, "m_socket", socket);
            Set(trigger, "m_player", m_player.transform);
            Set(trigger, "m_promptChanged", m_prompt);
        }

        [TearDown]
        public void TearDown()
        {
            m_prompt.EventRaised -= OnPrompt;
            Object.DestroyImmediate(m_player);
            Object.DestroyImmediate(m_torch);
            Object.DestroyImmediate(m_prompt);
        }

        private void OnPrompt(string prompt)
        {
            m_lastPrompt = prompt;
        }

        /// <summary>Writes a private serialized field, the way the prefab would have.</summary>
        private static void Set(object target, string field, object value)
        {
            FieldInfo info = target.GetType().GetField(
                field, BindingFlags.Instance | BindingFlags.NonPublic);

            Assert.That(info, Is.Not.Null, $"'{field}' is gone; the test needs updating");
            info.SetValue(target, value);
        }

        [UnityTest]
        public IEnumerator OutOfRange_OffersNothing()
        {
            yield return null;
            yield return null;

            Assert.That(string.IsNullOrEmpty(m_lastPrompt), Is.True,
                $"a torch 100 m away must offer nothing, got '{m_lastPrompt}'");
        }

        [UnityTest]
        public IEnumerator WithinRange_OffersThePickUp()
        {
            yield return null;

            m_torch.transform.position = new Vector3(1.5f, 0f, 0f);

            yield return null;
            yield return null;

            Assert.That(m_lastPrompt, Is.Not.Null.And.Not.Empty,
                "a torch 1.5 m away has to put a hint on the channel");
            Assert.That(m_lastPrompt, Does.Contain("手电筒"));
        }

        [UnityTest]
        public IEnumerator WalkingAway_ClearsTheOffer()
        {
            yield return null;
            m_torch.transform.position = new Vector3(1.5f, 0f, 0f);
            yield return null;
            yield return null;

            Assert.That(m_lastPrompt, Is.Not.Empty, "precondition: the hint was showing");

            m_torch.transform.position = new Vector3(100f, 0f, 0f);
            yield return null;
            yield return null;

            Assert.That(m_lastPrompt, Is.Empty, "walking away has to hide the hint again");
        }

        [UnityTest]
        public IEnumerator SeveralInRange_OffersTheNearest()
        {
            GameObject far = new GameObject("FarTorch");
            far.transform.position = new Vector3(2.8f, 0f, 0f);
            far.AddComponent<CarriedItem>();
            GroundPickup farPickup = far.AddComponent<GroundPickup>();
            Set(farPickup, "m_displayName", "远手电筒");

            yield return null;
            m_torch.transform.position = new Vector3(0.5f, 0f, 0f);
            yield return null;
            yield return null;

            PickupProximityTrigger trigger = m_player.GetComponent<PickupProximityTrigger>();

            Assert.That(trigger.InReach, Is.Not.Null);
            Assert.That(trigger.InReach.DisplayName, Is.EqualTo("手电筒"),
                "the nearer torch has to win");

            Object.DestroyImmediate(far);
        }
    }
}

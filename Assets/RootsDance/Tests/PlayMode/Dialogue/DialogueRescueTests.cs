using System.Collections;
using System.Reflection;
using NUnit.Framework;
using RootsDance.Dialogue;
using UnityEngine;
using UnityEngine.TestTools;

namespace RootsDance.Tests.PlayMode.Dialogue
{
    public class DialogueRescueTests
    {
        private GameObject m_root;
        private DialogueRunner m_runner;
        private DialogueSO m_conversation;

        [SetUp]
        public void SetUp()
        {
            m_root = new GameObject("DialogueRescueUnderTest");
            m_runner = m_root.AddComponent<DialogueRunner>();
            m_conversation = ScriptableObject.CreateInstance<DialogueSO>();
            Set(m_conversation, "m_id", "DLG-999");
            object line = new DialogueLine();
            Set(line, "m_chinese", "A long line that must not finish during the reset.");
            Set(line, "m_holdSeconds", 30f);
            Set(m_conversation, "m_lines", new[] { (DialogueLine)line });
        }

        [TearDown]
        public void TearDown()
        {
            Object.DestroyImmediate(m_root);
            Object.DestroyImmediate(m_conversation);
        }

        [UnityTest]
        public IEnumerator ResetForRescue_PlayingOnceOnlyDialogue_CancelsAndAllowsReplay()
        {
            m_runner.Play(m_conversation);
            Assert.That(m_runner.IsPlaying, Is.True);

            m_runner.ResetForRescue();
            Assert.That(m_runner.IsPlaying, Is.False);
            m_runner.Play(m_conversation);
            yield return null;

            // The old async finally must not hide or stop this newly started conversation.
            Assert.That(m_runner.IsPlaying, Is.True);
            m_runner.ResetForRescue();
        }

        private static void Set(object target, string field, object value)
        {
            FieldInfo info = target.GetType().GetField(field, BindingFlags.Instance | BindingFlags.NonPublic);
            Assert.That(info, Is.Not.Null, field);
            info.SetValue(target, value);
        }
    }
}

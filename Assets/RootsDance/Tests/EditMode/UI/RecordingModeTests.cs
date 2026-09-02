using System.Reflection;
using NUnit.Framework;
using RootsDance.Data;
using RootsDance.UI;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.UI
{
    public sealed class RecordingModeTests
    {
        private const string k_ActiveKey = "recording.active";
        private const string k_HiddenKey = "recording.hidden";

        private RecordingModeSO m_mode;
        private GameObject m_root;
        private bool m_hadActive;
        private bool m_hadHidden;
        private int m_savedActive;
        private int m_savedHidden;

        [SetUp]
        public void SetUp()
        {
            // The switch is remembered in PlayerPrefs on purpose; the test must not leave the
            // developer's own setting behind.
            m_hadActive = PlayerPrefs.HasKey(k_ActiveKey);
            m_hadHidden = PlayerPrefs.HasKey(k_HiddenKey);
            m_savedActive = PlayerPrefs.GetInt(k_ActiveKey, 0);
            m_savedHidden = PlayerPrefs.GetInt(k_HiddenKey, 0);
            PlayerPrefs.DeleteKey(k_ActiveKey);
            PlayerPrefs.DeleteKey(k_HiddenKey);
            m_mode = ScriptableObject.CreateInstance<RecordingModeSO>();
        }

        [TearDown]
        public void TearDown()
        {
            if (m_root != null)
            {
                Object.DestroyImmediate(m_root);
            }

            Object.DestroyImmediate(m_mode);
            Restore(k_ActiveKey, m_hadActive, m_savedActive);
            Restore(k_HiddenKey, m_hadHidden, m_savedHidden);
        }

        [Test]
        public void FreshMode_IsInactiveAndHidesEverythingOnceActivated()
        {
            Assert.IsFalse(m_mode.IsActive);
            Assert.AreEqual(RecordingHiddenUi.All, m_mode.Hidden);
            Assert.IsFalse(m_mode.IsHidden(RecordingHiddenUi.Dialogue), "nothing hides while inactive");

            m_mode.SetActive(true);

            Assert.IsTrue(m_mode.IsHidden(RecordingHiddenUi.Dialogue));
            Assert.IsTrue(m_mode.IsHidden(RecordingHiddenUi.HelmetHud));
        }

        [Test]
        public void SetHidden_TogglesOneGroupAndRaisesChangedOnlyOnRealChange()
        {
            int raised = 0;
            m_mode.Changed += () => raised++;
            m_mode.SetActive(true);

            m_mode.SetHidden(RecordingHiddenUi.Subtitles, false);
            m_mode.SetHidden(RecordingHiddenUi.Subtitles, false);

            Assert.AreEqual(2, raised);
            Assert.IsFalse(m_mode.IsHidden(RecordingHiddenUi.Subtitles));
            Assert.IsTrue(m_mode.IsHidden(RecordingHiddenUi.InteractionHints));
        }

        [Test]
        public void State_SurvivesReload()
        {
            m_mode.SetActive(true);
            m_mode.SetHidden(RecordingHiddenUi.Dialogue, false);

            var reloaded = ScriptableObject.CreateInstance<RecordingModeSO>();
            try
            {
                Assert.IsTrue(reloaded.IsActive);
                Assert.AreEqual(RecordingHiddenUi.All & ~RecordingHiddenUi.Dialogue, reloaded.Hidden);
            }
            finally
            {
                Object.DestroyImmediate(reloaded);
            }
        }

        [Test]
        public void Hider_FollowsItsGroupAndShowsAgainWhenDisabled()
        {
            m_root = new GameObject("HiderTest", typeof(RectTransform), typeof(CanvasGroup));
            CanvasGroup group = m_root.GetComponent<CanvasGroup>();
            var hider = m_root.AddComponent<RecordingModeHider>();
            var serialized = new SerializedObject(hider);
            serialized.FindProperty("m_mode").objectReferenceValue = m_mode;
            serialized.FindProperty("m_group").intValue = (int)RecordingHiddenUi.Subtitles;
            serialized.FindProperty("m_canvasGroup").objectReferenceValue = group;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            // Edit-mode tests never run MonoBehaviour lifecycle; drive it by hand.
            Invoke(hider, "OnEnable");
            Assert.AreEqual(1f, group.alpha);

            m_mode.SetActive(true);
            Assert.AreEqual(0f, group.alpha);
            Assert.IsFalse(group.blocksRaycasts);

            m_mode.SetHidden(RecordingHiddenUi.Subtitles, false);
            Assert.AreEqual(1f, group.alpha);
            Assert.IsTrue(group.blocksRaycasts);

            m_mode.SetHidden(RecordingHiddenUi.Subtitles, true);
            Invoke(hider, "OnDisable");
            Assert.AreEqual(1f, group.alpha, "a disabled hider leaves its element visible");

            m_mode.SetActive(false);
            Assert.AreEqual(1f, group.alpha, "no subscription is left behind");
        }

        private static void Invoke(object target, string method)
        {
            target.GetType().GetMethod(method, BindingFlags.Instance | BindingFlags.NonPublic).Invoke(target, null);
        }

        private static void Restore(string key, bool existed, int value)
        {
            if (existed)
            {
                PlayerPrefs.SetInt(key, value);
            }
            else
            {
                PlayerPrefs.DeleteKey(key);
            }
        }
    }
}

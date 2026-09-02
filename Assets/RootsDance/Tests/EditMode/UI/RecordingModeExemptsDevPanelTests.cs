using System.Text.RegularExpressions;
using NUnit.Framework;
using RootsDance.UI;
using UnityEngine;

namespace RootsDance.Tests.EditMode.UI
{
    /// <summary>
    /// Recording mode hides the game-facing screens so a capture is clean. The developer panel is
    /// not one of them — it is where recording mode is switched on and off, and it is parented
    /// under a root that recording mode hides, so without an explicit escape turning the option on
    /// hid the only control that could turn it back off.
    /// </summary>
    public class RecordingModeExemptsDevPanelTests
    {
        private const string k_Bootstrap = "Assets/RootsDance/Scenes/Bootstrap.unity";

        /// <summary>The dialogue-screen prefab, which the installer puts a hider on.</summary>
        private const string k_DialogueScreenGuid = "1f05530ebd8104b7b97e26de6d7d17e1";

        /// <summary>The rescue panel prefab — the Ctrl+Shift+D screen.</summary>
        private const string k_RescueGuid = "ee03749e0edf54e2f8576031e9e5889d";

        /// <summary>
        /// Records why the escape is needed rather than optional. If the panel is ever re-parented
        /// somewhere no hider reaches, this goes red and the escape can be reconsidered on purpose
        /// instead of being quietly dropped.
        /// </summary>
        [Test]
        public void Bootstrap_TheDevPanel_SitsUnderARootRecordingModeHides()
        {
            string text = System.IO.File.ReadAllText(k_Bootstrap);

            Match instance = Regex.Match(text,
                @"--- !u!1001 &\d+\r?\nPrefabInstance:(?:(?!--- !u!)[\s\S])*?" + k_RescueGuid
                + @"(?:(?!--- !u!)[\s\S])*");

            Assert.That(instance.Success, Is.True, "No CheckpointRescue instance in the bootstrap.");

            Match parent = Regex.Match(instance.Value, @"m_TransformParent: \{fileID: (\d+)\}");
            Assert.That(parent.Success, Is.True);

            Match stripped = Regex.Match(text,
                @"--- !u!22[04] &" + parent.Groups[1].Value + @" stripped[\s\S]{0,400}");

            Assert.That(stripped.Success, Is.True,
                "The rescue panel's parent is not a stripped transform of another prefab.");
            Assert.That(stripped.Value, Does.Contain(k_DialogueScreenGuid),
                "The rescue panel is no longer parented under the dialogue screen.");
        }

        [Test]
        public void Exempt_AppliedToAPanelUnderAHiddenGroup_KeepsItVisible()
        {
            GameObject parent = new GameObject("HiddenRoot");
            GameObject panel = new GameObject("CheckpointRescue");

            try
            {
                panel.transform.SetParent(parent.transform);

                CanvasGroup hidden = parent.AddComponent<CanvasGroup>();
                CanvasGroup exempt = UiRootVisibility.Exempt(panel);

                // What RecordingModeHider does to the group it owns.
                hidden.alpha = 0f;
                hidden.blocksRaycasts = false;
                hidden.interactable = false;

                Assert.That(exempt.ignoreParentGroups, Is.True);
                Assert.That(exempt.alpha, Is.EqualTo(1f));
                Assert.That(exempt.blocksRaycasts, Is.True,
                    "The panel's own buttons have to stay clickable while everything else is hidden.");
            }
            finally
            {
                Object.DestroyImmediate(parent);
            }
        }
    }
}

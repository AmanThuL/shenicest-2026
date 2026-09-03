using System.Linq;
using NUnit.Framework;
using RootsDance.Data;
using RootsDance.Editor.Tools;
using RootsDance.UI;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.Tests.EditMode.DevPlay
{
    /// <summary>Guards the installed recording-mode wiring in the generated assets.</summary>
    public sealed class RecordingModeInstallTests
    {
        [Test]
        public void RescuePrefab_CarriesMasterSwitchAndOneBoxPerGroup()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(CheckpointRescueBuilder.k_PrefabPath);
            Assert.IsTrue(prefab != null, CheckpointRescueBuilder.k_PrefabPath);
            RecordingModeSO mode = AssetDatabase.LoadAssetAtPath<RecordingModeSO>(RecordingModeInstaller.k_AssetPath);
            Assert.IsTrue(mode != null, RecordingModeInstaller.k_AssetPath);

            RecordingModeToggle[] toggles = prefab.GetComponentsInChildren<RecordingModeToggle>(true);
            Assert.AreEqual(5, toggles.Length);

            int masters = 0;
            var groups = RecordingHiddenUi.None;
            foreach (RecordingModeToggle toggle in toggles)
            {
                var serialized = new SerializedObject(toggle);
                Assert.AreSame(mode, serialized.FindProperty("m_mode").objectReferenceValue, toggle.name);
                Assert.IsTrue(serialized.FindProperty("m_toggle").objectReferenceValue is Toggle, toggle.name);
                if (serialized.FindProperty("m_isMasterSwitch").boolValue)
                {
                    masters++;
                }
                else
                {
                    groups |= (RecordingHiddenUi)serialized.FindProperty("m_group").intValue;
                }
            }

            Assert.AreEqual(1, masters);
            Assert.AreEqual(RecordingHiddenUi.All, groups);

            var presenter = new SerializedObject(prefab.GetComponent<CheckpointRescuePresenter>());
            Assert.AreEqual(5, presenter.FindProperty("m_recordingToggles").arraySize,
                "the presenter threads every box into keyboard navigation");
        }

        [Test]
        public void DialogueScreenPrefab_RootHidesAsDialogue()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(RecordingModeInstaller.k_DialogueScreenPrefabPath);
            Assert.IsTrue(prefab != null, RecordingModeInstaller.k_DialogueScreenPrefabPath);

            RecordingModeHider hider = prefab.GetComponent<RecordingModeHider>();
            Assert.IsTrue(hider != null, "hider on the prefab root");
            Assert.AreEqual(RecordingHiddenUi.Dialogue, hider.Group);
            Assert.IsTrue(prefab.GetComponent<CanvasGroup>() != null, "the hider's own CanvasGroup on the root");

            // The presenter's own group is one level down and must stay its own.
            RecordingModeHider[] all = prefab.GetComponentsInChildren<RecordingModeHider>(true);
            Assert.AreEqual(1, all.Length);
            Assert.IsTrue(prefab.GetComponentsInChildren<CanvasGroup>(true).Count(g => g.gameObject != prefab) >= 1);
        }
    }
}

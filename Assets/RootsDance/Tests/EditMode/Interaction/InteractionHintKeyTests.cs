using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Archive;
using RootsDance.Dialogue;
using RootsDance.Interaction;
using RootsDance.Investigation;
using RootsDance.Scanner;
using RootsDance.World;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Interaction
{
    /// <summary>
    /// 规范·规则 2: a hint for something the player can act on names its key, in the text itself,
    /// as "[E] …". Held-up modes are no exception — a sheet, the scanner's report, a terminal, the
    /// keypad each list every key that works in them. A hint without a key is not a wording nit:
    /// the player stands in front of the thing and does not know what to press.
    /// </summary>
    public class InteractionHintKeyTests
    {
        private const string k_Prefabs = "Assets/RootsDance/Prefabs";
        private const string k_Data = "Assets/RootsDance/Data";
        private const string k_Scanner = "Assets/RootsDance/Prefabs/Props/Scanner.prefab";
        private const string k_DialogueScreen = "Assets/RootsDance/Prefabs/UI/DialogueScreen.prefab";

        private static IEnumerable<T> AssetsOf<T>(string filter, string folder) where T : Object
        {
            foreach (string guid in AssetDatabase.FindAssets(filter, new[] { folder }))
            {
                T asset = AssetDatabase.LoadAssetAtPath<T>(AssetDatabase.GUIDToAssetPath(guid));

                if (asset != null)
                {
                    yield return asset;
                }
            }
        }

        private static void AssertNamesItsKey(string hint, string owner)
        {
            Assert.That(hint, Does.StartWith("["),
                $"{owner}: '{hint}' is an interaction hint without a key (规范·规则 2).");
        }

        private static string StringField(Object target, string field)
        {
            SerializedProperty property = new SerializedObject(target).FindProperty(field);
            Assert.That(property, Is.Not.Null, $"{target.GetType().Name} has no '{field}'.");

            return property.stringValue;
        }

        [Test]
        public void InvestigationTargets_NameTheirKey()
        {
            int count = 0;

            foreach (InvestigationTargetSO target in AssetsOf<InvestigationTargetSO>(
                "t:InvestigationTargetSO", k_Data))
            {
                AssertNamesItsKey(target.PromptText, target.name);
                count++;
            }

            Assert.That(count, Is.GreaterThan(0), "No investigation targets found under Data.");
        }

        [Test]
        public void ArchiveDocuments_NameTheirKey()
        {
            int count = 0;

            foreach (ArchiveDocumentSO document in AssetsOf<ArchiveDocumentSO>(
                "t:ArchiveDocumentSO", k_Data))
            {
                AssertNamesItsKey(document.PromptText, document.name);
                count++;
            }

            Assert.That(count, Is.GreaterThan(0), "No archive documents found under Data.");
        }

        /// <summary>
        /// Every interactable saved in a prefab. An empty line is a different rule (规则 4, or an
        /// unwired target) and is left to its own checks; a non-empty one names its key.
        /// </summary>
        [Test]
        public void PrefabInteractables_NameTheirKey()
        {
            int count = 0;

            foreach (GameObject prefab in AssetsOf<GameObject>("t:Prefab", k_Prefabs))
            {
                foreach (MonoBehaviour behaviour in prefab.GetComponentsInChildren<MonoBehaviour>(true))
                {
                    if (!(behaviour is IInteractable interactable))
                    {
                        continue;
                    }

                    string prompt = interactable.PromptText;

                    if (string.IsNullOrEmpty(prompt))
                    {
                        continue;
                    }

                    AssertNamesItsKey(prompt, $"{prefab.name}/{behaviour.GetType().Name}");
                    count++;
                }
            }

            Assert.That(count, Is.GreaterThan(0), "No interactables found in any prefab.");
        }

        /// <summary>
        /// The lines a held-up mode owns. Read off fresh components, which is what a scene that
        /// never overrode them gets.
        /// </summary>
        [Test]
        public void ModeHints_ListTheirKeys()
        {
            GameObject host = new GameObject("host");

            try
            {
                AssertNamesItsKey(StringField(host.AddComponent<DocumentInspectController>(),
                    "m_readingHint"), "DocumentInspectController");
                AssertNamesItsKey(StringField(host.AddComponent<DocumentInspectController>(),
                    "m_flipHint"), "DocumentInspectController flip");
                AssertNamesItsKey(StringField(host.AddComponent<ScannerInspectController>(),
                    "m_readingHint"), "ScannerInspectController");
                AssertNamesItsKey(StringField(host.AddComponent<TerminalInspectController>(),
                    "m_readingHint"), "TerminalInspectController");
                AssertNamesItsKey(StringField(host.AddComponent<DialoguePresenter>(),
                    "m_skipHint"), "DialoguePresenter skip");
            }
            finally
            {
                Object.DestroyImmediate(host);
            }
        }

        /// <summary>
        /// A mode line with no channel is a mode line nobody sees. The scanner is the one mode
        /// that lives on a prefab rather than a scene instance, so its wiring is pinned here.
        /// </summary>
        [Test]
        public void ScannerPrefab_ReportModeHint_HasAChannel()
        {
            GameObject scanner = AssetDatabase.LoadAssetAtPath<GameObject>(k_Scanner);
            Assert.That(scanner, Is.Not.Null, $"Missing {k_Scanner}");

            ScannerInspectController controller =
                scanner.GetComponentInChildren<ScannerInspectController>(true);
            Assert.That(controller, Is.Not.Null, "Scanner.prefab carries no ScannerInspectController.");

            SerializedProperty channel = new SerializedObject(controller).FindProperty("m_promptChanged");
            Assert.That(channel.objectReferenceValue, Is.Not.Null,
                "ScannerInspectController.m_promptChanged is unwired: the report's key line never shows.");
        }

        [Test]
        public void DialogueScreen_HasASkipHintLabel()
        {
            GameObject screen = AssetDatabase.LoadAssetAtPath<GameObject>(k_DialogueScreen);
            Assert.That(screen, Is.Not.Null, $"Missing {k_DialogueScreen}");

            DialoguePresenter presenter = screen.GetComponentInChildren<DialoguePresenter>(true);
            Assert.That(presenter, Is.Not.Null, "DialogueScreen.prefab carries no DialoguePresenter.");

            SerializedProperty label = new SerializedObject(presenter).FindProperty("m_skipHintLabel");
            Assert.That(label.objectReferenceValue, Is.Not.Null,
                "DialoguePresenter.m_skipHintLabel is unwired: an unvoiced line never says which key skips it.");
        }
    }
}

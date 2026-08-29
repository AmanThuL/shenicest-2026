using System.Collections.Generic;
using RootsDance.Dialogue;
using RootsDance.Narrative;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Content
{
    /// <summary>
    /// Gives every conversation and transmission that has no written line a stand-in one, so that a
    /// playtest can tell "this beat never fired" apart from "this beat has nothing to say".
    /// <para>
    /// Chapter 00's assets were laid out before the script was written and most are still empty
    /// (see <see cref="Chapter00NarrativeBuilder"/>: inventing dialogue is worse than leaving a
    /// gap). An empty conversation still runs — it starts and ends in the same frame and shows
    /// nothing — which looks exactly like a trigger that was never wired. That ambiguity is what
    /// this fixes, and it is the only thing it fixes.
    /// </para>
    /// <para>
    /// The Chinese is the agreed nonsense string, so no placeholder can ever be mistaken for copy.
    /// The English carries the conversation's id and title instead of a translation, because that
    /// is what makes the line useful during a test: it says on screen which asset just played.
    /// </para>
    /// <para>
    /// Only assets with <em>no</em> lines at all are touched — a written beat is never overwritten,
    /// and a placeholder disappears the moment the real line is typed over it. Every placeholder is
    /// findable by grepping <c>Data/</c> for the marker below.
    /// </para>
    /// Menu: RootsDance &gt; Content &gt; Fill Missing Text With Placeholders.
    /// </summary>
    public static class Chapter00PlaceholderTextBuilder
    {
        private const string k_DialogueFolder = "Assets/RootsDance/Data/Dialogue";
        private const string k_NarrativeFolder = "Assets/RootsDance/Data/Narrative";

        /// <summary>The agreed stand-in. Nonsense on purpose: it cannot be mistaken for a line.</summary>
        private const string k_PlaceholderChinese = "啦啦啦啦啦啦";

        /// <summary>Prefix on the English side, so every placeholder is greppable in the YAML.</summary>
        private const string k_Marker = "(placeholder)";

        /// <summary>Long enough to read on screen without the runner's estimate rushing it.</summary>
        private const float k_HoldSeconds = 2.5f;

        [MenuItem("RootsDance/Content/Fill Missing Text With Placeholders")]
        public static void Build()
        {
            List<string> filled = new List<string>();

            FillDialogues(filled);
            FillTransmissions(filled);

            AssetDatabase.SaveAssets();

            Debug.Log($"[Content] Placeholder text: {filled.Count} empty asset(s) given a stand-in "
                + $"line ({(filled.Count == 0 ? "none" : string.Join(", ", filled))}). Every one "
                + $"reads '{k_PlaceholderChinese}' and is marked '{k_Marker}' on the English side.");
        }

        /// <summary>Batch entry point (-executeMethod).</summary>
        public static void BuildFromCommandLine()
        {
            Build();
        }

        private static void FillDialogues(List<string> filled)
        {
            string[] guids = AssetDatabase.FindAssets("t:DialogueSO", new[] { k_DialogueFolder });

            for (int i = 0; i < guids.Length; i++)
            {
                string path = AssetDatabase.GUIDToAssetPath(guids[i]);
                DialogueSO conversation = AssetDatabase.LoadAssetAtPath<DialogueSO>(path);

                if (conversation == null || conversation.Lines == null || conversation.Lines.Length > 0)
                {
                    continue;
                }

                using (SerializedObject serialized = new SerializedObject(conversation))
                {
                    SerializedProperty lines = serialized.FindProperty("m_lines");
                    lines.arraySize = 1;

                    SerializedProperty line = lines.GetArrayElementAtIndex(0);

                    // The suit reads out; everything else in chapter 00 is the player thinking.
                    line.FindPropertyRelative("m_speaker").enumValueIndex =
                        (int)SpeakerFor(conversation.Id);
                    line.FindPropertyRelative("m_chinese").stringValue = k_PlaceholderChinese;
                    line.FindPropertyRelative("m_english").stringValue =
                        Label(conversation.Id, conversation.Title);
                    line.FindPropertyRelative("m_voice").objectReferenceValue = null;
                    line.FindPropertyRelative("m_holdSeconds").floatValue = k_HoldSeconds;
                    serialized.ApplyModifiedPropertiesWithoutUndo();
                }

                EditorUtility.SetDirty(conversation);
                filled.Add(conversation.Id);
            }
        }

        private static void FillTransmissions(List<string> filled)
        {
            string[] guids = AssetDatabase.FindAssets("t:RadioSequenceSO", new[] { k_NarrativeFolder });

            for (int i = 0; i < guids.Length; i++)
            {
                string path = AssetDatabase.GUIDToAssetPath(guids[i]);
                RadioSequenceSO sequence = AssetDatabase.LoadAssetAtPath<RadioSequenceSO>(path);

                if (sequence == null || sequence.Lines == null || sequence.Lines.Length > 0)
                {
                    continue;
                }

                using (SerializedObject serialized = new SerializedObject(sequence))
                {
                    SerializedProperty lines = serialized.FindProperty("m_lines");
                    lines.arraySize = 1;

                    SerializedProperty line = lines.GetArrayElementAtIndex(0);
                    line.FindPropertyRelative("m_text").stringValue = k_PlaceholderChinese;
                    line.FindPropertyRelative("m_english").stringValue =
                        Label(sequence.Id, sequence.Title);
                    line.FindPropertyRelative("m_voice").objectReferenceValue = null;
                    line.FindPropertyRelative("m_holdSeconds").floatValue = k_HoldSeconds;
                    serialized.ApplyModifiedPropertiesWithoutUndo();
                }

                EditorUtility.SetDirty(sequence);
                filled.Add(sequence.Id);
            }
        }

        /// <summary>
        /// A readout beat is the suit talking; the rest of chapter 00 is the player alone. Wrong in
        /// either direction only costs a colour on screen, and the placeholder is replaced anyway.
        /// </summary>
        private static DialogueSpeaker SpeakerFor(string id)
        {
            switch (id)
            {
                case "DLG-102":
                case "DLG-103":
                case "DLG-106":
                    return DialogueSpeaker.Device;
                default:
                    return DialogueSpeaker.Protagonist;
            }
        }

        private static string Label(string id, string title)
        {
            return string.IsNullOrEmpty(title) ? $"{k_Marker} {id}" : $"{k_Marker} {id} — {title}";
        }
    }
}

using RootsDance.Dialogue;
using RootsDance.Narrative;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Content
{
    /// <summary>
    /// Writes the chapter 00 copy that the flow document actually contains, into the assets
    /// <see cref="Chapter00NarrativeBuilder"/> laid out.
    /// <para>
    /// Only four beats have written lines in the flow document — the idle nudge, the departure
    /// briefing, the seal-release prompt, and the two thoughts after the first identification.
    /// Everything else in chapter 00 is described as sound and image rather than as speech, so
    /// those assets stay empty rather than being filled with invented dialogue.
    /// </para>
    /// <para>
    /// Nothing already written is overwritten: a transmission or conversation that has lines is
    /// left alone, and the briefing — which was authored before the English field existed — only
    /// has its blank English filled, matched line by line against its Chinese. That is the whole
    /// reason this is a builder and not a hand edit: the copy is transcribed once, from the
    /// document, and a second transcription is where a dropped line or a mismatched pair comes from.
    /// </para>
    /// Menu: RootsDance &gt; Content &gt; Fill Chapter 00 Narrative Text.
    /// </summary>
    public static class Chapter00NarrativeText
    {
        private const string k_NarrativeFolder = "Assets/RootsDance/Data/Narrative";
        private const string k_DialogueFolder = "Assets/RootsDance/Data/Dialogue";

        /// <summary>One authored line, before it becomes serialized data.</summary>
        private readonly struct Line
        {
            public readonly DialogueSpeaker m_speaker;
            public readonly string m_chinese;
            public readonly string m_english;

            public Line(DialogueSpeaker speaker, string chinese, string english)
            {
                m_speaker = speaker;
                m_chinese = chinese;
                m_english = english;
            }
        }

        // Node 00-03. The Chinese is already in the asset; these pairs exist to fill the English.
        private static readonly Line[] k_Briefing =
        {
            new Line(DialogueSpeaker.Device, "继续向前。监测数据显示前方污染浓度正在下降。",
                "Keep moving. Our readings show that the contamination levels are dropping ahead."),
            new Line(DialogueSpeaker.Device, "进入遗迹最外层后，通讯可能无法维持。",
                "Once you enter the outer perimeter of the ruins, we may not be able to maintain "
                + "communications."),
            new Line(DialogueSpeaker.Device, "完成基础环境调查。之后我们再联系。",
                "Complete the initial environmental survey. We'll get back in touch after that."),
            new Line(DialogueSpeaker.Device, "祝你好运。", "Good luck.")
        };

        // Node 00-02: what mission control says when the player has stopped moving for a while.
        private static readonly Line[] k_IdleNudge =
        {
            new Line(DialogueSpeaker.Device, "你那里出现情况了吗？往里走走，这边还是污染区。",
                "Everything alright over there? Keep moving further in. You're still in the "
                + "contaminated zone.")
        };

        // Node 00-05: the suit, not a person. Upper case in the English is the device's own voice.
        private static readonly Line[] k_SealRelease =
        {
            new Line(DialogueSpeaker.Device, "外部污染浓度低于防护阈值。可解除环境隔离。",
                "EXTERNAL CONTAMINATION LEVELS WITHIN SAFE LIMITS. ENVIRONMENTAL SEAL MAY BE RELEASED.")
        };

        // Node 00-07: the two thoughts after the first identification comes back.
        private static readonly Line[] k_FirstRecord =
        {
            new Line(DialogueSpeaker.Protagonist, "我说真的，有了这些东西，谁还想要植物学家。",
                "Seriously, with all this stuff, who needs a botanist?"),
            new Line(DialogueSpeaker.Protagonist, "不过……只是已确认物种？", "But... confirmed species?")
        };

        [MenuItem("RootsDance/Content/Fill Chapter 00 Narrative Text")]
        public static void Fill()
        {
            int written = 0;

            written += FillEnglish($"{k_NarrativeFolder}/RadioBriefing.asset", k_Briefing);
            written += FillTransmission($"{k_NarrativeFolder}/RAD-001_Wake.asset", k_IdleNudge,
                "长时间未移动的催促（00-02）", "RAD-001_IdleNudge");
            written += FillConversation($"{k_DialogueFolder}/DLG-103_HelmetRemovable.asset", k_SealRelease);
            written += FillConversation($"{k_DialogueFolder}/DLG-107_FirstRecord.asset", k_FirstRecord);

            AssetDatabase.SaveAssets();

            Debug.Log($"[Content] Chapter 00 text: {written} asset(s) filled. The beats the flow "
                + "document describes as sound and image rather than speech — 00-01, 00-04, 00-06 "
                + "and the facility nodes — were left empty on purpose.");
        }

        /// <summary>
        /// Fills the English of a transmission whose Chinese is already written, matching line by
        /// line. A line whose Chinese does not match is left completely alone and reported: it
        /// means the writer has changed the copy since, and this builder is not the authority.
        /// </summary>
        private static int FillEnglish(string path, Line[] lines)
        {
            RadioSequenceSO sequence = AssetDatabase.LoadAssetAtPath<RadioSequenceSO>(path);

            if (sequence == null)
            {
                Debug.LogWarning($"[Content] No transmission at {path}.");
                return 0;
            }

            SerializedObject serialized = new SerializedObject(sequence);
            SerializedProperty array = serialized.FindProperty("m_lines");
            int filled = 0;

            for (int i = 0; i < array.arraySize; i++)
            {
                SerializedProperty line = array.GetArrayElementAtIndex(i);
                SerializedProperty chinese = line.FindPropertyRelative("m_text");
                SerializedProperty english = line.FindPropertyRelative("m_english");

                if (!string.IsNullOrEmpty(english.stringValue))
                {
                    continue;
                }

                string match = EnglishFor(chinese.stringValue, lines);

                if (string.IsNullOrEmpty(match))
                {
                    Debug.LogWarning($"[Content] {sequence.name} line {i} has no English in the flow "
                        + $"document: \"{chinese.stringValue}\". Left blank.");
                    continue;
                }

                english.stringValue = match;
                filled++;
            }

            if (filled == 0)
            {
                return 0;
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(sequence);

            return 1;
        }

        private static string EnglishFor(string chinese, Line[] lines)
        {
            for (int i = 0; i < lines.Length; i++)
            {
                if (lines[i].m_chinese == chinese)
                {
                    return lines[i].m_english;
                }
            }

            return string.Empty;
        }

        /// <summary>
        /// Writes a transmission that has no lines yet, and renames the file when the copy turned
        /// out to belong to a different beat than the placeholder assumed. Renaming through
        /// <see cref="AssetDatabase"/> is what keeps the .meta — and therefore every reference —
        /// with the asset.
        /// </summary>
        private static int FillTransmission(string path, Line[] lines, string title, string newFileName)
        {
            RadioSequenceSO sequence = AssetDatabase.LoadAssetAtPath<RadioSequenceSO>(path);

            if (sequence == null)
            {
                Debug.LogWarning($"[Content] No transmission at {path}.");
                return 0;
            }

            SerializedObject serialized = new SerializedObject(sequence);
            SerializedProperty array = serialized.FindProperty("m_lines");

            if (array.arraySize > 0)
            {
                return 0;
            }

            array.arraySize = lines.Length;

            for (int i = 0; i < lines.Length; i++)
            {
                SerializedProperty line = array.GetArrayElementAtIndex(i);
                line.FindPropertyRelative("m_text").stringValue = lines[i].m_chinese;
                line.FindPropertyRelative("m_english").stringValue = lines[i].m_english;
                line.FindPropertyRelative("m_voice").objectReferenceValue = null;

                // 0 means "as long as the recording, or as long as the text takes to read".
                line.FindPropertyRelative("m_holdSeconds").floatValue = 0f;
            }

            serialized.FindProperty("m_title").stringValue = title;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(sequence);

            if (!string.IsNullOrEmpty(newFileName) && sequence.name != newFileName)
            {
                string error = AssetDatabase.RenameAsset(path, newFileName);

                if (!string.IsNullOrEmpty(error))
                {
                    Debug.LogWarning($"[Content] Could not rename {path} to {newFileName}: {error}");
                }
            }

            return 1;
        }

        private static int FillConversation(string path, Line[] lines)
        {
            DialogueSO conversation = AssetDatabase.LoadAssetAtPath<DialogueSO>(path);

            if (conversation == null)
            {
                Debug.LogWarning($"[Content] No conversation at {path}.");
                return 0;
            }

            SerializedObject serialized = new SerializedObject(conversation);
            SerializedProperty array = serialized.FindProperty("m_lines");

            if (array.arraySize > 0)
            {
                return 0;
            }

            array.arraySize = lines.Length;

            for (int i = 0; i < lines.Length; i++)
            {
                SerializedProperty line = array.GetArrayElementAtIndex(i);
                line.FindPropertyRelative("m_speaker").enumValueIndex = (int)lines[i].m_speaker;
                line.FindPropertyRelative("m_chinese").stringValue = lines[i].m_chinese;
                line.FindPropertyRelative("m_english").stringValue = lines[i].m_english;
                line.FindPropertyRelative("m_voice").objectReferenceValue = null;
                line.FindPropertyRelative("m_holdSeconds").floatValue = 0f;
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(conversation);

            return 1;
        }
    }
}

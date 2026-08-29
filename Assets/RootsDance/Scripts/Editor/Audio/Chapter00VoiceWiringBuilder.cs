using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Audio
{
    /// <summary>
    /// Puts chapter 00's mission-control recordings on the lines they belong to: the departure
    /// briefing, the idle nudge, and the suit's seal-release readout.
    /// <para>
    /// The recordings were delivered under the names the voice tool wrote them with, and the lines
    /// were written from the flow document, so nothing about the two sets matches automatically.
    /// The mapping is therefore typed out once, here, and every entry carries the opening words of
    /// the line it belongs to: a line inserted above it moves the index, and the check catches that
    /// instead of silently attaching the wrong recording to the wrong sentence.
    /// </para>
    /// <para>
    /// <see cref="RootsDance.Narrative.RadioSequenceSO"/> and
    /// <see cref="RootsDance.Dialogue.DialogueSO"/> both keep their lines in an <c>m_lines</c> array
    /// whose entries carry <c>m_english</c> and <c>m_voice</c>, so one pass serves both.
    /// </para>
    /// Non-destructive: a line that already has a recording is left alone.
    /// Menu: RootsDance &gt; Audio &gt; Wire Chapter 00 Voice.
    /// </summary>
    public static class Chapter00VoiceWiringBuilder
    {
        private const string k_ClipFolder = "Assets/RootsDance/Audio/Voice/Chapter1_Radio_Player";
        private const string k_NarrativeFolder = "Assets/RootsDance/Data/Narrative";
        private const string k_DialogueFolder = "Assets/RootsDance/Data/Dialogue";

        /// <summary>One recording, and the line it is the recording of.</summary>
        private readonly struct Take
        {
            public readonly string m_assetPath;
            public readonly int m_lineIndex;
            public readonly string m_englishStartsWith;
            public readonly string m_clipFileName;

            public Take(string assetPath, int lineIndex, string englishStartsWith, string clipFileName)
            {
                m_assetPath = assetPath;
                m_lineIndex = lineIndex;
                m_englishStartsWith = englishStartsWith;
                m_clipFileName = clipFileName;
            }
        }

        private static readonly Take[] k_Takes =
        {
            // RAD-001, node 00-02 — mission control when the player has stopped moving.
            new Take($"{k_NarrativeFolder}/RAD-001_IdleNudge.asset", 0,
                "Everything alright over there?",
                "ELITE-2026-08-29-12-19-[pause]-Everything-alright-over-there-Keep-movin.mp3"),

            // RAD-002, node 00-03 — the departure briefing, four lines in order.
            new Take($"{k_NarrativeFolder}/RadioBriefing.asset", 0,
                "Keep moving.",
                "ELITE-2026-08-29-12-21-Keep-moving.-Our-readings-show-that-the-contamin.mp3"),
            new Take($"{k_NarrativeFolder}/RadioBriefing.asset", 1,
                "Once you enter",
                "ELITE-2026-08-29-12-22-[with-a-serious,-cautious-tone]-Once-you-enter-t.mp3"),
            new Take($"{k_NarrativeFolder}/RadioBriefing.asset", 2,
                "Complete the initial",
                "ELITE-2026-08-29-12-23-[with-a-calm,-professional-tone]-Complete-the-in.mp3"),
            new Take($"{k_NarrativeFolder}/RadioBriefing.asset", 3,
                "Good luck.",
                "ELITE-2026-08-29-12-24-[with-a-warm,-encouraging-tone]-Good-luck.mp3"),

            // DLG-103, node 00-05 — the suit, not the radio; it is the same delivery voice.
            new Take($"{k_DialogueFolder}/DLG-103_HelmetRemovable.asset", 0,
                "EXTERNAL CONTAMINATION LEVELS",
                "ELITE-2026-08-29-12-36-EXTERNAL-CONTAMINATION-LEVELS-WITHIN-SAFE-LIMITS.mp3")
        };

        [MenuItem("RootsDance/Audio/Wire Chapter 00 Voice")]
        public static void Build()
        {
            int wired = 0;
            int alreadyWired = 0;
            int failed = 0;

            for (int i = 0; i < k_Takes.Length; i++)
            {
                switch (Apply(k_Takes[i]))
                {
                    case Result.Wired:
                        wired++;
                        break;
                    case Result.AlreadyWired:
                        alreadyWired++;
                        break;
                    default:
                        failed++;
                        break;
                }
            }

            AssetDatabase.SaveAssets();

            Debug.Log($"[Audio] Chapter 00 voice: {wired} recording(s) attached, {alreadyWired} "
                + $"already had one, {failed} could not be placed (see the errors above).");
        }

        /// <summary>Batch entry point (-executeMethod).</summary>
        public static void BuildFromCommandLine()
        {
            Build();
        }

        private enum Result
        {
            Wired,
            AlreadyWired,
            Failed
        }

        private static Result Apply(Take take)
        {
            ScriptableObject asset = AssetDatabase.LoadAssetAtPath<ScriptableObject>(take.m_assetPath);

            if (asset == null)
            {
                Debug.LogError($"[Audio] Missing asset: {take.m_assetPath}");
                return Result.Failed;
            }

            string clipPath = $"{k_ClipFolder}/{take.m_clipFileName}";
            AudioClip clip = AssetDatabase.LoadAssetAtPath<AudioClip>(clipPath);

            if (clip == null)
            {
                Debug.LogError($"[Audio] Missing recording: {clipPath}");
                return Result.Failed;
            }

            using (SerializedObject serialized = new SerializedObject(asset))
            {
                SerializedProperty lines = serialized.FindProperty("m_lines");

                if (lines == null || take.m_lineIndex >= lines.arraySize)
                {
                    Debug.LogError($"[Audio] {take.m_assetPath} has no line {take.m_lineIndex}. The "
                        + "copy is written by RootsDance > Content > Fill Chapter 00 Narrative Text; "
                        + "run that first.", asset);
                    return Result.Failed;
                }

                SerializedProperty line = lines.GetArrayElementAtIndex(take.m_lineIndex);
                SerializedProperty english = line.FindPropertyRelative("m_english");

                if (english == null || !english.stringValue.StartsWith(take.m_englishStartsWith))
                {
                    Debug.LogError($"[Audio] {take.m_assetPath} line {take.m_lineIndex} reads "
                        + $"'{english?.stringValue}', not '{take.m_englishStartsWith}…'. The lines "
                        + "moved; fix the table in Chapter00VoiceWiringBuilder rather than "
                        + "attaching the wrong recording.", asset);
                    return Result.Failed;
                }

                SerializedProperty voice = line.FindPropertyRelative("m_voice");

                if (voice.objectReferenceValue != null)
                {
                    return Result.AlreadyWired;
                }

                voice.objectReferenceValue = clip;
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }

            EditorUtility.SetDirty(asset);
            return Result.Wired;
        }
    }
}

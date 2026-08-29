using System.IO;
using RootsDance.Audio;
using RootsDance.Core;
using RootsDance.Dialogue;
using RootsDance.Events;
using RootsDance.Narrative;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Content
{
    /// <summary>
    /// Lays out chapter 00's narrative assets — the four radio transmissions, the fifteen spoken
    /// beats, and the channels that carry them — so that voice work and writing can start before
    /// either has to wait on the other.
    /// <para>
    /// The assets are created empty of text on purpose. The script itself lives in the flow
    /// documents (see <c>docs/design/</c>), and copying it in by hand a second time is exactly the
    /// mistake chapter 02's builder exists to avoid: a dropped line, a sample id that does not
    /// match, a Chinese line and an English line that say different things. What this builder does
    /// fix in place is everything around the text — the ids, the titles, the mix each beat is
    /// played through, and the folder each asset belongs in — so that adding a line is typing it
    /// into an asset that already exists and already sounds right.
    /// </para>
    /// <para>
    /// Every line carries its own clip field, so the moment a line exists, there is a slot for its
    /// recording next to it. That is the whole handover between the writer and whoever is cutting
    /// the audio: no naming convention to agree on, no import list to keep in sync.
    /// </para>
    /// Non-destructive: existing assets keep their content, and only fields that are still empty
    /// are filled. Menu: RootsDance &gt; Content &gt; Build Chapter 00 Narrative.
    /// </summary>
    public static class Chapter00NarrativeBuilder
    {
        private const string k_NarrativeFolder = "Assets/RootsDance/Data/Narrative";
        private const string k_DialogueFolder = "Assets/RootsDance/Data/Dialogue";
        private const string k_EventFolder = "Assets/RootsDance/Data/Events";
        private const string k_CueFolder = "Assets/RootsDance/Data/Audio";

        /// <summary>One transmission: the file, its id, what it is, and the beat it belongs to.</summary>
        private readonly struct Transmission
        {
            public readonly string m_fileName;
            public readonly string m_id;
            public readonly string m_title;

            public Transmission(string fileName, string id, string title)
            {
                m_fileName = fileName;
                m_id = id;
                m_title = title;
            }
        }

        /// <summary>One spoken beat, and the flag that has to be up before it may play.</summary>
        private readonly struct Beat
        {
            public readonly string m_fileName;
            public readonly string m_id;
            public readonly string m_title;
            public readonly string m_requiredFlag;

            public Beat(string fileName, string id, string title, string requiredFlag)
            {
                m_fileName = fileName;
                m_id = id;
                m_title = title;
                m_requiredFlag = requiredFlag;
            }
        }

        // RadioBriefing keeps its original file name: it is already authored and already wired into
        // Main_Gameplay, and renaming it to match the id scheme would break both for no gain.
        private static readonly Transmission[] k_Transmissions =
        {
            new Transmission("RAD-001_Wake", "RAD-001", "苏醒后的第一次呼叫（00-01）"),
            new Transmission("RadioBriefing", "RAD-002", "出发简报（00-03）"),
            new Transmission("RAD-003_Approach", "RAD-003", "接近异色草带前的最后通讯（00-04）"),
            new Transmission("RAD-004_SignalLost", "RAD-004", "信号中断（00-04）")
        };

        private static readonly Beat[] k_Beats =
        {
            new Beat("DLG-100_Wake", "DLG-100", "黑屏苏醒（00-01）", string.Empty),
            new Beat("DLG-101_LeftStartArea", "DLG-101", "离开起始低地（00-02）",
                WorldFlags.k_LeftStartArea),
            new Beat("DLG-102_SignalLost", "DLG-102", "失去外部通讯（00-04）",
                WorldFlags.k_RadioSignalLost),
            new Beat("DLG-103_HelmetRemovable", "DLG-103", "污染读数低于阈值（00-05）",
                WorldFlags.k_HelmetRemovable),
            new Beat("DLG-104_HelmetRemoved", "DLG-104", "摘下头盔（00-05）",
                WorldFlags.k_HelmetRemoved),
            new Beat("DLG-105_GrassBelt", "DLG-105", "进入异色草带（00-06）",
                WorldFlags.k_EnteredGrassBelt),
            new Beat("DLG-106_FirstToolUse", "DLG-106", "第一次使用调查工具（00-07）", string.Empty),
            new Beat("DLG-107_FirstRecord", "DLG-107", "第一条官方记录（00-07）",
                WorldFlags.k_FirstInvestigationDone),
            new Beat("DLG-108_FacilityInSight", "DLG-108", "看见研究设施（00-08）", string.Empty),
            new Beat("DLG-109_MainEntranceBlocked", "DLG-109", "正门无法进入（00-09）",
                WorldFlags.k_MainEntranceBlocked),
            new Beat("DLG-110_MainEntranceSign", "DLG-110", "研究室入口指示牌（00-10）",
                WorldFlags.k_MainEntranceSignRead),
            new Beat("DLG-111_FacilityPoster", "DLG-111", "研究所宣传海报（00-11）",
                WorldFlags.k_ResearchFacilityPosterRead),
            new Beat("DLG-112_AshleafVine", "DLG-112", "灰叶藤（00-12）",
                WorldFlags.k_AshleafVineScanned),
            new Beat("DLG-113_FineVeinedVine", "DLG-113", "细脉藤（00-13）",
                WorldFlags.k_FineVeinedVineScanned),
            new Beat("DLG-114_VineGrowthDirection", "DLG-114", "细脉藤的生长方向（00-14）",
                WorldFlags.k_VineGrowthDirectionObserved),
            new Beat("DLG-115_MaintenanceEntrance", "DLG-115", "露出的检修入口（00-15）",
                WorldFlags.k_MaintenanceEntranceRevealed),
            new Beat("DLG-116_InsideTunnel", "DLG-116", "进入检修通道（00-16）",
                WorldFlags.k_EnteredMaintenanceTunnel)
        };

        [MenuItem("RootsDance/Content/Build Chapter 00 Narrative")]
        public static void Build()
        {
            Directory.CreateDirectory(k_NarrativeFolder);
            Directory.CreateDirectory(k_DialogueFolder);
            Directory.CreateDirectory(k_EventFolder);
            AssetDatabase.Refresh();

            int channels = BuildChannels();

            AudioCueSO radioVoice = LoadCue("VOX_Radio");
            AudioCueSO dialogueVoice = LoadCue("VOX_Dialogue");

            if (radioVoice == null || dialogueVoice == null)
            {
                Debug.LogWarning("[Content] VOX_Radio or VOX_Dialogue is missing. Run "
                    + "RootsDance/Audio/Build Audio Cue Library first, then this item again to fill "
                    + "the voice cue in; the assets are created either way and stay silent until "
                    + "then.");
            }

            int transmissions = 0;
            int transmissionsRouted = 0;

            for (int i = 0; i < k_Transmissions.Length; i++)
            {
                if (Transmit(k_Transmissions[i], radioVoice, out bool routed))
                {
                    transmissions++;
                }

                if (routed)
                {
                    transmissionsRouted++;
                }
            }

            int beats = 0;

            for (int i = 0; i < k_Beats.Length; i++)
            {
                if (Speak(k_Beats[i]))
                {
                    beats++;
                }
            }

            AssetDatabase.SaveAssets();

            Debug.Log($"[Content] Chapter 00: {transmissions} transmission(s) and {beats} spoken "
                + $"beat(s) created, {transmissionsRouted} existing transmission(s) given their "
                + $"voice cue, {channels} channel asset(s) in {k_EventFolder}. Lines are left to "
                + "the writer; every line that exists gets a clip slot of its own.");
        }

        /// <summary>
        /// The channels the flow needs that nothing has created yet. The audio ones are made by
        /// the cue library; these are the narrative half.
        /// </summary>
        private static int BuildChannels()
        {
            int created = 0;

            created += Channel<DialogueEventChannelSO>("DialogueRequested") ? 1 : 0;
            created += Channel<RadioEventChannelSO>("RadioRequested") ? 1 : 0;
            created += Channel<StringEventChannelSO>("RadioLineEnglish") ? 1 : 0;
            created += Channel<VoidEventChannelSO>("ConversationStarted") ? 1 : 0;
            created += Channel<VoidEventChannelSO>("ConversationEnded") ? 1 : 0;

            return created;
        }

        private static bool Channel<T>(string fileName) where T : ScriptableObject
        {
            string path = $"{k_EventFolder}/{fileName}.asset";

            if (AssetDatabase.LoadAssetAtPath<T>(path) != null)
            {
                return false;
            }

            AssetDatabase.CreateAsset(ScriptableObject.CreateInstance<T>(), path);

            return true;
        }

        /// <summary>
        /// Creates a transmission, or fills in what an existing one is missing.
        /// <paramref name="routed"/> reports the second case — the one that matters when the cue
        /// library was run after the content, which is the normal order.
        /// </summary>
        private static bool Transmit(Transmission transmission, AudioCueSO voiceCue, out bool routed)
        {
            routed = false;

            string path = $"{k_NarrativeFolder}/{transmission.m_fileName}.asset";
            RadioSequenceSO sequence = ContentAssetWriter.Ensure<RadioSequenceSO>(path, out bool created);
            SerializedObject serialized = new SerializedObject(sequence);

            if (created)
            {
                ContentAssetWriter.SetString(serialized, "m_id", transmission.m_id);
                ContentAssetWriter.SetString(serialized, "m_title", transmission.m_title);
                ContentAssetWriter.SetFloat(serialized, "m_startDelay", 0.5f);
            }
            else
            {
                // Only the blanks. A transmission that is already authored belongs to whoever wrote
                // it, and the fields below are the ones that did not exist when it was written.
                FillIfEmpty(serialized, "m_id", transmission.m_id);
                FillIfEmpty(serialized, "m_title", transmission.m_title);
            }

            SerializedProperty cue = serialized.FindProperty("m_voiceCue");

            if (cue != null && cue.objectReferenceValue == null && voiceCue != null)
            {
                cue.objectReferenceValue = voiceCue;
                routed = !created;
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(sequence);

            return created;
        }

        /// <summary>
        /// Creates one spoken beat. Unlike a transmission it carries no voice cue: one runner plays
        /// every conversation, so the mix is wired once in the scene rather than onto each asset.
        /// </summary>
        private static bool Speak(Beat beat)
        {
            string path = $"{k_DialogueFolder}/{beat.m_fileName}.asset";
            DialogueSO conversation = ContentAssetWriter.Ensure<DialogueSO>(path, out bool created);

            if (!created)
            {
                return false;
            }

            SerializedObject serialized = new SerializedObject(conversation);
            ContentAssetWriter.SetString(serialized, "m_id", beat.m_id);
            ContentAssetWriter.SetString(serialized, "m_title", beat.m_title);
            ContentAssetWriter.SetString(serialized, "m_requiredFlag", beat.m_requiredFlag);
            ContentAssetWriter.SetBool(serialized, "m_playsOnce", true);
            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(conversation);

            return true;
        }

        private static void FillIfEmpty(SerializedObject serialized, string field, string value)
        {
            SerializedProperty property = serialized.FindProperty(field);

            if (property != null && string.IsNullOrEmpty(property.stringValue))
            {
                property.stringValue = value;
            }
        }

        private static AudioCueSO LoadCue(string fileName)
        {
            return AssetDatabase.LoadAssetAtPath<AudioCueSO>($"{k_CueFolder}/{fileName}.asset");
        }
    }
}

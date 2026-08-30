using System.IO;
using RootsDance.Core;
using RootsDance.Dialogue;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Content
{
    /// <summary>
    /// Writes chapter 02's conversations from the design document — the corridor meeting, the
    /// sprite's remarks around the greenhouse, the staff photograph, and the three-way choice at
    /// the circulation console.
    /// <para>
    /// The console is authored as a conversation rather than as a bespoke terminal component, and
    /// that is a deliberate reduction: what the console asks the player is "one of these three",
    /// which is what a set of dialogue choices already is. Each option raises its own world flag,
    /// and a <c>CueSequence</c> keyed to that flag plays the consequence. Nothing new had to be
    /// built for the chapter's central decision.
    /// </para>
    /// Non-destructive: an existing conversation is left alone.
    /// Menu: RootsDance &gt; Content &gt; Build Chapter 02 Dialogue.
    /// </summary>
    public static class Chapter02DialogueBuilder
    {
        private const string k_Folder = "Assets/RootsDance/Data/Dialogue";
        private const string k_VoiceFolder = "Assets/RootsDance/Audio/Voice/Chapter03";

        /// <summary>One authored line, before it becomes serialized data.</summary>
        private readonly struct Line
        {
            public readonly DialogueSpeaker m_speaker;
            public readonly string m_chinese;
            public readonly string m_english;
            public readonly string m_voiceFile;

            public Line(DialogueSpeaker speaker, string chinese, string english,
                string voiceFile = null)
            {
                m_speaker = speaker;
                m_chinese = chinese;
                m_english = english;
                m_voiceFile = voiceFile;
            }
        }

        /// <summary>One authored option.</summary>
        private class Choice
        {
            public string m_chinese;
            public string m_english;
            public Line[] m_response = new Line[0];
            public string m_followFile;
            public string m_flagOnChosen = string.Empty;
            public string m_voiceFile;
        }

        [MenuItem("RootsDance/Content/Build Chapter 02 Dialogue")]
        public static void Build()
        {
            Directory.CreateDirectory(k_Folder);
            AssetDatabase.Refresh();

            int created = 0;

            // Built before DLG-001, which points at it. Order is the whole dependency management
            // this needs: the follow-up is loaded back off disk when the parent is wired.
            created += Conversation("DLG-002_WhoIsShe", "DLG-002", "追问「她」",
                new[]
                {
                    P("她是谁？", "Who is she?", "VO_C3_MrsDavid_04_WhoIsShe"),
                    F("就是……就是她啦。", "Her. I mean... her.", "VO_C3_Verity_12_HerIMeanHer"),
                    F("这里是她的哦。", "This is hers.", "VO_C3_Verity_11_ThisIsHer"),
                    F("嗯，之前是。", "Well. It was.", "VO_C3_Verity_13_WellItWas")
                },
                null, true, string.Empty, WorldFlags.k_HeardAboutHer) ? 1 : 0;

            created += Conversation("DLG-001_FirstMeeting", "DLG-001", "初次相遇",
                new[]
                {
                    P("……什么东西？", "...What the hell?", "VO_C3_MrsDavid_01_WhatTheHell"),
                    F("啊！", "Ah!", "VO_C3_Verity_01_Ah"),
                    F("……不对，是你先吓到我的。", "...Wait. You scared me first.",
                        "VO_C3_Verity_03_Wait"),
                    P("你会说话？", "You can speak?", "VO_C3_MrsDavid_02_YouCanSpeak"),
                    F("对。", "Yeah.", "VO_C3_Verity_02_Yeah"),
                    F("我说得还可以。", "I'm pretty good at it.", "VO_C3_Verity_04_ImPret")
                },
                new[]
                {
                    new Choice
                    {
                        m_chinese = "……你是什么？",
                        m_english = "...What are you?",
                        m_voiceFile = "MrsDavid/VO_C3_MrsDavid_03_WhatAreYou",
                        m_response = new[]
                        {
                            F("这个问题很复杂。", "That's a very complicated question.",
                                "VO_C3_Verity_06_ThatsAVery"),
                            F("也可能不是。", "...Or maybe it isn't.", "VO_C3_Verity_05_OrMaybeItI"),
                            F("我住在这里。", "I live here.", "VO_C3_Verity_07_ILiveHere")
                        }
                    },
                    new Choice
                    {
                        m_chinese = "这里还有其他人？",
                        m_english = "Is anyone else here?",
                        m_voiceFile = "MrsDavid/VO_C3_MrsDavid_05_IsAnyoneElseHer",
                        m_response = new[]
                        {
                            F("以前有。", "There used to be.", "VO_C3_Verity_08_ThereUsedTo"),
                            F("后来没有了。", "Then there wasn't.", "VO_C3_Verity_09_ThenThereWasnt"),
                            F("不过东西还在。我就在这。", "But the things are still here. And I'm here.",
                                "VO_C3_Verity_10_ButTheThingsAreStillHereAndE")
                        },
                        m_followFile = "DLG-002_WhoIsShe"
                    }
                },
                true, string.Empty, WorldFlags.k_MetFlowerSprite) ? 1 : 0;

            created += Conversation("DLG-003_LeadOn", "DLG-003", "小花带路",
                new[]
                {
                    F("你不去吗？", "Aren't you going?", "VO_C3_Verity_15_ArentYou"),
                    F("我们都很喜欢那边哦！", "We all really like it over there!",
                        "VO_C3_Verity_16_WeAll")
                },
                null, true, string.Empty, string.Empty) ? 1 : 0;

            created += Conversation("DLG-004_ItUsedToBeNeat", "DLG-004", "温室：以前很整齐",
                new[]
                {
                    F("这里以前很整齐。真的，真的，非常，非常整齐。",
                        "It used to be very neat here. Really, really neat. Very, very neat.",
                        "VO_C3_Verity_17_ItUsedToBe"),
                    F("后来！她才不会管我们呢！没有谁喜欢那么长啊！",
                        "But then! She stopped keeping us in line! Nobody likes being that!",
                        "VO_C3_Verity_18_ButThenSheStop")
                },
                null, true, WorldFlags.k_EnteredGreenhouse, string.Empty) ? 1 : 0;

            created += Conversation("DLG-006_SheUsedToMove", "DLG-006", "盖娅雕像",
                new[]
                {
                    F("她以前会流动。", "She used to move.", "VO_C3_Verity_20_SheUsedToMove"),
                    F("很漂亮。", "She was beautiful.", "VO_C3_Verity_21_SheWasBeau"),
                    F("然后有一天，她就停下来了。", "Then one day, she stopped.",
                        "VO_C3_Verity_22_ThenOneDaySheStopped"),
                    P("她？", "She?", "VO_C3_MrsDavid_09_She"),
                    F("嗯。她。", "Yeah. Her.", "VO_C3_Verity_23_YeahHer")
                },
                null, true, string.Empty, string.Empty) ? 1 : 0;

            // The English for this exchange is not in the design document; left empty rather than
            // invented, so the writer can see at a glance what still needs translating.
            created += Conversation("DLG-007_StaffPhotograph", "DLG-007", "研究人员合照",
                new[]
                {
                    P("没有她。至少，没有一个看起来像她的人。", string.Empty,
                        "VO_C3_MrsDavid_10_SheWasntThere"),
                    F("这些人我一个都没见过。不知道是谁。", string.Empty,
                        "VO_C3_Verity_24_IveNeverSeenAn")
                },
                new[]
                {
                    new Choice
                    {
                        m_chinese = "你不是一直在这里吗？",
                        m_english = string.Empty,
                        m_voiceFile = "MrsDavid/VO_C3_MrsDavid_11_WerentYouHereTheWhol",
                        m_response = new[]
                        {
                            F("对呀！我可是一直陪着她呢！我现在还在这里等她！", string.Empty,
                                "VO_C3_Verity_26_OfCourseIveEm")
                        }
                    },
                    new Choice
                    {
                        m_chinese = "那她去哪了？",
                        m_english = string.Empty,
                        m_voiceFile = "MrsDavid/VO_C3_MrsDavid_12_ThenWhereDi",
                        m_response = new[]
                        {
                            F("……嗯。我忘记了。", string.Empty, "VO_C3_Verity_27_UmIStr")
                        }
                    }
                },
                true, string.Empty, WorldFlags.k_SawStaffPhotograph) ? 1 : 0;

            created += BuildConsole() ? 1 : 0;
            created += BuildWrongChoiceOutburst() ? 1 : 0;

            AssetDatabase.SaveAssets();

            Debug.Log($"[Content] Chapter 02: {created} conversation(s) created in {k_Folder}. "
                + "Existing assets were left untouched.");
        }

        /// <summary>
        /// The circulation console. Options do not repeat: the choice is the chapter's decision and
        /// the player gets one.
        /// </summary>
        private static bool BuildConsole()
        {
            return Conversation("DLG-008_CirculationConsole", "DLG-008", "中央循环装置",
                new[]
                {
                    D("GAIA 环境循环装置", "GAIA ENVIRONMENTAL CIRCULATION SYSTEM"),
                    D("系统状态：休眠", "SYSTEM STATUS: Dormant"),
                    D("当前环境参数与预设模型存在偏差。",
                        "Current environmental parameters deviate from the preset model.")
                },
                new[]
                {
                    new Choice
                    {
                        m_chinese = "【核心培育循环】",
                        m_english = "[CORE CULTIVATION CYCLE]",
                        m_response = new[]
                        {
                            D("适用于集中样本的集中培育与稳定观察。",
                                "For concentrated cultivation and stable observation of pooled samples.")
                        },
                        m_flagOnChosen = WorldFlags.k_CirculationCore
                    },
                    new Choice
                    {
                        m_chinese = "【标准环形循环】",
                        m_english = "[STANDARD RING CYCLE]",
                        m_response = new[]
                        {
                            D("培育区进行均衡供给。", "Balanced supply across the cultivation zones.")
                        },
                        m_flagOnChosen = WorldFlags.k_CirculationRing
                    },
                    new Choice
                    {
                        m_chinese = "【外缘检测循环】",
                        m_english = "[OUTER BOUNDARY SURVEY CYCLE]",
                        m_response = new[]
                        {
                            D("用于观测区域外缘变化及新增生长带。",
                                "For observing change at the zone's outer edge and newly grown belts.")
                        },
                        m_flagOnChosen = WorldFlags.k_CirculationOuter
                    }
                },
                false, string.Empty, string.Empty);
        }

        /// <summary>The sprite's reaction to either wrong cycle. Played by a CueSequence on the flag.</summary>
        private static bool BuildWrongChoiceOutburst()
        {
            return Conversation("DLG-009_TheyAreNotThere", "DLG-009", "错误循环：它们已经不在那里了",
                new[]
                {
                    F("哦。哦哦哦。", "Oh. Oh, oh, oh.", "VO_C3_Verity_28_OhOh"),
                    F("你选了这个。", "You picked this.", "VO_C3_Verity_29_YouPicked"),
                    F("没关系，没关系，机器有时候就是会——",
                        "It's okay. It's okay. Machines just sometimes—"),
                    F("……等等。", "...Wait.", "VO_C3_Verity_30_Wait"),
                    F("你真的选了这个。", "You really picked this."),
                    F("不，不，不不不。", "No. No, no, no."),
                    F("停下来。", "Stop it.", "VO_C3_Verity_31_StopIt"),
                    F("把它停下来。", "Make it stop.", "VO_C3_Verity_33_MakeItStop"),
                    F("它们已经不在那里了！", "They're not there anymore!",
                        "VO_C3_Verity_32_TheyreNotThere"),
                    F("拿着东西。站在这里。", "Take things. Stand here.",
                        "VO_C3_Verity_34_TakeThingsStan"),
                    F("然后说，嗯，这里应该这样。", "And then say, um, it should be like this."),
                    F("可是——", "But—", "VO_C3_Verity_36_But"),
                    F("停下来。", "Stop.", "VO_C3_Verity_35_Stop"),
                    F("停下来！", "Stop!", "VO_C3_Verity_37_Stop"),
                    F("它们已经不在那里了！", "They're not there anymore!",
                        "VO_C3_Verity_38_TheyreNotThere"),
                    F("为什么你们总想让活着的东西，回到已经死掉的地方？",
                        "Why do you always want to make living things go back to somewhere that's already dead?",
                        "VO_C3_Verity_39_WhyDoYouAlwa"),
                    F("它们没有出错。", "They didn't do anything wrong.",
                        "VO_C3_Verity_40_TheyDidntDoAn")
                },
                null, true, string.Empty, string.Empty);
        }

        private static Line P(string chinese, string english, string voiceFile = null)
        {
            return new Line(DialogueSpeaker.Protagonist, chinese, english,
                voiceFile == null ? null : $"MrsDavid/{voiceFile}");
        }

        private static Line F(string chinese, string english, string voiceFile = null)
        {
            return new Line(DialogueSpeaker.Flower, chinese, english,
                voiceFile == null ? null : $"Verity/{voiceFile}");
        }

        private static Line D(string chinese, string english)
        {
            return new Line(DialogueSpeaker.Device, chinese, english);
        }

        private static AudioClip LoadVoice(string voiceFile)
        {
            if (string.IsNullOrEmpty(voiceFile))
            {
                return null;
            }

            string path = $"{k_VoiceFolder}/{voiceFile}.mp3";
            AudioClip clip = AssetDatabase.LoadAssetAtPath<AudioClip>(path);

            if (clip == null)
            {
                Debug.LogWarning($"[Content] Voice take '{path}' was not found; the line ships silent.");
            }

            return clip;
        }

        private static bool Conversation(string fileName, string id, string title, Line[] lines,
            Choice[] choices, bool choicesRepeat, string requiredFlag, string flagOnComplete)
        {
            DialogueSO conversation = ContentAssetWriter.Ensure<DialogueSO>(
                $"{k_Folder}/{fileName}.asset", out bool created);

            if (!created)
            {
                return false;
            }

            SerializedObject serialized = new SerializedObject(conversation);
            ContentAssetWriter.SetString(serialized, "m_id", id);
            ContentAssetWriter.SetString(serialized, "m_title", title);
            ContentAssetWriter.SetBool(serialized, "m_choicesRepeat", choicesRepeat);
            ContentAssetWriter.SetBool(serialized, "m_playsOnce", true);
            ContentAssetWriter.SetString(serialized, "m_requiredFlag", requiredFlag);
            ContentAssetWriter.SetString(serialized, "m_flagOnComplete", flagOnComplete);

            WriteLines(serialized.FindProperty("m_lines"), lines);
            WriteChoices(serialized.FindProperty("m_choices"), choices);

            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(conversation);

            return true;
        }

        private static void WriteLines(SerializedProperty property, Line[] lines)
        {
            if (property == null)
            {
                return;
            }

            int count = lines == null ? 0 : lines.Length;
            property.arraySize = count;

            for (int i = 0; i < count; i++)
            {
                SerializedProperty entry = property.GetArrayElementAtIndex(i);
                entry.FindPropertyRelative("m_speaker").enumValueIndex = (int)lines[i].m_speaker;
                entry.FindPropertyRelative("m_chinese").stringValue = lines[i].m_chinese;
                entry.FindPropertyRelative("m_english").stringValue = lines[i].m_english;

                // 0 means "work it out from the text" — see DialogueTiming. Authoring a hold per
                // line is work that only pays off for a deliberate pause, and none of these are.
                entry.FindPropertyRelative("m_holdSeconds").floatValue = 0f;

                entry.FindPropertyRelative("m_voice").objectReferenceValue =
                    LoadVoice(lines[i].m_voiceFile);
            }
        }

        private static void WriteChoices(SerializedProperty property, Choice[] choices)
        {
            if (property == null)
            {
                return;
            }

            int count = choices == null ? 0 : choices.Length;
            property.arraySize = count;

            for (int i = 0; i < count; i++)
            {
                SerializedProperty entry = property.GetArrayElementAtIndex(i);
                entry.FindPropertyRelative("m_chinese").stringValue = choices[i].m_chinese;
                entry.FindPropertyRelative("m_english").stringValue = choices[i].m_english;
                entry.FindPropertyRelative("m_flagOnChosen").stringValue = choices[i].m_flagOnChosen;
                entry.FindPropertyRelative("m_voice").objectReferenceValue =
                    LoadVoice(choices[i].m_voiceFile);

                WriteLines(entry.FindPropertyRelative("m_response"), choices[i].m_response);

                DialogueSO follow = string.IsNullOrEmpty(choices[i].m_followFile)
                    ? null
                    : AssetDatabase.LoadAssetAtPath<DialogueSO>(
                        $"{k_Folder}/{choices[i].m_followFile}.asset");

                if (follow == null && !string.IsNullOrEmpty(choices[i].m_followFile))
                {
                    Debug.LogWarning($"[Content] Follow-up '{choices[i].m_followFile}' was not found; "
                        + "build it before the conversation that points at it.");
                }

                entry.FindPropertyRelative("m_follow").objectReferenceValue = follow;
            }
        }
    }
}

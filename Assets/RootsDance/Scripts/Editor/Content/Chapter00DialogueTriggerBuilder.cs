using System;
using System.Collections.Generic;
using RootsDance.Dialogue;
using RootsDance.Events;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Content
{
    /// <summary>
    /// Hangs chapter 00's spoken beats off the flags the level already raises, so that a
    /// conversation plays the moment its beat happens instead of waiting for someone to place a
    /// volume for it.
    /// <para>
    /// Every one of these conversations is gated on a flag already — that is what
    /// <c>DialogueSO.RequiredFlag</c> is — and chapter 00's route raises those flags from the
    /// triggers, the scanner and the investigation targets that are in the scene. So the trigger
    /// this builder places carries no collider and no position: it listens on
    /// <c>Data/Events/FlagRaised</c> for the conversation's own required flag and asks for it. A
    /// beat that later wants a place of its own gets a volume by hand; nothing here has to move for
    /// that, because a conversation refuses to play twice.
    /// </para>
    /// <para>
    /// The flag is read out of each conversation rather than typed here, so renaming a flag in the
    /// asset cannot leave a trigger listening for the old one. A conversation with no required flag
    /// is skipped and named in the log: there is nothing to hang it on, and guessing would put a
    /// story beat in the wrong place.
    /// </para>
    /// <para>
    /// Conversations that have no lines yet still get their trigger. An empty conversation costs a
    /// started/ended pair and shows nothing, and the wiring is then already in place for whoever
    /// types the copy in. The log says which ones are still empty.
    /// </para>
    /// Idempotent: hosts are found by name and re-wired rather than duplicated.
    /// Menu: RootsDance &gt; Content &gt; Wire Chapter 00 Dialogue Triggers.
    /// </summary>
    public static class Chapter00DialogueTriggerBuilder
    {
        private const string k_Gameplay = "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";
        private const string k_NarrativeRoot = "Narrative";
        private const string k_DialogueRoot = "Dialogue";

        private const string k_DialogueFolder = "Assets/RootsDance/Data/Dialogue";
        private const string k_EventsFolder = "Assets/RootsDance/Data/Events";
        private const string k_DialogueChannelPath = k_EventsFolder + "/DialogueRequested.asset";
        private const string k_FlagRaisedPath = k_EventsFolder + "/FlagRaised.asset";

        /// <summary>Chapter 00's conversations, in the order the route plays them.</summary>
        private static readonly string[] k_Conversations =
        {
            "DLG-100_Wake",
            "DLG-101_LeftStartArea",
            "DLG-102_SignalLost",
            "DLG-103_HelmetRemovable",
            "DLG-104_HelmetRemoved",
            "DLG-105_GrassBelt",
            "DLG-106_FirstToolUse",
            "DLG-107_FirstRecord",
            "DLG-108_FacilityInSight",
            "DLG-109_MainEntranceBlocked",
            "DLG-110_MainEntranceSign",
            "DLG-111_FacilityPoster",
            "DLG-112_AshleafVine",
            "DLG-113_FineVeinedVine",
            "DLG-114_VineGrowthDirection",
            "DLG-115_MaintenanceEntrance",
            "DLG-116_InsideTunnel"
        };

        [MenuItem("RootsDance/Content/Wire Chapter 00 Dialogue Triggers")]
        public static void Build()
        {
            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                Debug.LogWarning("[Content] Chapter 00 dialogue triggers cancelled: current scenes "
                    + "have unsaved changes.");
                return;
            }

            DialogueEventChannelSO channel = LoadRequired<DialogueEventChannelSO>(k_DialogueChannelPath);
            StringEventChannelSO flagRaised = LoadRequired<StringEventChannelSO>(k_FlagRaisedPath);

            Scene scene = EditorSceneManager.OpenScene(k_Gameplay, OpenSceneMode.Single);
            Transform parent = EnsureChild(EnsureRoot(scene, k_NarrativeRoot), k_DialogueRoot);

            List<string> wired = new List<string>();
            List<string> unhung = new List<string>();
            List<string> empty = new List<string>();

            for (int i = 0; i < k_Conversations.Length; i++)
            {
                string fileName = k_Conversations[i];
                DialogueSO conversation =
                    AssetDatabase.LoadAssetAtPath<DialogueSO>($"{k_DialogueFolder}/{fileName}.asset");

                if (conversation == null)
                {
                    Debug.LogWarning($"[Content] Missing conversation '{fileName}' — run "
                        + "RootsDance > Content > Build Chapter 00 Narrative first.");
                    continue;
                }

                if (string.IsNullOrEmpty(conversation.RequiredFlag))
                {
                    // Nothing in the level marks this beat yet. Remove any host left from a run
                    // made before the flag was cleared, so a stale trigger cannot fire.
                    Remove(parent, fileName);
                    unhung.Add(conversation.Id);
                    continue;
                }

                Wire(EnsureChild(parent, fileName).gameObject, conversation, channel, flagRaised);
                wired.Add($"{conversation.Id}←{conversation.RequiredFlag}");

                if (conversation.Lines == null || conversation.Lines.Length == 0)
                {
                    empty.Add(conversation.Id);
                }
            }

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);

            Debug.Log($"[Content] Chapter 00 dialogue triggers on '{k_NarrativeRoot}/{k_DialogueRoot}': "
                + $"{wired.Count} wired ({string.Join(", ", wired)}). "
                + $"No required flag, nothing to hang them on: {Join(unhung)}. "
                + $"Wired but still without a written line: {Join(empty)}.");
        }

        /// <summary>Batch entry point (-executeMethod).</summary>
        public static void BuildFromCommandLine()
        {
            Build();
        }

        private static void Wire(GameObject host, DialogueSO conversation,
            DialogueEventChannelSO channel, StringEventChannelSO flagRaised)
        {
            DialogueTrigger trigger = EnsureComponent<DialogueTrigger>(host);

            using (SerializedObject serialized = new SerializedObject(trigger))
            {
                serialized.FindProperty("m_conversation").objectReferenceValue = conversation;
                serialized.FindProperty("m_channel").objectReferenceValue = channel;
                serialized.FindProperty("m_playOn").enumValueIndex =
                    (int)DialogueTrigger.Moment.OnFlagRaised;
                serialized.FindProperty("m_flagId").stringValue = conversation.RequiredFlag;
                serialized.FindProperty("m_flagRaised").objectReferenceValue = flagRaised;
                serialized.FindProperty("m_fireOnce").boolValue = true;
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }
        }

        private static string Join(List<string> ids)
        {
            return ids.Count == 0 ? "none" : string.Join(", ", ids);
        }

        private static T LoadRequired<T>(string path) where T : UnityEngine.Object
        {
            T asset = AssetDatabase.LoadAssetAtPath<T>(path);

            if (asset == null)
            {
                throw new InvalidOperationException($"Required asset missing: {path}");
            }

            return asset;
        }

        private static T EnsureComponent<T>(GameObject target) where T : Component
        {
            T component = target.GetComponent<T>();
            return component != null ? component : target.AddComponent<T>();
        }

        private static Transform EnsureRoot(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == name)
                {
                    return roots[i].transform;
                }
            }

            GameObject created = new GameObject(name);
            SceneManager.MoveGameObjectToScene(created, scene);
            return created.transform;
        }

        private static Transform EnsureChild(Transform parent, string name)
        {
            Transform existing = parent.Find(name);

            if (existing != null)
            {
                return existing;
            }

            GameObject child = new GameObject(name);
            child.transform.SetParent(parent, false);
            return child.transform;
        }

        private static void Remove(Transform parent, string name)
        {
            Transform existing = parent.Find(name);

            if (existing != null)
            {
                UnityEngine.Object.DestroyImmediate(existing.gameObject);
            }
        }
    }
}

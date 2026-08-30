using RootsDance.App;
using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Player;
using RootsDance.World;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Wires node 00-05 — the seal — at both ends.
    /// <para>
    /// On the player prefab: the two visor channels the helmet talks on, so a press on a locked
    /// seal is refused in writing instead of doing nothing, and so the standing hint is up from
    /// the moment the suit offers the release.
    /// </para>
    /// <para>
    /// In Main_Gameplay: a <see cref="FlagGate"/> across the route a little past the unlock volume.
    /// It is what makes the hint mean something — the belt is on the other side of it, and it only
    /// opens on <c>flow.helmet_removed</c>. Placed from the two triggers it sits between rather
    /// than from typed-in coordinates, so it follows them if the route is re-walked.
    /// </para>
    /// Menu: RootsDance > Content > Wire Chapter 00 Helmet Seal.
    /// </summary>
    public static class Chapter00HelmetSealBuilder
    {
        private const string k_PlayerPrefab = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_TriggersRoot = "Triggers";
        private const string k_GatesRoot = "Gates";
        private const string k_GateName = "HelmetSealGate";
        private const string k_UnlockTrigger = "HelmetUnlock";
        private const string k_BeltTrigger = "GrassBelt";

        /// <summary>
        /// Metres past the unlock station's anchor. The trigger collider is fitted to the wall
        /// afterwards, so every route receives the notice before the player reaches the seal.
        /// </summary>
        private const float k_GateDistance = 8f;

        /// <summary>
        /// Across the route. The forest shell is ~73 m wide at this z, so this spans it with room
        /// on both sides — an invisible wall that can be walked round is worse than none.
        /// </summary>
        private const float k_GateWidth = 84f;

        /// <summary>Tall and deep enough that the undulating terrain cannot open a gap under it.</summary>
        private const float k_GateHeight = 20f;

        private const float k_GateThickness = 2f;

        // Cover every approach to the wall, including the sloping route along its left end.
        private const float k_UnlockApproachDepth = 10f;
        private const float k_UnlockMargin = 2f;

        /// <summary>Fits the loaded scene's unlock volume without rebuilding or saving other content.</summary>
        [MenuItem("RootsDance/Content/Fit Helmet Unlock To Existing Gate (No Save)")]
        public static void FitUnlockToExistingGate()
        {
            Scene scene = SceneManager.GetSceneByPath(ScenePaths.k_MainGameplay);
            if (!scene.IsValid() || !scene.isLoaded)
            {
                Debug.LogError("[Content] Open Main_Gameplay before fitting the helmet unlock trigger.");
                return;
            }

            Transform triggers = Find(scene, k_TriggersRoot);
            Transform gates = Find(scene, k_GatesRoot);
            Transform unlock = triggers == null ? null : triggers.Find(k_UnlockTrigger);
            Transform gate = gates == null ? null : gates.Find(k_GateName);
            BoxCollider wall = gate == null ? null : gate.GetComponent<BoxCollider>();
            if (unlock == null || wall == null || unlock.GetComponent<BoxCollider>() == null)
            {
                Debug.LogError("[Content] HelmetUnlock and HelmetSealGate must both have BoxColliders.");
                return;
            }

            FitUnlockTrigger(unlock, wall);
            EditorSceneManager.MarkSceneDirty(scene);
        }

        [MenuItem("RootsDance/Content/Wire Chapter 00 Helmet Seal")]
        public static void Build()
        {
            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                Debug.LogWarning("[Content] Helmet seal cancelled: current scenes have unsaved changes.");
                return;
            }

            EventChannelAssets.EnsureHelmetChannels(out StringEventChannelSO notice,
                out StringEventChannelSO warning);

            WirePlayer(notice, warning);
            BuildGate();
        }

        /// <summary>
        /// Fills the helmet's new channel fields on the prefab. Only empty slots are written: the
        /// texts are content, and a writer who has since changed the refusal is the authority on
        /// what it says, not this builder.
        /// </summary>
        private static void WirePlayer(StringEventChannelSO notice, StringEventChannelSO warning)
        {
            GameObject contents = PrefabUtility.LoadPrefabContents(k_PlayerPrefab);

            if (contents == null)
            {
                Debug.LogError($"[Content] {k_PlayerPrefab} could not be opened; the helmet's "
                    + "channels are unwired and the seal will still fail silently.");
                return;
            }

            try
            {
                HelmetController helmet = contents.GetComponentInChildren<HelmetController>(true);

                if (helmet == null)
                {
                    Debug.LogError($"[Content] {k_PlayerPrefab} has no HelmetController.");
                    return;
                }

                SerializedObject serialized = new SerializedObject(helmet);

                Fill(serialized, "m_hintRequested", notice);
                Fill(serialized, "m_warningRequested", warning);
                Fill(serialized, "m_conversationStarted",
                    EventChannelAssets.Ensure<VoidEventChannelSO>(
                        EventChannelAssets.k_ConversationStarted));
                Fill(serialized, "m_conversationEnded",
                    EventChannelAssets.Ensure<VoidEventChannelSO>(
                        EventChannelAssets.k_ConversationEnded));

                serialized.ApplyModifiedPropertiesWithoutUndo();

                PrefabUtility.SaveAsPrefabAsset(contents, k_PlayerPrefab);
                Debug.Log($"[Content] {k_PlayerPrefab}: helmet notice, warning and conversation "
                    + "channels wired.");
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(contents);
            }
        }

        private static void Fill(SerializedObject serialized, string field, Object value)
        {
            SerializedProperty property = serialized.FindProperty(field);

            if (property == null)
            {
                Debug.LogWarning($"[Content] HelmetController has no field '{field}'.");
                return;
            }

            if (property.objectReferenceValue == null)
            {
                property.objectReferenceValue = value;
            }
        }

        private static void BuildGate()
        {
            Scene scene = EditorSceneManager.OpenScene(ScenePaths.k_MainGameplay, OpenSceneMode.Single);

            Transform triggers = Find(scene, k_TriggersRoot);
            Transform unlock = triggers == null ? null : triggers.Find(k_UnlockTrigger);
            Transform belt = triggers == null ? null : triggers.Find(k_BeltTrigger);

            if (unlock == null || belt == null)
            {
                Debug.LogError($"[Content] {ScenePaths.k_MainGameplay} has no "
                    + $"'{k_TriggersRoot}/{k_UnlockTrigger}' or '{k_TriggersRoot}/{k_BeltTrigger}'. "
                    + "The gate is placed between those two, so there is nothing to place it against.");
                return;
            }

            Vector3 from = unlock.position;
            Vector3 to = belt.position;
            Vector3 along = to - from;
            along.y = 0f;

            if (along.sqrMagnitude < 0.01f)
            {
                Debug.LogError($"[Content] '{k_UnlockTrigger}' and '{k_BeltTrigger}' sit on top of "
                    + "each other; the gate has no direction to face.");
                return;
            }

            float distance = along.magnitude;
            float travelled = Mathf.Min(k_GateDistance, distance * 0.5f);
            Vector3 position = from + along.normalized * travelled;
            position.y = Mathf.Lerp(from.y, to.y, travelled / distance);

            Transform gates = EnsureRoot(scene, k_GatesRoot);
            Transform existing = gates.Find(k_GateName);

            if (existing != null)
            {
                Object.DestroyImmediate(existing.gameObject);
            }

            GameObject gate = new GameObject(k_GateName, typeof(BoxCollider));
            gate.transform.SetParent(gates, worldPositionStays: false);
            gate.transform.SetPositionAndRotation(position, Quaternion.LookRotation(along.normalized));

            BoxCollider box = gate.GetComponent<BoxCollider>();
            box.size = new Vector3(k_GateWidth, k_GateHeight, k_GateThickness);

            FitUnlockTrigger(unlock, box);

            FlagGate flagGate = gate.AddComponent<FlagGate>();
            SerializedObject serialized = new SerializedObject(flagGate);
            serialized.FindProperty("m_flagRaised").objectReferenceValue =
                EventChannelAssets.Ensure<StringEventChannelSO>(EventChannelAssets.k_FlagRaised);
            serialized.FindProperty("m_openFlag").stringValue = WorldFlags.k_HelmetRemoved;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);

            Debug.Log($"[Content] {k_GatesRoot}/{k_GateName} placed at {position}, {k_GateWidth} m "
                + $"across and {travelled:0.#} m past '{k_UnlockTrigger}' towards '{k_BeltTrigger}'. "
                + $"It opens on '{WorldFlags.k_HelmetRemoved}' and never closes again. Walk the "
                + "route in Play mode and check both ends of the wall meet the forest shell.");
        }

        private static void FitUnlockTrigger(Transform unlock, BoxCollider wall)
        {
            BoxCollider trigger = unlock.GetComponent<BoxCollider>();
            Undo.RecordObjects(new Object[] { unlock, trigger }, "Fit helmet unlock approach");

            // Keep the station's position: the seal and radio builders use it as a route anchor.
            // Shift only the collider centre, so rebuilding the seal cannot move it farther forward.
            unlock.rotation = wall.transform.rotation;
            Vector3 wallSize = Vector3.Scale(wall.size, wall.transform.lossyScale);
            float depth = Mathf.Max(k_UnlockApproachDepth, wallSize.z);
            Vector3 centre = wall.transform.TransformPoint(wall.center)
                - wall.transform.forward * ((depth - wallSize.z) * 0.5f);
            Vector3 scale = unlock.lossyScale;
            trigger.center = unlock.InverseTransformPoint(centre);
            trigger.size = new Vector3(
                (wallSize.x + k_UnlockMargin) / scale.x,
                (wallSize.y + k_UnlockMargin) / scale.y,
                depth / scale.z);
            trigger.isTrigger = true;
        }

        private static Transform Find(Scene scene, string rootName)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == rootName)
                {
                    return root.transform;
                }
            }

            return null;
        }

        private static Transform EnsureRoot(Scene scene, string rootName)
        {
            Transform existing = Find(scene, rootName);

            if (existing != null)
            {
                return existing;
            }

            GameObject root = new GameObject(rootName);
            SceneManager.MoveGameObjectToScene(root, scene);

            return root.transform;
        }
    }
}

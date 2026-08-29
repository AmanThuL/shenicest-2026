using RootsDance.Archive;
using RootsDance.Data;
using RootsDance.Events;
using RootsDance.Interaction;
using RootsDance.Player;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Archive
{
    /// <summary>
    /// Wires the archive into whatever scene is open so it can be played: puts a reader on the
    /// player, hangs a hold anchor off the head, and lays a sheet on the ground in front of them.
    /// <para>
    /// The scene is left <b>dirty, not saved</b>. Placing props is the level owner's call and two
    /// people editing one scene is how merge conflicts start (guideline 11) — so this sets the
    /// scene up to be played and leaves saving to whoever ran it.
    /// </para>
    /// </summary>
    public static class ArchivePlaytestBuilder
    {
        private const string k_LogPrefix = "ArchivePlaytestBuilder";
        private const string k_AnchorName = "DocumentHoldAnchor";

        /// <summary>How far in front of the player the sheets are laid, in metres.</summary>
        private const float k_Reach = 1.4f;

        /// <summary>Height the sheets are laid at, in metres — about a desk.</summary>
        private const float k_DeskHeight = 0.9f;

        [MenuItem("RootsDance/Archive/Set Up Playtest In Open Scene")]
        public static void SetUp()
        {
            FirstPersonController player = Object.FindFirstObjectByType<FirstPersonController>();

            if (player == null)
            {
                Debug.LogError($"[{k_LogPrefix}] No player in the open scene. Open a level's "
                    + "Gameplay scene — PlayerTest_Gameplay is the usual one — and run this again.");
                return;
            }

            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(
                ArchiveDocumentPrefabBuilder.k_PrefabPath);

            if (prefab == null)
            {
                Debug.LogError($"[{k_LogPrefix}] The page prefab is missing; run "
                    + "RootsDance/Archive/Build All first.");
                return;
            }

            DocumentInspectController reader = SetUpReader(player);
            SetUpOffer(player, reader);
            int placed = PlaceSheets(prefab, player.transform);

            EditorSceneManager.MarkSceneDirty(SceneManager.GetActiveScene());

            Debug.Log($"[{k_LogPrefix}] Ready: {placed} sheet(s) in front of the player, reader on "
                + $"'{reader.name}'. The scene is NOT saved. Press Play, walk towards a sheet — the "
                + "hint appears when you are in range — and press E.", reader);
        }

        /// <summary>Puts the read loop on the player and wires it to what it has to suspend.</summary>
        private static DocumentInspectController SetUpReader(FirstPersonController player)
        {
            GameObject root = player.gameObject;
            DocumentInspectController reader = root.GetComponent<DocumentInspectController>();

            if (reader == null)
            {
                reader = root.AddComponent<DocumentInspectController>();
            }

            Transform head = FindHead(root.transform);
            Transform anchor = head.Find(k_AnchorName);

            if (anchor == null)
            {
                anchor = new GameObject(k_AnchorName).transform;
                anchor.SetParent(head, false);
            }

            // Straight ahead of the eye. The sheet stands off along this axis, so its forward has
            // to be the direction of view.
            anchor.localPosition = Vector3.zero;
            anchor.localRotation = Quaternion.identity;

            SerializedObject serialized = new SerializedObject(reader);
            serialized.FindProperty("m_holdAnchor").objectReferenceValue = anchor;
            serialized.FindProperty("m_input").objectReferenceValue =
                root.GetComponentInChildren<PlayerInputReader>(true);

            // One owner per axis: while a sheet is up it owns the mouse, so look, move and the
            // interaction ray all stand down.
            SerializedProperty suspended = serialized.FindProperty("m_suspendedWhileReading");
            Behaviour[] toSuspend =
            {
                root.GetComponentInChildren<PlayerLook>(true),
                player,
                root.GetComponentInChildren<InteractionRaycaster>(true)
            };

            suspended.arraySize = 0;

            for (int i = 0; i < toSuspend.Length; i++)
            {
                if (toSuspend[i] == null)
                {
                    continue;
                }

                suspended.arraySize++;
                suspended.GetArrayElementAtIndex(suspended.arraySize - 1).objectReferenceValue =
                    toSuspend[i];
            }

            serialized.ApplyModifiedProperties();

            return reader;
        }

        /// <summary>
        /// Puts the proximity offer on the player, so a sheet is offered by walking near it rather
        /// than by aiming at it. Aiming does not work for a document: it lies flat, and the
        /// centre-screen ray goes over the top of it.
        /// </summary>
        private static void SetUpOffer(FirstPersonController player, DocumentInspectController reader)
        {
            GameObject root = player.gameObject;
            ArchiveProximityTrigger trigger = root.GetComponent<ArchiveProximityTrigger>();

            if (trigger == null)
            {
                trigger = root.AddComponent<ArchiveProximityTrigger>();
            }

            SerializedObject serialized = new SerializedObject(trigger);
            serialized.FindProperty("m_controller").objectReferenceValue = reader;
            serialized.FindProperty("m_player").objectReferenceValue = FindHead(root.transform);
            serialized.FindProperty("m_input").objectReferenceValue =
                root.GetComponentInChildren<PlayerInputReader>(true);
            serialized.FindProperty("m_promptChanged").objectReferenceValue = FindPromptChannel();
            serialized.ApplyModifiedProperties();
        }

        /// <summary>The channel the HUD listens on for interaction hints.</summary>
        private static StringEventChannelSO FindPromptChannel()
        {
            return AssetDatabase.LoadAssetAtPath<StringEventChannelSO>(
                "Assets/RootsDance/Data/Events/InteractionPrompt.asset");
        }

        /// <summary>The transform the camera follows, or the player itself when there is no head.</summary>
        private static Transform FindHead(Transform root)
        {
            Transform head = root.Find("Head");

            if (head != null)
            {
                return head;
            }

            PlayerLook look = root.GetComponentInChildren<PlayerLook>(true);

            return look == null ? root : look.transform;
        }

        /// <summary>Lays one sheet per authored document on the ground in front of the player.</summary>
        private static int PlaceSheets(GameObject prefab, Transform player)
        {
            ArchiveDocumentSO[] documents = ArchivePageStage.LoadDocuments();
            LayerMask allowed = AllowedLayers();
            int placed = 0;

            for (int i = 0; i < documents.Length; i++)
            {
                GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab);
                instance.name = $"ArchiveDocument_{documents[i].Id}";

                // Spread along the player's right so several are reachable from one spot, and set
                // at about desk height: a sheet at ankle level is fine for a proximity offer but
                // impossible to look at, and it was invisible to the centre-screen ray entirely.
                Vector3 across = player.right * ((i - (documents.Length - 1) * 0.5f) * 0.34f);
                instance.transform.position = player.position + player.forward * k_Reach
                    + across + Vector3.up * k_DeskHeight;

                // Face up: the readable side of a page looks back along its own forward axis.
                instance.transform.rotation = Quaternion.LookRotation(Vector3.down, player.forward);

                SetLayerRecursively(instance, FirstLayerIn(allowed));

                SerializedObject serialized = new SerializedObject(
                    instance.GetComponent<ArchiveDocumentPickup>());
                serialized.FindProperty("m_document").objectReferenceValue = documents[i];
                serialized.ApplyModifiedProperties();

                Undo.RegisterCreatedObjectUndo(instance, "Place archive document");
                placed++;
            }

            return placed;
        }

        private static LayerMask AllowedLayers()
        {
            string[] guids = AssetDatabase.FindAssets("t:InteractionConfigSO");

            if (guids.Length == 0)
            {
                return ~0;
            }

            InteractionConfigSO config = AssetDatabase.LoadAssetAtPath<InteractionConfigSO>(
                AssetDatabase.GUIDToAssetPath(guids[0]));

            return config == null ? ~0 : config.InteractableLayers;
        }

        /// <summary>The lowest layer the interaction ray accepts, so the sheet is sure to be hit.</summary>
        private static int FirstLayerIn(LayerMask mask)
        {
            for (int layer = 0; layer < 32; layer++)
            {
                if ((mask.value & (1 << layer)) != 0 && !string.IsNullOrEmpty(LayerMask.LayerToName(layer)))
                {
                    return layer;
                }
            }

            return 0;
        }

        private static void SetLayerRecursively(GameObject target, int layer)
        {
            target.layer = layer;

            for (int i = 0; i < target.transform.childCount; i++)
            {
                SetLayerRecursively(target.transform.GetChild(i).gameObject, layer);
            }
        }
    }
}

using RootsDance.Events;
using RootsDance.Interaction;
using RootsDance.Player;
using RootsDance.Scanner;
using RootsDance.World;
using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using Object = UnityEngine.Object;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Builds <c>Prefabs/Props/CirculationTerminal.prefab</c>: the circulation console as a panel
    /// bolted to a wall, and the read camera parked in front of it.
    /// <para>
    /// The panel is a slab, not a model. Three boxes — a housing, a bezel and the lit face — are
    /// the whole of it, because everything that carries meaning is already on the screen and a
    /// modelled frame around it would be work that changes nothing the player reads. The level's
    /// art owner can swap the housing for a mesh later; the screen, the collider and the camera
    /// hang off named children, not off the box.
    /// </para>
    /// <para>
    /// The screen itself is <c>CirculationConsoleScreen.prefab</c>'s canvas, re-parented into
    /// world space and scaled down. One screen, two homes: the same prefab and the same presenter,
    /// so a change to the console is a change to both.
    /// </para>
    /// <para>
    /// The read camera is framed here rather than at runtime. Its distance comes from
    /// <see cref="ScreenFraming.DistanceForFill"/> — the scanner's own framing sum — against the
    /// panel's built size, and the panel never changes size, so there is nothing left for a
    /// runtime component to recompute.
    /// </para>
    /// Idempotent. Menu: RootsDance &gt; UI &gt; Build Circulation Terminal.
    /// </summary>
    public static class CirculationTerminalBuilder
    {
        public const string k_PrefabPath =
            "Assets/RootsDance/Prefabs/Props/CirculationTerminal.prefab";

        private const string k_ScreenPrefab =
            "Assets/RootsDance/Prefabs/UI/CirculationConsoleScreen.prefab";

        private const string k_MaterialFolder = "Assets/RootsDance/Materials/Props";
        private const string k_HousingMaterial = k_MaterialFolder + "/TerminalHousing.mat";
        private const string k_BezelMaterial = k_MaterialFolder + "/TerminalBezel.mat";

        /// <summary>Metres. A panel a person reads standing in front of it.</summary>
        private const float k_ScreenWidth = 1.28f;

        private const float k_ScreenHeight = 0.82f;

        /// <summary>Metres of bezel on every side of the lit area.</summary>
        private const float k_Bezel = 0.05f;

        /// <summary>Metres. How far the housing stands off the wall.</summary>
        private const float k_Depth = 0.09f;

        /// <summary>Fraction of the viewport the screen covers when read. A little under 1.</summary>
        private const float k_ScreenFill = 0.88f;

        private const float k_ReadFieldOfView = 34f;

        /// <summary>The canvas is authored at this many units across; see the screen builder.</summary>
        private const float k_CanvasWidth = 1180f;

        private const float k_CanvasHeight = 760f;

        private const string k_PropScene =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Environment_2.unity";

        private const string k_GameplayScene =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Gameplay.unity";

        private const string k_PromptChannel =
            "Assets/RootsDance/Data/Events/InteractionPrompt.asset";

        private const string k_InstanceName = "CirculationTerminal";

        /// <summary>
        /// On the wall the narrative builder already puts the console interaction against, at a
        /// height a standing person reads without tilting their head. Its +Z faces back down the
        /// room, towards the checkpoint the player arrives at.
        /// </summary>
        private static readonly Vector3 k_WallPosition = new Vector3(0f, 1.45f, 2.5f);

        private static readonly Quaternion k_WallRotation = Quaternion.Euler(0f, 180f, 0f);

        [MenuItem("RootsDance/UI/Build Circulation Terminal")]
        public static void Build()
        {
            GameObject screenPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_ScreenPrefab);

            if (screenPrefab == null)
            {
                Debug.LogError($"[UI] {k_ScreenPrefab} not found. Run "
                    + "RootsDance > UI > Build Circulation Console Screen first.");
                return;
            }

            GameObject root = new GameObject("CirculationTerminal");

            try
            {
                BuildPanel(root, screenPrefab);
                PrefabUtility.SaveAsPrefabAsset(root, k_PrefabPath);
            }
            finally
            {
                Object.DestroyImmediate(root);
            }

            AssetDatabase.SaveAssets();
            Debug.Log($"[UI] {k_PrefabPath} built. Its +Z faces out of the wall.");

            PlaceInScene();
            WirePlayer();
        }

        /// <summary>
        /// Hangs the terminal in the greenhouse's second environment part.
        /// <para>
        /// A part scene of its own, the way the archive sheets got one: whoever is moving the
        /// terminal is not the person changing the room, and two people in one scene file is where
        /// the merge conflicts come from (guideline 11).
        /// </para>
        /// </summary>
        private static void PlaceInScene()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_PrefabPath);
            Scene scene = SceneManager.GetSceneByPath(k_PropScene);
            bool wasOpen = scene.IsValid() && scene.isLoaded;

            if (!wasOpen)
            {
                if (!System.IO.File.Exists(k_PropScene))
                {
                    Debug.LogError($"[UI] {k_PropScene} does not exist.");
                    return;
                }

                scene = EditorSceneManager.OpenScene(k_PropScene, OpenSceneMode.Additive);
            }
            else if (scene.isDirty)
            {
                Debug.LogError($"[UI] '{scene.name}' has unsaved changes. Save or discard them, "
                    + "then run this again.");
                return;
            }

            GameObject existing = null;

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == k_InstanceName)
                {
                    existing = root;
                    break;
                }
            }

            // Replaced rather than left alone: the prefab is what changes between runs, and an
            // instance from an older one keeps its old children.
            if (existing != null)
            {
                Object.DestroyImmediate(existing);
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            instance.name = k_InstanceName;
            instance.transform.SetPositionAndRotation(k_WallPosition, k_WallRotation);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);

            if (!wasOpen)
            {
                EditorSceneManager.CloseScene(scene, true);
            }

            Debug.Log($"[UI] '{k_InstanceName}' placed at {k_WallPosition} in {k_PropScene}. "
                + "Move it in the Editor and write the new pose back here, or it moves back.");
        }

        /// <summary>
        /// Puts the read loop and the approach hint on the greenhouse's player, the same two pieces
        /// <c>Wire Briggs Player For Reading</c> puts on Briggs's — and on the instance rather than
        /// on Player.prefab, for the same reason: another scene already carries its own copy.
        /// </summary>
        private static void WirePlayer()
        {
            Scene scene = SceneManager.GetSceneByPath(k_GameplayScene);
            bool wasOpen = scene.IsValid() && scene.isLoaded;

            if (!wasOpen)
            {
                scene = EditorSceneManager.OpenScene(k_GameplayScene, OpenSceneMode.Additive);
            }
            else if (scene.isDirty)
            {
                Debug.LogError($"[UI] '{scene.name}' has unsaved changes. Save or discard them, "
                    + "then run this again.");
                return;
            }

            FirstPersonController player = null;

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                player = root.GetComponentInChildren<FirstPersonController>(true);

                if (player != null)
                {
                    break;
                }
            }

            if (player == null)
            {
                Debug.LogError($"[UI] No FirstPersonController in {k_GameplayScene}.");

                if (!wasOpen)
                {
                    EditorSceneManager.CloseScene(scene, true);
                }

                return;
            }

            GameObject root2 = player.gameObject;

            TerminalInspectController reader = root2.GetComponent<TerminalInspectController>();

            if (reader == null)
            {
                reader = root2.AddComponent<TerminalInspectController>();
            }

            SerializedObject serializedReader = new SerializedObject(reader);
            serializedReader.FindProperty("m_input").objectReferenceValue =
                root2.GetComponentInChildren<PlayerInputReader>(true);

            // One owner per axis: while the terminal is up its camera owns the view, so the look,
            // the move and the interaction ray all stand down. Same three as the archive's.
            SerializedProperty suspended =
                serializedReader.FindProperty("m_suspendedWhileReading");
            Behaviour[] toSuspend =
            {
                root2.GetComponentInChildren<PlayerLook>(true),
                player,
                root2.GetComponentInChildren<InteractionRaycaster>(true),
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

            serializedReader.ApplyModifiedPropertiesWithoutUndo();

            TerminalProximityTrigger trigger = root2.GetComponent<TerminalProximityTrigger>();

            if (trigger == null)
            {
                trigger = root2.AddComponent<TerminalProximityTrigger>();
            }

            Transform head = root2.transform.Find("Head");
            SerializedObject serializedTrigger = new SerializedObject(trigger);
            serializedTrigger.FindProperty("m_controller").objectReferenceValue = reader;
            serializedTrigger.FindProperty("m_player").objectReferenceValue =
                head == null ? root2.transform : head;
            serializedTrigger.FindProperty("m_input").objectReferenceValue =
                root2.GetComponentInChildren<PlayerInputReader>(true);
            serializedTrigger.FindProperty("m_promptChanged").objectReferenceValue =
                AssetDatabase.LoadAssetAtPath<StringEventChannelSO>(k_PromptChannel);
            serializedTrigger.ApplyModifiedPropertiesWithoutUndo();

            string playerName = player.name;

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);

            if (!wasOpen)
            {
                EditorSceneManager.CloseScene(scene, true);
            }

            Debug.Log($"[UI] Wired the terminal reader and the approach hint onto '{playerName}' "
                + $"in {k_GameplayScene}.");
        }

        /// <summary>
        /// Everything hangs off the root, whose +Z is out of the wall. A canvas is looked at from
        /// the far side of its own forward (see 旧档案 §10), so the screen is turned to face back
        /// down +Z rather than being left pointing the way the root does.
        /// </summary>
        private static void BuildPanel(GameObject root, GameObject screenPrefab)
        {
            Material housingMaterial = EnsureMaterial(k_HousingMaterial,
                new Color(0.07f, 0.08f, 0.075f), 0.35f, 0.55f);
            Material bezelMaterial = EnsureMaterial(k_BezelMaterial,
                new Color(0.13f, 0.15f, 0.13f), 0.5f, 0.2f);

            float bezelWidth = k_ScreenWidth + k_Bezel * 2f;
            float bezelHeight = k_ScreenHeight + k_Bezel * 2f;

            // The housing sits proud of the wall and a little larger than the bezel, so the panel
            // reads as bolted on rather than cut in.
            Box(root.transform, "Housing", housingMaterial,
                new Vector3(bezelWidth + 0.04f, bezelHeight + 0.04f, k_Depth),
                new Vector3(0f, 0f, -k_Depth * 0.5f));

            Box(root.transform, "Bezel", bezelMaterial,
                new Vector3(bezelWidth, bezelHeight, 0.012f),
                new Vector3(0f, 0f, 0.006f));

            // Where the lit area is, and which way is out of it. Everything else measures from here.
            GameObject anchor = new GameObject("ScreenAnchor");
            anchor.transform.SetParent(root.transform, false);
            anchor.transform.localPosition = new Vector3(0f, 0f, 0.014f);

            GameObject screen = (GameObject)PrefabUtility.InstantiatePrefab(screenPrefab);
            PrefabUtility.UnpackPrefabInstance(screen, PrefabUnpackMode.Completely,
                InteractionMode.AutomatedAction);
            screen.name = "Screen";
            screen.transform.SetParent(anchor.transform, false);

            Canvas canvas = screen.GetComponent<Canvas>();
            canvas.renderMode = RenderMode.WorldSpace;

            // Above the wall it is on, so the panel does not z-fight its own bezel.
            canvas.sortingOrder = 0;

            RectTransform canvasRect = (RectTransform)screen.transform;
            canvasRect.sizeDelta = new Vector2(k_CanvasWidth, k_CanvasHeight);
            canvasRect.localPosition = Vector3.zero;

            // Turned to face back down the root's +Z: a canvas is read from behind its forward.
            canvasRect.localRotation = Quaternion.Euler(0f, 180f, 0f);
            canvasRect.localScale = Vector3.one * (k_ScreenWidth / k_CanvasWidth);

            // The scaler only means something in screen space and would fight the world scale.
            CanvasScaler scalerToDrop = screen.GetComponent<CanvasScaler>();

            if (scalerToDrop != null)
            {
                Object.DestroyImmediate(scalerToDrop);
            }

            // The screen the presenter switches off starts on here: a wall panel that is dark until
            // the player presses a key is a broken panel, not a closed menu.
            Transform inner = screen.transform.Find("Screen");

            if (inner != null)
            {
                inner.gameObject.SetActive(true);
            }

            GameObject cameraObject = new GameObject("ReadCamera");
            cameraObject.transform.SetParent(anchor.transform, false);

            float distance = ScreenFraming.DistanceForFill(
                new Vector2(k_ScreenWidth, k_ScreenHeight), k_ReadFieldOfView, 16f / 9f,
                k_ScreenFill);

            cameraObject.transform.localPosition = new Vector3(0f, 0f, distance);
            cameraObject.transform.localRotation = Quaternion.Euler(0f, 180f, 0f);

            CinemachineCamera readCamera = cameraObject.AddComponent<CinemachineCamera>();
            readCamera.Lens.FieldOfView = k_ReadFieldOfView;
            readCamera.Priority = 30;
            cameraObject.SetActive(false);

            // The hit box is the whole panel, not the lit area: the player aims at a screen on a
            // wall, and the bezel is part of what they are aiming at.
            BoxCollider collider = root.AddComponent<BoxCollider>();
            collider.size = new Vector3(bezelWidth, bezelHeight, k_Depth);
            collider.center = new Vector3(0f, 0f, -k_Depth * 0.5f + 0.006f);

            WallTerminal terminal = root.AddComponent<WallTerminal>();
            SerializedObject serialized = new SerializedObject(terminal);
            serialized.FindProperty("m_displayName").stringValue = "中央循环装置";
            serialized.FindProperty("m_canvas").objectReferenceValue = canvas;
            serialized.FindProperty("m_inspectCamera").objectReferenceValue = readCamera;
            serialized.FindProperty("m_screenAnchor").objectReferenceValue = anchor.transform;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static void Box(Transform parent, string name, Material material, Vector3 size,
            Vector3 localPosition)
        {
            GameObject box = GameObject.CreatePrimitive(PrimitiveType.Cube);
            box.name = name;
            box.transform.SetParent(parent, false);
            box.transform.localPosition = localPosition;
            box.transform.localScale = size;

            // One collider for the whole panel, on the root. These are shape, not surface.
            Object.DestroyImmediate(box.GetComponent<BoxCollider>());

            box.GetComponent<MeshRenderer>().sharedMaterial = material;
        }

        private static Material EnsureMaterial(string path, Color color, float smoothness,
            float metallic)
        {
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material == null)
            {
                Shader shader = Shader.Find("HDRP/Lit");

                if (shader == null)
                {
                    Debug.LogError("[UI] HDRP/Lit not found.");
                    return null;
                }

                EnsureFolder(k_MaterialFolder);
                material = new Material(shader);
                AssetDatabase.CreateAsset(material, path);
            }

            material.SetColor("_BaseColor", color);
            material.SetFloat("_Smoothness", smoothness);
            material.SetFloat("_Metallic", metallic);
            EditorUtility.SetDirty(material);

            return material;
        }

        private static void EnsureFolder(string folder)
        {
            if (AssetDatabase.IsValidFolder(folder))
            {
                return;
            }

            string parent = System.IO.Path.GetDirectoryName(folder);
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, System.IO.Path.GetFileName(folder));
        }
    }
}

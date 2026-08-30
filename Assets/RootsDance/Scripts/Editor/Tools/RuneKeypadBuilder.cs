using System;
using System.Collections.Generic;
using System.IO;
using RootsDance.Data;
using RootsDance.Events;
using RootsDance.Interaction;
using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Builds the authored rune-keypad model into an interactive HDRP prefab and places its one
    /// chapter-00 instance. The generated prefab owns all grouping and collider authoring; the FBX
    /// remains an untouched source asset.
    /// </summary>
    public static class RuneKeypadBuilder
    {
        private const string k_ModelPath =
            "Assets/RootsDance/Meshes/Props/RuneKeypad/RuneKeypad.fbx";
        private const string k_PrefabFolder = "Assets/RootsDance/Prefabs/Props";
        private const string k_PrefabPath = k_PrefabFolder + "/RuneKeypad.prefab";
        private const string k_MaterialFolder = "Assets/RootsDance/Materials/Props";
        private const string k_TextureFolder = "Assets/RootsDance/Textures/Props/RuneKeypad";
        private const string k_MainGameplayPath =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";
        private const string k_LoadLevelChannelPath =
            "Assets/RootsDance/Data/Events/LoadLevelRequested.asset";
        private const string k_DestinationLevelPath =
            "Assets/RootsDance/Data/Levels/BriggsInterior.asset";
        private const string k_PromptChannelPath =
            "Assets/RootsDance/Data/Events/InteractionPrompt.asset";

        private const float k_ModelScale = 0.25f;
        private const float k_InspectFieldOfView = 40f;
        private static readonly Vector3 k_LegacyInspectPosition =
            new Vector3(0.05f, -0.03f, 1.05f);
        private static readonly Vector3 k_LegacyConfirmPosition =
            new Vector3(0.156f, -0.407f, 0.774f);
        private static readonly Quaternion k_LegacyPropRotation = Quaternion.Euler(0f, -90f, 0f);
        private const float k_LegacyInspectScale = 0.75f;
        private const float k_LegacyConfirmScale = 0.7f;
        private static readonly Vector3 k_Placement = new Vector3(31.847f, 7.835f, 107.114f);
        private const float k_PlacementYaw = 13.5f;

        private static readonly RuneSymbol[] k_RuneSymbols =
        {
            RuneSymbol.Othila,
            RuneSymbol.Algiz,
            RuneSymbol.Perth,
            RuneSymbol.Jera,
            RuneSymbol.Raidho,
            RuneSymbol.Berkana,
            RuneSymbol.Sowelu,
            RuneSymbol.Dagaz,
            RuneSymbol.Ansuz,
            RuneSymbol.Nauthiz
        };

        private sealed class KeypadMaterials
        {
            public Material Base;
            public Material Screen;
            public Material Keycap;
            public Material Inlay;
            public Material Confirm;
            public Material Delete;
            public Material Glass;
            public Material ScreenRune;
            public Material InputGlow;
            public Material ConfirmGlow;
            public Material ErrorGlow;
        }

        [MenuItem("RootsDance/Build Rune Keypad")]
        public static void BuildFromMenu()
        {
            BuildAll();
        }

        /// <summary>Command-line entry point for the deterministic prefab and scene wiring pass.</summary>
        public static void BuildAll()
        {
            ThrowIfAnyOpenSceneIsDirty();
            EnsureFolder(k_PrefabFolder);
            EnsureFolder(k_MaterialFolder);
            ConfigureTextureImporters();

            KeypadMaterials materials = EnsureMaterials();
            GameObject prefab = BuildPrefab(materials);
            PlaceInMainGameplay(prefab);
            AssetDatabase.SaveAssets();

            Debug.Log($"RuneKeypadBuilder: built {k_PrefabPath} and placed it at "
                + $"{k_Placement} with yaw {k_PlacementYaw:F1} in {k_MainGameplayPath}.");
        }

        private static GameObject BuildPrefab(KeypadMaterials materials)
        {
            GameObject modelAsset = RequireAsset<GameObject>(k_ModelPath);
            Scene preview = EditorSceneManager.NewPreviewScene();

            try
            {
                GameObject root = new GameObject("RuneKeypad");
                SceneManager.MoveGameObjectToScene(root, preview);

                try
                {
                    GameObject model = (GameObject)PrefabUtility.InstantiatePrefab(modelAsset, preview);
                    PrefabUtility.UnpackPrefabInstance(
                        model,
                        PrefabUnpackMode.Completely,
                        InteractionMode.AutomatedAction);
                    model.name = "Model";
                    model.transform.SetParent(root.transform, false);
                    model.transform.localScale = Vector3.one * k_ModelScale;

                    AssignMaterials(model, materials);

                    int buttonLayer = RequireLayer("UI");
                    List<RuneKeypadButton> buttons = new List<RuneKeypadButton>();

                    for (int i = 0; i < k_RuneSymbols.Length; i++)
                    {
                        string number = (i + 1).ToString("00");
                        RuneKeypadButton button = BuildButton(
                            model.transform,
                            $"Button_Rune_{number}",
                            $"Rune_Key_{number}_Plate",
                            $"Rune_Key_{number}_Stroke_",
                            RuneKeypadButton.ButtonKind.Rune,
                            k_RuneSymbols[i],
                            materials.InputGlow,
                            buttonLayer);
                        buttons.Add(button);
                    }

                    RuneKeypadButton clearButton = BuildButton(
                        model.transform,
                        "Button_Clear",
                        "Action_Clear_Plate",
                        "Action_Delete_Red_X_Stroke_",
                        RuneKeypadButton.ButtonKind.Clear,
                        RuneSymbol.Othila,
                        materials.ErrorGlow,
                        buttonLayer);
                    buttons.Add(clearButton);

                    RuneKeypadButton confirmButton = BuildButton(
                        model.transform,
                        "Button_Confirm",
                        "Action_Enter_Plate",
                        "Action_Confirm_Green_Check_Stroke_",
                        RuneKeypadButton.ButtonKind.Confirm,
                        RuneSymbol.Othila,
                        materials.ConfirmGlow,
                        buttonLayer);
                    buttons.Add(confirmButton);

                    GameObject[] solvedRunes = BuildSolvedRunes(model.transform);
                    GameObject[] indicators = BuildEntryIndicators(
                        model.transform,
                        solvedRunes,
                        materials.InputGlow);

                    BoxCollider worldCollider = root.AddComponent<BoxCollider>();
                    SetColliderToRenderers(worldCollider, root.transform,
                        root.GetComponentsInChildren<Renderer>(true), new Vector3(0.025f, 0.025f, 0.025f));
                    root.layer = RequireLayer("Interactable");

                    CinemachineCamera inspectCamera = BuildInspectCamera(root.transform);
                    InvertPropPose(
                        k_LegacyConfirmPosition,
                        k_LegacyPropRotation,
                        k_LegacyConfirmScale,
                        out Vector3 confirmCameraPosition,
                        out Quaternion confirmCameraRotation);

                    RuneKeypadInteractable interactable = root.AddComponent<RuneKeypadInteractable>();
                    interactable.Configure(
                        worldCollider,
                        1 << buttonLayer,
                        buttons.ToArray(),
                        indicators,
                        solvedRunes,
                        clearButton,
                        confirmButton,
                        inspectCamera,
                        confirmCameraPosition,
                        confirmCameraRotation.eulerAngles,
                        RequireAsset<LevelEventChannelSO>(k_LoadLevelChannelPath),
                        RequireAsset<LevelSO>(k_DestinationLevelPath),
                        RequireAsset<StringEventChannelSO>(k_PromptChannelPath));

                    bool saved;
                    GameObject prefab = PrefabUtility.SaveAsPrefabAsset(root, k_PrefabPath, out saved);

                    if (!saved || prefab == null)
                    {
                        throw new InvalidOperationException("Failed to save rune keypad prefab: " + k_PrefabPath);
                    }

                    return prefab;
                }
                finally
                {
                    UnityEngine.Object.DestroyImmediate(root);
                }
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(preview);
            }
        }

        private static CinemachineCamera BuildInspectCamera(Transform parent)
        {
            GameObject cameraObject = new GameObject("InspectCamera");
            cameraObject.transform.SetParent(parent, false);
            InvertPropPose(
                k_LegacyInspectPosition,
                k_LegacyPropRotation,
                k_LegacyInspectScale,
                out Vector3 cameraPosition,
                out Quaternion cameraRotation);
            cameraObject.transform.localPosition = cameraPosition;
            cameraObject.transform.localRotation = cameraRotation;

            CinemachineCamera camera = cameraObject.AddComponent<CinemachineCamera>();
            camera.Lens.FieldOfView = k_InspectFieldOfView;
            camera.Priority = 30;
            cameraObject.SetActive(false);
            return camera;
        }

        /// <summary>
        /// Converts the legacy "prop in front of the eye" pose into the inverse fixed-prop camera
        /// pose, preserving the exact framing while leaving the wall mount untouched.
        /// </summary>
        private static void InvertPropPose(
            Vector3 propPosition,
            Quaternion propRotation,
            float propScale,
            out Vector3 cameraPosition,
            out Quaternion cameraRotation)
        {
            cameraRotation = Quaternion.Inverse(propRotation);
            cameraPosition = cameraRotation * -propPosition / propScale;
        }

        private static RuneKeypadButton BuildButton(
            Transform model,
            string wrapperName,
            string plateName,
            string strokePrefix,
            RuneKeypadButton.ButtonKind kind,
            RuneSymbol symbol,
            Material feedbackMaterial,
            int layer)
        {
            Transform plate = RequireTransform(model, plateName);
            List<Transform> strokes = FindTransforms(model, strokePrefix, true);

            if (strokes.Count == 0)
            {
                throw new InvalidOperationException(
                    $"RuneKeypadBuilder: no feedback strokes start with '{strokePrefix}'.");
            }

            GameObject wrapper = new GameObject(wrapperName);
            SceneManager.MoveGameObjectToScene(wrapper, model.gameObject.scene);
            wrapper.transform.SetParent(model, false);
            plate.SetParent(wrapper.transform, true);

            for (int i = 0; i < strokes.Count; i++)
            {
                strokes[i].SetParent(wrapper.transform, true);
            }

            BoxCollider collider = wrapper.AddComponent<BoxCollider>();
            Renderer[] renderers = wrapper.GetComponentsInChildren<Renderer>(true);
            SetColliderToRenderers(collider, wrapper.transform, renderers,
                new Vector3(0.025f, 0.012f, 0.012f));

            Renderer[] feedbackRenderers = new Renderer[strokes.Count];

            for (int i = 0; i < strokes.Count; i++)
            {
                feedbackRenderers[i] = strokes[i].GetComponent<Renderer>();

                if (feedbackRenderers[i] == null)
                {
                    throw new InvalidOperationException(
                        $"RuneKeypadBuilder: '{strokes[i].name}' has no Renderer.");
                }
            }

            RuneKeypadButton button = wrapper.AddComponent<RuneKeypadButton>();
            button.Configure(kind, symbol, feedbackRenderers, feedbackMaterial);
            SetLayerRecursively(wrapper, layer);
            return button;
        }

        private static GameObject[] BuildSolvedRunes(Transform model)
        {
            GameObject[] groups = new GameObject[4];

            for (int i = 0; i < groups.Length; i++)
            {
                string number = (i + 1).ToString("00");
                List<Transform> strokes = FindTransforms(model, $"Screen_Rune_{number}_Stroke_", true);

                if (strokes.Count == 0)
                {
                    throw new InvalidOperationException(
                        $"RuneKeypadBuilder: screen rune {number} has no strokes.");
                }

                GameObject group = new GameObject($"SolvedRune_{number}");
                SceneManager.MoveGameObjectToScene(group, model.gameObject.scene);
                group.transform.SetParent(model, false);

                for (int strokeIndex = 0; strokeIndex < strokes.Count; strokeIndex++)
                {
                    strokes[strokeIndex].SetParent(group.transform, true);
                }

                group.SetActive(false);
                groups[i] = group;
            }

            return groups;
        }

        private static GameObject[] BuildEntryIndicators(
            Transform model,
            GameObject[] solvedRunes,
            Material material)
        {
            GameObject group = new GameObject("EntryIndicators");
            SceneManager.MoveGameObjectToScene(group, model.gameObject.scene);
            group.transform.SetParent(model, false);
            GameObject[] indicators = new GameObject[solvedRunes.Length];

            for (int i = 0; i < solvedRunes.Length; i++)
            {
                Renderer[] renderers = solvedRunes[i].GetComponentsInChildren<Renderer>(true);
                Bounds bounds = CombinedWorldBounds(renderers);
                Vector3 localPosition = model.InverseTransformPoint(bounds.center);
                localPosition.x -= 0.014f;

                GameObject indicator = GameObject.CreatePrimitive(PrimitiveType.Cube);
                indicator.name = $"EntryIndicator_{i + 1:00}";
                SceneManager.MoveGameObjectToScene(indicator, model.gameObject.scene);
                indicator.transform.SetParent(group.transform, false);
                indicator.transform.localPosition = localPosition;
                indicator.transform.localScale = new Vector3(0.009f, 0.035f, 0.035f);
                indicator.GetComponent<MeshRenderer>().sharedMaterial = material;
                UnityEngine.Object.DestroyImmediate(indicator.GetComponent<Collider>());
                indicator.SetActive(false);
                indicators[i] = indicator;
            }

            return indicators;
        }

        private static void AssignMaterials(GameObject model, KeypadMaterials materials)
        {
            Dictionary<string, Material> replacements = new Dictionary<string, Material>(StringComparer.Ordinal)
            {
                { "Base", materials.Base },
                { "Screen", materials.Screen },
                { "Rune_Keycap_Charcoal", materials.Keycap },
                { "Rune_Inlay_PaleGreen", materials.Inlay },
                { "Action_Confirm_Green", materials.Confirm },
                { "Action_Delete_Red", materials.Delete },
                { "Screen_Glass_Green", materials.Glass },
                { "Screen_Rune_Dim_LCD", materials.ScreenRune }
            };

            Renderer[] renderers = model.GetComponentsInChildren<Renderer>(true);
            HashSet<string> replacedNames = new HashSet<string>(StringComparer.Ordinal);

            for (int rendererIndex = 0; rendererIndex < renderers.Length; rendererIndex++)
            {
                Material[] shared = renderers[rendererIndex].sharedMaterials;

                for (int materialIndex = 0; materialIndex < shared.Length; materialIndex++)
                {
                    Material source = shared[materialIndex];

                    if (source != null && replacements.TryGetValue(source.name, out Material replacement))
                    {
                        shared[materialIndex] = replacement;
                        replacedNames.Add(source.name);
                    }
                }

                renderers[rendererIndex].sharedMaterials = shared;
            }

            foreach (string expectedName in replacements.Keys)
            {
                if (!replacedNames.Contains(expectedName))
                {
                    throw new InvalidOperationException(
                        $"RuneKeypadBuilder: FBX material slot '{expectedName}' was not found.");
                }
            }
        }

        private static KeypadMaterials EnsureMaterials()
        {
            Shader lit = Shader.Find("HDRP/Lit");

            if (lit == null)
            {
                throw new InvalidOperationException("RuneKeypadBuilder: HDRP/Lit shader was not found.");
            }

            KeypadMaterials materials = new KeypadMaterials
            {
                Base = EnsureTexturedMaterial(
                    lit,
                    "RuneKeypad_Base",
                    "RuneKeypadBase_BaseMap.png",
                    "RuneKeypadBase_Normal.png",
                    "RuneKeypadBase_Mask.png"),
                Screen = EnsureTexturedMaterial(
                    lit,
                    "RuneKeypad_Screen",
                    "RuneKeypadScreen_BaseMap.png",
                    "RuneKeypadScreen_Normal.png",
                    "RuneKeypadScreen_Mask.png"),
                Keycap = EnsureSolidMaterial(
                    lit,
                    "RuneKeypad_Keycap",
                    new Color(0.025f, 0.035f, 0.031f),
                    0.58f,
                    0.32f,
                    Color.black),
                Inlay = EnsureSolidMaterial(
                    lit,
                    "RuneKeypad_Inlay",
                    new Color(0.18f, 0.36f, 0.25f),
                    0.08f,
                    0.36f,
                    new Color(0.04f, 0.30f, 0.12f).linear * 8f),
                Confirm = EnsureSolidMaterial(
                    lit,
                    "RuneKeypad_Confirm",
                    new Color(0.04f, 0.32f, 0.12f),
                    0.05f,
                    0.42f,
                    new Color(0.02f, 0.18f, 0.06f).linear * 3f),
                Delete = EnsureSolidMaterial(
                    lit,
                    "RuneKeypad_Delete",
                    new Color(0.36f, 0.025f, 0.018f),
                    0.05f,
                    0.42f,
                    new Color(0.18f, 0.008f, 0.004f).linear * 3f),
                Glass = EnsureGlassMaterial(lit),
                ScreenRune = EnsureSolidMaterial(
                    lit,
                    "RuneKeypad_ScreenRune",
                    new Color(0.03f, 0.16f, 0.08f),
                    0f,
                    0.5f,
                    new Color(0.02f, 0.28f, 0.09f).linear * 10f),
                InputGlow = EnsureSolidMaterial(
                    lit,
                    "RuneKeypad_InputGlow",
                    new Color(0.18f, 0.78f, 0.36f),
                    0f,
                    0.5f,
                    new Color(0.06f, 0.85f, 0.22f).linear * 45f),
                ConfirmGlow = EnsureSolidMaterial(
                    lit,
                    "RuneKeypad_ConfirmGlow",
                    new Color(0.14f, 0.85f, 0.30f),
                    0f,
                    0.5f,
                    new Color(0.04f, 1f, 0.18f).linear * 60f),
                ErrorGlow = EnsureSolidMaterial(
                    lit,
                    "RuneKeypad_ErrorGlow",
                    new Color(0.9f, 0.025f, 0.012f),
                    0f,
                    0.5f,
                    new Color(1f, 0.006f, 0.002f).linear * 75f)
            };

            return materials;
        }

        private static Material EnsureTexturedMaterial(
            Shader shader,
            string name,
            string baseMapName,
            string normalMapName,
            string maskMapName)
        {
            Material material = EnsureMaterial(shader, name);
            material.SetTexture("_BaseColorMap", RequireTexture(baseMapName));
            material.SetTexture("_NormalMap", RequireTexture(normalMapName));
            material.SetTexture("_MaskMap", RequireTexture(maskMapName));
            material.SetColor("_BaseColor", Color.white);
            material.SetFloat("_Metallic", 1f);
            material.SetFloat("_Smoothness", 1f);
            material.SetFloat("_NormalScale", 1f);
            material.enableInstancing = true;
            HDMaterial.SetSurfaceType(material, false);
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureSolidMaterial(
            Shader shader,
            string name,
            Color baseColor,
            float metallic,
            float smoothness,
            Color emission)
        {
            Material material = EnsureMaterial(shader, name);
            material.SetTexture("_BaseColorMap", null);
            material.SetTexture("_NormalMap", null);
            material.SetTexture("_MaskMap", null);
            material.SetColor("_BaseColor", baseColor);
            material.SetFloat("_Metallic", metallic);
            material.SetFloat("_Smoothness", smoothness);
            HDMaterial.SetSurfaceType(material, false);
            HDMaterial.SetUseEmissiveIntensity(material, false);
            HDMaterial.SetEmissiveColor(material, emission);
            material.enableInstancing = true;
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureGlassMaterial(Shader shader)
        {
            Material material = EnsureMaterial(shader, "RuneKeypad_Glass");
            material.SetTexture("_BaseColorMap", null);
            material.SetColor("_BaseColor", new Color(0.025f, 0.19f, 0.09f, 0.30f));
            material.SetFloat("_Metallic", 0f);
            material.SetFloat("_Smoothness", 0.94f);
            material.SetFloat("_BlendMode", 0f);
            material.SetFloat("_TransparentZWrite", 0f);
            HDMaterial.SetSurfaceType(material, true);
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureMaterial(Shader shader, string name)
        {
            string path = k_MaterialFolder + "/" + name + ".mat";
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material == null)
            {
                material = new Material(shader) { name = name };
                AssetDatabase.CreateAsset(material, path);
            }
            else if (material.shader != shader)
            {
                material.shader = shader;
            }

            return material;
        }

        private static void ConfigureTextureImporters()
        {
            ConfigureTexture("RuneKeypadBase_BaseMap.png", TextureImporterType.Default, true);
            ConfigureTexture("RuneKeypadBase_Normal.png", TextureImporterType.NormalMap, false);
            ConfigureTexture("RuneKeypadBase_Mask.png", TextureImporterType.Default, false);
            ConfigureTexture("RuneKeypadScreen_BaseMap.png", TextureImporterType.Default, true);
            ConfigureTexture("RuneKeypadScreen_Normal.png", TextureImporterType.NormalMap, false);
            ConfigureTexture("RuneKeypadScreen_Mask.png", TextureImporterType.Default, false);
        }

        private static void ConfigureTexture(
            string fileName,
            TextureImporterType textureType,
            bool sRgb)
        {
            string path = k_TextureFolder + "/" + fileName;
            TextureImporter importer = AssetImporter.GetAtPath(path) as TextureImporter;

            if (importer == null)
            {
                throw new FileNotFoundException("Rune keypad texture was not imported: " + path);
            }

            bool changed = importer.textureType != textureType || importer.sRGBTexture != sRgb;
            importer.textureType = textureType;
            importer.sRGBTexture = sRgb;

            if (changed)
            {
                importer.SaveAndReimport();
            }
        }

        private static void PlaceInMainGameplay(GameObject prefab)
        {
            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                Scene scene = EditorSceneManager.OpenScene(k_MainGameplayPath, OpenSceneMode.Single);
                Transform interactables = FindRoot(scene, "_Interactables");

                if (interactables == null)
                {
                    GameObject group = new GameObject("_Interactables");
                    SceneManager.MoveGameObjectToScene(group, scene);
                    interactables = group.transform;
                }

                for (int i = interactables.childCount - 1; i >= 0; i--)
                {
                    if (interactables.GetChild(i).name == "RuneKeypad")
                    {
                        UnityEngine.Object.DestroyImmediate(interactables.GetChild(i).gameObject);
                    }
                }

                GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
                instance.name = "RuneKeypad";
                instance.transform.SetParent(interactables, true);
                instance.transform.SetPositionAndRotation(
                    k_Placement,
                    Quaternion.Euler(0f, k_PlacementYaw, 0f));

                EditorSceneManager.MarkSceneDirty(scene);
                EditorSceneManager.SaveScene(scene);
            }
            finally
            {
                if (originalSetup.Length > 0)
                {
                    EditorSceneManager.RestoreSceneManagerSetup(originalSetup);
                }
            }
        }

        private static Transform FindRoot(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == name)
                {
                    return roots[i].transform;
                }
            }

            return null;
        }

        private static Transform RequireTransform(Transform root, string name)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                if (transforms[i].name == name)
                {
                    return transforms[i];
                }
            }

            throw new InvalidOperationException(
                $"RuneKeypadBuilder: model transform '{name}' was not found.");
        }

        private static List<Transform> FindTransforms(Transform root, string name, bool prefix)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);
            List<Transform> results = new List<Transform>();

            for (int i = 0; i < transforms.Length; i++)
            {
                bool matches = prefix
                    ? transforms[i].name.StartsWith(name, StringComparison.Ordinal)
                    : transforms[i].name == name;

                if (matches)
                {
                    results.Add(transforms[i]);
                }
            }

            results.Sort((left, right) => string.CompareOrdinal(left.name, right.name));
            return results;
        }

        private static void SetColliderToRenderers(
            BoxCollider collider,
            Transform owner,
            Renderer[] renderers,
            Vector3 padding)
        {
            Bounds worldBounds = CombinedWorldBounds(renderers);
            Vector3 min = new Vector3(float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity);
            Vector3 max = new Vector3(float.NegativeInfinity, float.NegativeInfinity, float.NegativeInfinity);

            for (int x = -1; x <= 1; x += 2)
            {
                for (int y = -1; y <= 1; y += 2)
                {
                    for (int z = -1; z <= 1; z += 2)
                    {
                        Vector3 corner = worldBounds.center + Vector3.Scale(
                            worldBounds.extents,
                            new Vector3(x, y, z));
                        Vector3 local = owner.InverseTransformPoint(corner);
                        min = Vector3.Min(min, local);
                        max = Vector3.Max(max, local);
                    }
                }
            }

            collider.center = (min + max) * 0.5f;
            collider.size = max - min + padding;
        }

        private static Bounds CombinedWorldBounds(Renderer[] renderers)
        {
            bool hasBounds = false;
            Bounds bounds = default;

            for (int i = 0; i < renderers.Length; i++)
            {
                if (renderers[i] == null)
                {
                    continue;
                }

                if (!hasBounds)
                {
                    bounds = renderers[i].bounds;
                    hasBounds = true;
                }
                else
                {
                    bounds.Encapsulate(renderers[i].bounds);
                }
            }

            if (!hasBounds)
            {
                throw new InvalidOperationException("RuneKeypadBuilder: no renderer bounds were available.");
            }

            return bounds;
        }

        private static void SetLayerRecursively(GameObject root, int layer)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                transforms[i].gameObject.layer = layer;
            }
        }

        private static int RequireLayer(string name)
        {
            int layer = LayerMask.NameToLayer(name);

            if (layer < 0)
            {
                throw new InvalidOperationException("Required layer is missing: " + name);
            }

            return layer;
        }

        private static T RequireAsset<T>(string path) where T : UnityEngine.Object
        {
            T asset = AssetDatabase.LoadAssetAtPath<T>(path);

            if (asset == null)
            {
                throw new FileNotFoundException($"Required asset was not found: {path}");
            }

            return asset;
        }

        private static Texture2D RequireTexture(string fileName)
        {
            return RequireAsset<Texture2D>(k_TextureFolder + "/" + fileName);
        }

        private static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = Path.GetDirectoryName(path).Replace('\\', '/');
            string folder = Path.GetFileName(path);
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, folder);
        }

        private static void ThrowIfAnyOpenSceneIsDirty()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.isDirty)
                {
                    throw new InvalidOperationException(
                        "RuneKeypadBuilder refuses to replace the open scene setup while it has "
                        + "unsaved changes: " + scene.path);
                }
            }
        }
    }
}

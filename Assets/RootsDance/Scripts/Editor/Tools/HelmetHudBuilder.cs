using CurvedUIUtility;
using RootsDance.EditorTools;
using RootsDance.Player;
using RootsDance.UI;
using TMPro;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Builds the inside-the-helmet HUD test canvas in PlayerTest_Gameplay: a full-screen
    /// RootsDance/UI/HelmetVisor frame (shell, metal rim and glass-edge shadow around the sight),
    /// a CurvedUIController driven by a shared curve asset, and sample CurvedTextMeshPro readouts
    /// so the on-glass text curvature can be judged in Play mode. Idempotent: running it again
    /// replaces the previous canvas but keeps the curve asset and material, so hand tuning on
    /// those survives a rebuild. Saves the gameplay scene, like the other test-rig builders.
    /// Menu: RootsDance > Build Helmet HUD (Test).
    /// </summary>
    public static class HelmetHudBuilder
    {
        private const string k_EnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Environment.unity";
        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity";
        private const string k_MainGameplayPath =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";
        private const string k_CurveAssetPath = "Assets/RootsDance/Data/Config/HelmetHudCurve.asset";
        private const string k_VisorMaterialPath = "Assets/RootsDance/Materials/HelmetVisor.mat";
        private const string k_VisorShader = "RootsDance/UI/HelmetVisor";
        private const string k_CanvasName = "HelmetHudCanvas";

        /// <summary>Above the kit's screens but below any future fade/loading overlay.</summary>
        private const int k_SortingOrder = 40;

        private static readonly Color k_TextColor = new Color(0.78f, 0.86f, 0.80f, 0.92f);

        [MenuItem("RootsDance/Build Helmet HUD (Test)")]
        public static void Build()
        {
            Build(k_EnvironmentPath, k_GameplayPath, withSampleReadouts: true);
        }

        /// <summary>
        /// The same canvas in the Main level. No sample readouts: those exist to judge the text
        /// curvature in the test rig, and placeholder strings have no business in the level the
        /// game ships. Main_Environment is deliberately not opened — the canvas needs nothing from
        /// it, and that scene is shared.
        /// </summary>
        [MenuItem("RootsDance/Build Helmet HUD (Main)")]
        public static void BuildMain()
        {
            Build(string.Empty, k_MainGameplayPath, withSampleReadouts: false);
        }

        private static void Build(string environmentPath, string gameplayPath,
            bool withSampleReadouts)
        {
            Scene gameplay = OpenLevel(environmentPath, gameplayPath);

            foreach (GameObject root in gameplay.GetRootGameObjects())
            {
                if (root.name == k_CanvasName)
                {
                    Object.DestroyImmediate(root);
                }
            }

            CurvedUISettingsObject curve = EnsureCurveSettings();
            Material visorMaterial = EnsureVisorMaterial();

            GameObject canvasGo = new GameObject(k_CanvasName, typeof(RectTransform), typeof(Canvas),
                typeof(CanvasScaler), typeof(CurvedUIController));
            SceneManager.MoveGameObjectToScene(canvasGo, gameplay);

            Canvas canvas = canvasGo.GetComponent<Canvas>();
            canvas.renderMode = RenderMode.ScreenSpaceOverlay;
            canvas.sortingOrder = k_SortingOrder;

            CanvasScaler scaler = canvasGo.GetComponent<CanvasScaler>();
            scaler.uiScaleMode = CanvasScaler.ScaleMode.ScaleWithScreenSize;
            scaler.referenceResolution = new Vector2(1920f, 1080f);
            scaler.matchWidthOrHeight = 0.5f;

            // The controller's inputs are vendor-private serialized fields; SerializedObject is the
            // supported way to wire them without editing the vendor code.
            SerializedObject controller = new SerializedObject(canvasGo.GetComponent<CurvedUIController>());
            controller.FindProperty("settingsSource").enumValueIndex = (int)SettingsSource.FromScriptableObject;
            controller.FindProperty("startingCurveObject").objectReferenceValue = curve;
            controller.ApplyModifiedPropertiesWithoutUndo();

            // Everything that lifts away with the helmet lives under one root, so the removal
            // animation moves a single RectTransform.
            GameObject visorRootGo = new GameObject("VisorRoot", typeof(RectTransform));
            visorRootGo.transform.SetParent(canvasGo.transform, false);
            RectTransform visorRoot = (RectTransform)visorRootGo.transform;
            visorRoot.anchorMin = Vector2.zero;
            visorRoot.anchorMax = Vector2.one;
            visorRoot.offsetMin = Vector2.zero;
            visorRoot.offsetMax = Vector2.zero;

            // The faceplate is one continuous sheet now — no shell, no metal rim. The glass quad
            // itself stays: it carries the smudges and the tint. With the rim gone, the only thing
            // left selling "you are looking through a curved visor" is the curvature of the
            // readouts, which makes the curve load-bearing rather than decorative.
            BuildVisorGlass(visorRoot, visorMaterial);

            BuildInteractPrompt(visorRoot, withSampleReadouts ? "[E]  INSPECT" : string.Empty);

            if (withSampleReadouts)
            {
                BuildSampleReadouts(visorRoot);
            }

            WireHudView(canvasGo, visorRoot);

            EditorSceneManager.MarkSceneDirty(gameplay);
            EditorSceneManager.SaveScene(gameplay);

            Debug.Log($"HelmetHudBuilder: {k_CanvasName} built and {gameplayPath} saved. "
                + $"Tune the text curve on {k_CurveAssetPath} and the frame on {k_VisorMaterialPath}.");
        }

        /// <param name="environmentPath">
        /// Opened first, so the canvas is judged against the level it belongs to. Empty opens the
        /// gameplay scene on its own, for a level whose environment scene is shared and should not
        /// be pulled into someone else's Editor session.
        /// </param>
        private static Scene OpenLevel(string environmentPath, string gameplayPath)
        {
            OpenSceneMode gameplayMode = OpenSceneMode.Single;

            if (!string.IsNullOrEmpty(environmentPath))
            {
                Scene environment = EditorSceneManager.GetSceneByPath(environmentPath);

                if (!environment.isLoaded)
                {
                    EditorSceneManager.OpenScene(environmentPath, OpenSceneMode.Single);
                }

                gameplayMode = OpenSceneMode.Additive;
            }

            Scene gameplay = EditorSceneManager.GetSceneByPath(gameplayPath);

            if (!gameplay.isLoaded)
            {
                gameplay = EditorSceneManager.OpenScene(gameplayPath, gameplayMode);
            }

            return gameplay;
        }

        /// <summary>
        /// The shared text-curve asset. Created once with a gentle inward bow (Halo sits around
        /// curve y 0.1; the reference frame is subtler) and never overwritten, so Inspector tuning
        /// is what ships.
        /// </summary>
        private static CurvedUISettingsObject EnsureCurveSettings()
        {
            CurvedUISettingsObject asset = AssetDatabase.LoadAssetAtPath<CurvedUISettingsObject>(k_CurveAssetPath);

            if (asset != null)
            {
                return asset;
            }

            asset = ScriptableObject.CreateInstance<CurvedUISettingsObject>();
            asset.Settings = new CurvedUISettings
            {
                Curve = new Vector3(0.05f, 0.12f, 0f),
                Pull = Vector3.zero,
                Scale = new Vector3(0.97f, 0.97f, 1f),
                Offset = Vector3.zero
            };

            AssetDatabase.CreateAsset(asset, k_CurveAssetPath);
            return asset;
        }

        private static Material EnsureVisorMaterial()
        {
            Shader shader = Shader.Find(k_VisorShader);

            if (shader == null)
            {
                Debug.LogError($"HelmetHudBuilder: shader {k_VisorShader} not found; falling back to UI/Default.");
                shader = Shader.Find("UI/Default");
            }

            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_VisorMaterialPath);

            if (material == null)
            {
                material = new Material(shader);
                AssetDatabase.CreateAsset(material, k_VisorMaterialPath);
            }

            material.shader = shader;

            // The ambientCG dressing maps (CC0, recorded in docs/third-party.md). Only empty slots
            // are filled, so a hand-swapped texture survives a rebuild like the rest of the material.
            AssignIfEmpty(material, "_ShellTex",
                "Assets/ThirdParty/Environment/AmbientCG/Rubber004/Rubber004_1K-JPG_Color.jpg");
            AssignIfEmpty(material, "_RimTex",
                "Assets/ThirdParty/Environment/AmbientCG/Metal032/Metal032_1K-JPG_Color.jpg");
            AssignIfEmpty(material, "_SmudgeTex",
                "Assets/ThirdParty/Environment/AmbientCG/Fingerprints002/Fingerprints002_1K-JPG_Color.jpg");

            // The traced opening silhouette (SDF, linear data — the importer must not sRGB it).
            const string shapePath = "Assets/RootsDance/UI/Sprites/HelmetVisorShape.png";
            EnsureLinearImporter(shapePath);
            AssignIfEmpty(material, "_ShapeTex", shapePath);

            if (material.HasProperty("_ShapeBlend") && material.GetTexture("_ShapeTex") != null)
            {
                material.SetFloat("_ShapeBlend", 1f);
            }

            // Edge to edge: the helmet shell and its metal rim are no longer drawn, so the visor is
            // one sheet of glass. Set unconditionally rather than only-if-empty — this is the
            // current design of the faceplate, not a slot left open for dressing.
            if (material.HasProperty("_GlassOnly"))
            {
                material.SetFloat("_GlassOnly", 1f);
            }

            EditorUtility.SetDirty(material);

            return material;
        }

        /// <summary>Distance-field data must import raw: no sRGB, no mips, no compression, clamped.</summary>
        private static void EnsureLinearImporter(string path)
        {
            TextureImporter importer = AssetImporter.GetAtPath(path) as TextureImporter;

            if (importer == null)
            {
                return;
            }

            bool dirty = importer.sRGBTexture || importer.mipmapEnabled
                || importer.wrapMode != TextureWrapMode.Clamp
                || importer.textureCompression != TextureImporterCompression.Uncompressed;

            if (!dirty)
            {
                return;
            }

            importer.sRGBTexture = false;
            importer.mipmapEnabled = false;
            importer.wrapMode = TextureWrapMode.Clamp;
            importer.textureCompression = TextureImporterCompression.Uncompressed;
            importer.SaveAndReimport();
        }

        private static void AssignIfEmpty(Material material, string property, string texturePath)
        {
            if (!material.HasProperty(property) || material.GetTexture(property) != null)
            {
                return;
            }

            Texture2D texture = AssetDatabase.LoadAssetAtPath<Texture2D>(texturePath);

            if (texture == null)
            {
                Debug.LogWarning($"HelmetHudBuilder: {texturePath} missing; {property} left empty "
                    + "(the shader falls back to its flat look).");
                return;
            }

            material.SetTexture(property, texture);
        }

        /// <summary>
        /// Binds the HUD to the arms rig's helmet view, so pressing H lifts the visor chrome in
        /// sync with the removal clip. Wiring is best-effort: without a rig in the scene the HUD
        /// still builds, it just stays put.
        /// </summary>
        private static void WireHudView(GameObject canvasGo, RectTransform visorRoot)
        {
            HelmetAnimatorView helmetView =
                Object.FindFirstObjectByType<HelmetAnimatorView>(FindObjectsInactive.Include);

            if (helmetView == null)
            {
                Debug.LogWarning("HelmetHudBuilder: no HelmetAnimatorView in the open scenes; "
                    + "the visor will not react to the removal. Rebuild after adding the rig.");
            }

            // Without this the readouts render flat whenever a text rebuild loses the race with
            // the curve library's once-per-frame guard.
            canvasGo.AddComponent<RootsDance.UI.CurvedHudKeeper>();

            HelmetHudView hudView = canvasGo.AddComponent<HelmetHudView>();
            SerializedObject serialized = new SerializedObject(hudView);
            serialized.FindProperty("m_helmetViewBehaviour").objectReferenceValue = helmetView;
            serialized.FindProperty("m_visorRoot").objectReferenceValue = visorRoot;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        /// <summary>
        /// The glass is a plain Image, not a curved one: the shader works in screen UV across a
        /// four-vertex quad, so curving it would only shear those corners and drag the whole effect
        /// off-screen. The curvature belongs to the readouts drawn on it.
        /// </summary>
        private static void BuildVisorGlass(Transform parent, Material material)
        {
            // An earlier build called this object VisorFrame, back when it drew a shell as well.
            Transform legacy = parent.Find("VisorFrame");

            if (legacy != null)
            {
                Object.DestroyImmediate(legacy.gameObject);
            }

            GameObject go = new GameObject("VisorGlass", typeof(RectTransform), typeof(Image));
            go.transform.SetParent(parent, false);

            RectTransform rect = (RectTransform)go.transform;
            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.offsetMin = Vector2.zero;
            rect.offsetMax = Vector2.zero;

            Image image = go.GetComponent<Image>();
            image.material = material;
            image.raycastTarget = false;
        }

        /// <summary>
        /// The interaction hint. Not a sample, despite having lived among them: ScannerFlowBuilder
        /// finds this label by name and hangs the prompt presenter on it, so a HUD without it
        /// leaves the "hold to scan" hint firing into nowhere.
        /// </summary>
        /// <param name="placeholder">
        /// What the label reads before anything drives it. The test rig shows a specimen line so
        /// the layout can be judged; the level starts blank, because the presenter only writes when
        /// the player is actually near something.
        /// </param>
        private static void BuildInteractPrompt(Transform parent, string placeholder)
        {
            CreateLabel(parent, "InteractPrompt", placeholder,
                new Vector2(0.5f, 0f), new Vector2(0f, 170f), TextAlignmentOptions.Bottom);
        }

        /// <summary>Specimen readouts, for judging the curvature. Test rig only.</summary>
        private static void BuildSampleReadouts(Transform parent)
        {
            CreateLabel(parent, "ContamReadout", "CONTAM 072\nAIR / SOIL / BIO",
                new Vector2(0f, 1f), new Vector2(90f, -70f), TextAlignmentOptions.TopLeft);
            CreateLabel(parent, "SystemReadout", "HELMET SYS  OK\nEXT. SIGNAL  WEAK",
                new Vector2(1f, 1f), new Vector2(-90f, -70f), TextAlignmentOptions.TopRight);
        }

        private static void CreateLabel(Transform parent, string name, string text,
            Vector2 anchor, Vector2 anchoredPosition, TextAlignmentOptions alignment)
        {
            GameObject go = new GameObject(name, typeof(RectTransform));
            go.transform.SetParent(parent, false);

            RectTransform rect = (RectTransform)go.transform;
            rect.anchorMin = anchor;
            rect.anchorMax = anchor;
            rect.pivot = anchor;
            rect.sizeDelta = new Vector2(520f, 140f);
            rect.anchoredPosition = anchoredPosition;

            CurvedTextMeshPro label = go.AddComponent<CurvedTextMeshPro>();
            label.font = ElectronicUIKitBuilder.EnsureFont();
            label.text = text;
            label.fontSize = 34f;
            label.color = k_TextColor;
            label.alignment = alignment;
            label.raycastTarget = false;
        }
    }
}

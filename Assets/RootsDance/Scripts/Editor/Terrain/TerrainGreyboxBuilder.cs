using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// Turns <see cref="TerrainGreyboxConfigSO"/> into the real greybox in
    /// <c>Main_Environment.unity</c>: a Unity Terrain driven by the pure generators, five flat-colour
    /// terrain layers, the lab blockout on its terrace and the Chapter-00 anchor markers. Idempotent —
    /// running it twice yields the same hierarchy. This is the one sanctioned tool that saves a scene.
    /// Menu: RootsDance &gt; Terrain &gt; Build Greybox Terrain.
    /// </summary>
    /// <remarks>
    /// This file's own namespace is <c>RootsDance.Editor.Terrain</c>, so a bare <c>Terrain</c> resolves
    /// to the namespace rather than to the component. Every engine terrain type is fully qualified.
    /// </remarks>
    public static class TerrainGreyboxBuilder
    {
        private const string k_ConfigPath = "Assets/RootsDance/Data/Config/TerrainGreyboxConfig.asset";
        private const string k_LabPrefabPath = "Assets/RootsDance/Meshes/Environment/LabBlockout.fbx";
        private const string k_MaterialFolder = "Assets/RootsDance/Materials";
        private const string k_TerrainLayerFolder = k_MaterialFolder + "/Terrain";
        private const string k_LayerTextureFolder = "Assets/RootsDance/Textures/Environment";
        private const string k_AnchorMaterialPath = k_MaterialFolder + "/Greybox_Anchor.mat";
        private const string k_UrpLitShader = "Universal Render Pipeline/Lit";

        private const string k_GeometryRootName = "_Geometry";
        private const string k_AnchorRootName = "_Anchors";
        private const string k_TerrainObjectName = "Terrain_Main";
        private const string k_LabObjectName = "LabBlockout";
        private const string k_GroundLayerName = "Ground";
        private const string k_PlaceholderGroundName = "Ground";
        private const string k_PlaceholderLandmarkPrefix = "Landmark_";

        private const float k_LabTerraceMargin = 6f;
        private const float k_AnchorHeightOffset = 0.5f;
        private const float k_SlopeSampleStep = 0.5f;
        private const float k_HeightmapPixelError = 5f;
        private const float k_BasemapDistance = 2000f;
        private const float k_LayerTileSize = 8f;
        private const int k_LayerTextureSize = 4;

        /// <summary>
        /// Asset-name stem of each terrain layer, indexed by the <c>TerrainSplatGenerator.k_Layer*</c>
        /// constants. Public so an EditMode test can pin the table to those constants.
        /// </summary>
        public static readonly string[] k_LayerNames = CreateLayerNames();

        /// <summary>
        /// Flat greybox colour of each terrain layer, indexed by the <c>TerrainSplatGenerator.k_Layer*</c>
        /// constants. Public so an EditMode test can pin the table to those constants.
        /// </summary>
        public static readonly Color[] k_LayerColors = CreateLayerColors();

        private static readonly Color k_AnchorColor = new Color32(0xFF, 0x7A, 0x2F, 0xFF);
        private static readonly int k_BaseColorId = Shader.PropertyToID("_BaseColor");

        private static readonly StaticEditorFlags k_TerrainStaticFlags =
            StaticEditorFlags.BatchingStatic
            | StaticEditorFlags.ContributeGI
            | StaticEditorFlags.OccluderStatic
            | StaticEditorFlags.OccludeeStatic
            | StaticEditorFlags.ReflectionProbeStatic;

        /// <summary>Menu entry: loads (or creates) the default config asset and builds with it.</summary>
        [MenuItem("RootsDance/Terrain/Build Greybox Terrain")]
        public static void BuildFromDefaultConfig()
        {
            TerrainGreyboxConfigSO config = EnsureConfigAsset();
            Build(config);
        }

        /// <summary>
        /// Rebuilds the greybox terrain described by <paramref name="config"/> into its target scene
        /// and saves both the scene and the generated assets.
        /// </summary>
        /// <param name="config">The config asset to build from; a null config is logged and ignored.</param>
        public static void Build(TerrainGreyboxConfigSO config)
        {
            if (config == null)
            {
                Debug.LogError("TerrainGreyboxBuilder: no config asset — nothing to build.");
                return;
            }

            Scene scene;

            if (!TryOpenTargetScene(config, out scene))
            {
                return;
            }

            RemovePlaytestPlaceholders(scene);

            // The lab goes first: its measured footprint defines the terrace, and the terrace is part
            // of the heightmap the generators produce a few lines further down.
            if (!EnsureLabBlockout(config, scene))
            {
                return;
            }

            UnityEngine.TerrainLayer[] layers = EnsureLayerAssets();

            if (layers == null)
            {
                return;
            }

            UnityEngine.TerrainData terrainData = EnsureTerrainData(config, layers);

            if (terrainData == null)
            {
                return;
            }

            UnityEngine.Terrain terrain = EnsureTerrainObject(config, terrainData, scene);
            EnsureAnchors(config, terrain, scene);
            ReportRouteSlopes(config.Params);

            EditorSceneManager.MarkSceneDirty(scene);

            if (!EditorSceneManager.SaveScene(scene))
            {
                Debug.LogError($"TerrainGreyboxBuilder: failed to save '{config.ScenePath}'; "
                    + "the generated hierarchy is only in memory.");
                return;
            }

            AssetDatabase.SaveAssets();

            Debug.Log($"TerrainGreyboxBuilder: built the greybox terrain into '{config.ScenePath}'.");
        }

        /// <summary>
        /// Logs the steepest 0.5 m pitch of every route segment, so a route that became unwalkable
        /// after a parameter change is visible in the Console without entering Play mode.
        /// </summary>
        /// <param name="parameters">Terrain parameters whose <c>Paths</c> are walked; null is ignored.</param>
        public static void ReportRouteSlopes(TerrainGreyboxParams parameters)
        {
            if (parameters == null || parameters.Paths == null)
            {
                return;
            }

            for (int pathIndex = 0; pathIndex < parameters.Paths.Length; pathIndex++)
            {
                HeightPath path = parameters.Paths[pathIndex];

                if (path == null || path.Nodes == null || path.Nodes.Length < 2)
                {
                    continue;
                }

                for (int i = 0; i < path.Nodes.Length - 1; i++)
                {
                    Vector2 from = path.Nodes[i].Position;
                    Vector2 to = path.Nodes[i + 1].Position;
                    float length = Vector2.Distance(from, to);

                    if (length < 1e-4f)
                    {
                        continue;
                    }

                    float previous = TerrainHeightmapGenerator.SampleWorldHeight(parameters, from.x, from.y);
                    float maxDegrees = 0f;
                    float maxAt = 0f;

                    for (float s = k_SlopeSampleStep; s <= length; s += k_SlopeSampleStep)
                    {
                        Vector2 point = Vector2.Lerp(from, to, s / length);
                        float height = TerrainHeightmapGenerator.SampleWorldHeight(parameters, point.x, point.y);
                        float degrees = Mathf.Atan2(Mathf.Abs(height - previous), k_SlopeSampleStep) * Mathf.Rad2Deg;

                        if (degrees > maxDegrees)
                        {
                            maxDegrees = degrees;
                            maxAt = s;
                        }

                        previous = height;
                    }

                    Debug.Log($"TerrainGreyboxBuilder: route {pathIndex} segment {i} "
                        + $"({from.x:F0},{from.y:F0})->({to.x:F0},{to.y:F0}) length={length:F1}m "
                        + $"maxSlope={maxDegrees:F1}deg at s={maxAt:F1}m");
                }
            }
        }

        /// <summary>
        /// Loads the config asset, creating it with defaults when it is missing, and fills in the lab
        /// blockout reference from <c>LabBlockout.fbx</c> while it is still empty.
        /// </summary>
        private static TerrainGreyboxConfigSO EnsureConfigAsset()
        {
            TerrainGreyboxConfigSO config = AssetDatabase.LoadAssetAtPath<TerrainGreyboxConfigSO>(k_ConfigPath);

            if (config == null)
            {
                EnsureFolder(ParentFolderOf(k_ConfigPath));
                config = ScriptableObject.CreateInstance<TerrainGreyboxConfigSO>();
                AssetDatabase.CreateAsset(config, k_ConfigPath);
                Debug.Log($"TerrainGreyboxBuilder: created the default config asset at {k_ConfigPath}.");
            }

            if (config.LabBlockout == null)
            {
                GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_LabPrefabPath);

                if (prefab == null)
                {
                    Debug.LogWarning($"TerrainGreyboxBuilder: {k_LabPrefabPath} is not imported yet; "
                        + "the lab blockout and the terrace derivation will be skipped.");
                }
                else
                {
                    SerializedObject serialized = new SerializedObject(config);
                    serialized.FindProperty("m_labBlockout").objectReferenceValue = prefab;
                    serialized.ApplyModifiedPropertiesWithoutUndo();
                    EditorUtility.SetDirty(config);
                    AssetDatabase.SaveAssets();
                }
            }

            return config;
        }

        /// <summary>
        /// Keeps the target scene when it is already active; otherwise opens it single — but refuses
        /// to do so while any open scene has unsaved changes, because that would throw them away.
        /// </summary>
        private static bool TryOpenTargetScene(TerrainGreyboxConfigSO config, out Scene scene)
        {
            scene = default(Scene);
            string path = config.ScenePath;
            Scene active = SceneManager.GetActiveScene();

            if (active.path == path)
            {
                scene = active;
                return true;
            }

            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene open = SceneManager.GetSceneAt(i);

                if (open.isDirty)
                {
                    Debug.LogError($"TerrainGreyboxBuilder: scene '{open.name}' has unsaved changes. "
                        + $"Save or discard them, then run the builder again ({path} is not open).");
                    return false;
                }
            }

            if (!File.Exists(path))
            {
                Debug.LogError($"TerrainGreyboxBuilder: target scene {path} does not exist.");
                return false;
            }

            scene = EditorSceneManager.OpenScene(path, OpenSceneMode.Single);
            return scene.IsValid();
        }

        /// <summary>
        /// Deletes the PlaytestLevelBuilder leftovers (the 100 m plane and the landmark cubes) from
        /// <c>_Geometry</c>. Everything else, <c>_Lighting/Sun</c> included, is left alone.
        /// </summary>
        private static void RemovePlaytestPlaceholders(Scene scene)
        {
            Transform geometry = FindRoot(scene, k_GeometryRootName);

            if (geometry == null)
            {
                return;
            }

            for (int i = geometry.childCount - 1; i >= 0; i--)
            {
                GameObject child = geometry.GetChild(i).gameObject;

                if (child.name == k_PlaceholderGroundName || child.name.StartsWith(k_PlaceholderLandmarkPrefix))
                {
                    Undo.DestroyObjectImmediate(child);
                }
            }
        }

        /// <summary>
        /// Find-or-create <c>_Geometry/LabBlockout</c> as an instance of the configured model prefab.
        /// The FBX is a presentation board: only the top-level children named in
        /// <see cref="TerrainGreyboxConfigSO.LabIncludedChildren"/> are the actual building, the rest
        /// (display plates, the disc, the second scale model) are switched off on the instance.
        /// The surviving cluster is then measured, yawed and dropped onto the terrace, and its rotated
        /// world footprint becomes <c>Params.TerraceHalfExtents</c>. The lab is required: the terrace is
        /// derived from it, so a missing prefab aborts the build instead of producing a wrong terrace.
        /// </summary>
        /// <param name="config">The config asset being built from.</param>
        /// <param name="scene">The scene the lab instance lives in.</param>
        /// <returns>True when the lab is in place; false when the build must stop.</returns>
        private static bool EnsureLabBlockout(TerrainGreyboxConfigSO config, Scene scene)
        {
            GameObject prefab = config.LabBlockout;

            if (prefab == null)
            {
                Debug.LogError("TerrainGreyboxBuilder: the config's Lab Blockout reference is empty. It is "
                    + $"required — the terrace is derived from its bounds. Import {k_LabPrefabPath} and "
                    + "assign it, then run the builder again.");
                return false;
            }

            Transform geometry = EnsureRoot(scene, k_GeometryRootName);
            Transform existing = geometry.Find(k_LabObjectName);

            if (existing != null
                && PrefabUtility.GetCorrespondingObjectFromSource(existing.gameObject) != prefab)
            {
                Undo.DestroyObjectImmediate(existing.gameObject);
                existing = null;
            }

            GameObject instance;

            if (existing == null)
            {
                instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
                instance.name = k_LabObjectName;
                instance.transform.SetParent(geometry, true);
                Undo.RegisterCreatedObjectUndo(instance, "Create LabBlockout");
            }
            else
            {
                instance = existing.gameObject;
            }

            ApplyLabChildFilter(config, instance);

            if (!config.DeriveTerraceFromLab)
            {
                instance.transform.position = config.LabPosition;
                instance.transform.rotation = Quaternion.Euler(0f, config.LabYawDegrees, 0f);
                instance.transform.localScale = Vector3.one;
                return true;
            }

            // Park the instance at identity so the measured bounds are the cluster's own local box.
            instance.transform.position = Vector3.zero;
            instance.transform.rotation = Quaternion.identity;
            instance.transform.localScale = Vector3.one;

            Bounds local;

            if (!TryMeasureActiveBounds(instance, out local))
            {
                Debug.LogWarning("TerrainGreyboxBuilder: the lab instance has no active meshes after the "
                    + "child filter; keeping the authored terrace extents and lab position.");
                instance.transform.position = config.LabPosition;
                instance.transform.rotation = Quaternion.Euler(0f, config.LabYawDegrees, 0f);
                return true;
            }

            TerrainGreyboxParams parameters = config.Params;
            Quaternion rotation = Quaternion.Euler(0f, config.LabYawDegrees, 0f);
            Vector3 target = new Vector3(
                parameters.TerraceCenter.x, parameters.TerraceHeight, parameters.TerraceCenter.y);

            // Put the cluster's footprint centre on the terrace centre and its lowest point on the floor.
            Vector3 pivotOffset = new Vector3(local.center.x, local.min.y, local.center.z);
            Vector3 position = target - rotation * pivotOffset;

            instance.transform.rotation = rotation;
            instance.transform.position = position;

            Bounds world = TransformBounds(local, Matrix4x4.TRS(position, rotation, Vector3.one));

            parameters.TerraceHalfExtents = new Vector2(
                world.size.x * 0.5f + k_LabTerraceMargin,
                world.size.z * 0.5f + k_LabTerraceMargin);

            // The world AABB of the yawed cluster already covers the building, so the terrace itself
            // stays axis-aligned — a yawed terrace would only add a second, redundant rotation.
            parameters.TerraceYawDegrees = 0f;

            SerializedObject serialized = new SerializedObject(config);
            serialized.FindProperty("m_labPosition").vector3Value = position;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(config);
            AssetDatabase.SaveAssets();

            Debug.Log($"TerrainGreyboxBuilder: lab cluster local bounds min={local.min:F2} max={local.max:F2} "
                + $"size={local.size:F2} center={local.center:F2}.");
            Debug.Log($"TerrainGreyboxBuilder: lab placed at position={position:F2} yaw={config.LabYawDegrees:F1}deg; "
                + $"world AABB min={world.min:F2} max={world.max:F2} size={world.size:F2}.");
            Debug.Log($"TerrainGreyboxBuilder: derived TerraceHalfExtents={parameters.TerraceHalfExtents:F2} "
                + $"(margin {k_LabTerraceMargin:F0} m), TerraceYaw={parameters.TerraceYawDegrees:F1}deg, "
                + $"TerraceCenter={parameters.TerraceCenter:F2}, TerraceHeight={parameters.TerraceHeight:F2}.");

            return true;
        }

        /// <summary>
        /// Switches off every top-level child of the lab instance that is not part of the building
        /// cluster. These are instance-level active-state overrides, which guideline 11 allows.
        /// </summary>
        private static void ApplyLabChildFilter(TerrainGreyboxConfigSO config, GameObject instance)
        {
            string[] included = config.LabIncludedChildren;

            if (included == null || included.Length == 0)
            {
                return;
            }

            HashSet<string> keep = new HashSet<string>(included);
            int disabled = 0;

            for (int i = 0; i < instance.transform.childCount; i++)
            {
                GameObject child = instance.transform.GetChild(i).gameObject;
                bool wanted = keep.Contains(child.name);

                if (child.activeSelf != wanted)
                {
                    child.SetActive(wanted);
                }

                if (!wanted)
                {
                    disabled++;
                }
            }

            Debug.Log($"TerrainGreyboxBuilder: lab child filter kept {instance.transform.childCount - disabled} "
                + $"of {instance.transform.childCount} top-level children (the presentation board is hidden).");
        }

        /// <summary>
        /// Combined mesh bounds of every <em>active</em> renderer under <paramref name="root"/>,
        /// expressed in the root's own local space, so the numbers do not depend on where it stands.
        /// </summary>
        private static bool TryMeasureActiveBounds(GameObject root, out Bounds bounds)
        {
            bounds = new Bounds(Vector3.zero, Vector3.zero);
            bool hasAny = false;
            Matrix4x4 worldToRoot = root.transform.worldToLocalMatrix;
            MeshFilter[] filters = root.GetComponentsInChildren<MeshFilter>(false);

            for (int i = 0; i < filters.Length; i++)
            {
                Mesh mesh = filters[i].sharedMesh;

                if (mesh == null)
                {
                    continue;
                }

                Matrix4x4 meshToRoot = worldToRoot * filters[i].transform.localToWorldMatrix;
                Bounds transformed = TransformBounds(mesh.bounds, meshToRoot);

                if (hasAny)
                {
                    bounds.Encapsulate(transformed);
                }
                else
                {
                    bounds = transformed;
                    hasAny = true;
                }
            }

            return hasAny;
        }

        /// <summary>
        /// Axis-aligned box containing the eight transformed corners of <paramref name="source"/>.
        /// </summary>
        private static Bounds TransformBounds(Bounds source, Matrix4x4 matrix)
        {
            Bounds result = new Bounds(Vector3.zero, Vector3.zero);

            for (int corner = 0; corner < 8; corner++)
            {
                Vector3 local = new Vector3(
                    (corner & 1) == 0 ? source.min.x : source.max.x,
                    (corner & 2) == 0 ? source.min.y : source.max.y,
                    (corner & 4) == 0 ? source.min.z : source.max.z);
                Vector3 point = matrix.MultiplyPoint3x4(local);

                if (corner == 0)
                {
                    result = new Bounds(point, Vector3.zero);
                }
                else
                {
                    result.Encapsulate(point);
                }
            }

            return result;
        }

        /// <summary>Layer names in splat-layer order; see <see cref="k_LayerNames"/>.</summary>
        /// <returns>A new array of length <c>TerrainSplatGenerator.k_LayerCount</c>.</returns>
        private static string[] CreateLayerNames()
        {
            string[] names = new string[TerrainSplatGenerator.k_LayerCount];

            names[TerrainSplatGenerator.k_LayerAshDry] = "AshDry";
            names[TerrainSplatGenerator.k_LayerHumusDead] = "HumusDead";
            names[TerrainSplatGenerator.k_LayerGrassBand] = "GrassBandGreybox";
            names[TerrainSplatGenerator.k_LayerStableSoil] = "StableSoil";
            names[TerrainSplatGenerator.k_LayerResearchGround] = "ResearchGround";

            return names;
        }

        /// <summary>Layer colours in splat-layer order; see <see cref="k_LayerColors"/>.</summary>
        /// <returns>A new array of length <c>TerrainSplatGenerator.k_LayerCount</c>.</returns>
        private static Color[] CreateLayerColors()
        {
            Color[] colors = new Color[TerrainSplatGenerator.k_LayerCount];

            colors[TerrainSplatGenerator.k_LayerAshDry] = new Color32(0x6E, 0x65, 0x59, 0xFF);
            colors[TerrainSplatGenerator.k_LayerHumusDead] = new Color32(0x4A, 0x3B, 0x2E, 0xFF);
            colors[TerrainSplatGenerator.k_LayerGrassBand] = new Color32(0x8F, 0xB0, 0x8A, 0xFF);
            colors[TerrainSplatGenerator.k_LayerStableSoil] = new Color32(0x4F, 0x6B, 0x4A, 0xFF);
            colors[TerrainSplatGenerator.k_LayerResearchGround] = new Color32(0x8C, 0x8C, 0x86, 0xFF);

            return colors;
        }

        /// <summary>
        /// Creates (once) the five flat-colour base maps and their <c>TerrainLayer</c> assets, and
        /// re-applies the layer settings every run so the assets cannot drift.
        /// </summary>
        /// <returns>One layer per splat layer, or null when the layer tables are inconsistent.</returns>
        private static UnityEngine.TerrainLayer[] EnsureLayerAssets()
        {
            int layerCount = TerrainSplatGenerator.k_LayerCount;

            if (k_LayerNames.Length != layerCount || k_LayerColors.Length != layerCount)
            {
                Debug.LogError($"TerrainGreyboxBuilder: the layer tables hold {k_LayerNames.Length} names and "
                    + $"{k_LayerColors.Length} colours, but the splat generator has {layerCount} layers. "
                    + "Fix CreateLayerNames/CreateLayerColors before building.");
                return null;
            }

            EnsureFolder(k_LayerTextureFolder);
            EnsureFolder(k_TerrainLayerFolder);

            UnityEngine.TerrainLayer[] layers = new UnityEngine.TerrainLayer[layerCount];

            for (int i = 0; i < layerCount; i++)
            {
                string texturePath = $"{k_LayerTextureFolder}/TL_{k_LayerNames[i]}_BaseMap.png";
                Texture2D texture = EnsureLayerTexture(texturePath, k_LayerColors[i]);

                string layerPath = $"{k_TerrainLayerFolder}/TL_{k_LayerNames[i]}.terrainlayer";
                UnityEngine.TerrainLayer layer = AssetDatabase.LoadAssetAtPath<UnityEngine.TerrainLayer>(layerPath);
                bool isNew = layer == null;

                if (isNew)
                {
                    layer = new UnityEngine.TerrainLayer();
                }

                layer.diffuseTexture = texture;
                layer.tileSize = new Vector2(k_LayerTileSize, k_LayerTileSize);
                layer.tileOffset = Vector2.zero;
                layer.specular = Color.black;
                layer.smoothness = 0f;
                layer.metallic = 0f;

                if (isNew)
                {
                    AssetDatabase.CreateAsset(layer, layerPath);
                }
                else
                {
                    EditorUtility.SetDirty(layer);
                }

                layers[i] = layer;
            }

            return layers;
        }

        /// <summary>Writes a 4x4 solid-colour PNG the first time, then enforces the import settings.</summary>
        private static Texture2D EnsureLayerTexture(string assetPath, Color color)
        {
            if (!File.Exists(assetPath))
            {
                Texture2D source = new Texture2D(k_LayerTextureSize, k_LayerTextureSize, TextureFormat.RGBA32, false);
                Color[] pixels = new Color[k_LayerTextureSize * k_LayerTextureSize];

                for (int i = 0; i < pixels.Length; i++)
                {
                    pixels[i] = color;
                }

                source.SetPixels(pixels);
                source.Apply();
                File.WriteAllBytes(assetPath, source.EncodeToPNG());
                UnityEngine.Object.DestroyImmediate(source);
                AssetDatabase.ImportAsset(assetPath, ImportAssetOptions.ForceSynchronousImport);
            }

            TextureImporter importer = AssetImporter.GetAtPath(assetPath) as TextureImporter;

            if (importer != null)
            {
                bool changed = false;

                if (!importer.sRGBTexture)
                {
                    importer.sRGBTexture = true;
                    changed = true;
                }

                if (importer.mipmapEnabled)
                {
                    importer.mipmapEnabled = false;
                    changed = true;
                }

                if (importer.wrapMode != TextureWrapMode.Repeat)
                {
                    importer.wrapMode = TextureWrapMode.Repeat;
                    changed = true;
                }

                if (importer.textureCompression != TextureImporterCompression.Uncompressed)
                {
                    importer.textureCompression = TextureImporterCompression.Uncompressed;
                    changed = true;
                }

                if (changed)
                {
                    importer.SaveAndReimport();
                }
            }

            return AssetDatabase.LoadAssetAtPath<Texture2D>(assetPath);
        }

        /// <summary>
        /// Loads or creates the <c>TerrainData</c> asset and fills it from the generators. Resolution
        /// is set before <c>size</c> on purpose: Unity resets the size whenever a resolution changes.
        /// </summary>
        /// <param name="config">The config asset being built from.</param>
        /// <param name="layers">The terrain layers to assign, in splat-layer order.</param>
        /// <returns>The filled <c>TerrainData</c>, or null when the configured resolutions are illegal.</returns>
        private static UnityEngine.TerrainData EnsureTerrainData(
            TerrainGreyboxConfigSO config, UnityEngine.TerrainLayer[] layers)
        {
            TerrainGreyboxParams parameters = config.Params;

            // Unity silently rounds an illegal resolution to the nearest legal one, which would leave the
            // asset out of step with the generated arrays. Refuse before anything is written.
            if (!IsLegalHeightmapResolution(parameters.HeightmapResolution))
            {
                Debug.LogError($"TerrainGreyboxBuilder: HeightmapResolution {parameters.HeightmapResolution} is "
                    + "not a power of two plus one between 33 and 4097; nothing was modified.");
                return null;
            }

            if (!IsLegalAlphamapResolution(parameters.AlphamapResolution))
            {
                Debug.LogError($"TerrainGreyboxBuilder: AlphamapResolution {parameters.AlphamapResolution} is "
                    + "not a power of two between 16 and 4096; nothing was modified.");
                return null;
            }

            string path = config.TerrainDataPath;
            EnsureFolder(ParentFolderOf(path));

            UnityEngine.TerrainData terrainData = AssetDatabase.LoadAssetAtPath<UnityEngine.TerrainData>(path);

            if (terrainData == null)
            {
                terrainData = new UnityEngine.TerrainData();
                terrainData.name = Path.GetFileNameWithoutExtension(path);
                AssetDatabase.CreateAsset(terrainData, path);
            }

            terrainData.heightmapResolution = parameters.HeightmapResolution;
            terrainData.alphamapResolution = parameters.AlphamapResolution;
            terrainData.size = parameters.TerrainSize;
            terrainData.terrainLayers = layers;

            float[,] heights = TerrainHeightmapGenerator.Generate(parameters);
            terrainData.SetHeights(0, 0, heights);

            float[,,] alphamaps = TerrainSplatGenerator.Generate(parameters);
            terrainData.SetAlphamaps(0, 0, alphamaps);

            EditorUtility.SetDirty(terrainData);
            return terrainData;
        }

        /// <summary>Unity accepts a heightmap resolution of 2^n + 1 from 33 up to 4097.</summary>
        /// <param name="resolution">The configured heightmap resolution.</param>
        /// <returns>True when Unity will store the resolution unchanged.</returns>
        private static bool IsLegalHeightmapResolution(int resolution)
        {
            return resolution >= 33 && resolution <= 4097 && IsPowerOfTwo(resolution - 1);
        }

        /// <summary>Unity accepts an alphamap resolution that is a power of two from 16 up to 4096.</summary>
        /// <param name="resolution">The configured alphamap resolution.</param>
        /// <returns>True when Unity will store the resolution unchanged.</returns>
        private static bool IsLegalAlphamapResolution(int resolution)
        {
            return resolution >= 16 && resolution <= 4096 && IsPowerOfTwo(resolution);
        }

        /// <summary>Tests whether a positive integer has exactly one bit set.</summary>
        /// <param name="value">The value to test.</param>
        /// <returns>True when <paramref name="value"/> is a power of two.</returns>
        private static bool IsPowerOfTwo(int value)
        {
            return value > 0 && (value & (value - 1)) == 0;
        }

        /// <summary>Find-or-create <c>_Geometry/Terrain_Main</c> and re-apply every setting.</summary>
        private static UnityEngine.Terrain EnsureTerrainObject(
            TerrainGreyboxConfigSO config, UnityEngine.TerrainData terrainData, Scene scene)
        {
            Transform geometry = EnsureRoot(scene, k_GeometryRootName);
            Transform existing = geometry.Find(k_TerrainObjectName);
            GameObject terrainObject;

            if (existing == null)
            {
                terrainObject = UnityEngine.Terrain.CreateTerrainGameObject(terrainData);
                terrainObject.name = k_TerrainObjectName;
                MoveToScene(terrainObject, scene);
                terrainObject.transform.SetParent(geometry, true);
                Undo.RegisterCreatedObjectUndo(terrainObject, "Create Terrain_Main");
            }
            else
            {
                terrainObject = existing.gameObject;
            }

            UnityEngine.Terrain terrain = terrainObject.GetComponent<UnityEngine.Terrain>();

            if (terrain == null)
            {
                terrain = terrainObject.AddComponent<UnityEngine.Terrain>();
            }

            UnityEngine.TerrainCollider collider = terrainObject.GetComponent<UnityEngine.TerrainCollider>();

            if (collider == null)
            {
                collider = terrainObject.AddComponent<UnityEngine.TerrainCollider>();
            }

            terrain.terrainData = terrainData;
            collider.terrainData = terrainData;
            terrain.heightmapPixelError = k_HeightmapPixelError;
            terrain.basemapDistance = k_BasemapDistance;

            terrainObject.transform.position = config.Params.TerrainPosition;
            terrainObject.transform.rotation = Quaternion.identity;
            terrainObject.transform.localScale = Vector3.one;

            int groundLayer = LayerMask.NameToLayer(k_GroundLayerName);

            if (groundLayer < 0)
            {
                Debug.LogError($"TerrainGreyboxBuilder: layer '{k_GroundLayerName}' does not exist; "
                    + "the terrain stays on its current layer and the player will not collide with it.");
            }
            else
            {
                terrainObject.layer = groundLayer;
            }

            RenderPipelineAsset pipeline = GraphicsSettings.currentRenderPipeline;

            if (pipeline != null && pipeline.defaultTerrainMaterial != null)
            {
                terrain.materialTemplate = pipeline.defaultTerrainMaterial;
            }
            else
            {
                Debug.LogWarning("TerrainGreyboxBuilder: no render-pipeline terrain material found; "
                    + "the terrain keeps its default material.");
            }

            GameObjectUtility.SetStaticEditorFlags(terrainObject, k_TerrainStaticFlags);
            return terrain;
        }

        /// <summary>
        /// Find-or-create one orange marker sphere per spec anchor under <c>_Anchors</c>, dropped onto
        /// the generated terrain, and log how far the terrain ended up from the spec height.
        /// </summary>
        private static void EnsureAnchors(
            TerrainGreyboxConfigSO config, UnityEngine.Terrain terrain, Scene scene)
        {
            AnchorDefinition[] anchors = config.Anchors;

            if (anchors == null || anchors.Length == 0)
            {
                Debug.LogWarning("TerrainGreyboxBuilder: the config has no anchors.");
                return;
            }

            Material material = EnsureAnchorMaterial();
            Transform anchorRoot = EnsureRoot(scene, k_AnchorRootName);
            float terrainBaseY = terrain.transform.position.y;

            for (int i = 0; i < anchors.Length; i++)
            {
                AnchorDefinition anchor = anchors[i];

                if (anchor == null || string.IsNullOrEmpty(anchor.Name))
                {
                    continue;
                }

                Transform existing = anchorRoot.Find(anchor.Name);
                GameObject marker;

                if (existing == null)
                {
                    marker = GameObject.CreatePrimitive(PrimitiveType.Sphere);
                    marker.name = anchor.Name;
                    Collider collider = marker.GetComponent<Collider>();

                    if (collider != null)
                    {
                        UnityEngine.Object.DestroyImmediate(collider);
                    }

                    MoveToScene(marker, scene);
                    marker.transform.SetParent(anchorRoot, true);
                    Undo.RegisterCreatedObjectUndo(marker, "Create anchor marker");
                }
                else
                {
                    marker = existing.gameObject;
                }

                Vector3 spec = anchor.SpecPosition;
                float terrainY = terrain.SampleHeight(new Vector3(spec.x, 0f, spec.z)) + terrainBaseY;
                float y = anchor.UseSpecHeight ? spec.y : terrainY + k_AnchorHeightOffset;

                marker.transform.position = new Vector3(spec.x, y, spec.z);
                marker.transform.rotation = Quaternion.identity;
                marker.transform.localScale = Vector3.one;

                MeshRenderer renderer = marker.GetComponent<MeshRenderer>();

                if (renderer != null && material != null)
                {
                    renderer.sharedMaterial = material;
                }

                Debug.Log($"TerrainGreyboxBuilder: {anchor.Name}: specY={spec.y:F2} "
                    + $"terrainY={terrainY:F2} delta={terrainY - spec.y:F2}"
                    + (anchor.UseSpecHeight ? " (kept spec Y — wall-mounted)" : string.Empty));
            }
        }

        private static Material EnsureAnchorMaterial()
        {
            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_AnchorMaterialPath);

            if (material == null)
            {
                Shader shader = Shader.Find(k_UrpLitShader);

                if (shader == null)
                {
                    Debug.LogError($"TerrainGreyboxBuilder: shader '{k_UrpLitShader}' not found; "
                        + "the anchor markers keep the default material.");
                    return null;
                }

                EnsureFolder(k_MaterialFolder);
                material = new Material(shader);
                material.name = Path.GetFileNameWithoutExtension(k_AnchorMaterialPath);
                AssetDatabase.CreateAsset(material, k_AnchorMaterialPath);
            }

            if (material.HasProperty(k_BaseColorId) && material.GetColor(k_BaseColorId) != k_AnchorColor)
            {
                material.SetColor(k_BaseColorId, k_AnchorColor);
                EditorUtility.SetDirty(material);
            }

            return material;
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

        private static Transform EnsureRoot(Scene scene, string name)
        {
            Transform existing = FindRoot(scene, name);

            if (existing != null)
            {
                return existing;
            }

            GameObject created = new GameObject(name);
            MoveToScene(created, scene);
            Undo.RegisterCreatedObjectUndo(created, "Create " + name);
            return created.transform;
        }

        private static void MoveToScene(GameObject target, Scene scene)
        {
            if (target.scene != scene)
            {
                SceneManager.MoveGameObjectToScene(target, scene);
            }
        }

        private static string ParentFolderOf(string assetPath)
        {
            return Path.GetDirectoryName(assetPath).Replace('\\', '/');
        }

        private static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = ParentFolderOf(path);
            string folderName = Path.GetFileName(path);

            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, folderName);
        }
    }
}

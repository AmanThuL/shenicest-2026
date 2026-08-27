using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// Turns <see cref="TerrainGreyboxConfigSO"/> into the real greybox in
    /// <c>Main_Environment.unity</c>: a Unity Terrain driven by the pure generators, one terrain layer
    /// per splat band (textured from the CC0 ground sets, or flat greybox colour while a definition has
    /// no albedo), the lab blockout on its terrace and the Chapter-00 anchor markers. Idempotent —
    /// running it twice yields the same hierarchy (the lab instance is destroyed and re-instantiated on
    /// every run; it carries no hand edits by contract). This is the one sanctioned tool that saves a
    /// scene.
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
        private const string k_TerrainMaterialPath = k_TerrainLayerFolder + "/Terrain_Main.mat";
        private const string k_LitShader = "HDRP/Lit";
        private const string k_TerrainLitShader = "HDRP/TerrainLit";

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
        private static readonly int k_HeightBlendId = Shader.PropertyToID("_EnableHeightBlend");

        private static readonly int k_InstancedPerPixelNormalId =
            Shader.PropertyToID("_EnableInstancedPerPixelNormal");

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

            if (!TerrainSceneUtility.TryOpenTargetScene(config.ScenePath, nameof(TerrainGreyboxBuilder), out scene))
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

            UnityEngine.TerrainLayer[] layers = EnsureLayerAssets(config);

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
                TerrainSceneUtility.EnsureFolder(TerrainSceneUtility.ParentFolderOf(k_ConfigPath));
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
        /// Deletes the PlaytestLevelBuilder leftovers (the 100 m plane and the landmark cubes) from
        /// <c>_Geometry</c>. Everything else, <c>_Lighting/Sun</c> included, is left alone.
        /// </summary>
        private static void RemovePlaytestPlaceholders(Scene scene)
        {
            Transform geometry = TerrainSceneUtility.FindRoot(scene, k_GeometryRootName);

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
        /// Recreates <c>_Geometry/LabBlockout</c> as a fresh instance of the configured model prefab:
        /// any existing instance is destroyed first, so stale per-child active-state overrides from a
        /// previous model cannot survive a model swap. When
        /// <see cref="TerrainGreyboxConfigSO.LabIncludedChildren"/> names any top-level children, only
        /// those stay active and the rest are switched off on the instance (the V2 export contains only
        /// the building, so the list is empty). The surviving cluster is then measured in its own local
        /// space, yawed and dropped onto the terrace; its local footprint plus margin becomes
        /// <c>Params.TerraceHalfExtents</c> and its yaw becomes <c>Params.TerraceYawDegrees</c>, so the
        /// terrace follows the building instead of its world AABB. The lab is required: the terrace is
        /// derived from it, so a missing prefab or an unmeasurable instance aborts the build instead of
        /// producing a wrong terrace.
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

            Transform geometry = TerrainSceneUtility.EnsureRoot(scene, k_GeometryRootName);
            Transform existing = geometry.Find(k_LabObjectName);

            if (existing != null)
            {
                Undo.DestroyObjectImmediate(existing.gameObject);
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            instance.name = k_LabObjectName;
            instance.transform.SetParent(geometry, true);
            Undo.RegisterCreatedObjectUndo(instance, "Create LabBlockout");

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
                // A wrong terrace saved into the scene is worse than an aborted build, so this is fatal
                // rather than a silent fallback to the stale authored position.
                Debug.LogError("TerrainGreyboxBuilder: the lab instance has no active meshes after the child "
                    + "filter, so the terrace cannot be derived. Check Lab Included Children against the "
                    + "model's top-level children, then run the builder again.");
                return false;
            }

            TerrainGreyboxParams parameters = config.Params;
            Quaternion rotation = Quaternion.Euler(0f, config.LabYawDegrees, 0f);
            Vector3 target = new Vector3(
                parameters.TerraceCenter.x, parameters.TerraceHeight, parameters.TerraceCenter.y);

            // Put the cluster's footprint centre on the terrace centre and its main floor slab (the lowest
            // point raised by the configured floor offset) on the terrace height.
            Vector3 pivotOffset = LabTerraceDerivation.LabPivot(local, config.LabFloorOffset);
            Vector3 position = target - rotation * pivotOffset;

            instance.transform.rotation = rotation;
            instance.transform.position = position;

            // The terrace is the lab's own oriented footprint, yawed with it, so a diagonal lab gets a
            // diagonal terrace instead of a square world AABB with empty corners.
            Vector2 halfExtents;
            float terraceYawDegrees;
            LabTerraceDerivation.DeriveTerrace(
                local, config.LabYawDegrees, k_LabTerraceMargin, out halfExtents, out terraceYawDegrees);

            parameters.TerraceHalfExtents = halfExtents;
            parameters.TerraceYawDegrees = terraceYawDegrees;

            SerializedObject serialized = new SerializedObject(config);
            serialized.FindProperty("m_labPosition").vector3Value = position;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(config);
            AssetDatabase.SaveAssets();

            Debug.Log($"TerrainGreyboxBuilder: lab cluster local bounds min={local.min:F2} max={local.max:F2} "
                + $"size={local.size:F2} center={local.center:F2}.");
            Debug.Log($"TerrainGreyboxBuilder: lab placed at position={position:F2} yaw={config.LabYawDegrees:F1}deg, "
                + $"floor offset {config.LabFloorOffset:F2} m (lowest point at world y={position.y + local.min.y:F2}, "
                + $"terrace at y={parameters.TerraceHeight:F2}).");
            Debug.Log($"TerrainGreyboxBuilder: derived TerraceHalfExtents={parameters.TerraceHalfExtents:F2} "
                + $"from local size ({local.size.x:F2} x {local.size.z:F2}) + margin {k_LabTerraceMargin:F0} m, "
                + $"TerraceYaw={parameters.TerraceYawDegrees:F1}deg, TerraceCenter={parameters.TerraceCenter:F2}, "
                + $"TerraceHeight={parameters.TerraceHeight:F2}.");

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
                + $"of {instance.transform.childCount} top-level children (the rest are hidden).");
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
            names[TerrainSplatGenerator.k_LayerGrassBand] = "GrassBand";
            names[TerrainSplatGenerator.k_LayerStableSoil] = "StableSoil";
            names[TerrainSplatGenerator.k_LayerResearchGround] = "ResearchGround";
            names[TerrainSplatGenerator.k_LayerTrail] = "Trail";

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
            colors[TerrainSplatGenerator.k_LayerTrail] = new Color32(0x5A, 0x4A, 0x3A, 0xFF);

            return colors;
        }

        /// <summary>
        /// Creates (once) the flat greybox base maps and the <c>TerrainLayer</c> assets, and re-applies
        /// every layer setting on each run so the assets cannot drift. A layer whose definition carries
        /// an albedo is textured from the CC0 ground set; the others keep the flat greybox colour.
        /// </summary>
        /// <param name="config">The config asset holding the layer definitions.</param>
        /// <returns>One layer per splat layer, or null when the layer tables are inconsistent.</returns>
        private static UnityEngine.TerrainLayer[] EnsureLayerAssets(TerrainGreyboxConfigSO config)
        {
            int layerCount = TerrainSplatGenerator.k_LayerCount;
            int sourceCount = TerrainLayerMaskPacker.k_LayerSources.GetLength(0);

            if (k_LayerNames.Length != layerCount || k_LayerColors.Length != layerCount || sourceCount != layerCount)
            {
                Debug.LogError($"TerrainGreyboxBuilder: the layer tables hold {k_LayerNames.Length} names, "
                    + $"{k_LayerColors.Length} colours and {sourceCount} mask sources, but the splat generator "
                    + $"has {layerCount} layers. Fix CreateLayerNames/CreateLayerColors/"
                    + "TerrainLayerMaskPacker.k_LayerSources before building.");
                return null;
            }

            TerrainSceneUtility.EnsureFolder(k_LayerTextureFolder);
            TerrainSceneUtility.EnsureFolder(k_TerrainLayerFolder);
            EnsureLayerTexturesWired(config);

            TerrainLayerDefinition[] definitions = config.Layers;
            UnityEngine.TerrainLayer[] layers = new UnityEngine.TerrainLayer[layerCount];

            for (int i = 0; i < layerCount; i++)
            {
                TerrainLayerDefinition definition =
                    definitions != null && i < definitions.Length ? definitions[i] : null;

                string layerPath = $"{k_TerrainLayerFolder}/TL_{k_LayerNames[i]}.terrainlayer";
                UnityEngine.TerrainLayer layer = AssetDatabase.LoadAssetAtPath<UnityEngine.TerrainLayer>(layerPath);
                bool isNew = layer == null;

                if (isNew)
                {
                    layer = new UnityEngine.TerrainLayer();
                }

                if (definition != null && definition.HasTextures)
                {
                    ApplyTexturedLayer(layer, definition);
                }
                else
                {
                    ApplyFlatLayer(layer, i);
                }

                layer.tileOffset = Vector2.zero;
                layer.specular = Color.black;
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

        /// <summary>Applies one CC0 ground set to a terrain layer, tinted and remapped for this level.</summary>
        private static void ApplyTexturedLayer(UnityEngine.TerrainLayer layer, TerrainLayerDefinition definition)
        {
            layer.diffuseTexture = definition.Albedo;
            layer.normalMapTexture = definition.Normal;
            layer.maskMapTexture = definition.Mask;
            layer.normalScale = definition.NormalScale;
            layer.tileSize = Vector2.one * definition.TileSize;

            // HDRP TerrainLit remaps the albedo into [diffuseRemapMin, diffuseRemapMax], so the tint is the
            // layer's colour cast and the floor is how much of the source's contrast survives; the ceiling's
            // alpha must stay 1 (the shader reads .w as "use opacity as density").
            layer.diffuseRemapMin = definition.TintMin;
            layer.diffuseRemapMax = definition.Tint;

            // R metallic (kept at 0), G occlusion, B height, A smoothness. The alpha ceiling turns the
            // packed 1 − roughness into this layer's smoothness range.
            layer.maskMapRemapMin = Vector4.zero;
            layer.maskMapRemapMax = new Vector4(0f, 1f, 1f, definition.Smoothness * 2f);
            layer.smoothness = definition.Smoothness;
        }

        /// <summary>Applies the flat greybox colour of splat layer <paramref name="index"/>.</summary>
        private static void ApplyFlatLayer(UnityEngine.TerrainLayer layer, int index)
        {
            string texturePath = $"{k_LayerTextureFolder}/TerrainGreybox{k_LayerNames[index]}_BaseMap.png";

            layer.diffuseTexture = EnsureLayerTexture(texturePath, k_LayerColors[index]);
            layer.normalMapTexture = null;
            layer.maskMapTexture = null;
            layer.normalScale = 1f;
            layer.tileSize = new Vector2(k_LayerTileSize, k_LayerTileSize);
            layer.diffuseRemapMin = Color.black;
            layer.diffuseRemapMax = Color.white;
            layer.maskMapRemapMin = Vector4.zero;
            layer.maskMapRemapMax = Vector4.one;
            layer.smoothness = 0f;
        }

        /// <summary>
        /// Fills in the textures of every layer definition that has none, from the CC0 ground set the
        /// mask packer uses. Import settings are not touched here — <c>TexturePipelinePostprocessor</c>
        /// owns everything under <c>Assets/RootsDance/Textures/</c> and the environment postprocessor
        /// owns <c>Assets/ThirdParty/Environment/</c>.
        /// </summary>
        /// <param name="config">The config asset whose <c>m_layers</c> array is written through.</param>
        private static void EnsureLayerTexturesWired(TerrainGreyboxConfigSO config)
        {
            SerializedObject serialized = new SerializedObject(config);
            SerializedProperty layers = serialized.FindProperty("m_layers");
            int layerCount = TerrainSplatGenerator.k_LayerCount;

            // A config asset written before the layer definitions existed has no array at all.
            if (layers.arraySize != layerCount)
            {
                WriteDefaultLayerDefinitions(layers);
            }

            for (int i = 0; i < layerCount; i++)
            {
                SerializedProperty element = layers.GetArrayElementAtIndex(i);
                string name = k_LayerNames[i];
                string id = TerrainLayerMaskPacker.k_LayerSources[i, 1];

                // Each field is gated independently so a mask that is missing on the first build (or
                // later deleted, or whose GUID changed) is re-wired on the next build instead of being
                // skipped forever because the albedo alone was already assigned.
                if (element.FindPropertyRelative("m_albedo").objectReferenceValue == null)
                {
                    AssignTexture(element, "m_albedo", TerrainLayerMaskPacker.ColorPath(id), name);
                }

                if (element.FindPropertyRelative("m_normal").objectReferenceValue == null)
                {
                    AssignTexture(element, "m_normal", TerrainLayerMaskPacker.NormalPath(id), name);
                }

                if (element.FindPropertyRelative("m_mask").objectReferenceValue == null)
                {
                    AssignTexture(element, "m_mask", TerrainLayerMaskPacker.MaskPath(name), name);
                }
            }

            if (serialized.ApplyModifiedPropertiesWithoutUndo())
            {
                EditorUtility.SetDirty(config);
                AssetDatabase.SaveAssets();
            }
        }

        /// <summary>
        /// Resets the config's layer definitions to <see cref="TerrainGreyboxConfigSO.CreateDefaultLayers"/>,
        /// dropping any texture assignment. Used when the tint/tile defaults in code have moved on.
        /// </summary>
        /// <param name="config">The config asset to rewrite; a null config is ignored.</param>
        public static void ResetLayerDefinitions(TerrainGreyboxConfigSO config)
        {
            if (config == null)
            {
                return;
            }

            SerializedObject serialized = new SerializedObject(config);
            WriteDefaultLayerDefinitions(serialized.FindProperty("m_layers"));

            // This is the Inspector button path (a human pressed "Reset Terrain Layers"), so the write
            // must be undoable — unlike the automatic wiring in EnsureLayerTexturesWired, which runs on
            // every build and would otherwise spam the undo stack.
            serialized.ApplyModifiedProperties();
            EditorUtility.SetDirty(config);
            AssetDatabase.SaveAssets();
        }

        /// <summary>Writes the code defaults into the serialized <c>m_layers</c> array.</summary>
        /// <param name="layers">The <c>m_layers</c> array property; resized to the default count.</param>
        private static void WriteDefaultLayerDefinitions(SerializedProperty layers)
        {
            TerrainLayerDefinition[] defaults = TerrainGreyboxConfigSO.CreateDefaultLayers();
            layers.arraySize = defaults.Length;

            for (int i = 0; i < defaults.Length; i++)
            {
                SerializedProperty element = layers.GetArrayElementAtIndex(i);

                element.FindPropertyRelative("m_name").stringValue = defaults[i].Name;
                element.FindPropertyRelative("m_albedo").objectReferenceValue = null;
                element.FindPropertyRelative("m_normal").objectReferenceValue = null;
                element.FindPropertyRelative("m_mask").objectReferenceValue = null;
                element.FindPropertyRelative("m_tileSize").floatValue = defaults[i].TileSize;
                element.FindPropertyRelative("m_tint").colorValue = defaults[i].Tint;
                element.FindPropertyRelative("m_tintMin").colorValue = defaults[i].TintMin;
                element.FindPropertyRelative("m_smoothness").floatValue = defaults[i].Smoothness;
                element.FindPropertyRelative("m_normalScale").floatValue = defaults[i].NormalScale;
            }

            Debug.Log($"TerrainGreyboxBuilder: wrote {defaults.Length} default terrain-layer definitions "
                + "into the config asset.");
        }

        /// <summary>Assigns one texture into a layer definition, warning when the asset is missing.</summary>
        private static void AssignTexture(
            SerializedProperty element, string fieldName, string assetPath, string layerName)
        {
            Texture2D texture = AssetDatabase.LoadAssetAtPath<Texture2D>(assetPath);

            if (texture == null)
            {
                Debug.LogWarning($"TerrainGreyboxBuilder: layer '{layerName}' has no texture at {assetPath}; "
                    + "it keeps the flat greybox colour. Run RootsDance/Terrain/Pack Terrain Layer Masks "
                    + "and check the CC0 import.");
                return;
            }

            element.FindPropertyRelative(fieldName).objectReferenceValue = texture;
        }

        /// <summary>
        /// Writes a 4x4 solid-colour PNG the first time. Import settings are left to
        /// <c>TexturePipelinePostprocessor</c>, which owns this folder.
        /// </summary>
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
            TerrainSceneUtility.EnsureFolder(TerrainSceneUtility.ParentFolderOf(path));

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
            Transform geometry = TerrainSceneUtility.EnsureRoot(scene, k_GeometryRootName);
            Transform existing = geometry.Find(k_TerrainObjectName);
            GameObject terrainObject;

            if (existing == null)
            {
                terrainObject = UnityEngine.Terrain.CreateTerrainGameObject(terrainData);
                terrainObject.name = k_TerrainObjectName;
                TerrainSceneUtility.MoveToScene(terrainObject, scene);
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

            Material terrainMaterial = EnsureTerrainMaterial();

            if (terrainMaterial != null)
            {
                terrain.materialTemplate = terrainMaterial;
            }

            // TerrainLit's per-pixel normals are an instanced-terrain feature: without this the material
            // silently falls back to interpolated vertex normals and the greybox slopes read as facets.
            terrain.drawInstanced = true;

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
            Transform anchorRoot = TerrainSceneUtility.EnsureRoot(scene, k_AnchorRootName);
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

                    TerrainSceneUtility.MoveToScene(marker, scene);
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

        /// <summary>
        /// Find-or-create the terrain's own <c>HDRP/TerrainLit</c> material template. HDRP's built-in
        /// default terrain material is Editor-only and lives inside the package, so the project owns
        /// this one; the eight layers, their mask maps and their keywords are still set by the native
        /// terrain renderer from the <c>TerrainLayer[]</c>.
        /// </summary>
        /// <returns>The terrain material, or null when the shader is missing.</returns>
        private static Material EnsureTerrainMaterial()
        {
            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_TerrainMaterialPath);
            Shader shader = Shader.Find(k_TerrainLitShader);

            if (shader == null)
            {
                Debug.LogError($"TerrainGreyboxBuilder: shader '{k_TerrainLitShader}' not found; "
                    + "the terrain keeps its current material.");
                return material;
            }

            if (material == null)
            {
                TerrainSceneUtility.EnsureFolder(k_TerrainLayerFolder);
                material = new Material(shader);
                material.name = Path.GetFileNameWithoutExtension(k_TerrainMaterialPath);
                AssetDatabase.CreateAsset(material, k_TerrainMaterialPath);
            }
            else if (material.shader != shader)
            {
                material.shader = shader;
            }

            if (material.HasProperty(k_InstancedPerPixelNormalId))
            {
                material.SetFloat(k_InstancedPerPixelNormalId, 1f);
            }

            // Height blend stays off: the layers keep blending by splat weight alone, exactly as they
            // did before, instead of letting the mask maps' height channel take over the seams.
            if (material.HasProperty(k_HeightBlendId))
            {
                material.SetFloat(k_HeightBlendId, 0f);
            }

            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureAnchorMaterial()
        {
            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_AnchorMaterialPath);
            Shader shader = Shader.Find(k_LitShader);

            if (shader == null)
            {
                Debug.LogError($"TerrainGreyboxBuilder: shader '{k_LitShader}' not found; "
                    + "the anchor markers keep their current material.");
                return material;
            }

            if (material == null)
            {
                TerrainSceneUtility.EnsureFolder(k_MaterialFolder);
                material = new Material(shader);
                material.name = Path.GetFileNameWithoutExtension(k_AnchorMaterialPath);
                HDMaterial.ValidateMaterial(material);
                AssetDatabase.CreateAsset(material, k_AnchorMaterialPath);
            }
            else if (material.shader != shader)
            {
                // An anchor material authored against another pipeline keeps its GUID and is
                // re-shadered here; validation rebuilds the keywords and passes HDRP expects.
                material.shader = shader;
                HDMaterial.ValidateMaterial(material);
                EditorUtility.SetDirty(material);
            }

            if (material.HasProperty(k_BaseColorId) && material.GetColor(k_BaseColorId) != k_AnchorColor)
            {
                material.SetColor(k_BaseColorId, k_AnchorColor);
                EditorUtility.SetDirty(material);
            }

            return material;
        }
    }
}

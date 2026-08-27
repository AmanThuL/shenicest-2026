using System;
using System.Collections.Generic;
using System.IO;
using RootsDance.Editor.Environment;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// Dresses the greybox terrain in <c>Main_Environment.unity</c>: scattered vegetation and rocks
    /// under <c>_Vegetation</c>, the Terrain detail layers that make the grass band read, the
    /// hand-authored Chapter-00 props under <c>_Props</c> and the lab blockout's palette materials.
    /// The sky is not its business: under HDRP it belongs to the level's Global Volume. Idempotent —
    /// both generated roots are destroyed and rebuilt from scratch, the detail layers are re-baked and
    /// the lab materials are re-applied. Like <see cref="TerrainGreyboxBuilder"/> this is a sanctioned
    /// tool that saves the scene.
    /// Menu: RootsDance &gt; Terrain &gt; Build Terrain Dressing.
    /// </summary>
    /// <remarks>
    /// <para>
    /// This file's own namespace is <c>RootsDance.Editor.Terrain</c>, so a bare <c>Terrain</c> resolves
    /// to the namespace rather than to the component. Every engine terrain type is fully qualified.
    /// </para>
    /// <para>
    /// The scattered instances are created and destroyed without <c>Undo</c> registration on purpose:
    /// a build places a few thousand objects, and recording each of them would cost more than the
    /// build itself and bury the rest of the undo stack. Re-run the builder to get back to a known
    /// state instead.
    /// </para>
    /// </remarks>
    public static class TerrainDressingBuilder
    {
        private const string k_LogPrefix = "TerrainDressingBuilder";
        private const string k_ConfigPath = "Assets/RootsDance/Data/Config/TerrainDressingConfig.asset";
        private const string k_GreyboxConfigPath = "Assets/RootsDance/Data/Config/TerrainGreyboxConfig.asset";

        private const string k_GeometryRootName = "_Geometry";
        private const string k_VegetationRootName = "_Vegetation";
        private const string k_PropsRootName = "_Props";
        private const string k_TerrainObjectName = "Terrain_Main";
        private const string k_LabObjectName = "LabBlockout";

        private const float k_DetailMinWidth = 0.8f;
        private const float k_DetailMaxWidth = 1.3f;
        private const float k_DetailMinHeight = 0.8f;
        private const float k_DetailMaxHeight = 1.3f;
        private const float k_DetailNoiseSpread = 0.2f;
        private const float k_DetailAlignToGround = 0.3f;
        private const float k_DetailPositionJitter = 0.6f;

        /// <summary>Menu entry: loads (or creates) the default config asset and builds with it.</summary>
        [MenuItem("RootsDance/Terrain/Build Terrain Dressing")]
        public static void BuildFromDefaultConfig()
        {
            TerrainDressingConfigSO config = EnsureConfigAsset();
            Build(config);
        }

        /// <summary>
        /// Rebuilds every dressing layer described by <paramref name="config"/> into the greybox
        /// config's target scene and saves both the scene and the generated assets.
        /// </summary>
        /// <param name="config">The config asset to build from; a null config is logged and ignored.</param>
        public static void Build(TerrainDressingConfigSO config)
        {
            if (config == null)
            {
                Debug.LogError($"{k_LogPrefix}: no config asset — nothing to build.");
                return;
            }

            TerrainGreyboxConfigSO greybox = config.GreyboxConfig;

            if (greybox == null)
            {
                Debug.LogError($"{k_LogPrefix}: the config's Greybox Config reference is empty. It is "
                    + $"required — the terrain shape, the routes and the scene path all come from it. "
                    + $"Assign {k_GreyboxConfigPath} and run the builder again.");
                return;
            }

            Scene scene;

            if (!TerrainSceneUtility.TryOpenTargetScene(greybox.ScenePath, k_LogPrefix, out scene))
            {
                return;
            }

            UnityEngine.Terrain terrain = FindTerrain(scene);

            if (terrain == null)
            {
                Debug.LogError($"{k_LogPrefix}: '{k_GeometryRootName}/{k_TerrainObjectName}' is missing from "
                    + $"'{greybox.ScenePath}'. Run RootsDance/Terrain/Build Greybox Terrain first.");
                return;
            }

            Dictionary<string, GameObject> prefabs = new Dictionary<string, GameObject>(128);
            int scattered = ScatterVegetation(config, greybox.Params, terrain, scene, prefabs);
            int details = FillDetailLayers(config, greybox.Params, terrain, prefabs);
            int props = PlaceProps(config, terrain, scene, prefabs);

            ApplyLabMaterials(config, scene);
            Debug.Log($"{k_LogPrefix}: sky/fog are authored in the level's Global Volume "
                + "(see guideline 07 §5.9).");

            EditorSceneManager.MarkSceneDirty(scene);

            if (!EditorSceneManager.SaveScene(scene))
            {
                Debug.LogError($"{k_LogPrefix}: failed to save '{greybox.ScenePath}'; "
                    + "the generated hierarchy is only in memory.");
                return;
            }

            EditorUtility.SetDirty(terrain.terrainData);
            AssetDatabase.SaveAssets();

            Debug.Log($"{k_LogPrefix}: summary — {scattered} scattered instances, {details} detail instances "
                + $"over {terrain.terrainData.detailPrototypes.Length} layers, {props} props "
                + $"in '{greybox.ScenePath}'.");
        }

        /// <summary>
        /// Drops the config's scatter, detail and prop tables back to the code defaults. The
        /// <c>CreateDefault*</c> methods only run when the asset is first created, so this is how a
        /// code edit reaches an existing asset.
        /// </summary>
        /// <param name="config">The config asset to reset; a null config is ignored.</param>
        public static void ResetAuthoredContent(TerrainDressingConfigSO config)
        {
            if (config == null)
            {
                return;
            }

            Undo.RecordObject(config, "Reset Terrain Dressing Content");
            config.ApplyAuthoredDefaults();
            EditorUtility.SetDirty(config);
            AssetDatabase.SaveAssets();
            Debug.Log($"{k_LogPrefix}: reset the scatter, detail and prop tables to the code defaults.");
        }

        /// <summary>
        /// Loads the config asset, creating it with the authored defaults when it is missing, and
        /// fills in the greybox config reference while it is still empty.
        /// </summary>
        private static TerrainDressingConfigSO EnsureConfigAsset()
        {
            TerrainDressingConfigSO config = AssetDatabase.LoadAssetAtPath<TerrainDressingConfigSO>(k_ConfigPath);

            if (config == null)
            {
                TerrainSceneUtility.EnsureFolder(TerrainSceneUtility.ParentFolderOf(k_ConfigPath));
                config = ScriptableObject.CreateInstance<TerrainDressingConfigSO>();
                AssetDatabase.CreateAsset(config, k_ConfigPath);
                Debug.Log($"{k_LogPrefix}: created the default config asset at {k_ConfigPath}.");
            }

            SerializedObject serialized = new SerializedObject(config);
            bool changed = false;

            changed |= WireReference(serialized, "m_greyboxConfig",
                AssetDatabase.LoadAssetAtPath<TerrainGreyboxConfigSO>(k_GreyboxConfigPath), k_GreyboxConfigPath);

            if (changed)
            {
                serialized.ApplyModifiedPropertiesWithoutUndo();
                EditorUtility.SetDirty(config);
                AssetDatabase.SaveAssets();
            }

            return config;
        }

        /// <summary>Assigns <paramref name="asset"/> to a still-empty object reference property.</summary>
        /// <returns>True when the property was written.</returns>
        private static bool WireReference(SerializedObject serialized, string propertyName,
            UnityEngine.Object asset, string assetPath)
        {
            SerializedProperty property = serialized.FindProperty(propertyName);

            if (property == null || property.objectReferenceValue != null)
            {
                return false;
            }

            if (asset == null)
            {
                Debug.LogWarning($"{k_LogPrefix}: {assetPath} is not imported yet, so '{propertyName}' "
                    + "stays empty.");
                return false;
            }

            property.objectReferenceValue = asset;
            return true;
        }

        /// <summary>Returns the greybox terrain component, or null when the greybox has not been built.</summary>
        private static UnityEngine.Terrain FindTerrain(Scene scene)
        {
            Transform geometry = TerrainSceneUtility.FindRoot(scene, k_GeometryRootName);

            if (geometry == null)
            {
                return null;
            }

            Transform terrainObject = geometry.Find(k_TerrainObjectName);

            if (terrainObject == null)
            {
                return null;
            }

            return terrainObject.GetComponent<UnityEngine.Terrain>();
        }

        /// <summary>
        /// Rebuilds <c>_Vegetation</c>: one child group per scatter rule, each filled with prefab
        /// instances dropped onto the real terrain surface rather than onto the generator's heightmap.
        /// </summary>
        /// <returns>How many instances were placed in total.</returns>
        private static int ScatterVegetation(TerrainDressingConfigSO config, TerrainGreyboxParams parameters,
            UnityEngine.Terrain terrain, Scene scene, Dictionary<string, GameObject> prefabs)
        {
            Transform root = RecreateRoot(scene, k_VegetationRootName);
            ScatterRule[] rules = config.ScatterRules;

            if (rules == null)
            {
                return 0;
            }

            int total = 0;

            for (int i = 0; i < rules.Length; i++)
            {
                ScatterRule rule = rules[i];

                if (rule == null)
                {
                    continue;
                }

                List<ScatterInstance> instances =
                    TerrainScatterGenerator.Generate(parameters, rule, config.Seed + i);
                Transform group = EnsureChild(root, rule.Name);
                int placed = 0;

                for (int j = 0; j < instances.Count; j++)
                {
                    ScatterInstance instance = instances[j];
                    GameObject prefab = LoadPrefab(instance.PrefabKey, prefabs);

                    if (prefab == null)
                    {
                        continue;
                    }

                    GameObject spawned = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
                    spawned.transform.SetParent(group, false);
                    spawned.transform.position = GroundPosition(terrain, instance.Position.x, instance.Position.z,
                        -rule.SinkDepth);
                    spawned.transform.rotation = rule.AlignToSlope
                        ? Quaternion.FromToRotation(Vector3.up, instance.GroundNormal)
                            * Quaternion.Euler(0f, instance.YawDegrees, 0f)
                        : Quaternion.Euler(0f, instance.YawDegrees, 0f);
                    spawned.transform.localScale = prefab.transform.localScale * instance.Scale;
                    placed++;
                }

                Debug.Log($"{k_LogPrefix}: {rule.Name}: {placed} instances");
                total += placed;
            }

            return total;
        }

        /// <summary>
        /// Re-bakes every Terrain detail layer from the config's detail rules. Rules whose prototype
        /// prefab is missing, or that Unity rejects as a detail prototype, are skipped with a warning
        /// so the rest of the dressing still builds.
        /// </summary>
        /// <returns>The summed instance count over every accepted layer.</returns>
        private static int FillDetailLayers(TerrainDressingConfigSO config, TerrainGreyboxParams parameters,
            UnityEngine.Terrain terrain, Dictionary<string, GameObject> prefabs)
        {
            DetailRule[] rules = config.DetailRules;
            List<DetailRule> accepted = new List<DetailRule>();
            List<DetailPrototype> prototypes = new List<DetailPrototype>();
            Dictionary<string, GameObject> baked = new Dictionary<string, GameObject>(8);

            if (rules != null)
            {
                for (int i = 0; i < rules.Length; i++)
                {
                    DetailRule rule = rules[i];

                    if (rule == null)
                    {
                        continue;
                    }

                    GameObject prefab = LoadPrefab(rule.PrefabKey, prefabs);

                    if (prefab == null)
                    {
                        continue;
                    }

                    DetailPrototype prototype = CreatePrototype(rule, prefab, baked);

                    if (prototype == null)
                    {
                        continue;
                    }

                    accepted.Add(rule);
                    prototypes.Add(prototype);
                }
            }

            UnityEngine.TerrainData data = terrain.terrainData;

            // Dropping the old prototypes first keeps the terrain from ever holding coverage-mode
            // prototypes while the scatter mode is already instance count — a mismatch the detail
            // renderer reports as "Detail coverage unsupported…". Both the resolution change and the
            // scatter-mode change clear the existing layers, so they also have to happen before the
            // prototypes and the density maps go in.
            data.detailPrototypes = Array.Empty<DetailPrototype>();
            data.SetDetailResolution(config.DetailResolution, config.DetailResolutionPerPatch);
            data.SetDetailScatterMode(DetailScatterMode.InstanceCountMode);
            data.detailPrototypes = prototypes.ToArray();

            // Unity clamps and rounds the requested resolution, so the density maps have to be generated
            // at the resolution the TerrainData actually took, not the one the config asked for.
            int resolution = data.detailResolution;

            if (resolution != config.DetailResolution)
            {
                Debug.LogWarning($"{k_LogPrefix}: detail resolution {config.DetailResolution} was adjusted "
                    + $"to {resolution} by the TerrainData; the density maps use {resolution}.");
            }

            int total = 0;

            for (int i = 0; i < accepted.Count; i++)
            {
                int[,] map = TerrainDetailGenerator.Generate(parameters, accepted[i], resolution);
                data.SetDetailLayer(0, 0, i, map);

                int sum = SumInstances(map);
                Debug.Log($"{k_LogPrefix}: detail layer {i} '{accepted[i].Name}' "
                    + $"({accepted[i].PrefabKey}): {sum} instances");
                total += sum;
            }

            terrain.detailObjectDistance = config.DetailDistance;
            terrain.detailObjectDensity = config.DetailDensity;
            terrain.drawInstanced = true;
            SweepOrphanedDetailAssets(rules, accepted.Count);
            return total;
        }

        /// <summary>
        /// Deletes generated detail meshes and prototype prefabs whose rule is gone. The factory is
        /// add-only, so renaming a <c>DetailRule.PrefabKey</c> or dropping a rule would otherwise leave
        /// its <c>&lt;Key&gt;_Detail</c> assets behind in the project and in git forever.
        /// </summary>
        /// <param name="rules">Every configured detail rule, accepted or not.</param>
        /// <param name="acceptedCount">How many of them made it into the terrain this build.</param>
        private static void SweepOrphanedDetailAssets(DetailRule[] rules, int acceptedCount)
        {
            if (rules == null)
            {
                return;
            }

            HashSet<string> live = new HashSet<string>();
            int configured = 0;

            for (int i = 0; i < rules.Length; i++)
            {
                DetailRule rule = rules[i];

                if (rule == null)
                {
                    continue;
                }

                // The keep-set is every *configured* key, not just the accepted ones: a rule whose
                // prefab is missing (the dressing build ran before "Build Environment Prefabs") or
                // whose prototype failed to bake is a warning, not a deletion order — its generated
                // assets are still live content.
                configured++;
                live.Add(rule.PrefabKey + TerrainDetailPrototypeFactory.k_NameSuffix);
            }

            if (acceptedCount != configured)
            {
                Debug.LogWarning($"{k_LogPrefix}: {configured - acceptedCount} of {configured} detail rules "
                    + "did not build this run, so the orphan sweep was skipped — nothing was deleted. "
                    + "Fix the warnings above and build again to clean up.");
                return;
            }

            string[] folders =
            {
                TerrainDetailPrototypeFactory.MeshFolder, TerrainDetailPrototypeFactory.PrefabFolder
            };

            for (int i = 0; i < folders.Length; i++)
            {
                if (!AssetDatabase.IsValidFolder(folders[i]))
                {
                    continue;
                }

                string[] guids = AssetDatabase.FindAssets(string.Empty, new[] { folders[i] });

                for (int g = 0; g < guids.Length; g++)
                {
                    string path = AssetDatabase.GUIDToAssetPath(guids[g]);

                    if (AssetDatabase.IsValidFolder(path)
                        || live.Contains(Path.GetFileNameWithoutExtension(path)))
                    {
                        continue;
                    }

                    if (AssetDatabase.DeleteAsset(path))
                    {
                        Debug.Log($"{k_LogPrefix}: deleted orphaned detail asset '{path}' — no detail rule "
                            + "produces it any more.");
                    }
                    else
                    {
                        Debug.LogWarning($"{k_LogPrefix}: could not delete orphaned detail asset '{path}'.");
                    }
                }
            }
        }

        /// <summary>
        /// Builds one detail prototype from a dressing prefab.
        /// </summary>
        /// <remarks>
        /// The detail renderer only reads the MeshFilter and the MeshRenderer on the prototype's own
        /// root, and it ignores every transform in the prefab — so a dressing prefab, whose wrapper
        /// root carries the vendor unit fix and whose model child carries the vendor Z-up rotation,
        /// cannot be a prototype directly. <see cref="TerrainDetailPrototypeFactory"/> bakes that
        /// transform into a mesh, which lets the width/height ranges stay plain 0.8–1.3 multipliers
        /// on the size the prefab has in the world.
        /// </remarks>
        /// <returns>The prototype, or null when Unity would reject it.</returns>
        private static DetailPrototype CreatePrototype(DetailRule rule, GameObject prefab,
            Dictionary<string, GameObject> baked)
        {
            GameObject prototype =
                TerrainDetailPrototypeFactory.EnsurePrototype(rule.PrefabKey, prefab, baked);

            if (prototype == null)
            {
                Debug.LogWarning($"{k_LogPrefix}: detail rule '{rule.Name}' skipped — no detail "
                    + $"prototype could be baked from '{rule.PrefabKey}'.");
                return null;
            }

            DetailPrototype detail = new DetailPrototype();
            detail.prototype = prototype;
            detail.usePrototypeMesh = true;
            detail.renderMode = DetailRenderMode.VertexLit;
            detail.useInstancing = true;
            detail.useDensityScaling = true;
            detail.minWidth = k_DetailMinWidth;
            detail.maxWidth = k_DetailMaxWidth;
            detail.minHeight = k_DetailMinHeight;
            detail.maxHeight = k_DetailMaxHeight;
            detail.noiseSpread = k_DetailNoiseSpread;
            detail.alignToGround = k_DetailAlignToGround;
            detail.positionJitter = k_DetailPositionJitter;
            detail.healthyColor = Color.white;
            detail.dryColor = Color.white;

            string error;

            if (!detail.Validate(out error))
            {
                Debug.LogWarning($"{k_LogPrefix}: detail rule '{rule.Name}' skipped — Unity rejected "
                    + $"'{rule.PrefabKey}' as a detail prototype: {error}");
                return null;
            }

            return detail;
        }

        /// <summary>
        /// Rebuilds <c>_Props</c>: one child group per <see cref="PropPlacement.Group"/>, each prop at
        /// its authored yaw and scale, dropped onto the terrain unless it is wall- or slab-mounted.
        /// </summary>
        /// <returns>How many props were placed.</returns>
        private static int PlaceProps(TerrainDressingConfigSO config, UnityEngine.Terrain terrain, Scene scene,
            Dictionary<string, GameObject> prefabs)
        {
            Transform root = RecreateRoot(scene, k_PropsRootName);
            PropPlacement[] placements = config.Props;

            if (placements == null)
            {
                return 0;
            }

            int placed = 0;

            for (int i = 0; i < placements.Length; i++)
            {
                PropPlacement placement = placements[i];

                if (placement == null)
                {
                    continue;
                }

                GameObject prefab = LoadPrefab(placement.Key, prefabs);

                if (prefab == null)
                {
                    continue;
                }

                Vector3 position = placement.DropToGround
                    ? GroundPosition(terrain, placement.Position.x, placement.Position.z, placement.HeightOffset)
                    : placement.Position;

                Transform group = EnsureChild(root, placement.Group);
                GameObject spawned = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
                spawned.transform.SetParent(group, false);
                spawned.transform.position = position;
                spawned.transform.rotation = Quaternion.Euler(0f, placement.YawDegrees, 0f);
                spawned.transform.localScale = prefab.transform.localScale * placement.Scale;
                placed++;

                Debug.Log($"{k_LogPrefix}: prop {placement.Group}/{placement.Key} -> "
                    + $"({position.x:F1}, {position.y:F2}, {position.z:F1}) yaw={placement.YawDegrees:F0} "
                    + $"ground={placement.DropToGround}");
            }

            return placed;
        }

        /// <summary>
        /// Paints the lab blockout with the project palette: the glass material on every renderer whose
        /// vendor materials look glazed, plain lab concrete everywhere else. Idempotent because the
        /// glass palette material's own name also matches the fragment.
        /// </summary>
        private static void ApplyLabMaterials(TerrainDressingConfigSO config, Scene scene)
        {
            Transform geometry = TerrainSceneUtility.FindRoot(scene, k_GeometryRootName);
            Transform lab = geometry == null ? null : geometry.Find(k_LabObjectName);

            if (lab == null)
            {
                Debug.LogWarning($"{k_LogPrefix}: '{k_GeometryRootName}/{k_LabObjectName}' is missing; "
                    + "the lab keeps its vendor materials.");
                return;
            }

            Material concrete = EnvironmentPalette.Get(config.LabMaterialKey);

            if (concrete == null)
            {
                return;
            }

            // The glass material is loaded on first glazed renderer, not up front: the lab blockout
            // currently has no glazed material at all, and looking it up eagerly used to abort the whole
            // paint over a key nothing needs, leaving every renderer on the vendor default.
            Material glass = null;
            bool glassLoaded = false;

            MeshRenderer[] renderers = lab.GetComponentsInChildren<MeshRenderer>(false);
            int concreteCount = 0;
            int glassCount = 0;
            int skipped = 0;

            for (int i = 0; i < renderers.Length; i++)
            {
                Material[] slots = renderers[i].sharedMaterials;

                if (slots.Length == 0)
                {
                    continue;
                }

                bool glazed = IsGlazed(slots, config.LabGlassNameContains);

                if (glazed && !glassLoaded)
                {
                    glass = EnvironmentPalette.Get(config.LabGlassMaterialKey);
                    glassLoaded = true;
                }

                Material target = glazed ? glass : concrete;

                if (target == null)
                {
                    skipped++;
                    continue;
                }

                Material[] painted = new Material[slots.Length];

                for (int slot = 0; slot < painted.Length; slot++)
                {
                    painted[slot] = target;
                }

                renderers[i].sharedMaterials = painted;

                if (glazed)
                {
                    glassCount++;
                }
                else
                {
                    concreteCount++;
                }
            }

            Debug.Log($"{k_LogPrefix}: lab materials — {concreteCount} renderers on "
                + $"'{config.LabMaterialKey}', {glassCount} on '{config.LabGlassMaterialKey}', "
                + $"{skipped} left on their vendor material.");
        }

        /// <summary>True when any of the renderer's materials is named after the glazing fragment.</summary>
        private static bool IsGlazed(Material[] slots, string nameContains)
        {
            if (string.IsNullOrEmpty(nameContains))
            {
                return false;
            }

            for (int i = 0; i < slots.Length; i++)
            {
                if (slots[i] != null
                    && slots[i].name.IndexOf(nameContains, StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>Destroys the named scene root when it exists and creates an empty one in its place.</summary>
        private static Transform RecreateRoot(Scene scene, string name)
        {
            Transform existing = TerrainSceneUtility.FindRoot(scene, name);

            if (existing != null)
            {
                UnityEngine.Object.DestroyImmediate(existing.gameObject);
            }

            GameObject created = new GameObject(name);
            TerrainSceneUtility.MoveToScene(created, scene);
            return created.transform;
        }

        /// <summary>Find-or-create a direct child of <paramref name="parent"/> with the given name.</summary>
        private static Transform EnsureChild(Transform parent, string name)
        {
            Transform existing = parent.Find(name);

            if (existing != null)
            {
                return existing;
            }

            GameObject created = new GameObject(name);
            created.transform.SetParent(parent, false);
            return created.transform;
        }

        /// <summary>Loads a dressing prefab by key, caching hits and misses so a bad key warns once.</summary>
        private static GameObject LoadPrefab(string key, Dictionary<string, GameObject> cache)
        {
            GameObject prefab;

            if (cache.TryGetValue(key, out prefab))
            {
                return prefab;
            }

            string path = EnvironmentPrefabBuilder.PrefabPath(key);
            prefab = string.IsNullOrEmpty(path) ? null : AssetDatabase.LoadAssetAtPath<GameObject>(path);

            // PrefabPath already logs an error for an unknown key, so an unknown key is not reported
            // twice; a known key whose asset is missing is a warning, which keeps the zero-errors gate
            // meaningful when someone simply has not run the prefab builder yet.
            if (prefab == null && !string.IsNullOrEmpty(path))
            {
                Debug.LogWarning($"{k_LogPrefix}: no prefab asset at '{path}' for key '{key}'; every "
                    + "instance of it is skipped. Run RootsDance/Environment/Build Environment Prefabs.");
            }

            cache[key] = prefab;
            return prefab;
        }

        /// <summary>World position on the terrain surface at an XZ, plus a vertical offset.</summary>
        private static Vector3 GroundPosition(UnityEngine.Terrain terrain, float x, float z, float offset)
        {
            Vector3 position = new Vector3(x, 0f, z);
            position.y = terrain.SampleHeight(position) + terrain.transform.position.y + offset;
            return position;
        }

        /// <summary>Total instance count in a baked detail-density map.</summary>
        private static int SumInstances(int[,] map)
        {
            int total = 0;

            for (int z = 0; z < map.GetLength(0); z++)
            {
                for (int x = 0; x < map.GetLength(1); x++)
                {
                    total += map[z, x];
                }
            }

            return total;
        }
    }
}

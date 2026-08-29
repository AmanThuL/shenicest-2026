using System;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Builds the high-density A-E vegetation pass into PWB palette/PIN parents. The tool is idempotent,
    /// owns only <c>C00V_</c> instances, and deliberately leaves Main Environment dirty without saving it.
    /// </summary>
    public static class Chapter00ZoneVegetationBuilder
    {
        private const string k_Menu = "RootsDance/Environment/Build Chapter 00 A-E Vegetation (No Save)";
        private const string k_ClearMenu = "RootsDance/Environment/Clear Chapter 00 A-E Vegetation (No Save)";
        private const string k_TintFolder =
            "Assets/RootsDance/Materials/Environment/Chapter00ZoneVegetation";
        private const string k_GroupPrefabFolder =
            "Assets/RootsDance/Prefabs/Environment/Chapter00ZoneVegetation";
        private const string k_GroupPrefix = "C00V_Group_";

        [MenuItem(k_Menu)]
        public static void Build()
        {
            BuildWith(Chapter00ZoneVegetationParams.CreateDefault());
        }

        /// <summary>
        /// Batch content entry used by CI and this implementation pass. It builds, validates ownership and final
        /// grass heights, then explicitly saves Main Environment and the generated tint assets.
        /// </summary>
        public static void BuildAndSaveFromCommandLine()
        {
            Chapter00ZoneVegetationParams p = Chapter00ZoneVegetationParams.CreateDefault();
            int placed = BuildWith(p);

            if (placed <= 0)
            {
                throw new InvalidOperationException(
                    "Chapter00ZoneVegetationBuilder: no vegetation was placed; scene was not saved.");
            }

            Scene scene = SceneManager.GetSceneByPath(p.ScenePath);
            int installed = ValidateInstalled(p, scene, logSuccess: true);

            if (installed != placed)
            {
                throw new InvalidOperationException(
                    $"Chapter00ZoneVegetationBuilder: placed {placed} instances but validated {installed}.");
            }

            if (!EditorSceneManager.SaveScene(scene))
            {
                throw new InvalidOperationException(
                    $"Chapter00ZoneVegetationBuilder: failed to save '{p.ScenePath}'.");
            }

            AssetDatabase.SaveAssets();
            Debug.Log($"Chapter00ZoneVegetationBuilder: saved {placed} validated C00V_ instances.");
        }

        /// <summary>Read-only batch validation of the installed PWB hierarchy and authored height ranges.</summary>
        public static void ValidateInstalledFromCommandLine()
        {
            Chapter00ZoneVegetationParams p = Chapter00ZoneVegetationParams.CreateDefault();
            Scene scene;

            if (!TryGetScene(p.ScenePath, out scene) || ValidateInstalled(p, scene, logSuccess: true) <= 0)
            {
                throw new InvalidOperationException(
                    "Chapter00ZoneVegetationBuilder: installed vegetation validation failed.");
            }
        }

        /// <summary>Read-only placement-count audit used before committing a high-density scene build.</summary>
        public static void AnalyzeFromCommandLine()
        {
            Chapter00ZoneVegetationParams p = Chapter00ZoneVegetationParams.CreateDefault();
            Scene scene;
            if (!TryGetScene(p.ScenePath, out scene))
            {
                throw new InvalidOperationException("Chapter00ZoneVegetationBuilder: cannot open Main Environment.");
            }

            UnityEngine.Terrain terrain = FindTerrain(scene);
            Transform facility = FindByName(scene, "ResearchFacility_GaiaV7");
            ResolveCurrentSpatialTargets(p, facility);
            Dictionary<string, GameObject> prefabs;
            PrefabMetricTable metrics;

            if (terrain == null || !LoadPrefabsAndMetrics(p, out prefabs, out metrics))
            {
                throw new InvalidOperationException(
                    "Chapter00ZoneVegetationBuilder: cannot resolve terrain/prefab metrics for analysis.");
            }

            List<Chapter00VegetationPlacement> placements = Chapter00ZoneVegetationLayout.Build(
                p, metrics, new SceneGroundFilter(terrain, facility));
            Dictionary<string, int> counts = new Dictionary<string, int>();
            Dictionary<Chapter00VegetationTint, int> cTintCounts =
                new Dictionary<Chapter00VegetationTint, int>();

            foreach (Chapter00VegetationPlacement placement in placements)
            {
                string key = placement.Zone + "/" + placement.Role;
                counts[key] = counts.TryGetValue(key, out int existing) ? existing + 1 : 1;
                if (placement.Zone == Chapter00VegetationZone.C)
                {
                    cTintCounts[placement.Tint] = cTintCounts.TryGetValue(
                        placement.Tint, out int tintExisting) ? tintExisting + 1 : 1;
                }
            }

            List<string> parts = new List<string>();
            foreach (KeyValuePair<string, int> pair in counts) parts.Add(pair.Key + "=" + pair.Value);
            parts.Sort(StringComparer.Ordinal);
            List<string> tintParts = new List<string>();
            foreach (KeyValuePair<Chapter00VegetationTint, int> pair in cTintCounts)
            {
                tintParts.Add(pair.Key + "=" + pair.Value);
            }
            tintParts.Sort(StringComparer.Ordinal);
            Debug.Log("Chapter00ZoneVegetationBuilder analysis: total=" + placements.Count + "; "
                + string.Join(", ", parts) + "; C tints=" + string.Join(", ", tintParts));
        }

        /// <summary>Fast material-only refresh for art-direction changes; does not rebuild scene placement.</summary>
        public static void RefreshTintMaterialsFromCommandLine()
        {
            int changed = 0;
            string[] guids = AssetDatabase.FindAssets("t:Material", new[] { k_TintFolder });
            for (int i = 0; i < guids.Length; i++)
            {
                Material material = AssetDatabase.LoadAssetAtPath<Material>(
                    AssetDatabase.GUIDToAssetPath(guids[i]));
                Chapter00VegetationTint tint;
                if (material == null || !TryParseTintSuffix(material.name, out tint)) continue;

                Color color = TintColor(tint);
                if (material.HasProperty("_MainColor")) material.SetColor("_MainColor", color);
                if (material.HasProperty("_BaseColor")) material.SetColor("_BaseColor", color);
                if (material.HasProperty("_TintingColor")) material.SetColor("_TintingColor", color);
                if (material.HasProperty("_Color")) material.SetColor("_Color", color);
                if (IsAnomalousTint(tint))
                {
                    if (material.HasProperty("_EmissiveColor")) material.SetColor("_EmissiveColor", color);
                    if (material.HasProperty("_EmissiveIntensityValue"))
                        material.SetFloat("_EmissiveIntensityValue", .3f);
                }
                EditorUtility.SetDirty(material);
                changed++;
            }
            AssetDatabase.SaveAssets();
            Debug.Log($"Chapter00ZoneVegetationBuilder: refreshed {changed} tint materials without rebuilding.");
        }

        /// <summary>Builds into an open/additively-opened scene and returns the placed count. Never saves it.</summary>
        public static int BuildWith(Chapter00ZoneVegetationParams p)
        {
            Scene scene;
            if (!TryGetScene(p.ScenePath, out scene)) return 0;

            UnityEngine.Terrain terrain = FindTerrain(scene);
            if (terrain == null)
            {
                Debug.LogError("Chapter00ZoneVegetationBuilder: Main Environment has no Terrain.");
                return 0;
            }

            Transform facility = FindByName(scene, "ResearchFacility_GaiaV7");
            ResolveCurrentSpatialTargets(p, facility);

            Dictionary<string, GameObject> prefabs;
            PrefabMetricTable metricTable;
            if (!LoadPrefabsAndMetrics(p, out prefabs, out metricTable)) return 0;

            SceneGroundFilter filter = new SceneGroundFilter(terrain, facility);
            List<Chapter00VegetationPlacement> placements =
                Chapter00ZoneVegetationLayout.Build(p, metricTable, filter);

            if (SceneManager.GetActiveScene() != scene) SceneManager.SetActiveScene(scene);
            Transform pwb = EnsureRoot(scene, Chapter00ZoneVegetationParams.k_PwbRootName);
            Dictionary<string, Transform> pins = EnsureOwnedPins(pwb);
            ClearOwnedInstances(pins.Values);
            Dictionary<string, Transform> groups = CreateGroupParents(pins);

            int undoGroup = Undo.GetCurrentGroup();
            Dictionary<string, Material> tintCache = new Dictionary<string, Material>();
            int placed = 0;

            for (int i = 0; i < placements.Count; i++)
            {
                Chapter00VegetationPlacement placement = placements[i];
                string palette = Chapter00ZoneVegetationParams.PaletteName(placement.Zone, placement.Role);

                if (Place(prefabs[placement.PrefabKey], groups[palette], terrain, p, placement, i, tintCache))
                {
                    placed++;
                }
            }

            SaveAndConnectGroups(groups);

            Undo.SetCurrentGroupName("Build Chapter 00 A-E Vegetation");
            Undo.CollapseUndoOperations(undoGroup);
            EditorSceneManager.MarkSceneDirty(scene);
            Debug.Log($"Chapter00ZoneVegetationBuilder: placed {placed} C00V_ instances across A-E. "
                + "Main Environment is dirty and has NOT been saved.");
            return placed;
        }

        [MenuItem(k_ClearMenu)]
        public static void Clear()
        {
            Chapter00ZoneVegetationParams p = Chapter00ZoneVegetationParams.CreateDefault();
            Scene scene;
            if (!TryGetScene(p.ScenePath, out scene)) return;
            Transform pwb = FindDirectChild(null, Chapter00ZoneVegetationParams.k_PwbRootName, scene);
            if (pwb == null) return;
            Dictionary<string, Transform> pins = EnsureOwnedPins(pwb);
            ClearOwnedInstances(pins.Values);
            EditorSceneManager.MarkSceneDirty(scene);
            Debug.Log("Chapter00ZoneVegetationBuilder: cleared C00V_ instances; scene was not saved.");
        }

        private static bool Place(
            GameObject prefab,
            Transform parent,
            UnityEngine.Terrain terrain,
            Chapter00ZoneVegetationParams p,
            Chapter00VegetationPlacement placement,
            int index,
            Dictionary<string, Material> tintCache)
        {
            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, parent);
            if (instance == null) return false;

            instance.name = $"{Chapter00ZoneVegetationParams.k_OwnedPrefix}{placement.Zone}_"
                + $"{placement.Role}_{index:00000}_{placement.PrefabKey}";
            instance.transform.position = new Vector3(placement.Position.x, 0f, placement.Position.y);

            Vector3 normal = SampleNormal(terrain, placement.Position);
            Vector3 up = Vector3.Slerp(Vector3.up, normal, Mathf.Clamp01(placement.NormalAlign));
            instance.transform.rotation = Quaternion.FromToRotation(Vector3.up, up)
                * Quaternion.Euler(0f, placement.Yaw, 0f);

            Bounds before = RendererBounds(instance);
            if (before.size.y <= .0001f)
            {
                UnityEngine.Object.DestroyImmediate(instance);
                return false;
            }

            float heightFactor = placement.TargetHeight / before.size.y;
            instance.transform.localScale = Vector3.Scale(instance.transform.localScale, Vector3.one * heightFactor);

            Bounds scaled = RendererBounds(instance);
            float ground = terrain.SampleHeight(new Vector3(placement.Position.x, 0f, placement.Position.y))
                + terrain.transform.position.y;
            instance.transform.position += Vector3.up * (ground - scaled.min.y);

            if (placement.Role != Chapter00VegetationRole.PhysicalBlocker)
            {
                Collider[] colliders = instance.GetComponentsInChildren<Collider>(true);
                for (int i = 0; i < colliders.Length; i++) UnityEngine.Object.DestroyImmediate(colliders[i]);
            }
            else if (PhysicalColliderIntrudesRoute(instance, p))
            {
                UnityEngine.Object.DestroyImmediate(instance);
                return false;
            }

            ApplyTint(instance, placement.Tint, tintCache);
            Undo.RegisterCreatedObjectUndo(instance, "Build Chapter 00 A-E Vegetation");
            return true;
        }

        private static bool PhysicalColliderIntrudesRoute(
            GameObject instance,
            Chapter00ZoneVegetationParams p)
        {
            Physics.SyncTransforms();
            Collider[] colliders = instance.GetComponentsInChildren<Collider>(true);
            if (colliders.Length == 0) return false;
            Bounds bounds = colliders[0].bounds;
            for (int i = 1; i < colliders.Length; i++) bounds.Encapsulate(colliders[i].bounds);

            Vector2 center = new Vector2(bounds.center.x, bounds.center.z);
            float radius = .5f * Mathf.Sqrt(bounds.size.x * bounds.size.x + bounds.size.z * bounds.size.z);
            const float playerMargin = .65f;

            if (Chapter00ZoneVegetationLayout.DistanceToRoutes(p.Routes, center) < radius + playerMargin)
            {
                return true;
            }

            for (int i = 0; i < p.Checkpoints.Length; i++)
            {
                if (Vector2.Distance(center, p.Checkpoints[i]) < radius + playerMargin)
                {
                    return true;
                }
            }

            return false;
        }

        private static int ValidateInstalled(
            Chapter00ZoneVegetationParams p,
            Scene scene,
            bool logSuccess)
        {
            if (!scene.IsValid() || !scene.isLoaded)
            {
                Debug.LogError("Chapter00ZoneVegetationBuilder: Main Environment is not loaded for validation.");
                return -1;
            }

            Transform pwb = FindDirectChild(null, Chapter00ZoneVegetationParams.k_PwbRootName, scene);

            if (pwb == null)
            {
                Debug.LogError("Chapter00ZoneVegetationBuilder: missing Prefab World Builder root.");
                return -1;
            }

            Dictionary<string, Transform> pins = FindOwnedPins(pwb);
            if (pins == null)
            {
                return -1;
            }
            int count = 0;
            int groupCount = 0;

            foreach (Transform pin in pins.Values)
            {
                for (int childIndex = 0; childIndex < pin.childCount; childIndex++)
                {
                    GameObject group = pin.GetChild(childIndex).gameObject;

                    if (!group.name.StartsWith(k_GroupPrefix, StringComparison.Ordinal))
                    {
                        continue;
                    }

                    if (!PrefabUtility.IsAnyPrefabInstanceRoot(group))
                    {
                        Debug.LogError("Chapter00ZoneVegetationBuilder: vegetation group is not a prefab root: "
                            + group.name);
                        return -1;
                    }
                    groupCount++;

                    Transform[] descendants = group.GetComponentsInChildren<Transform>(true);
                    for (int descendantIndex = 1; descendantIndex < descendants.Length; descendantIndex++)
                    {
                        GameObject child = descendants[descendantIndex].gameObject;
                        if (!child.name.StartsWith(Chapter00ZoneVegetationParams.k_OwnedPrefix,
                            StringComparison.Ordinal) || child.name.StartsWith(k_GroupPrefix,
                            StringComparison.Ordinal))
                        {
                            continue;
                        }

                        if (!PrefabUtility.IsPartOfPrefabInstance(child))
                        {
                            Debug.LogError("Chapter00ZoneVegetationBuilder: visible prop is not a prefab instance: "
                                + child.name);
                            return -1;
                        }

                        Chapter00VegetationZone zone;
                        Chapter00VegetationRole role;
                        if (!TryParseIdentity(child.name, out zone, out role))
                        {
                            Debug.LogError("Chapter00ZoneVegetationBuilder: cannot parse zone/role from "
                                + child.name);
                            return -1;
                        }

                        Bounds bounds = RendererBounds(child);
                        Vector2 range = HeightRange(p, zone, role);
                        if (bounds.size.y < range.x - .03f || bounds.size.y > range.y + .03f)
                        {
                            Debug.LogError($"Chapter00ZoneVegetationBuilder: {child.name} height "
                                + $"{bounds.size.y:F3}m is outside zone {zone} range "
                                + $"{range.x:F2}-{range.y:F2}m.");
                            return -1;
                        }

                        count++;
                    }
                }
            }

            if (groupCount != pins.Count)
            {
                Debug.LogError($"Chapter00ZoneVegetationBuilder: expected {pins.Count} zone palette prefab "
                    + $"groups but found {groupCount}.");
                return -1;
            }

            if (logSuccess)
            {
                Debug.Log($"Chapter00ZoneVegetationBuilder: validation passed for {count} PWB prefab instances.");
            }

            return count;
        }

        private static Vector2 HeightRange(
            Chapter00ZoneVegetationParams p,
            Chapter00VegetationZone zone,
            Chapter00VegetationRole role)
        {
            Vector2 result = new Vector2(float.MaxValue, float.MinValue);

            foreach (Chapter00VegetationLayerSpec layer in p.Layers)
            {
                if (layer.Zone != zone || layer.Role != role)
                {
                    continue;
                }

                result.x = Mathf.Min(result.x, layer.TargetHeightMin);
                result.y = Mathf.Max(result.y, layer.TargetHeightMax);
            }

            if (result.x == float.MaxValue)
            {
                throw new InvalidOperationException($"No layer range exists for {zone}/{role}.");
            }

            return result;
        }

        private static bool TryParseIdentity(
            string name,
            out Chapter00VegetationZone zone,
            out Chapter00VegetationRole role)
        {
            zone = default(Chapter00VegetationZone);
            role = default(Chapter00VegetationRole);
            string prefix = Chapter00ZoneVegetationParams.k_OwnedPrefix;
            string[] parts = name.Substring(prefix.Length).Split('_');
            return parts.Length >= 2
                && Enum.TryParse(parts[0], out zone)
                && Enum.TryParse(parts[1], out role);
        }

        private static void ApplyTint(
            GameObject instance,
            Chapter00VegetationTint tint,
            Dictionary<string, Material> cache)
        {
            Renderer[] renderers = instance.GetComponentsInChildren<Renderer>(true);
            for (int rendererIndex = 0; rendererIndex < renderers.Length; rendererIndex++)
            {
                Material[] assigned = renderers[rendererIndex].sharedMaterials;
                bool changed = false;

                for (int materialIndex = 0; materialIndex < assigned.Length; materialIndex++)
                {
                    Material source = assigned[materialIndex];
                    if (source == null || !CanTint(source)) continue;

                    string sourcePath = AssetDatabase.GetAssetPath(source);
                    string guid = AssetDatabase.AssetPathToGUID(sourcePath);
                    string cacheKey = guid + "|" + tint;
                    Material variant;

                    if (!cache.TryGetValue(cacheKey, out variant))
                    {
                        variant = EnsureTintVariant(source, guid, tint);
                        cache[cacheKey] = variant;
                    }

                    assigned[materialIndex] = variant;
                    changed = true;
                }

                if (changed) renderers[rendererIndex].sharedMaterials = assigned;
            }
        }

        private static bool CanTint(Material material)
        {
            return material.HasProperty("_MainColor")
                || material.HasProperty("_BaseColor")
                || material.HasProperty("_TintingColor")
                || material.HasProperty("_Color");
        }

        private static Material EnsureTintVariant(
            Material source,
            string sourceGuid,
            Chapter00VegetationTint tint)
        {
            EnsureFolder(k_TintFolder);
            string shortGuid = string.IsNullOrEmpty(sourceGuid) ? "local" : sourceGuid.Substring(0, 8);
            string safeName = Sanitize(source.name);
            string path = $"{k_TintFolder}/{safeName}_{shortGuid}_{tint}.mat";
            Material variant = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (variant == null)
            {
                variant = new Material(source) { name = Path.GetFileNameWithoutExtension(path) };
                AssetDatabase.CreateAsset(variant, path);
            }
            else
            {
                variant.CopyPropertiesFromMaterial(source);
                variant.shader = source.shader;
            }

            Color color = TintColor(tint);
            if (variant.HasProperty("_MainColor")) variant.SetColor("_MainColor", color);
            if (variant.HasProperty("_BaseColor")) variant.SetColor("_BaseColor", color);
            if (variant.HasProperty("_TintingColor")) variant.SetColor("_TintingColor", color);
            if (variant.HasProperty("_Color")) variant.SetColor("_Color", color);
            if (IsAnomalousTint(tint))
            {
                // A small self-lit contribution keeps the five C families readable through the authored fog
                // and dark source albedo without turning the band into a neon/bloom effect.
                if (variant.HasProperty("_EmissiveColor")) variant.SetColor("_EmissiveColor", color);
                if (variant.HasProperty("_EmissiveIntensityValue"))
                    variant.SetFloat("_EmissiveIntensityValue", .3f);
            }
            variant.enableInstancing = true;
            EditorUtility.SetDirty(variant);
            AssetDatabase.SaveAssetIfDirty(variant);
            return variant;
        }

        private static Color TintColor(Chapter00VegetationTint tint)
        {
            switch (tint)
            {
                case Chapter00VegetationTint.DeadAsh: return new Color(.37f, .35f, .28f, 1f);
                case Chapter00VegetationTint.HumusOlive: return new Color(.42f, .44f, .30f, 1f);
                case Chapter00VegetationTint.SilverGreyGreen: return new Color(1.15f, 1.45f, 1.32f, 1f);
                case Chapter00VegetationTint.CoolCyanGreen: return new Color(.50f, 1.55f, 1.35f, 1f);
                case Chapter00VegetationTint.MutedViolet: return new Color(1.35f, .80f, 1.55f, 1f);
                case Chapter00VegetationTint.FadedPink: return new Color(1.55f, .90f, 1.10f, 1f);
                case Chapter00VegetationTint.CoolYellowGreen: return new Color(1.50f, 1.40f, .50f, 1f);
                case Chapter00VegetationTint.StableGreen: return new Color(.38f, .48f, .34f, 1f);
                case Chapter00VegetationTint.FacilityGreen: return new Color(.32f, .43f, .34f, 1f);
                default: return Color.white;
            }
        }

        private static bool IsAnomalousTint(Chapter00VegetationTint tint)
        {
            return tint == Chapter00VegetationTint.SilverGreyGreen
                || tint == Chapter00VegetationTint.CoolCyanGreen
                || tint == Chapter00VegetationTint.MutedViolet
                || tint == Chapter00VegetationTint.FadedPink
                || tint == Chapter00VegetationTint.CoolYellowGreen;
        }

        private static bool TryParseTintSuffix(string name, out Chapter00VegetationTint tint)
        {
            foreach (Chapter00VegetationTint candidate in Enum.GetValues(typeof(Chapter00VegetationTint)))
            {
                if (name.EndsWith("_" + candidate, StringComparison.Ordinal))
                {
                    tint = candidate;
                    return true;
                }
            }
            tint = default(Chapter00VegetationTint);
            return false;
        }

        private static string Sanitize(string value)
        {
            foreach (char invalid in Path.GetInvalidFileNameChars()) value = value.Replace(invalid, '_');
            return value.Replace(' ', '_');
        }

        private static void ResolveCurrentSpatialTargets(Chapter00ZoneVegetationParams p, Transform facility)
        {
            if (facility == null) return;

            // Prefer a semantically named dome/greenhouse renderer. The Gaia import currently has opaque mesh
            // names, so the deterministic fallback is the union of the facility's highest renderers.
            Renderer[] renderers = facility.GetComponentsInChildren<Renderer>(true);
            Bounds all = RendererBounds(facility.gameObject);
            bool hasDome = false;
            Bounds dome = default(Bounds);

            for (int i = 0; i < renderers.Length; i++)
            {
                string searchable = (renderers[i].name + " "
                    + (renderers[i] is MeshRenderer
                        && renderers[i].GetComponent<MeshFilter>() != null
                        && renderers[i].GetComponent<MeshFilter>().sharedMesh != null
                        ? renderers[i].GetComponent<MeshFilter>().sharedMesh.name : string.Empty)).ToLowerInvariant();
                bool semantic = searchable.Contains("greenhouse") || searchable.Contains("dome")
                    || searchable.Contains("glass");
                bool upperFallback = renderers[i].bounds.max.y >= all.max.y - 2.2f;
                if (!semantic && !upperFallback) continue;

                if (!hasDome) { dome = renderers[i].bounds; hasDome = true; }
                else dome.Encapsulate(renderers[i].bounds);
            }

            if (hasDome) p.DomeTarget = new Vector2(dome.center.x, dome.center.z);
        }

        private static bool LoadPrefabsAndMetrics(
            Chapter00ZoneVegetationParams p,
            out Dictionary<string, GameObject> prefabs,
            out PrefabMetricTable metrics)
        {
            prefabs = new Dictionary<string, GameObject>();
            metrics = new PrefabMetricTable();
            bool complete = true;

            for (int layer = 0; layer < p.Layers.Length; layer++)
            {
                for (int keyIndex = 0; keyIndex < p.Layers[layer].PrefabKeys.Length; keyIndex++)
                {
                    string key = p.Layers[layer].PrefabKeys[keyIndex];
                    if (prefabs.ContainsKey(key)) continue;

                    string path = EnvironmentPrefabBuilder.PrefabPath(key);
                    GameObject prefab = string.IsNullOrEmpty(path)
                        ? null : AssetDatabase.LoadAssetAtPath<GameObject>(path);
                    if (prefab == null)
                    {
                        Debug.LogError($"Chapter00ZoneVegetationBuilder: missing prefab '{key}'. Run "
                            + "Build Environment Prefabs before this pass.");
                        complete = false;
                        continue;
                    }

                    GameObject contents = PrefabUtility.LoadPrefabContents(path);
                    try
                    {
                        Bounds bounds = RendererBounds(contents);
                        if (bounds.size.y <= .0001f)
                        {
                            Debug.LogError($"Chapter00ZoneVegetationBuilder: '{key}' has no Renderer bounds.");
                            complete = false;
                            continue;
                        }
                        metrics.Add(key, new Chapter00PrefabMetrics(bounds.size.y,
                            new Vector2(bounds.size.x, bounds.size.z)));
                    }
                    finally
                    {
                        PrefabUtility.UnloadPrefabContents(contents);
                    }

                    prefabs[key] = prefab;
                }
            }

            return complete;
        }

        private static Dictionary<string, Transform> EnsureOwnedPins(Transform root)
        {
            Dictionary<string, Transform> result = new Dictionary<string, Transform>();
            foreach (Chapter00VegetationZone zone in Enum.GetValues(typeof(Chapter00VegetationZone)))
            {
                foreach (Chapter00VegetationRole role in Enum.GetValues(typeof(Chapter00VegetationRole)))
                {
                    string paletteName = Chapter00ZoneVegetationParams.PaletteName(zone, role);
                    if (result.ContainsKey(paletteName)) continue;
                    Transform palette = EnsureDirectChild(root, paletteName);
                    result[paletteName] = EnsureDirectChild(palette, Chapter00ZoneVegetationParams.k_PinName);
                }
            }
            return result;
        }

        private static Dictionary<string, Transform> CreateGroupParents(
            Dictionary<string, Transform> pins)
        {
            Dictionary<string, Transform> result = new Dictionary<string, Transform>();
            foreach (KeyValuePair<string, Transform> pair in pins)
            {
                GameObject group = new GameObject(k_GroupPrefix + pair.Key);
                group.transform.SetParent(pair.Value, false);
                Undo.RegisterCreatedObjectUndo(group, "Build Chapter 00 A-E Vegetation");
                result[pair.Key] = group.transform;
            }
            return result;
        }

        private static void SaveAndConnectGroups(Dictionary<string, Transform> groups)
        {
            EnsureFolder(k_GroupPrefabFolder);
            foreach (KeyValuePair<string, Transform> pair in groups)
            {
                string path = k_GroupPrefabFolder + "/" + Sanitize(pair.Value.name) + ".prefab";
                GameObject connected = PrefabUtility.SaveAsPrefabAssetAndConnect(
                    pair.Value.gameObject, path, InteractionMode.AutomatedAction);

                if (connected == null)
                {
                    throw new InvalidOperationException(
                        "Chapter00ZoneVegetationBuilder: failed to save vegetation group " + path);
                }
            }
        }

        private static Dictionary<string, Transform> FindOwnedPins(Transform root)
        {
            Dictionary<string, Transform> result = new Dictionary<string, Transform>();
            foreach (Chapter00VegetationZone zone in Enum.GetValues(typeof(Chapter00VegetationZone)))
            {
                foreach (Chapter00VegetationRole role in Enum.GetValues(typeof(Chapter00VegetationRole)))
                {
                    string paletteName = Chapter00ZoneVegetationParams.PaletteName(zone, role);
                    if (result.ContainsKey(paletteName)) continue;
                    Transform palette = root.Find(paletteName);
                    Transform pin = palette == null ? null : palette.Find(Chapter00ZoneVegetationParams.k_PinName);

                    if (pin == null)
                    {
                        Debug.LogError("Chapter00ZoneVegetationBuilder: missing PWB palette/PIN " + paletteName);
                        return null;
                    }

                    result[paletteName] = pin;
                }
            }
            return result;
        }

        private static void ClearOwnedInstances(IEnumerable<Transform> pins)
        {
            HashSet<int> seen = new HashSet<int>();
            foreach (Transform pin in pins)
            {
                if (!seen.Add(pin.GetInstanceID())) continue;
                for (int i = pin.childCount - 1; i >= 0; i--)
                {
                    GameObject child = pin.GetChild(i).gameObject;
                    if (child.name.StartsWith(Chapter00ZoneVegetationParams.k_OwnedPrefix,
                        StringComparison.Ordinal))
                    {
                        Undo.DestroyObjectImmediate(child);
                    }
                }
            }
        }

        private static SceneGroundFilter NoOpGroundFilter(UnityEngine.Terrain terrain)
        {
            return new SceneGroundFilter(terrain, null);
        }

        private static Scene TryScene(string path)
        {
            return SceneManager.GetSceneByPath(path);
        }

        private static bool TryGetScene(string path, out Scene scene)
        {
            scene = TryScene(path);
            if (!scene.IsValid() || !scene.isLoaded)
            {
                scene = EditorSceneManager.OpenScene(path, OpenSceneMode.Additive);
            }
            return scene.IsValid() && scene.isLoaded;
        }

        private static UnityEngine.Terrain FindTerrain(Scene scene)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                UnityEngine.Terrain terrain = root.GetComponentInChildren<UnityEngine.Terrain>(true);
                if (terrain != null && terrain.terrainData != null) return terrain;
            }
            return null;
        }

        private static Transform EnsureRoot(Scene scene, string name)
        {
            Transform existing = FindDirectChild(null, name, scene);
            if (existing != null) return existing;
            GameObject created = new GameObject(name);
            SceneManager.MoveGameObjectToScene(created, scene);
            Undo.RegisterCreatedObjectUndo(created, "Build Chapter 00 A-E Vegetation");
            return created.transform;
        }

        private static Transform EnsureDirectChild(Transform parent, string name)
        {
            Transform existing = parent.Find(name);
            if (existing != null) return existing;
            GameObject created = new GameObject(name);
            created.transform.SetParent(parent, false);
            Undo.RegisterCreatedObjectUndo(created, "Build Chapter 00 A-E Vegetation");
            return created.transform;
        }

        private static Transform FindDirectChild(Transform parent, string name, Scene scene)
        {
            if (parent != null) return parent.Find(name);
            foreach (GameObject root in scene.GetRootGameObjects()) if (root.name == name) return root.transform;
            return null;
        }

        private static Transform FindByName(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                foreach (Transform child in root.GetComponentsInChildren<Transform>(true))
                {
                    if (child.name == name) return child;
                }
            }
            return null;
        }

        private static Transform FindDescendant(Transform parent, string name)
        {
            foreach (Transform child in parent.GetComponentsInChildren<Transform>(true))
            {
                if (child.name == name) return child;
            }
            return null;
        }

        private static Bounds RendererBounds(GameObject root)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);
            if (renderers.Length == 0) return new Bounds(root.transform.position, Vector3.zero);
            Bounds bounds = renderers[0].bounds;
            for (int i = 1; i < renderers.Length; i++) bounds.Encapsulate(renderers[i].bounds);
            return bounds;
        }

        private static Vector3 SampleNormal(UnityEngine.Terrain terrain, Vector2 position)
        {
            Vector3 origin = terrain.transform.position;
            Vector3 size = terrain.terrainData.size;
            float u = Mathf.Clamp01((position.x - origin.x) / size.x);
            float v = Mathf.Clamp01((position.y - origin.z) / size.z);
            return terrain.terrainData.GetInterpolatedNormal(u, v);
        }

        private static void EnsureFolder(string path)
        {
            string[] parts = path.Split('/');
            string current = parts[0];
            for (int i = 1; i < parts.Length; i++)
            {
                string next = current + "/" + parts[i];
                if (!AssetDatabase.IsValidFolder(next)) AssetDatabase.CreateFolder(current, parts[i]);
                current = next;
            }
        }

        private sealed class PrefabMetricTable : Chapter00ZoneVegetationLayout.IPrefabMetrics
        {
            private readonly Dictionary<string, Chapter00PrefabMetrics> m_values =
                new Dictionary<string, Chapter00PrefabMetrics>();

            public void Add(string key, Chapter00PrefabMetrics value) { m_values[key] = value; }
            public bool TryGet(string key, out Chapter00PrefabMetrics metrics)
            {
                return m_values.TryGetValue(key, out metrics);
            }
        }

        private sealed class SceneGroundFilter : Chapter00ZoneVegetationLayout.IGroundFilter
        {
            private readonly UnityEngine.Terrain m_terrain;
            private readonly Vector3 m_origin;
            private readonly Vector3 m_size;
            private readonly List<Rect> m_facilityFootprints = new List<Rect>();

            public SceneGroundFilter(UnityEngine.Terrain terrain, Transform facility)
            {
                m_terrain = terrain;
                m_origin = terrain.transform.position;
                m_size = terrain.terrainData.size;

                if (facility == null) return;
                Renderer[] renderers = facility.GetComponentsInChildren<Renderer>(true);
                for (int i = 0; i < renderers.Length; i++)
                {
                    Bounds b = renderers[i].bounds;
                    m_facilityFootprints.Add(Rect.MinMaxRect(
                        b.min.x - .25f, b.min.z - .25f, b.max.x + .25f, b.max.z + .25f));
                }
            }

            public bool Accepts(
                Vector2 position,
                Chapter00VegetationZone zone,
                Chapter00VegetationRole role)
            {
                float u = (position.x - m_origin.x) / m_size.x;
                float v = (position.y - m_origin.z) / m_size.z;
                if (u < 0f || u > 1f || v < 0f || v > 1f) return false;
                if (Vector3.Angle(m_terrain.terrainData.GetInterpolatedNormal(u, v), Vector3.up) > 48f)
                {
                    return false;
                }

                if (zone == Chapter00VegetationZone.E)
                {
                    for (int i = 0; i < m_facilityFootprints.Count; i++)
                    {
                        if (m_facilityFootprints[i].Contains(position)) return false;
                    }
                }

                return true;
            }
        }
    }
}

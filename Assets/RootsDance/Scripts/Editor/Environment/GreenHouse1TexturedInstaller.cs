using System.Collections.Generic;
using RootsDance.Core;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Swaps the flat-shaded greenhouse for the textured build, everywhere it stands.
    /// <para>
    /// <c>Briggs_Greenhouse.fbx</c> holds three structures, not one: two long wings either side and
    /// the octagonal dome between them. Only the dome is what the module pipeline rebuilt, so this
    /// deactivates the dome's own objects — the ones SketchUp left under <c>Group49</c> — and leaves
    /// the wings alone. Replacing the whole prefab instance would delete them.
    /// </para>
    /// <para>
    /// The replacement goes in beside each instance it replaces, carrying that instance's local
    /// transform. Copying it rather than assuming identity is what lets one pass serve both scenes:
    /// the main facility places the greenhouse at the origin of its parent, the greenhouse-interior
    /// level places it offset and scaled by 1.198.
    /// </para>
    /// Idempotent, and nothing is deleted — the old dome objects are deactivated. The interior
    /// restores the authored window frames and uses double-sided materials to match Blender.
    /// Runs over every loaded scene.
    /// Menu: RootsDance > Environment > Install Textured GreenHouse1.
    /// </summary>
    public static class GreenHouse1TexturedInstaller
    {
        private const string k_FbxPath =
            "Assets/RootsDance/Meshes/Environment/GAIA1/Buildings/GreenHouse1_Textured.fbx";

        private const string k_MaterialFolder =
            "Assets/RootsDance/Materials/Environment/GreenHouse1";

        /// <summary>
        /// The building being replaced, and the source of the import settings below. The facility's
        /// FBXs are imported at a hand-set scale (0.6045) with baked axis conversion, so a
        /// replacement left on the importer defaults comes in about 1.65x too big and in the wrong
        /// place. Copying the settings across rather than restating them keeps the two from
        /// drifting apart if that scale is ever retuned.
        /// </summary>
        private const string k_ReferenceFbxPath =
            "Assets/RootsDance/Meshes/Environment/GAIA1/Buildings/Briggs_Greenhouse.fbx";

        private const string k_Installed = "GreenHouse1_Textured";

        private const string k_InteriorMaterialFolder =
            "Assets/RootsDance/Materials/Environment/GreenhouseInterior";

        private const string k_WindowMaterial = "GreenHouse1Window";

        /// <summary>
        /// The SketchUp group the dome's objects sit under. Their names carry the whole group chain,
        /// so this is the only thing separating the dome from the wings in a flat 97-object import.
        /// </summary>
        private const string k_DomeGroup = "Group49";

        [MenuItem("RootsDance/Environment/Install Textured GreenHouse1")]
        public static void Install()
        {
            if (AssetDatabase.LoadAssetAtPath<GameObject>(k_FbxPath) == null)
            {
                Debug.LogError($"GreenHouse1TexturedInstaller: {k_FbxPath} is missing. Export it "
                    + "from GreenHouse1_Assembled.blend first.");
                return;
            }

            MatchImportSettings();

            GameObject source = AssetDatabase.LoadAssetAtPath<GameObject>(k_FbxPath);
            GameObject reference = AssetDatabase.LoadAssetAtPath<GameObject>(k_ReferenceFbxPath);

            if (source == null || reference == null)
            {
                Debug.LogError("GreenHouse1TexturedInstaller: could not load the meshes.");
                return;
            }

            List<GameObject> targets = FindOldGreenhouses(reference);

            if (targets.Count == 0)
            {
                Debug.LogWarning("GreenHouse1TexturedInstaller: no instance of "
                    + $"{System.IO.Path.GetFileName(k_ReferenceFbxPath)} in any open scene. Open "
                    + "Main_Environment or GreenhouseInterior_Environment first.");
                return;
            }

            foreach (GameObject old in targets)
            {
                Replace(source, old);
            }
        }

        private static void Replace(GameObject source, GameObject old)
        {
            Transform parent = old.transform.parent;
            Transform existing = FindSibling(old, k_Installed);
            GameObject installed;

            // Re-instantiating an already-correct replacement would rewrite its scene ids for no
            // gain, so a scene that is already done is left byte-identical.
            if (existing != null && IsAlreadyCorrect(existing, source, old.transform))
            {
                installed = existing.gameObject;
            }
            else
            {
                if (existing != null)
                {
                    Object.DestroyImmediate(existing.gameObject);
                }

                installed = (GameObject)PrefabUtility.InstantiatePrefab(source, parent);
                installed.name = k_Installed;
                installed.transform.SetParent(parent, false);

                // The replacement mesh already carries the old building's own coordinates, so
                // matching the instance transform lands it exactly where the dome was.
                installed.transform.localPosition = old.transform.localPosition;
                installed.transform.localRotation = old.transform.localRotation;
                installed.transform.localScale = old.transform.localScale;
                installed.transform.SetSiblingIndex(old.transform.GetSiblingIndex() + 1);
                EditorSceneManager.MarkSceneDirty(old.scene);
            }

            int assigned = AssignMaterials(installed);
            int restoredWindowFrames = old.scene.name == "GreenhouseInterior_Environment"
                ? RestoreWindowFrames(installed)
                : 0;
            int disabledGlassShadows = old.scene.name == "GreenhouseInterior_Environment"
                ? DisableInteriorGlassShadows(installed)
                : 0;
            int hiddenOldDomeObjects = HideOldDome(old);

            if (restoredWindowFrames > 0 || disabledGlassShadows > 0 || hiddenOldDomeObjects > 0)
            {
                EditorSceneManager.MarkSceneDirty(old.scene);
            }

            Log.Info($"GreenHouse1TexturedInstaller: [{old.scene.name}] replaced the dome of "
                + $"'{old.name}'; {assigned} renderer material slots bound, {restoredWindowFrames} "
                + $"window frames restored, {disabledGlassShadows} opaque glass shadows disabled, "
                + $"{hiddenOldDomeObjects} old dome objects deactivated. "
                + $"Placed at {installed.transform.localPosition:F3} scale "
                + $"{installed.transform.localScale:F5}. The wings either side are untouched.",
                installed);
        }

        /// <summary>Every prefab-instance root of the old greenhouse across the loaded scenes.</summary>
        private static List<GameObject> FindOldGreenhouses(GameObject reference)
        {
            List<GameObject> found = new List<GameObject>();

            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (!scene.isLoaded)
                {
                    continue;
                }

                foreach (GameObject root in scene.GetRootGameObjects())
                {
                    foreach (Transform t in root.GetComponentsInChildren<Transform>(true))
                    {
                        GameObject go = t.gameObject;

                        if (!PrefabUtility.IsAnyPrefabInstanceRoot(go))
                        {
                            continue;
                        }

                        Object asset = PrefabUtility.GetCorrespondingObjectFromOriginalSource(go);

                        if (asset != null && AssetDatabase.GetAssetPath(asset) == k_ReferenceFbxPath)
                        {
                            found.Add(go);
                        }
                    }
                }
            }

            return found;
        }

        /// <summary>True when this replacement is the right prefab already sitting on the right transform.</summary>
        private static bool IsAlreadyCorrect(Transform existing, GameObject source, Transform old)
        {
            Object asset = PrefabUtility.GetCorrespondingObjectFromOriginalSource(existing.gameObject);

            return asset != null
                && AssetDatabase.GetAssetPath(asset) == k_FbxPath
                && existing.localPosition == old.localPosition
                && existing.localRotation == old.localRotation
                && existing.localScale == old.localScale;
        }

        private static Transform FindSibling(GameObject of, string name)
        {
            if (of.transform.parent != null)
            {
                return of.transform.parent.Find(name);
            }

            foreach (GameObject root in of.scene.GetRootGameObjects())
            {
                if (root.name == name)
                {
                    return root.transform;
                }
            }

            return null;
        }

        /// <summary>
        /// Makes the replacement import exactly as the building it stands in for. The scene places
        /// it on the old instance's transform and the mesh already carries the old building's
        /// coordinates, so the two only line up while the importers agree — scale above all.
        /// </summary>
        private static void MatchImportSettings()
        {
            ModelImporter reference = AssetImporter.GetAtPath(k_ReferenceFbxPath) as ModelImporter;
            ModelImporter target = AssetImporter.GetAtPath(k_FbxPath) as ModelImporter;

            if (reference == null || target == null)
            {
                Debug.LogWarning("GreenHouse1TexturedInstaller: could not read the model importers; "
                    + "the replacement may not line up with the building it replaces.");
                return;
            }

            bool changed = !Mathf.Approximately(target.globalScale, reference.globalScale)
                || target.useFileScale != reference.useFileScale
                || target.bakeAxisConversion != reference.bakeAxisConversion
                || target.importVisibility != reference.importVisibility;

            if (!changed)
            {
                return;
            }

            target.globalScale = reference.globalScale;
            target.useFileScale = reference.useFileScale;
            target.bakeAxisConversion = reference.bakeAxisConversion;
            target.importVisibility = reference.importVisibility;
            target.SaveAndReimport();

            Debug.Log("GreenHouse1TexturedInstaller: matched the import settings of "
                + $"{System.IO.Path.GetFileName(k_ReferenceFbxPath)} — scale {reference.globalScale}, "
                + $"bakeAxisConversion {reference.bakeAxisConversion}.");
        }

        /// <summary>
        /// Binds each renderer slot to the project material of the same name. Done here rather than
        /// left to the importer's material search, so the result does not depend on an importer
        /// setting that a reimport can quietly change.
        /// </summary>
        private static int AssignMaterials(GameObject root)
        {
            Dictionary<string, Material> byName = new Dictionary<string, Material>();

            foreach (string guid in AssetDatabase.FindAssets("t:Material", new[] { k_MaterialFolder }))
            {
                string path = AssetDatabase.GUIDToAssetPath(guid);
                Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

                if (material != null)
                {
                    byName[material.name] = material;
                }
            }

            // Match the Blender material in chapter 03 without changing the exterior parents.
            if (root.scene.name == "GreenhouseInterior_Environment")
            {
                ModelImporter importer = (ModelImporter)AssetImporter.GetAtPath(k_FbxPath);

                // Blender repeats the maps every 2 m. The FBX's 100x centimetre conversion is
                // cancelled by useFileScale; only globalScale and the scene placement scale remain.
                // Use the uniformly scaled prefab root, not a child carrying FBX's 100x transform.
                float worldScale = 0.5f / (importer.globalScale * Mathf.Abs(root.transform.lossyScale.x));
                AddInteriorGlassVariant(byName, "GreenHouse1GlassIntact", worldScale);
                AddInteriorGlassVariant(byName, "GreenHouse1GlassCracked", worldScale);
                AddInteriorGlassVariant(byName, "GreenHouse1GlassShattered", worldScale);
                AddInteriorGlassVariant(byName, "GreenHouse1GlassStained", worldScale);
                AddInteriorFrameVariant(byName, "GreenHouse1Wall");
                AddInteriorFrameVariant(byName, k_WindowMaterial);
            }

            int bound = 0;
            List<string> missing = new List<string>();

            foreach (Renderer renderer in root.GetComponentsInChildren<Renderer>(true))
            {
                Material[] slots = renderer.sharedMaterials;
                bool changed = false;

                for (int i = 0; i < slots.Length; i++)
                {
                    string wanted = slots[i] == null
                        ? null
                        : slots[i].name.Replace(" (Instance)", string.Empty);

                    if (wanted == null)
                    {
                        continue;
                    }

                    if (byName.TryGetValue(wanted, out Material match))
                    {
                        if (slots[i] != match)
                        {
                            slots[i] = match;
                            changed = true;
                        }

                        bound++;
                    }
                    else if (!missing.Contains(wanted))
                    {
                        missing.Add(wanted);
                    }
                }

                if (changed)
                {
                    renderer.sharedMaterials = slots;
                    PrefabUtility.RecordPrefabInstancePropertyModifications(renderer);
                    EditorSceneManager.MarkSceneDirty(root.scene);
                }
            }

            if (missing.Count > 0)
            {
                Debug.LogWarning("GreenHouse1TexturedInstaller: no project material for "
                    + $"{string.Join(", ", missing)}. Run RootsDance > Build Prop Materials.");
            }

            return bound;
        }

        private static void AddInteriorGlassVariant(Dictionary<string, Material> byName,
            string sourceName, float worldScale)
        {
            Material source = byName[sourceName];
            string name = sourceName + "_Interior";
            string path = k_InteriorMaterialFolder + "/" + name + ".mat";
            Material variant = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (variant == null)
            {
                variant = new Material(source);
                variant.name = name;
                AssetDatabase.CreateAsset(variant, path);
            }

            // Repair the inheritance as well as the values on repeated installs.
            variant.parent = source;
            Color tint = source.GetColor("_BaseColor");
            tint.a = 1f;
            variant.SetColor("_BaseColor", tint);

            // Blender uses BaseMap alpha on a Principled surface, not transmission. HDRP Thin
            // replaces alpha blending with screen-space refraction and can become opaque when
            // that camera feature is off. Keep the authored colour, haze and roughness maps intact.
            variant.SetFloat("_RefractionModel", 0f);
            variant.SetFloat("_BlendMode", 0f);
            variant.SetFloat("_SmoothnessRemapMin", 0f);
            variant.SetFloat("_SmoothnessRemapMax", 1f);
            variant.SetFloat("_NormalScale", 0.5f);
            variant.SetFloat("_TexWorldScale", worldScale);

            // The source panes are sheets visible from either side; Flip faces the back normal
            // toward the viewer without drawing a second, overlapping transparent backface pass.
            variant.SetFloat("_DoubleSidedEnable", 1f);
            variant.SetFloat("_DoubleSidedNormalMode", 0f);
            variant.SetFloat("_TransparentBackfaceEnable", 0f);
            HDMaterial.SetSurfaceType(variant, true);
            HDMaterial.ValidateMaterial(variant);
            EditorUtility.SetDirty(variant);
            AssetDatabase.SaveAssetIfDirty(variant);
            byName[sourceName] = variant;
            byName[name] = variant;
        }

        private static void AddInteriorFrameVariant(Dictionary<string, Material> byName, string sourceName)
        {
            Material source = byName[sourceName];
            string name = sourceName + "_Interior";
            string path = k_InteriorMaterialFolder + "/" + name + ".mat";
            Material variant = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (variant == null)
            {
                variant = new Material(source);
                variant.name = name;
                AssetDatabase.CreateAsset(variant, path);
            }

            // Blender shows the frame backs inside the greenhouse. Keep the opaque shader and
            // all authored texture properties inherited; only the two-sided surface differs.
            variant.parent = source;
            variant.SetFloat("_DoubleSidedEnable", 1f);
            variant.SetFloat("_DoubleSidedNormalMode", 0f);
            HDMaterial.ValidateMaterial(variant);
            EditorUtility.SetDirty(variant);
            AssetDatabase.SaveAssetIfDirty(variant);
            byName[sourceName] = variant;
            byName[name] = variant;
        }

        /// <summary>
        /// Restores the frames hidden by the earlier glass fix. The current imported window
        /// surfaces match Preview_Whole; hiding the whole renderer removes valid frame geometry.
        /// </summary>
        private static int RestoreWindowFrames(GameObject root)
        {
            int restored = 0;

            foreach (Renderer renderer in root.GetComponentsInChildren<Renderer>(true))
            {
                if (renderer.enabled
                    || (!UsesMaterial(renderer, k_WindowMaterial)
                        && !UsesMaterial(renderer, k_WindowMaterial + "_Interior")))
                {
                    continue;
                }

                renderer.enabled = true;
                PrefabUtility.RecordPrefabInstancePropertyModifications(renderer);
                restored++;
            }

            return restored;
        }

        /// <summary>
        /// Raster shadow maps treat this alpha-blended glazing as solid. Let sunlight through the
        /// ordinary glass as an approximation; frames, mixed renderers and stained glass keep shadows.
        /// </summary>
        private static int DisableInteriorGlassShadows(GameObject root)
        {
            int disabled = 0;

            foreach (Renderer renderer in root.GetComponentsInChildren<Renderer>(true))
            {
                if (renderer.shadowCastingMode == ShadowCastingMode.Off || !UsesOnlyInteriorGlass(renderer))
                {
                    continue;
                }

                renderer.shadowCastingMode = ShadowCastingMode.Off;
                PrefabUtility.RecordPrefabInstancePropertyModifications(renderer);
                disabled++;
            }

            return disabled;
        }

        private static bool UsesOnlyInteriorGlass(Renderer renderer)
        {
            bool hasGlass = false;

            foreach (Material material in renderer.sharedMaterials)
            {
                if (material == null)
                {
                    continue;
                }

                string name = material.name;

                if (name != "GreenHouse1GlassIntact_Interior"
                    && name != "GreenHouse1GlassCracked_Interior"
                    && name != "GreenHouse1GlassShattered_Interior")
                {
                    return false;
                }

                hasGlass = true;
            }

            return hasGlass;
        }

        private static bool UsesMaterial(Renderer renderer, string materialName)
        {
            foreach (Material material in renderer.sharedMaterials)
            {
                if (material != null && material.name == materialName)
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>Turns off the dome's objects inside the old FBX, leaving the two wings on.</summary>
        private static int HideOldDome(GameObject old)
        {
            int hidden = 0;

            foreach (Transform child in old.transform)
            {
                if (!child.name.Contains(k_DomeGroup))
                {
                    continue;
                }

                if (child.gameObject.activeSelf)
                {
                    child.gameObject.SetActive(false);
                    hidden++;
                }
            }

            return hidden;
        }
    }
}

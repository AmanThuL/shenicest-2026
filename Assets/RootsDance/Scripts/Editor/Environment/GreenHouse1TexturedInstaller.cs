using System.Collections.Generic;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Swaps the flat-shaded greenhouse in the main environment for the textured build.
    /// <para>
    /// <c>Briggs_Greenhouse.fbx</c> holds three structures, not one: two long wings either side and
    /// the octagonal dome between them. Only the dome is what the module pipeline rebuilt, so this
    /// deactivates the dome's own objects — the ones SketchUp left under <c>Group49</c> — and leaves
    /// the wings alone. Replacing the whole prefab instance would delete them.
    /// </para>
    /// <para>
    /// The replacement is exported with the original building's coordinates baked in, so it goes in
    /// at local identity beside the object it replaces rather than needing a placement offset. That
    /// is the whole reason the export bakes the frame difference instead of the scene carrying it.
    /// </para>
    /// Idempotent: running it again rebuilds the replacement in place. Nothing is deleted — the old
    /// dome is only deactivated, so reverting is a matter of ticking it back on.
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

        private const string k_FacilityPath = "_Geometry/ResearchFacility_GaiaV7";
        private const string k_OldGreenhouse = "Main";
        private const string k_Installed = "GreenHouse1_Textured";

        /// <summary>
        /// The SketchUp group the dome's objects sit under. Their names carry the whole group chain,
        /// so this is the only thing separating the dome from the wings in a flat 97-object import.
        /// </summary>
        private const string k_DomeGroup = "Group49";

        [MenuItem("RootsDance/Environment/Install Textured GreenHouse1")]
        public static void Install()
        {
            GameObject facility = Find(k_FacilityPath);

            if (facility == null)
            {
                Debug.LogError($"GreenHouse1TexturedInstaller: '{k_FacilityPath}' is not in any open "
                    + "scene. Open Main_Environment first.");
                return;
            }

            if (AssetDatabase.LoadAssetAtPath<GameObject>(k_FbxPath) == null)
            {
                Debug.LogError($"GreenHouse1TexturedInstaller: {k_FbxPath} is missing. Export it "
                    + "from GreenHouse1_Assembled.blend first.");
                return;
            }

            MatchImportSettings();

            GameObject source = AssetDatabase.LoadAssetAtPath<GameObject>(k_FbxPath);

            if (source == null)
            {
                Debug.LogError($"GreenHouse1TexturedInstaller: {k_FbxPath} failed to reimport.");
                return;
            }

            Transform existing = facility.transform.Find(k_Installed);

            if (existing != null)
            {
                Object.DestroyImmediate(existing.gameObject);
            }

            GameObject installed = (GameObject)PrefabUtility.InstantiatePrefab(source, facility.transform);
            installed.name = k_Installed;
            installed.transform.localPosition = Vector3.zero;
            installed.transform.localRotation = Quaternion.identity;
            installed.transform.localScale = Vector3.one;

            int assigned = AssignMaterials(installed);
            int hidden = HideOldDome(facility);

            EditorSceneManager.MarkSceneDirty(facility.scene);
            Selection.activeGameObject = installed;

            Debug.Log($"GreenHouse1TexturedInstaller: installed '{k_Installed}' under "
                + $"{k_FacilityPath}; {assigned} renderer material slots bound, {hidden} objects of "
                + $"the old dome deactivated. The wings either side are untouched.", installed);
        }

        /// <summary>
        /// Makes the replacement import exactly as the building it stands in for. The scene places
        /// it at local identity and the mesh already carries the old building's coordinates, so the
        /// two only line up while the importers agree — scale above all.
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

            int bound = 0;
            List<string> missing = new List<string>();

            foreach (Renderer renderer in root.GetComponentsInChildren<Renderer>(true))
            {
                Material[] slots = renderer.sharedMaterials;

                for (int i = 0; i < slots.Length; i++)
                {
                    // The imported slot carries the name Blender exported, which is the material
                    // name the assembly assigned; Unity appends nothing when it matches an asset.
                    string wanted = slots[i] == null
                        ? null
                        : slots[i].name.Replace(" (Instance)", string.Empty);

                    if (wanted == null)
                    {
                        continue;
                    }

                    if (byName.TryGetValue(wanted, out Material match))
                    {
                        slots[i] = match;
                        bound++;
                    }
                    else if (!missing.Contains(wanted))
                    {
                        missing.Add(wanted);
                    }
                }

                renderer.sharedMaterials = slots;
            }

            if (missing.Count > 0)
            {
                Debug.LogWarning("GreenHouse1TexturedInstaller: no project material for "
                    + $"{string.Join(", ", missing)}. Run RootsDance > Build Prop Materials.");
            }

            return bound;
        }

        /// <summary>Turns off the dome's objects inside the old FBX, leaving the two wings on.</summary>
        private static int HideOldDome(GameObject facility)
        {
            Transform old = facility.transform.Find(k_OldGreenhouse);

            if (old == null)
            {
                Debug.LogWarning($"GreenHouse1TexturedInstaller: no '{k_OldGreenhouse}' under "
                    + $"{k_FacilityPath}; nothing was hidden, so the old dome may still be drawn.");
                return 0;
            }

            int hidden = 0;

            foreach (Transform child in old)
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

        private static GameObject Find(string path)
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (!scene.isLoaded)
                {
                    continue;
                }

                foreach (GameObject root in scene.GetRootGameObjects())
                {
                    if (root.name == path)
                    {
                        return root;
                    }

                    Transform found = root.transform.Find(PathUnder(root.name, path));

                    if (found != null)
                    {
                        return found.gameObject;
                    }
                }
            }

            return null;
        }

        /// <summary>The part of a slash path below the named root, or the path itself if unrelated.</summary>
        private static string PathUnder(string rootName, string path)
        {
            string prefix = rootName + "/";
            return path.StartsWith(prefix) ? path.Substring(prefix.Length) : path;
        }
    }
}

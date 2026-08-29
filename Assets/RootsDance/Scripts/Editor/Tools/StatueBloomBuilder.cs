using System.IO;
using RootsDance.Environment;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Puts the growth that climbs the StMuerte statue into <c>Main_Environment_Statue</c>: the
    /// material, the prefab and the one scene placement.
    /// <para>
    /// Written as a builder for the same reason <see cref="CorridorAlgaeBuilder"/> is — the effect
    /// is a material, a prefab and a placement that have to agree, and a mismatch fails silently
    /// rather than loudly. It is far simpler than the algae one because the clumps were wrapped
    /// onto the robe in Blender and exported in place: the mesh already carries the statue's own
    /// world coordinates, so the placement is an identity transform under the statue's root and
    /// there is nothing to position by hand.
    /// </para>
    /// <para>
    /// The clumps cast no shadows. <c>RootsDance/Environment/StatueBloom</c> has a DepthForwardOnly
    /// and a ForwardOnly pass and no ShadowCaster — see the plan's §6.3 for why it is unlit — so
    /// asking for shadows would cost a pass that cannot run.
    /// </para>
    /// Menu: RootsDance > Build Statue Bloom. Re-runnable: every step reuses what is already there,
    /// and an existing placement is left exactly where it is.
    /// </summary>
    public static class StatueBloomBuilder
    {
        private const string k_LogPrefix = "StatueBloomBuilder";

        private const string k_ScenePath = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_Statue.unity";
        private const string k_Fbx = "Assets/RootsDance/Meshes/Environment/GAIA1/Sculpture/BloomPatches.fbx";
        private const string k_Shader = "RootsDance/Environment/StatueBloom";
        private const string k_Material = "Assets/RootsDance/Materials/Environment/StatueBloom.mat";
        private const string k_Prefab = "Assets/RootsDance/Prefabs/Environment/StatueBloom.prefab";

        /// <summary>The merged object build_bloom_patch.py writes. Found by name, not by index.</summary>
        private const string k_MeshName = "BloomPatches";

        /// <summary>The statue's root in the scene. The clumps go under it, so it carries them.</summary>
        private const string k_StatueRoot = "Statue";

        private const string k_InstanceName = "StatueBloom";

        /// <summary>
        /// Seconds from bare stone to fully grown. Matched to MUS_EndingBloom when the cut is
        /// timed; until then it is long enough to read as growth rather than as a switch.
        /// </summary>
        private const float k_Duration = 45f;

        [MenuItem("RootsDance/Build Statue Bloom")]
        public static void Build()
        {
            Material material = EnsureMaterial();

            if (material == null)
            {
                return;
            }

            GameObject prefab = EnsurePrefab(material);

            if (prefab == null)
            {
                return;
            }

            PlaceInScene(prefab);
            AssetDatabase.SaveAssets();
            Debug.Log($"{k_LogPrefix}: done.");
        }

        private static Material EnsureMaterial()
        {
            Shader shader = Shader.Find(k_Shader);

            if (shader == null)
            {
                Debug.LogError($"{k_LogPrefix}: shader '{k_Shader}' not found.");
                return null;
            }

            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_Material);

            if (material == null)
            {
                EnsureFolder(Path.GetDirectoryName(k_Material));
                material = new Material(shader);
                AssetDatabase.CreateAsset(material, k_Material);
            }

            material.shader = shader;

            // Authored fully grown, so the material reads correctly in the project window and in a
            // prefab preview. GrowthDriver takes it to 0 the moment the object is switched on.
            material.SetFloat("_Growth", 1f);
            EditorUtility.SetDirty(material);

            return material;
        }

        private static GameObject EnsurePrefab(Material material)
        {
            Mesh mesh = LoadMesh();

            if (mesh == null)
            {
                return null;
            }

            EnsureFolder(Path.GetDirectoryName(k_Prefab));

            GameObject root = new GameObject(k_InstanceName);

            try
            {
                root.AddComponent<MeshFilter>().sharedMesh = mesh;

                MeshRenderer renderer = root.AddComponent<MeshRenderer>();
                renderer.sharedMaterial = material;
                renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;

                GrowthDriver driver = root.AddComponent<GrowthDriver>();
                SerializedObject so = new SerializedObject(driver);
                so.FindProperty("m_renderer").objectReferenceValue = renderer;
                so.FindProperty("m_duration").floatValue = k_Duration;
                so.FindProperty("m_startAt").floatValue = 0f;

                // The sequence switches the object on when the ending begins, and OnEnable starts
                // the curve. Nothing else has to call Play.
                so.FindProperty("m_playOnEnable").boolValue = true;
                so.ApplyModifiedPropertiesWithoutUndo();

                return PrefabUtility.SaveAsPrefabAsset(root, k_Prefab);
            }
            finally
            {
                Object.DestroyImmediate(root);
            }
        }

        private static Mesh LoadMesh()
        {
            Object[] all = AssetDatabase.LoadAllAssetsAtPath(k_Fbx);

            for (int i = 0; i < all.Length; i++)
            {
                if (all[i] is Mesh mesh && mesh.name == k_MeshName)
                {
                    return mesh;
                }
            }

            Debug.LogError($"{k_LogPrefix}: no mesh named '{k_MeshName}' in {k_Fbx}.");

            return null;
        }

        private static void PlaceInScene(GameObject prefab)
        {
            // Opening Single would throw away unsaved work in whatever is open. Refusing is the
            // only safe answer: this builder saves the scene it opens, so it cannot ask later.
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene open = SceneManager.GetSceneAt(i);

                if (open.isDirty)
                {
                    Debug.LogError($"{k_LogPrefix}: '{open.name}' has unsaved changes. Save or "
                        + "discard them, then run this again.");
                    return;
                }
            }

            Scene scene = EditorSceneManager.OpenScene(k_ScenePath, OpenSceneMode.Single);
            GameObject statue = null;

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == k_StatueRoot)
                {
                    statue = root;
                    break;
                }
            }

            if (statue == null)
            {
                Debug.LogError($"{k_LogPrefix}: no '{k_StatueRoot}' root in {k_ScenePath}. Run "
                    + "RootsDance > Build Statue Environment Scene first.");
                return;
            }

            Transform existing = statue.transform.Find(k_InstanceName);

            if (existing != null)
            {
                Debug.Log($"{k_LogPrefix}: '{k_InstanceName}' is already under '{k_StatueRoot}'; "
                    + "left as it is.");
                return;
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            instance.name = k_InstanceName;

            // The mesh carries the statue's own world coordinates, exported in place from the same
            // blend the statue came from. Anything but identity here moves the growth off the robe.
            instance.transform.SetParent(statue.transform, false);
            instance.transform.localPosition = Vector3.zero;
            instance.transform.localRotation = Quaternion.identity;
            instance.transform.localScale = Vector3.one;

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            Debug.Log($"{k_LogPrefix}: placed '{k_InstanceName}' under '{k_StatueRoot}'.");
        }

        private static void EnsureFolder(string folder)
        {
            if (string.IsNullOrEmpty(folder) || AssetDatabase.IsValidFolder(folder))
            {
                return;
            }

            string parent = Path.GetDirectoryName(folder);
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, Path.GetFileName(folder));
        }
    }
}

using System.Collections.Generic;
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

        /// <summary>The statue's root in the scene. The clumps go under it, so it carries them.</summary>
        private const string k_StatueRoot = "Statue";

        private const string k_InstanceName = "StatueBloom";

        /// <summary>
        /// Seconds from bare stone to fully grown. Matched to MUS_EndingBloom when the cut is
        /// timed; until then it is long enough to read as growth rather than as a switch.
        /// </summary>
        private const float k_Duration = 45f;

        // --- Standing flowers -------------------------------------------------------------------

        private static readonly string[] k_FlowerFbx =
        {
            "Assets/ThirdParty/Environment/NiwlPlants/Models/Flowers/M3D_poppy-1.fbx",
            "Assets/ThirdParty/Environment/NiwlPlants/Models/Flowers/M3D_poppy2.fbx",
            "Assets/ThirdParty/Environment/NiwlPlants/Models/Flowers/M3D_sunflower.fbx",
        };

        private const string k_FlowerMaterial =
            "Assets/RootsDance/Materials/Environment/Niwl_Plants_General.mat";

        /// <summary>LOD0 of each source. They are 24-114 triangles, so a few dozen cost nothing.</summary>
        private const string k_FlowerLodSuffix = "_LOD0";

        private const string k_FlowerRoot = "Flowers";

        /// <summary>How many stems to plant. The clumps carry the coverage; these carry silhouette.</summary>
        private const int k_FlowerCount = 110;

        /// <summary>Minimum metres between stems, so they read as clumps and not as a lawn.</summary>
        private const float k_FlowerSpacing = 0.85f;

        /// <summary>
        /// Only plant on a clump's interior. Vertex colour R is the rim falloff, and a stem rooted
        /// on an eroded edge stands in a part of the cover the shader has clipped away.
        /// </summary>
        private const float k_FlowerRimFloor = 0.75f;

        /// <summary>
        /// Fraction of the statue's height, from the base up, that gets stems. The player stands at
        /// its feet: above this only the silhouette reads, and the wrapped cover carries that.
        /// </summary>
        private const float k_FlowerHeightFraction = 0.55f;

        /// <summary>How far a stem leans towards world up rather than straight out of the robe.</summary>
        private const float k_FlowerUprightBias = 0.4f;

        /// <summary>Metres tall, at the statue's own scale. A stem, not a tree.</summary>
        private const float k_FlowerHeightMin = 0.55f;

        private const float k_FlowerHeightMax = 1.15f;

        /// <summary>Fixed, so a rebuild plants the same garden rather than reshuffling it.</summary>
        private const int k_FlowerSeed = 20260830;

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
            GameObject source = AssetDatabase.LoadAssetAtPath<GameObject>(k_Fbx);

            if (source == null)
            {
                Debug.LogError($"{k_LogPrefix}: {k_Fbx} not found.");
                return null;
            }

            EnsureFolder(Path.GetDirectoryName(k_Prefab));

            // Instantiate the imported model rather than hanging its mesh on a fresh GameObject.
            // The importer leaves the Blender-to-Unity axis conversion on this FBX's root as a 90°
            // rotation about X instead of baking it into the vertices, and the mesh's local origin
            // is tens of metres from the statue — so dropping that rotation does not merely tip the
            // clumps over, it throws them ~93 m away. Taking the model's own root keeps whatever
            // transform the importer decided on, for this export and for every future one.
            GameObject root = (GameObject)PrefabUtility.InstantiatePrefab(source);
            PrefabUtility.UnpackPrefabInstance(root, PrefabUnpackMode.Completely,
                InteractionMode.AutomatedAction);
            root.name = k_InstanceName;

            try
            {
                MeshRenderer renderer = root.GetComponentInChildren<MeshRenderer>();

                if (renderer == null)
                {
                    Debug.LogError($"{k_LogPrefix}: no MeshRenderer in {k_Fbx}.");
                    return null;
                }

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

                PlantFlowers(root, driver);

                return PrefabUtility.SaveAsPrefabAsset(root, k_Prefab);
            }
            finally
            {
                Object.DestroyImmediate(root);
            }
        }


        /// <summary>
        /// Plants standing flowers on the clumps and hands them to a <see cref="BloomBurst"/>.
        /// <para>
        /// Positions come out of the clump mesh rather than from a separate scatter, which is what
        /// keeps a stem and the cover under it inseparable: the vertex it is rooted at supplies the
        /// place, the surface direction and — in vertex colour B — the moment the front reaches it.
        /// A stem can therefore never open before, or long after, the patch it stands in.
        /// </para>
        /// <para>
        /// Editor-only work. The mesh is imported non-readable, which costs nothing here because
        /// the Editor keeps its own copy, and means the runtime never touches vertex data.
        /// </para>
        /// </summary>
        private static void PlantFlowers(GameObject root, GrowthDriver driver)
        {
            MeshFilter filter = root.GetComponentInChildren<MeshFilter>();
            Mesh mesh = filter == null ? null : filter.sharedMesh;

            if (mesh == null)
            {
                Debug.LogError($"{k_LogPrefix}: no clump mesh to plant on.");
                return;
            }

            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_FlowerMaterial);
            FlowerSource[] sources = LoadFlowerSources();

            if (material == null || sources.Length == 0)
            {
                Debug.LogError($"{k_LogPrefix}: flower material or meshes missing; "
                    + "planting nothing.");
                return;
            }

            Vector3[] vertices = mesh.vertices;
            Vector3[] normals = mesh.normals;
            Color[] colors = mesh.colors;

            if (colors == null || colors.Length != vertices.Length)
            {
                Debug.LogError($"{k_LogPrefix}: the clump mesh carries no vertex colour, so there "
                    + "is no growth order to plant against.");
                return;
            }

            // The clumps' own local space is not world space -- the model root holds the axis
            // conversion -- so "up" has to be brought into it before anything can lean towards it.
            Vector3 localUp = Quaternion.Inverse(root.transform.localRotation) * Vector3.up;

            float lowest = float.MaxValue;
            float highest = float.MinValue;

            for (int i = 0; i < vertices.Length; i++)
            {
                float h = Vector3.Dot(vertices[i], localUp);
                lowest = Mathf.Min(lowest, h);
                highest = Mathf.Max(highest, h);
            }

            float ceiling = lowest + (highest - lowest) * k_FlowerHeightFraction;

            GameObject holder = new GameObject(k_FlowerRoot);
            holder.transform.SetParent(root.transform, false);

            System.Random rng = new System.Random(k_FlowerSeed);
            List<Vector3> taken = new List<Vector3>(k_FlowerCount);
            List<BloomBurst.Flower> planted = new List<BloomBurst.Flower>(k_FlowerCount);

            // Walk the vertices in a shuffled order rather than in mesh order, which would plant
            // every stem in whichever clump happens to be first in the buffer.
            int[] order = new int[vertices.Length];

            for (int i = 0; i < order.Length; i++)
            {
                order[i] = i;
            }

            for (int i = order.Length - 1; i > 0; i--)
            {
                int j = rng.Next(i + 1);
                (order[i], order[j]) = (order[j], order[i]);
            }

            for (int k = 0; k < order.Length && planted.Count < k_FlowerCount; k++)
            {
                int i = order[k];

                if (colors[i].r < k_FlowerRimFloor)
                {
                    continue;
                }

                Vector3 position = vertices[i];

                if (Vector3.Dot(position, localUp) > ceiling)
                {
                    continue;
                }

                Vector3 normal = normals != null && normals.Length == vertices.Length
                    ? normals[i]
                    : localUp;

                // Nothing grows out of an overhang pointing at the ground.
                if (Vector3.Dot(normal.normalized, localUp) < -0.2f)
                {
                    continue;
                }

                if (TooClose(taken, position, k_FlowerSpacing))
                {
                    continue;
                }

                taken.Add(position);

                Vector3 aim = Vector3.Slerp(normal.normalized, localUp, k_FlowerUprightBias);
                FlowerSource source = sources[rng.Next(sources.Length)];

                float target = Mathf.Lerp(k_FlowerHeightMin, k_FlowerHeightMax,
                    (float)rng.NextDouble());
                float scale = source.m_unitScale * (target / source.m_height);

                GameObject flower = new GameObject(source.m_mesh.name);
                flower.transform.SetParent(holder.transform, false);
                flower.transform.localPosition = position;

                // Stand the mesh up with its model root's pose first, then aim the standing stem
                // along the surface. Composed in that order: the right-hand rotation is applied
                // first, so the flower is upright before it is tilted.
                flower.transform.localRotation =
                    Quaternion.FromToRotation(Vector3.up, aim) * source.m_pose;

                // Saved open, not shut. BloomBurst runs only in Play, so stems saved at zero scale
                // are invisible in the Editor — exactly where the look gets judged and the growth
                // slider gets dragged. Nothing flickers at runtime: BloomBurst writes every scale
                // in OnEnable, before the first frame is drawn.
                flower.transform.localScale = new Vector3(scale, scale, scale);

                flower.AddComponent<MeshFilter>().sharedMesh = source.m_mesh;
                MeshRenderer mr = flower.AddComponent<MeshRenderer>();
                mr.sharedMaterial = material;
                mr.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;

                planted.Add(new BloomBurst.Flower(flower.transform, colors[i].b, scale));
            }

            BloomBurst burst = root.AddComponent<BloomBurst>();
            SerializedObject so = new SerializedObject(burst);
            so.FindProperty("m_driver").objectReferenceValue = driver;

            SerializedProperty array = so.FindProperty("m_flowers");
            array.arraySize = planted.Count;

            for (int i = 0; i < planted.Count; i++)
            {
                SerializedProperty element = array.GetArrayElementAtIndex(i);
                element.FindPropertyRelative("m_transform").objectReferenceValue =
                    planted[i].Transform;
                element.FindPropertyRelative("m_order").floatValue = planted[i].Order;
                element.FindPropertyRelative("m_scale").floatValue = planted[i].Scale;
            }

            so.ApplyModifiedPropertiesWithoutUndo();
            Debug.Log($"{k_LogPrefix}: planted {planted.Count} flowers of {k_FlowerCount} asked "
                + "for.");
        }

        private static bool TooClose(List<Vector3> taken, Vector3 candidate, float spacing)
        {
            float sqr = spacing * spacing;

            for (int i = 0; i < taken.Count; i++)
            {
                if ((taken[i] - candidate).sqrMagnitude < sqr)
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>
        /// One flower source: its LOD0 mesh plus the pose and scale its own model root carries.
        /// <para>
        /// Those are not decoration. The importer parks the axis conversion (270° about X, so the
        /// mesh's long axis is Z, not Y) and the unit conversion (x100 — the FBX declares
        /// centimetres) on the model root, and its LOD children are identity. A bare mesh planted
        /// straight into the scene is therefore a centimetre tall and lying on its side.
        /// </para>
        /// </summary>
        private struct FlowerSource
        {
            public Mesh m_mesh;

            /// <summary>The model root's orientation, which stands the mesh up.</summary>
            public Quaternion m_pose;

            /// <summary>The model root's uniform scale, which converts its units to metres.</summary>
            public float m_unitScale;

            /// <summary>Metres tall once posed and scaled — what a real one measures.</summary>
            public float m_height;
        }

        /// <summary>
        /// LOD0 of each flower source, with the transform its model root carries. Everything is
        /// read from the asset rather than written down here, so a change to the import settings
        /// moves the flowers with it instead of silently mis-sizing them.
        /// </summary>
        private static FlowerSource[] LoadFlowerSources()
        {
            List<FlowerSource> found = new List<FlowerSource>(k_FlowerFbx.Length);

            foreach (string path in k_FlowerFbx)
            {
                GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(path);

                if (model == null)
                {
                    Debug.LogWarning($"{k_LogPrefix}: {path} not found.");
                    continue;
                }

                Mesh best = null;

                foreach (Object o in AssetDatabase.LoadAllAssetsAtPath(path))
                {
                    if (o is Mesh m && m.name.EndsWith(k_FlowerLodSuffix))
                    {
                        best = m;
                        break;
                    }
                }

                if (best == null)
                {
                    Debug.LogWarning($"{k_LogPrefix}: no {k_FlowerLodSuffix} mesh in {path}.");
                    continue;
                }

                MeshRenderer renderer = model.GetComponentInChildren<MeshRenderer>();
                float height = renderer == null ? 0f : renderer.bounds.size.y;

                if (height < 1e-4f)
                {
                    Debug.LogWarning($"{k_LogPrefix}: {path} measures no height; skipping.");
                    continue;
                }

                found.Add(new FlowerSource
                {
                    m_mesh = best,
                    m_pose = model.transform.localRotation,
                    m_unitScale = model.transform.localScale.y,
                    m_height = height,
                });
            }

            return found.ToArray();
        }

        private static void PlaceInScene(GameObject prefab)
        {
            // Use the scene if it is already open. The Main level is four additive scenes, and
            // opening this one Single would close the other three out from under whoever is
            // working in them — a builder has no business rearranging someone's setup.
            Scene scene = SceneManager.GetSceneByPath(k_ScenePath);

            if (!scene.IsValid() || !scene.isLoaded)
            {
                // Not open, so this has to open it — and Single would discard unsaved work
                // anywhere else. Refusing is the only safe answer.
                for (int i = 0; i < SceneManager.sceneCount; i++)
                {
                    Scene other = SceneManager.GetSceneAt(i);

                    if (other.isDirty)
                    {
                        Debug.LogError($"{k_LogPrefix}: '{other.name}' has unsaved changes. Save "
                            + "or discard them, then run this again.");
                        return;
                    }
                }

                scene = EditorSceneManager.OpenScene(k_ScenePath, OpenSceneMode.Single);
            }
            else if (scene.isDirty)
            {
                Debug.LogError($"{k_LogPrefix}: '{scene.name}' has unsaved changes. Save or "
                    + "discard them, then run this again.");
                return;
            }
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
                // Re-running must not stack a second copy. It must, however, repair a pose left by
                // an earlier build: an instance placed at identity is the 93 m bug, and telling
                // somebody it is "already there" while it sits in the sky is worse than useless.
                if (PoseMatches(existing, prefab.transform))
                {
                    Debug.Log($"{k_LogPrefix}: '{k_InstanceName}' is already under "
                        + $"'{k_StatueRoot}'; left as it is.");
                    return;
                }

                ApplyPrefabPose(existing, prefab.transform);
                EditorSceneManager.MarkSceneDirty(scene);
                EditorSceneManager.SaveScene(scene);
                Debug.Log($"{k_LogPrefix}: corrected the pose of '{k_InstanceName}' to the "
                    + "prefab's own.");
                return;
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            instance.name = k_InstanceName;

            // The mesh carries the statue's own world coordinates, exported in place from the same
            // blend the statue came from, so the clumps land on the robe as long as the prefab's
            // own transform is left alone. Forcing identity here is exactly what put them 93 m off
            // the statue: it discards the axis conversion the importer parked on the model's root.
            instance.transform.SetParent(statue.transform, false);
            ApplyPrefabPose(instance.transform, prefab.transform);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            Debug.Log($"{k_LogPrefix}: placed '{k_InstanceName}' under '{k_StatueRoot}'.");
        }

        /// <summary>
        /// Give <paramref name="target"/> the pose the prefab itself carries. That pose is not
        /// identity: it holds the axis conversion the model importer left on the FBX root.
        /// </summary>
        private static void ApplyPrefabPose(Transform target, Transform prefabRoot)
        {
            target.localPosition = prefabRoot.localPosition;
            target.localRotation = prefabRoot.localRotation;
            target.localScale = prefabRoot.localScale;
        }

        private static bool PoseMatches(Transform target, Transform prefabRoot)
        {
            return target.localPosition == prefabRoot.localPosition
                && Quaternion.Angle(target.localRotation, prefabRoot.localRotation) < 0.01f
                && target.localScale == prefabRoot.localScale;
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

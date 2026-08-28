using System.Collections.Generic;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Places the opening段's props into <c>Main_Environment</c> so the three concept images of
    /// <c>docs/design/00章前段环境设计_起始点至异色草带.md</c> §5/§6 read in-engine: the contamination zone at
    /// the wake lowland, the abandoned survey camp, and the threshold in front of the anomalous grass band.
    /// </summary>
    /// <remarks>
    /// <para>
    /// Everything lands under PWB's own hierarchy — <c>Prefab World Builder/&lt;palette&gt;/PIN</c>, exactly
    /// what Prefab World Builder builds from the project's parenting settings (auto parent + a sub-parent per
    /// palette and per tool). Instances are real prefab instances, so PWB's Pin, Brush, Replacer and Eraser
    /// tools all keep working on them and the placement can be adjusted by hand afterwards.
    /// </para>
    /// <para>
    /// Idempotent and destructive within its own scope: a run clears the six palette sub-parents it owns and
    /// rebuilds them, and touches nothing else in the scene. The scene is left dirty, never saved — reviewing
    /// and saving is the human's call.
    /// </para>
    /// </remarks>
    public static class OpeningPropsBuilder
    {
        private const string k_Menu = "RootsDance/Environment/Build Opening Props";

        [MenuItem(k_Menu)]
        public static void Build()
        {
            BuildWith(OpeningPropsParams.CreateDefault());
        }

        /// <summary>Runs the pass against explicit parameters. Returns the number of props placed.</summary>
        public static int BuildWith(OpeningPropsParams p)
        {
            Scene scene;

            if (!TryGetScene(p.ScenePath, out scene))
            {
                return 0;
            }

            UnityEngine.Terrain terrain = FindTerrain(scene);

            if (terrain == null)
            {
                Debug.LogError($"OpeningPropsBuilder: no Terrain in '{p.ScenePath}'; nothing was placed.");
                return 0;
            }

            TerrainSampler sampler = new TerrainSampler(terrain);
            List<PropInstance> instances = OpeningPropsLayout.Build(p, sampler);
            Dictionary<string, GameObject> prefabs = LoadPrefabs(instances);

            if (prefabs == null)
            {
                return 0;
            }

            int undoGroup = Undo.GetCurrentGroup();
            Transform root = EnsurePwbRoot(scene);
            Dictionary<PropPool, Transform> parents = ResetPoolParents(root);
            Dictionary<string, Bounds> boundsCache = new Dictionary<string, Bounds>();
            Dictionary<string, int> counters = new Dictionary<string, int>();

            int placed = 0;
            int skipped = 0;

            for (int i = 0; i < instances.Count; i++)
            {
                if (Place(instances[i], prefabs, parents, sampler, boundsCache, counters))
                {
                    placed++;
                }
                else
                {
                    skipped++;
                }
            }

            // One Ctrl+Z has to take the whole pass back out; ~1500 separate entries would bury every other
            // undo step the human still has in the stack.
            Undo.SetCurrentGroupName("Build Opening Props");
            Undo.CollapseUndoOperations(undoGroup);

            EditorSceneManager.MarkSceneDirty(scene);
            Debug.Log($"OpeningPropsBuilder: placed {placed} props under "
                + $"'{OpeningPropsParams.k_PwbRootName}' in {scene.name} ({skipped} off the terrain). "
                + "The scene is dirty and has not been saved.");
            return placed;
        }

        /// <summary>Removes every prop this pass owns, leaving the PWB root and the rest of the scene alone.</summary>
        [MenuItem("RootsDance/Environment/Clear Opening Props")]
        public static void Clear()
        {
            OpeningPropsParams p = OpeningPropsParams.CreateDefault();
            Scene scene;

            if (!TryGetScene(p.ScenePath, out scene))
            {
                return;
            }

            Transform root = FindChild(null, OpeningPropsParams.k_PwbRootName, scene);

            if (root == null)
            {
                Debug.Log("OpeningPropsBuilder: nothing to clear.");
                return;
            }

            ResetPoolParents(root);
            EditorSceneManager.MarkSceneDirty(scene);
            Debug.Log("OpeningPropsBuilder: cleared the six palette sub-parents.");
        }

        // -------------------------------------------------------------------------------------------------
        // Placement
        // -------------------------------------------------------------------------------------------------

        private static bool Place(PropInstance instance, Dictionary<string, GameObject> prefabs,
            Dictionary<PropPool, Transform> parents, TerrainSampler sampler,
            Dictionary<string, Bounds> boundsCache, Dictionary<string, int> counters)
        {
            Vector3 groundNormal;
            float height;

            if (!sampler.Sample(instance.Position, out height, out groundNormal))
            {
                return false;
            }

            GameObject prefab = prefabs[instance.Prefab];
            GameObject go = (GameObject)PrefabUtility.InstantiatePrefab(prefab, parents[instance.Pool]);

            if (go == null)
            {
                return false;
            }

            // PropInstance.Scale multiplies the prefab root's own uniform scale, it does not replace it: the
            // Lab Assets are modelled in centimetres and carry 0.01 on their root, so overwriting it with 1
            // would put a 60 cm balance in the valley at 60 m.
            float scale = prefab.transform.localScale.x * instance.Scale;
            Quaternion rotation = Rotation(instance, groundNormal);
            go.transform.localScale = Vector3.one * scale;
            go.transform.rotation = rotation;

            // The pivot of a vendor model is wherever the scan happened to put it, and a rolled or tipped
            // prop moves its own lowest point. Measuring the rotated, scaled bounds is the only way to make
            // every pool sit on the ground instead of floating or sinking.
            float baseOffset = BaseOffset(prefab, instance.Prefab, rotation, scale, boundsCache);
            go.transform.position = new Vector3(instance.Position.x,
                height + baseOffset - instance.Sink, instance.Position.y);

            go.name = UniqueName(instance, counters);
            Undo.RegisterCreatedObjectUndo(go, "Build Opening Props");
            return true;
        }

        /// <summary>
        /// Upright by default, leant into the ground normal by <see cref="PropInstance.NormalAlign"/>, then
        /// yawed, then given its authored re-orientation and a random tilt on top.
        /// </summary>
        private static Quaternion Rotation(PropInstance instance, Vector3 groundNormal)
        {
            Vector3 up = Vector3.Slerp(Vector3.up, groundNormal, Mathf.Clamp01(instance.NormalAlign));
            Quaternion align = Quaternion.FromToRotation(Vector3.up, up);
            Quaternion tilt = Quaternion.identity;

            if (instance.Tilt > 0f)
            {
                Vector3 axis = Quaternion.Euler(0f, instance.TiltDirection, 0f) * Vector3.right;
                tilt = Quaternion.AngleAxis(instance.Tilt, axis);
            }

            return tilt * align * Quaternion.Euler(0f, instance.Yaw, 0f) * Quaternion.Euler(instance.ExtraEuler);
        }

        /// <summary>Metres to lift the pivot so the prop's lowest rotated point touches the ground.</summary>
        private static float BaseOffset(GameObject prefab, string key, Quaternion rotation, float scale,
            Dictionary<string, Bounds> cache)
        {
            Bounds local;

            if (!cache.TryGetValue(key, out local))
            {
                local = MeshBounds(prefab);
                cache[key] = local;
            }

            if (local.size == Vector3.zero)
            {
                return 0f;
            }

            float lowest = float.MaxValue;

            for (int corner = 0; corner < 8; corner++)
            {
                Vector3 point = local.center + Vector3.Scale(local.extents, new Vector3(
                    (corner & 1) == 0 ? -1f : 1f,
                    (corner & 2) == 0 ? -1f : 1f,
                    (corner & 4) == 0 ? -1f : 1f));
                lowest = Mathf.Min(lowest, (rotation * (point * scale)).y);
            }

            return -lowest;
        }

        /// <summary>
        /// Bounds of the prefab's LOD0 renderers in the prefab root's own space. Built from
        /// <c>MeshFilter.sharedMesh.bounds</c>: a renderer on an asset has no world bounds to read.
        /// </summary>
        private static Bounds MeshBounds(GameObject prefab)
        {
            LODGroup group = prefab.GetComponentInChildren<LODGroup>(true);
            HashSet<Renderer> lod0 = null;

            if (group != null)
            {
                LOD[] lods = group.GetLODs();

                if (lods.Length > 0)
                {
                    lod0 = new HashSet<Renderer>(lods[0].renderers);
                }
            }

            Matrix4x4 worldToRoot = prefab.transform.worldToLocalMatrix;
            Bounds bounds = new Bounds(Vector3.zero, Vector3.zero);
            bool started = false;

            foreach (MeshRenderer renderer in prefab.GetComponentsInChildren<MeshRenderer>(true))
            {
                if (lod0 != null && !lod0.Contains(renderer))
                {
                    continue;
                }

                MeshFilter filter = renderer.GetComponent<MeshFilter>();

                if (filter == null || filter.sharedMesh == null)
                {
                    continue;
                }

                Matrix4x4 toRoot = worldToRoot * renderer.transform.localToWorldMatrix;
                Bounds mesh = filter.sharedMesh.bounds;

                for (int corner = 0; corner < 8; corner++)
                {
                    Vector3 point = mesh.center + Vector3.Scale(mesh.extents, new Vector3(
                        (corner & 1) == 0 ? -1f : 1f,
                        (corner & 2) == 0 ? -1f : 1f,
                        (corner & 4) == 0 ? -1f : 1f));
                    Vector3 inRoot = toRoot.MultiplyPoint3x4(point);

                    if (started)
                    {
                        bounds.Encapsulate(inRoot);
                    }
                    else
                    {
                        bounds = new Bounds(inRoot, Vector3.zero);
                        started = true;
                    }
                }
            }

            return bounds;
        }

        private static string UniqueName(PropInstance instance, Dictionary<string, int> counters)
        {
            string key = instance.Group + "|" + instance.Prefab;
            int index;
            counters.TryGetValue(key, out index);
            counters[key] = index + 1;
            return $"{instance.Group}_{instance.Prefab}_{index:000}";
        }

        // -------------------------------------------------------------------------------------------------
        // Scene plumbing
        // -------------------------------------------------------------------------------------------------

        private static bool TryGetScene(string path, out Scene scene)
        {
            scene = SceneManager.GetSceneByPath(path);

            if (!scene.IsValid() || !scene.isLoaded)
            {
                scene = EditorSceneManager.OpenScene(path, OpenSceneMode.Additive);
            }

            if (!scene.IsValid() || !scene.isLoaded)
            {
                Debug.LogError($"OpeningPropsBuilder: could not open '{path}'.");
                return false;
            }

            return true;
        }

        private static UnityEngine.Terrain FindTerrain(Scene scene)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                UnityEngine.Terrain terrain = root.GetComponentInChildren<UnityEngine.Terrain>(true);

                if (terrain != null && terrain.terrainData != null)
                {
                    return terrain;
                }
            }

            return null;
        }

        /// <summary>
        /// The root PWB parents everything it paints to. PWB looks it up by name in the <i>active</i> scene,
        /// so the props scene is made active for the run — otherwise a later PWB stroke would start a second
        /// root in whichever scene happened to be active.
        /// </summary>
        private static Transform EnsurePwbRoot(Scene scene)
        {
            if (SceneManager.GetActiveScene() != scene)
            {
                SceneManager.SetActiveScene(scene);
            }

            Transform root = FindChild(null, OpeningPropsParams.k_PwbRootName, scene);

            if (root == null)
            {
                GameObject created = new GameObject(OpeningPropsParams.k_PwbRootName);
                SceneManager.MoveGameObjectToScene(created, scene);
                Undo.RegisterCreatedObjectUndo(created, "Build Opening Props");
                root = created.transform;
            }

            return root;
        }

        /// <summary>Empties and returns the <c>&lt;palette&gt;/PIN</c> parent of every pool.</summary>
        private static Dictionary<PropPool, Transform> ResetPoolParents(Transform root)
        {
            Dictionary<PropPool, Transform> parents = new Dictionary<PropPool, Transform>();

            foreach (PropPool pool in System.Enum.GetValues(typeof(PropPool)))
            {
                Transform palette = FindChild(root, OpeningPropsParams.PaletteName(pool), root.gameObject.scene);

                if (palette == null)
                {
                    palette = CreateChild(OpeningPropsParams.PaletteName(pool), root);
                }

                Transform tool = FindChild(palette, OpeningPropsParams.k_PwbToolName, root.gameObject.scene);

                if (tool != null)
                {
                    Undo.DestroyObjectImmediate(tool.gameObject);
                }

                parents[pool] = CreateChild(OpeningPropsParams.k_PwbToolName, palette);
            }

            return parents;
        }

        private static Transform CreateChild(string name, Transform parent)
        {
            GameObject created = new GameObject(name);
            created.transform.SetParent(parent, false);
            created.transform.localPosition = Vector3.zero;
            created.transform.localRotation = Quaternion.identity;
            created.transform.localScale = Vector3.one;
            Undo.RegisterCreatedObjectUndo(created, "Build Opening Props");
            return created.transform;
        }

        /// <summary>Direct child by name, or a scene root by name when <paramref name="parent"/> is null.</summary>
        private static Transform FindChild(Transform parent, string name, Scene scene)
        {
            if (parent != null)
            {
                return parent.Find(name);
            }

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == name)
                {
                    return root.transform;
                }
            }

            return null;
        }

        private static Dictionary<string, GameObject> LoadPrefabs(List<PropInstance> instances)
        {
            Dictionary<string, GameObject> prefabs = new Dictionary<string, GameObject>();
            bool complete = true;

            for (int i = 0; i < instances.Count; i++)
            {
                string key = instances[i].Prefab;

                if (prefabs.ContainsKey(key))
                {
                    continue;
                }

                string path = EnvironmentPrefabBuilder.PrefabPath(key);
                GameObject prefab = path == null ? null : AssetDatabase.LoadAssetAtPath<GameObject>(path);

                if (prefab == null)
                {
                    Debug.LogError($"OpeningPropsBuilder: prefab '{key}' is missing — run "
                        + "RootsDance/Environment/Build Environment Prefabs first.");
                    complete = false;
                    continue;
                }

                prefabs[key] = prefab;
            }

            return complete ? prefabs : null;
        }

        /// <summary>
        /// Height, normal and painted-layer lookups against one terrain, in world XZ. Also the
        /// <see cref="OpeningPropsLayout.IGroundFilter"/> the scatter runs through, so a patch that asks for
        /// 420 instances on the grass band gets 420 — the rejections happen while sampling, not afterwards.
        /// </summary>
        private sealed class TerrainSampler : OpeningPropsLayout.IGroundFilter
        {
            private readonly UnityEngine.Terrain m_terrain;
            private readonly Vector3 m_origin;
            private readonly Vector3 m_size;

            // The whole splat map is pulled once: GetAlphamaps allocates per call, and the band alone tests
            // thousands of candidates.
            private readonly float[,,] m_alphamaps;
            private readonly int m_alphamapWidth;
            private readonly int m_alphamapHeight;

            public TerrainSampler(UnityEngine.Terrain terrain)
            {
                m_terrain = terrain;
                m_origin = terrain.transform.position;
                m_size = terrain.terrainData.size;
                TerrainData data = terrain.terrainData;
                m_alphamapWidth = data.alphamapWidth;
                m_alphamapHeight = data.alphamapHeight;
                m_alphamaps = data.GetAlphamaps(0, 0, m_alphamapWidth, m_alphamapHeight);
            }

            public bool Accepts(Vector2 position, float maxSlopeDegrees, int layer, float minLayerWeight)
            {
                float height;
                Vector3 normal;

                if (!Sample(position, out height, out normal))
                {
                    return false;
                }

                if (Vector3.Angle(normal, Vector3.up) > maxSlopeDegrees)
                {
                    return false;
                }

                return layer < 0 || LayerWeight(position, layer) >= minLayerWeight;
            }

            /// <summary>False when the point is off the terrain.</summary>
            public bool Sample(Vector2 position, out float height, out Vector3 normal)
            {
                float u = (position.x - m_origin.x) / m_size.x;
                float v = (position.y - m_origin.z) / m_size.z;
                height = 0f;
                normal = Vector3.up;

                if (u < 0f || u > 1f || v < 0f || v > 1f)
                {
                    return false;
                }

                height = m_terrain.SampleHeight(new Vector3(position.x, 0f, position.y)) + m_origin.y;
                normal = m_terrain.terrainData.GetInterpolatedNormal(u, v);
                return true;
            }

            /// <summary>Weight of one painted terrain layer at a world XZ point, 0..1.</summary>
            public float LayerWeight(Vector2 position, int layer)
            {
                if (layer < 0 || layer >= m_alphamaps.GetLength(2))
                {
                    return 1f;
                }

                // Alphamaps are indexed [z, x, layer].
                int x = Mathf.Clamp(Mathf.RoundToInt((position.x - m_origin.x) / m_size.x
                    * (m_alphamapWidth - 1)), 0, m_alphamapWidth - 1);
                int z = Mathf.Clamp(Mathf.RoundToInt((position.y - m_origin.z) / m_size.z
                    * (m_alphamapHeight - 1)), 0, m_alphamapHeight - 1);

                return m_alphamaps[z, x, layer];
            }
        }
    }
}

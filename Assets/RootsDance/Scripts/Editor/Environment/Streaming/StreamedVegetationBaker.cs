using System;
using System.Collections.Generic;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using RootsDance.App;
using RootsDance.Editor.Terrain;
using RootsDance.Environment;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Turns the authored Chapter 00 vegetation groups in Main Environment into streamed content.
    /// The <c>C00V_Group_*</c> prefab instances the vegetation builder leaves under Prefab World
    /// Builder hold ~170k objects between them, and Unity activates a scene's objects in one frame:
    /// that frame measured 3-12 seconds in the Editor, and no async load moves it. This baker keeps
    /// the groups as the authoring source (their prefab assets are untouched) and derives from them:
    /// <list type="bullet">
    /// <item>one small prototype prefab per distinct (source prefab, materials, colliders) combination,</item>
    /// <item>a <see cref="StreamedPlacementSet"/> of every item's prototype, group and transform,</item>
    /// <item>a <see cref="StreamedPlacementSpawner"/> under the PWB root that spawns them over frames,</item>
    /// </list>
    /// then removes the group instances from the scene. Items that carry scripts (the scannable hero)
    /// are moved up to their PIN and stay in the scene: a placement cannot carry per-instance data.
    /// Re-running the vegetation builder recreates the groups; this runs again after it.
    /// </summary>
    public static class StreamedVegetationBaker
    {
        private const string k_LogPrefix = "StreamedVegetationBaker";
        private const string k_Menu = "RootsDance/Environment/Bake Streamed Chapter 00 Vegetation";
        private const string k_GroupPrefix = "C00V_Group_";
        private const string k_PwbRootName = "Prefab World Builder";
        private const string k_SpawnerName = "Streamed Vegetation";
        private const string k_PrototypeFolder = "Assets/RootsDance/Prefabs/Environment/Chapter00ZoneVegetation/Streamed";
        private const string k_SetFolder = "Assets/RootsDance/Data/Environment";
        private const string k_SetPath = k_SetFolder + "/Chapter00StreamedVegetation.asset";

        /// <summary>
        /// Where the player first sees the exterior: the greenhouse exit corridor. Only applied to a
        /// spawner that has no origin yet, so a hand-tuned value survives rebakes.
        /// </summary>
        private static readonly Vector3 s_DefaultPriorityOrigin = new Vector3(0f, 11f, 132f);

        private sealed class PrototypeRecord
        {
            public string Key;
            public string Name;
            public GameObject Prefab;
            public bool HasColliders;
            public int Index;
        }

        [MenuItem(k_Menu)]
        public static void BakeMenu()
        {
            Scene scene;

            if (!TerrainSceneUtility.TryOpenTargetScene(ScenePaths.k_MainEnvironment, k_LogPrefix, out scene))
            {
                return;
            }

            Bake(scene, saveScene: false);
        }

        /// <summary>Batch entry: bakes and saves Main Environment plus every generated asset.</summary>
        public static void BakeFromCommandLine()
        {
            Scene scene;

            if (!TerrainSceneUtility.TryOpenTargetScene(ScenePaths.k_MainEnvironment, k_LogPrefix, out scene))
            {
                throw new InvalidOperationException(k_LogPrefix + ": cannot open Main Environment.");
            }

            if (Bake(scene, saveScene: true) < 0)
            {
                throw new InvalidOperationException(k_LogPrefix + ": bake failed; see the Console.");
            }
        }

        /// <summary>
        /// Bakes every vegetation group currently instanced in <paramref name="scene"/>. Returns the
        /// number of streamed items, 0 when there was nothing to bake, -1 on failure. Prefab and set
        /// assets are always saved; the scene only when asked, so a menu run stays undoable-by-revert.
        /// </summary>
        public static int Bake(Scene scene, bool saveScene)
        {
            Transform pwb = TerrainSceneUtility.FindRoot(scene, k_PwbRootName);

            if (pwb == null)
            {
                Debug.LogError(k_LogPrefix + ": Main Environment has no '" + k_PwbRootName + "' root.");
                return -1;
            }

            List<Transform> groups = FindGroups(pwb);

            if (groups.Count == 0)
            {
                StreamedPlacementSpawner existing = pwb.GetComponentInChildren<StreamedPlacementSpawner>(true);
                Debug.Log(k_LogPrefix + ": no " + k_GroupPrefix + "* instances in the scene; "
                    + (existing != null ? "already baked, nothing to do." : "nothing to bake."));
                return 0;
            }

            foreach (Transform group in groups)
            {
                if (!PrefabUtility.IsAnyPrefabInstanceRoot(group.gameObject))
                {
                    Debug.LogError(k_LogPrefix + ": '" + group.name + "' is not a prefab instance root; run the "
                        + "vegetation builder first so the groups are connected to their prefabs.");
                    return -1;
                }
            }

            EnsureFolder(k_PrototypeFolder);
            EnsureFolder(k_SetFolder);

            Dictionary<string, PrototypeRecord> prototypes = new Dictionary<string, PrototypeRecord>();
            List<string> groupParentPaths = new List<string>();
            List<string> groupNames = new List<string>();
            List<int> prototypeIndices = new List<int>();
            List<int> groupIndices = new List<int>();
            List<Vector3> positions = new List<Vector3>();
            List<Quaternion> rotations = new List<Quaternion>();
            List<Vector3> scales = new List<Vector3>();
            int kept = 0;

            {
                for (int g = 0; g < groups.Count; g++)
                {
                    Transform group = groups[g];
                    int groupIndex = groupParentPaths.Count;
                    groupParentPaths.Add(RelativePath(pwb, group.parent));
                    groupNames.Add(group.name);

                    // Snapshot first: items with scripts are reparented out of the group as we go.
                    List<Transform> items = new List<Transform>(group.childCount);

                    foreach (Transform item in group)
                    {
                        items.Add(item);
                    }

                    for (int i = 0; i < items.Count; i++)
                    {
                        Transform item = items[i];

                        if (item.GetComponentInChildren<MonoBehaviour>(true) != null)
                        {
                            KeepInScene(item, group.parent);
                            kept++;
                            continue;
                        }

                        PrototypeRecord record = GetOrCreatePrototype(item, prototypes);
                        prototypeIndices.Add(record.Index);
                        groupIndices.Add(groupIndex);
                        positions.Add(item.position);
                        rotations.Add(item.rotation);
                        scales.Add(item.localScale);
                    }
                }
            }

            StreamedPlacementSet.Prototype[] table = new StreamedPlacementSet.Prototype[prototypes.Count];

            foreach (PrototypeRecord record in prototypes.Values)
            {
                table[record.Index] = new StreamedPlacementSet.Prototype { Prefab = record.Prefab, HasColliders = record.HasColliders };
            }

            List<Mesh> collisionMeshes = new List<Mesh>();
            List<bool> collisionConvex = new List<bool>();
            CollectCollisionMeshes(table, collisionMeshes, collisionConvex);

            StreamedPlacementSet set = AssetDatabase.LoadAssetAtPath<StreamedPlacementSet>(k_SetPath);

            if (set == null)
            {
                set = ScriptableObject.CreateInstance<StreamedPlacementSet>();
                AssetDatabase.CreateAsset(set, k_SetPath);
            }

            set.Populate(table, groupParentPaths.ToArray(), groupNames.ToArray(), prototypeIndices.ToArray(),
                groupIndices.ToArray(), positions.ToArray(), rotations.ToArray(), scales.ToArray(),
                collisionMeshes.ToArray(), collisionConvex.ToArray());
            EditorUtility.SetDirty(set);

            for (int g = 0; g < groups.Count; g++)
            {
                UnityEngine.Object.DestroyImmediate(groups[g].gameObject);
            }

            ConfigureSpawner(pwb, set);
            EditorSceneManager.MarkSceneDirty(scene);
            AssetDatabase.SaveAssets();

            // The scene's remaining colliders (buildings, fences) are what activation now cooks; give
            // the loader the list so it cooks them on worker threads during the preload instead.
            SceneCollisionPrebakeBaker.Bake(scene, SceneCollisionPrebakeBaker.k_MainEnvironmentAssetPath, set);

            if (saveScene && !EditorSceneManager.SaveScene(scene))
            {
                Debug.LogError(k_LogPrefix + ": failed to save '" + scene.path + "'.");
                return -1;
            }

            Debug.Log(k_LogPrefix + ": baked " + prototypeIndices.Count + " items from " + groups.Count
                + " groups into " + prototypes.Count + " prototypes (" + collisionMeshes.Count
                + " collision meshes); " + kept + " scripted item(s) kept in the scene."
                + (saveScene ? " Scene saved." : " Scene is dirty and has NOT been saved."));
            return prototypeIndices.Count;
        }

        /// <summary>
        /// A scripted item cannot be streamed (a placement carries no per-instance data) and cannot be
        /// moved out of its group either: a child of a prefab instance stays part of that instance
        /// whatever its parent is, and dies with the group. So it is copied — a plain, fully unpacked
        /// object under the group's PIN at the same world transform — and the original goes with the
        /// group. Every serialized field (scan target, report result, materials) survives the copy.
        /// </summary>
        private static void KeepInScene(Transform item, Transform parent)
        {
            GameObject copy = UnityEngine.Object.Instantiate(item.gameObject, parent);

            if (PrefabUtility.IsPartOfPrefabInstance(copy))
            {
                PrefabUtility.UnpackPrefabInstance(copy, PrefabUnpackMode.Completely, InteractionMode.AutomatedAction);
            }

            copy.name = item.name;
            copy.transform.SetPositionAndRotation(item.position, item.rotation);
            copy.transform.localScale = item.localScale;
        }

        /// <summary>Removes the spawner the bake installs; used by the vegetation builder's Clear.</summary>
        public static void ClearSpawner(Transform pwb)
        {
            if (pwb == null)
            {
                return;
            }

            Transform spawner = pwb.Find(k_SpawnerName);

            if (spawner != null)
            {
                Undo.DestroyObjectImmediate(spawner.gameObject);
            }
        }

        /// <summary>Items the current bake would spawn, for validation after the groups are gone.</summary>
        public static int CountStreamedItems(Transform pwb)
        {
            StreamedPlacementSpawner spawner = pwb == null ? null : pwb.GetComponentInChildren<StreamedPlacementSpawner>(true);

            if (spawner == null)
            {
                return 0;
            }

            SerializedObject serialized = new SerializedObject(spawner);
            StreamedPlacementSet set = serialized.FindProperty("m_set").objectReferenceValue as StreamedPlacementSet;
            return set == null ? 0 : set.ItemCount;
        }

        private static List<Transform> FindGroups(Transform pwb)
        {
            List<Transform> result = new List<Transform>();

            foreach (Transform t in pwb.GetComponentsInChildren<Transform>(true))
            {
                if (t != pwb && t.name.StartsWith(k_GroupPrefix, StringComparison.Ordinal))
                {
                    result.Add(t);
                }
            }

            return result;
        }

        private static PrototypeRecord GetOrCreatePrototype(Transform item, Dictionary<string, PrototypeRecord> prototypes)
        {
            string key = PrototypeKey(item);
            PrototypeRecord record;

            if (prototypes.TryGetValue(key, out record))
            {
                return record;
            }

            GameObject source = PrefabUtility.GetCorrespondingObjectFromSource(item.gameObject);
            string sourceName = source != null
                ? source.name
                : Regex.Replace(item.name, "^C00V_[^_]+_[^_]+_[0-9]+_", string.Empty);
            string name = Sanitize(sourceName) + "_" + ShortHash(key);
            string path = k_PrototypeFolder + "/" + name + ".prefab";
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(path);

            if (prefab == null)
            {
                prefab = SavePrototype(item, name, path);
            }

            record = new PrototypeRecord
            {
                Key = key,
                Name = name,
                Prefab = prefab,
                HasColliders = item.GetComponentInChildren<Collider>(true) != null,
                Index = prototypes.Count,
            };
            prototypes.Add(key, record);
            return record;
        }

        /// <summary>
        /// A plain copy of the item at the origin with unit scale: the item's own local scale is what
        /// the placement carries, so the prototype must not bake any of it in.
        /// </summary>
        private static GameObject SavePrototype(Transform item, string name, string path)
        {
            GameObject clone = UnityEngine.Object.Instantiate(item.gameObject);

            try
            {
                if (PrefabUtility.IsPartOfPrefabInstance(clone))
                {
                    PrefabUtility.UnpackPrefabInstance(clone, PrefabUnpackMode.Completely, InteractionMode.AutomatedAction);
                }

                clone.name = name;
                clone.transform.SetParent(null, false);
                clone.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
                clone.transform.localScale = Vector3.one;
                return PrefabUtility.SaveAsPrefabAsset(clone, path);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(clone);
            }
        }

        /// <summary>
        /// Everything that makes two items render or collide differently: source prefab, every
        /// renderer's materials, every mesh, collider shapes and LOD cut-offs, in hierarchy order.
        /// The root's name and transform are deliberately excluded — those are the placement.
        /// </summary>
        private static string PrototypeKey(Transform item)
        {
            StringBuilder key = new StringBuilder();
            GameObject source = PrefabUtility.GetCorrespondingObjectFromSource(item.gameObject);
            key.Append(source != null ? AssetDatabase.GetAssetPath(source) : "(none)");

            foreach (Transform t in item.GetComponentsInChildren<Transform>(true))
            {
                key.Append('|').Append(t.gameObject.activeSelf ? '+' : '-');

                if (t != item)
                {
                    // The root's name carries the builder's per-instance index; children's names are structure.
                    key.Append(t.name).Append(t.localPosition.ToString("F4")).Append(t.localRotation.ToString("F4")).Append(t.localScale.ToString("F4"));
                }

                foreach (Component c in t.GetComponents<Component>())
                {
                    if (c == null || c is Transform)
                    {
                        continue;
                    }

                    key.Append(',').Append(c.GetType().FullName);

                    MeshFilter filter = c as MeshFilter;
                    if (filter != null) key.Append('#').Append(AssetRef(filter.sharedMesh));

                    Renderer renderer = c as Renderer;
                    if (renderer != null)
                    {
                        foreach (Material m in renderer.sharedMaterials) key.Append('#').Append(AssetRef(m));
                        key.Append(renderer.shadowCastingMode).Append(t.gameObject.layer);
                    }

                    MeshCollider meshCollider = c as MeshCollider;
                    if (meshCollider != null) key.Append('#').Append(AssetRef(meshCollider.sharedMesh)).Append(meshCollider.convex);

                    Collider collider = c as Collider;
                    if (collider != null) key.Append(collider.isTrigger);

                    LODGroup lodGroup = c as LODGroup;
                    if (lodGroup != null)
                    {
                        foreach (LOD lod in lodGroup.GetLODs()) key.Append('%').Append(lod.screenRelativeTransitionHeight.ToString("F4"));
                    }
                }
            }

            return key.ToString();
        }

        private static string AssetRef(UnityEngine.Object asset)
        {
            if (asset == null)
            {
                return "null";
            }

            string guid;
            long localId;
            return AssetDatabase.TryGetGUIDAndLocalFileIdentifier(asset, out guid, out localId)
                ? guid + ":" + localId
                : asset.GetInstanceID().ToString();
        }

        private static void CollectCollisionMeshes(StreamedPlacementSet.Prototype[] table, List<Mesh> meshes, List<bool> convex)
        {
            HashSet<string> seen = new HashSet<string>();

            for (int i = 0; i < table.Length; i++)
            {
                if (table[i].Prefab == null)
                {
                    continue;
                }

                foreach (MeshCollider collider in table[i].Prefab.GetComponentsInChildren<MeshCollider>(true))
                {
                    if (collider.sharedMesh != null && seen.Add(collider.sharedMesh.GetInstanceID() + ":" + collider.convex))
                    {
                        meshes.Add(collider.sharedMesh);
                        convex.Add(collider.convex);
                    }
                }
            }
        }

        private static void ConfigureSpawner(Transform pwb, StreamedPlacementSet set)
        {
            Transform host = pwb.Find(k_SpawnerName);

            if (host == null)
            {
                host = new GameObject(k_SpawnerName).transform;
                host.SetParent(pwb, false);
            }

            StreamedPlacementSpawner spawner = host.GetComponent<StreamedPlacementSpawner>();

            if (spawner == null)
            {
                spawner = host.gameObject.AddComponent<StreamedPlacementSpawner>();
            }

            SerializedObject serialized = new SerializedObject(spawner);
            serialized.FindProperty("m_set").objectReferenceValue = set;
            serialized.FindProperty("m_groupRoot").objectReferenceValue = pwb;
            SerializedProperty origin = serialized.FindProperty("m_priorityOrigin");

            if (origin.vector3Value == Vector3.zero)
            {
                origin.vector3Value = s_DefaultPriorityOrigin;
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static string RelativePath(Transform root, Transform t)
        {
            List<string> parts = new List<string>();

            while (t != null && t != root)
            {
                parts.Insert(0, t.name);
                t = t.parent;
            }

            return string.Join("/", parts);
        }

        private static string ShortHash(string text)
        {
            using (SHA1 sha = SHA1.Create())
            {
                byte[] hash = sha.ComputeHash(Encoding.UTF8.GetBytes(text));
                return BitConverter.ToString(hash, 0, 4).Replace("-", string.Empty).ToLowerInvariant();
            }
        }

        private static string Sanitize(string name)
        {
            StringBuilder result = new StringBuilder(name.Length);

            foreach (char c in name)
            {
                result.Append(char.IsLetterOrDigit(c) || c == '_' || c == '-' ? c : '_');
            }

            return result.ToString();
        }

        private static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = Path.GetDirectoryName(path).Replace('\\', '/');
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, Path.GetFileName(path));
        }
    }
}

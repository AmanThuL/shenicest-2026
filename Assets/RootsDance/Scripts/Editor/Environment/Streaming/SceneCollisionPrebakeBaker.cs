using System.Collections.Generic;
using RootsDance.App;
using RootsDance.Editor.Terrain;
using RootsDance.Environment;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Writes the <see cref="CollisionPrebakeSet"/> for a scene: every mesh its MeshColliders use,
    /// plus the meshes of any streamed placement set the scene spawns. SceneLoader cooks these on
    /// worker threads while the scene is still deserializing, so activation never cooks on the main
    /// thread. Run again whenever colliders are added to or removed from the scene; the vegetation
    /// bake runs it for Main Environment itself.
    /// </summary>
    public static class SceneCollisionPrebakeBaker
    {
        private const string k_LogPrefix = "SceneCollisionPrebakeBaker";
        private const string k_Menu = "RootsDance/Environment/Bake Main Environment Collision Prebake";
        public const string k_MainEnvironmentAssetPath = "Assets/RootsDance/Data/Environment/Chapter00ExteriorCollisionPrebake.asset";

        [MenuItem(k_Menu)]
        public static void BakeMainEnvironmentMenu()
        {
            Scene scene;

            if (TerrainSceneUtility.TryOpenTargetScene(ScenePaths.k_MainEnvironment, k_LogPrefix, out scene))
            {
                BakeMainEnvironment(scene);
            }
        }

        /// <summary>Main Environment's set, including whatever its streamed vegetation spawner will spawn.</summary>
        public static CollisionPrebakeSet BakeMainEnvironment(Scene scene)
        {
            StreamedPlacementSpawner spawner = null;

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                spawner = root.GetComponentInChildren<StreamedPlacementSpawner>(true);

                if (spawner != null)
                {
                    break;
                }
            }

            StreamedPlacementSet streamed = spawner == null
                ? null
                : new SerializedObject(spawner).FindProperty("m_set").objectReferenceValue as StreamedPlacementSet;
            return Bake(scene, k_MainEnvironmentAssetPath, streamed);
        }

        public static CollisionPrebakeSet Bake(Scene scene, string assetPath, StreamedPlacementSet streamed)
        {
            List<Mesh> meshes = new List<Mesh>();
            List<bool> convex = new List<bool>();
            HashSet<string> seen = new HashSet<string>();

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                foreach (MeshCollider collider in root.GetComponentsInChildren<MeshCollider>(true))
                {
                    Add(collider.sharedMesh, collider.convex, meshes, convex, seen);
                }
            }

            int sceneCount = meshes.Count;

            if (streamed != null)
            {
                Mesh[] streamedMeshes = streamed.CollisionMeshes;
                bool[] streamedConvex = streamed.CollisionConvex;

                for (int i = 0; i < streamedMeshes.Length; i++)
                {
                    Add(streamedMeshes[i], streamedConvex[i], meshes, convex, seen);
                }
            }

            CollisionPrebakeSet set = AssetDatabase.LoadAssetAtPath<CollisionPrebakeSet>(assetPath);

            if (set == null)
            {
                string folder = System.IO.Path.GetDirectoryName(assetPath).Replace('\\', '/');

                if (!AssetDatabase.IsValidFolder(folder))
                {
                    AssetDatabase.CreateFolder(System.IO.Path.GetDirectoryName(folder).Replace('\\', '/'),
                        System.IO.Path.GetFileName(folder));
                }

                set = ScriptableObject.CreateInstance<CollisionPrebakeSet>();
                AssetDatabase.CreateAsset(set, assetPath);
            }

            set.Populate(meshes.ToArray(), convex.ToArray());
            EditorUtility.SetDirty(set);
            AssetDatabase.SaveAssets();
            Debug.Log(k_LogPrefix + ": " + scene.name + " -> " + meshes.Count + " collision meshes (" + sceneCount
                + " from the scene, " + (meshes.Count - sceneCount) + " from streamed content) in " + assetPath);
            return set;
        }

        private static void Add(Mesh mesh, bool isConvex, List<Mesh> meshes, List<bool> convex, HashSet<string> seen)
        {
            if (mesh != null && seen.Add(mesh.GetInstanceID() + ":" + isConvex))
            {
                meshes.Add(mesh);
                convex.Add(isConvex);
            }
        }
    }
}

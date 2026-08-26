using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// Scene and asset-folder plumbing shared by the terrain builders: opening the target scene
    /// without ever discarding someone's unsaved work, finding or creating the named scene roots and
    /// creating asset folders on demand. Every method takes a <c>logPrefix</c> or is silent, so the
    /// Console still names the builder that called it.
    /// </summary>
    public static class TerrainSceneUtility
    {
        /// <summary>
        /// Keeps the target scene when it is already active; otherwise opens it single — but refuses
        /// to do so while any open scene has unsaved changes, because that would throw them away.
        /// </summary>
        /// <param name="scenePath">Asset path of the scene the builder writes into.</param>
        /// <param name="logPrefix">Name of the calling builder, used as the Console message prefix.</param>
        /// <param name="scene">The opened (or already active) scene; invalid when this returns false.</param>
        /// <returns>True when the scene is open and safe to edit.</returns>
        public static bool TryOpenTargetScene(string scenePath, string logPrefix, out Scene scene)
        {
            scene = default(Scene);
            Scene active = SceneManager.GetActiveScene();

            if (active.path == scenePath)
            {
                scene = active;
                return true;
            }

            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene open = SceneManager.GetSceneAt(i);

                if (open.isDirty)
                {
                    Debug.LogError($"{logPrefix}: scene '{open.name}' has unsaved changes. "
                        + $"Save or discard them, then run the builder again ({scenePath} is not open).");
                    return false;
                }
            }

            if (!File.Exists(scenePath))
            {
                Debug.LogError($"{logPrefix}: target scene {scenePath} does not exist.");
                return false;
            }

            scene = EditorSceneManager.OpenScene(scenePath, OpenSceneMode.Single);
            return scene.IsValid();
        }

        /// <summary>Returns the scene root GameObject called <paramref name="name"/>, or null.</summary>
        /// <param name="scene">Scene to search.</param>
        /// <param name="name">Exact root GameObject name.</param>
        /// <returns>The root's transform, or null when the scene has no such root.</returns>
        public static Transform FindRoot(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == name)
                {
                    return roots[i].transform;
                }
            }

            return null;
        }

        /// <summary>Find-or-create the scene root called <paramref name="name"/>.</summary>
        /// <param name="scene">Scene the root belongs to.</param>
        /// <param name="name">Exact root GameObject name.</param>
        /// <returns>The existing or newly created root's transform.</returns>
        public static Transform EnsureRoot(Scene scene, string name)
        {
            Transform existing = FindRoot(scene, name);

            if (existing != null)
            {
                return existing;
            }

            GameObject created = new GameObject(name);
            MoveToScene(created, scene);
            Undo.RegisterCreatedObjectUndo(created, "Create " + name);
            return created.transform;
        }

        /// <summary>Moves <paramref name="target"/> into <paramref name="scene"/> when it is elsewhere.</summary>
        /// <param name="target">Root GameObject to move.</param>
        /// <param name="scene">Destination scene.</param>
        public static void MoveToScene(GameObject target, Scene scene)
        {
            if (target.scene != scene)
            {
                SceneManager.MoveGameObjectToScene(target, scene);
            }
        }

        /// <summary>Returns the folder that contains <paramref name="assetPath"/>, with forward slashes.</summary>
        /// <param name="assetPath">Asset path of a file or folder.</param>
        /// <returns>The parent folder's asset path.</returns>
        public static string ParentFolderOf(string assetPath)
        {
            return Path.GetDirectoryName(assetPath).Replace('\\', '/');
        }

        /// <summary>Creates <paramref name="path"/> and every missing folder above it.</summary>
        /// <param name="path">Asset path of the folder to create.</param>
        public static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = ParentFolderOf(path);
            string folderName = Path.GetFileName(path);

            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, folderName);
        }
    }
}

using System.IO;
using RootsDance.Environment;
using TheVisualEngine;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Creates the <c>TVEManager</c> prefab every level Environment scene drops in once. The Visual Engine
    /// materials read wind, tinting, season and wetness from <see cref="TVEManager.Instance"/>, so a scene
    /// without the manager renders them at their defaults and every TVE editor window refuses to open.
    /// Idempotent: an existing prefab is left untouched (its GUID is what scenes reference).
    /// </summary>
    public static class TveManagerPrefabBuilder
    {
        /// <summary>Asset path of the manager prefab.</summary>
        public const string k_PrefabPath = "Assets/RootsDance/Prefabs/Systems/TVEManager.prefab";

        // TVEManager renames its GameObject to this in OnEnable; naming the prefab root the same keeps the
        // hierarchy stable across Play mode.
        private const string k_RootName = "The Visual Engine";

        [MenuItem("RootsDance/Environment/Create TVE Manager Prefab")]
        public static void Create()
        {
            if (AssetDatabase.LoadAssetAtPath<GameObject>(k_PrefabPath) != null)
            {
                EnsureBinder();
                return;
            }

            string folder = Path.GetDirectoryName(k_PrefabPath).Replace('\\', '/');

            if (!AssetDatabase.IsValidFolder(folder))
            {
                AssetDatabase.CreateFolder(Path.GetDirectoryName(folder).Replace('\\', '/'), Path.GetFileName(folder));
            }

            GameObject root = new GameObject(k_RootName);

            try
            {
                root.AddComponent<TVEManager>();
                root.AddComponent<TveCameraBinder>();
                bool saved;
                PrefabUtility.SaveAsPrefabAsset(root, k_PrefabPath, out saved);

                if (!saved)
                {
                    Debug.LogError($"TveManagerPrefabBuilder: SaveAsPrefabAsset failed for '{k_PrefabPath}'.");
                    return;
                }

                AssetDatabase.SaveAssets();
                Debug.Log($"TveManagerPrefabBuilder: created '{k_PrefabPath}'.");
            }
            finally
            {
                Object.DestroyImmediate(root);
            }
        }

        /// <summary>
        /// Adds <see cref="TveCameraBinder"/> to an already-created prefab (the GUID scenes reference
        /// is preserved — the asset is edited in place). Idempotent.
        /// </summary>
        [MenuItem("RootsDance/Environment/Ensure TVE Camera Binder")]
        public static void EnsureBinder()
        {
            GameObject root = PrefabUtility.LoadPrefabContents(k_PrefabPath);

            if (root == null)
            {
                Debug.LogError($"TveManagerPrefabBuilder: '{k_PrefabPath}' missing; run Create first.");
                return;
            }

            try
            {
                if (root.GetComponent<TveCameraBinder>() != null)
                {
                    Debug.Log("TveManagerPrefabBuilder: binder already present; nothing to do.");
                    return;
                }

                root.AddComponent<TveCameraBinder>();
                PrefabUtility.SaveAsPrefabAsset(root, k_PrefabPath);
                AssetDatabase.SaveAssets();
                Debug.Log($"TveManagerPrefabBuilder: added TveCameraBinder to '{k_PrefabPath}'.");
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(root);
            }
        }
    }
}

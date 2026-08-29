using RootsDance.Player;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Applies the arms-view tuning that lives as scene overrides in PlayerTest_Gameplay onto the
    /// Player prefab itself, so every scene frames the arms and helmet the same way.
    /// </summary>
    /// <remarks>
    /// <para>
    /// The framing was tuned in PlayerTest and stayed there: the instance's ArmsViewOffset carried
    /// a 5.27 degree pitch, a (0.03, -0.3, 0.35) offset and the per-clip corrections as overrides,
    /// and Main ran on the prefab's untouched defaults - which is why the helmet's rim showed at
    /// the screen edge in one scene and not the other. ArmsViewOffset recomputes the arms-view
    /// transform from these fields every frame, so syncing raw transforms cannot fix it.
    /// </para>
    /// <para>
    /// Uses ApplyObjectOverride, so Unity itself rewrites scene-internal references into prefab
    /// ones. The Player root's transform is never applied - the spawn belongs to each scene.
    /// </para>
    /// Menu: RootsDance > Apply PlayerTest Arms Framing To Prefab.
    /// </remarks>
    public static class ArmsFramingApply
    {
        private const string k_Scene = "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity";
        private const string k_Player = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_PlayerName = "Player";

        [MenuItem("RootsDance/Apply PlayerTest Arms Framing To Prefab")]
        public static void Apply()
        {
            Scene scene = EditorSceneManager.OpenScene(k_Scene, OpenSceneMode.Single);
            GameObject player = Find(scene, k_PlayerName);

            if (player == null)
            {
                Debug.LogError($"ArmsFramingApply: no '{k_PlayerName}' in {k_Scene}.");
                return;
            }

            int applied = 0;

            // The tuned component itself.
            foreach (ArmsViewOffset view in player.GetComponentsInChildren<ArmsViewOffset>(true))
            {
                PrefabUtility.ApplyObjectOverride(view, k_Player, InteractionMode.AutomatedAction);
                Debug.Log($"ArmsFramingApply: applied ArmsViewOffset on '{view.name}'.");
                applied++;
            }

            // Every child transform the tuning touched - measured against the prefab rather than
            // listed by name, so a tweak on a nested helmet mesh is found without knowing it is
            // there. The root stays: its transform is the spawn.
            foreach (Transform child in player.GetComponentsInChildren<Transform>(true))
            {
                if (child == player.transform)
                {
                    continue;
                }

                Transform source = PrefabUtility.GetCorrespondingObjectFromSource(child);

                if (source == null)
                {
                    continue;
                }

                if (child.localPosition == source.localPosition
                    && child.localRotation == source.localRotation
                    && child.localScale == source.localScale)
                {
                    continue;
                }

                PrefabUtility.ApplyObjectOverride(child, k_Player, InteractionMode.AutomatedAction);
                Debug.Log($"ArmsFramingApply: applied transform on '{Path(player.transform, child)}'.");
                applied++;
            }

            AssetDatabase.SaveAssets();
            Debug.Log($"ArmsFramingApply: {applied} objects applied to {k_Player}.");
        }

        private static string Path(Transform root, Transform child)
        {
            string path = child.name;

            for (Transform t = child.parent; t != null && t != root; t = t.parent)
            {
                path = t.name + "/" + path;
            }

            return path;
        }

        private static GameObject Find(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == name)
                {
                    return root;
                }
            }

            return null;
        }
    }
}

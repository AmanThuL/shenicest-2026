using System.Collections.Generic;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Copies the Player's arm and hand offsets from PlayerTest_Gameplay onto Main_Gameplay.
    /// </summary>
    /// <remarks>
    /// <para>
    /// Both scenes drop the same Player prefab, and everything under it is positioned relative to
    /// the player - so those offsets have no business differing between scenes. They had drifted:
    /// Main was missing the z override on both hand sockets and the y on the left one, which sat
    /// the hands about 0.38 m high and 0.25 m back, and took the flashlight's beam anchor with
    /// them. PlayerTest is the tuned one, so it is the source.
    /// </para>
    /// <para>
    /// The spawn transform is deliberately not copied. The two scenes stand the player on
    /// different ground - 3.8 on Main's terrain, 0.1 on PlayerTest's flat floor - and that
    /// difference is the level, not a drift.
    /// </para>
    /// Menu: RootsDance > Sync Player Arm Offsets To Main.
    /// </remarks>
    public static class PlayerArmsOffsetSync
    {
        private const string k_Source = "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity";
        private const string k_Target = "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";
        private const string k_PlayerName = "Player";

        /// <summary>The player's own transform, which each scene sets to its own ground.</summary>
        private const string k_SpawnRoot = "Player";

        [MenuItem("RootsDance/Sync Player Arm Offsets To Main")]
        public static void Sync()
        {
            Dictionary<string, Pose> tuned = Read(k_Source);

            if (tuned.Count == 0)
            {
                Debug.LogError($"PlayerArmsOffsetSync: no Player found in {k_Source}.");
                return;
            }

            Scene scene = EditorSceneManager.OpenScene(k_Target, OpenSceneMode.Single);
            GameObject player = Find(scene, k_PlayerName);

            if (player == null)
            {
                Debug.LogError($"PlayerArmsOffsetSync: no '{k_PlayerName}' in {k_Target}.");
                return;
            }

            int changed = 0;

            foreach (Transform child in player.GetComponentsInChildren<Transform>(true))
            {
                string path = Path(player.transform, child);

                if (path == k_SpawnRoot || !tuned.TryGetValue(path, out Pose pose))
                {
                    continue;
                }

                if (child.localPosition == pose.position && child.localRotation == pose.rotation)
                {
                    continue;
                }

                Debug.Log($"[{path}] {child.localPosition:F3} -> {pose.position:F3}");
                child.localPosition = pose.position;
                child.localRotation = pose.rotation;
                changed++;
            }

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);

            Debug.Log($"PlayerArmsOffsetSync: aligned {changed} transforms with {k_Source}.");
        }

        /// <summary>Every transform under the Player in the tuned scene, by path.</summary>
        private static Dictionary<string, Pose> Read(string scenePath)
        {
            Scene scene = EditorSceneManager.OpenScene(scenePath, OpenSceneMode.Single);
            GameObject player = Find(scene, k_PlayerName);
            Dictionary<string, Pose> poses = new Dictionary<string, Pose>();

            if (player == null)
            {
                return poses;
            }

            foreach (Transform child in player.GetComponentsInChildren<Transform>(true))
            {
                poses[Path(player.transform, child)] =
                    new Pose(child.localPosition, child.localRotation);
            }

            return poses;
        }

        /// <summary>Path from the player root, so the two scenes are matched by structure.</summary>
        private static string Path(Transform root, Transform child)
        {
            string path = child.name;

            for (Transform t = child.parent; t != null && t != root.parent; t = t.parent)
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

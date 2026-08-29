using UnityEditor;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Raises the Player's <c>Head</c> to a human eye height above the feet.
    /// </summary>
    /// <remarks>
    /// <para>
    /// The CharacterController is 1.8 m tall with its centre on the Player origin, so the capsule
    /// spans 0.9 m either side and the origin sits at chest height. <c>Head</c> was authored at
    /// local zero — the eye exactly on the origin, 0.9 m off the ground, waist height for the body
    /// it is in. Everything the world's scale is judged against hangs off that eye, so the whole
    /// level read almost twice its size.
    /// </para>
    /// <para>
    /// The target is 1.62 m above the feet (0.9 of body height, the usual figure), which is +0.72
    /// on Head's local Y. One prefab edit fixes every scene: no scene overrides Head, the arms rig
    /// and both hand sockets are Head's children so the tuned framing rides along, and the view
    /// bob rebases from the authored position at Awake.
    /// </para>
    /// Menu: RootsDance > Fix Player Eye Height.
    /// </remarks>
    public static class PlayerEyeHeightFix
    {
        private const string k_Player = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_HeadName = "Head";

        /// <summary>Eye height above the capsule centre: 1.62 m over the feet, minus the 0.9 rise.</summary>
        private const float k_HeadLocalY = 0.72f;

        [MenuItem("RootsDance/Fix Player Eye Height")]
        public static void Fix()
        {
            GameObject root = PrefabUtility.LoadPrefabContents(k_Player);

            if (root == null)
            {
                Debug.LogError($"PlayerEyeHeightFix: could not open {k_Player}.");
                return;
            }

            try
            {
                Transform head = root.transform.Find(k_HeadName);

                if (head == null)
                {
                    Debug.LogError($"PlayerEyeHeightFix: no '{k_HeadName}' under the Player root.");
                    return;
                }

                Vector3 position = head.localPosition;
                position.y = k_HeadLocalY;
                head.localPosition = position;

                PrefabUtility.SaveAsPrefabAsset(root, k_Player);
                AssetDatabase.SaveAssets();

                Debug.Log($"PlayerEyeHeightFix: Head local Y -> {k_HeadLocalY} "
                    + "(eye 1.62 m above the feet).");
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(root);
            }
        }
    }
}

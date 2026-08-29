using RootsDance.Player;
using RootsDance.Player.Arms;
using UnityEditor;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Points the flashlight's beam anchor at the right hand socket on the Player prefab.
    /// </summary>
    /// <remarks>
    /// This is wiring, not tuning: the anchor is the one reference that turns an eye-mounted torch
    /// into a carried one, and it has to name a specific socket in a specific prefab. Doing it here
    /// rather than by hand keeps it reproducible and keeps the prefab YAML out of a text editor.
    /// <para>
    /// The hold socket is deliberately left alone. Nothing in the game hands the torch to a hand
    /// yet, so wiring it would put the flashlight permanently out.
    /// </para>
    /// Menu: RootsDance > Wire Flashlight To Right Hand.
    /// </remarks>
    public static class FlashlightRigWiring
    {
        private const string k_Player = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_AnchorField = "m_beamAnchor";

        [MenuItem("RootsDance/Wire Flashlight To Right Hand")]
        public static void Wire()
        {
            GameObject root = PrefabUtility.LoadPrefabContents(k_Player);

            if (root == null)
            {
                Debug.LogError($"FlashlightRigWiring: could not open {k_Player}.");
                return;
            }

            try
            {
                FlashlightController controller = root.GetComponentInChildren<FlashlightController>(true);

                if (controller == null)
                {
                    Debug.LogError("FlashlightRigWiring: no FlashlightController on the Player.");
                    return;
                }

                HandSocket socket = FindRightHand(root);

                if (socket == null)
                {
                    Debug.LogError("FlashlightRigWiring: no right HandSocket on the Player.");
                    return;
                }

                SerializedObject serialized = new SerializedObject(controller);
                SerializedProperty anchor = serialized.FindProperty(k_AnchorField);

                if (anchor == null)
                {
                    Debug.LogError($"FlashlightRigWiring: FlashlightController has no "
                        + $"'{k_AnchorField}' field.");
                    return;
                }

                anchor.objectReferenceValue = socket.transform;
                serialized.ApplyModifiedPropertiesWithoutUndo();

                PrefabUtility.SaveAsPrefabAsset(root, k_Player);
                AssetDatabase.SaveAssets();

                Debug.Log($"FlashlightRigWiring: beam anchor -> '{socket.name}'. The torch now "
                    + "emits from the right hand.");
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(root);
            }
        }

        private static HandSocket FindRightHand(GameObject root)
        {
            foreach (HandSocket socket in root.GetComponentsInChildren<HandSocket>(true))
            {
                if (socket.Hand == HandSide.Right)
                {
                    return socket;
                }
            }

            return null;
        }
    }
}

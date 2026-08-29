using System.Collections.Generic;
using System.IO;
using RootsDance.Data;
using RootsDance.Events;
using RootsDance.Interaction;
using RootsDance.Player;
using RootsDance.Player.Arms;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Turns the torches lying around Main_Environment_2 into things a hand can actually pick up,
    /// and wires the player to offer them.
    /// </summary>
    /// <remarks>
    /// <para>
    /// The torches went into the scene as bare FBX instances, which carry a mesh and nothing else.
    /// A pickup needs physics to land on the floor, a grip so the hand holds it by the barrel, and
    /// a registration so the proximity offer can see it — five copies of that is a prefab, per the
    /// project's own rule that anything placed twice is one. This builds that prefab and swaps the
    /// bare instances for it, keeping every transform exactly where it was placed by hand.
    /// </para>
    /// Idempotent: run it again after moving a torch and only the swap is redone.
    /// Menu: RootsDance > Build Flashlight Pickups.
    /// </remarks>
    public static class FlashlightPickupBuilder
    {
        private const string k_Scene = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_2.unity";
        private const string k_Model = "Assets/RootsDance/Meshes/Props/Flashlight.fbx";
        private const string k_PrefabDir = "Assets/RootsDance/Prefabs/Props";
        private const string k_Prefab = "Assets/RootsDance/Prefabs/Props/FlashlightPickup.prefab";
        private const string k_Player = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_Prompt = "Assets/RootsDance/Data/Events/InteractionPrompt.asset";

        private const string k_DisplayName = "手电筒";

        /// <summary>Kilograms. Heavy enough to stay put, light enough to be knocked about.</summary>
        private const float k_Mass = 0.6f;

        [MenuItem("RootsDance/Build Flashlight Pickups")]
        public static void Build()
        {
            GameObject prefab = BuildPrefab();

            if (prefab == null)
            {
                return;
            }

            SwapInScene(prefab);
            WirePlayer();

            Debug.Log("FlashlightPickupBuilder: done.");
        }

        /// <summary>The pickup prefab: the model, physics, a grip and a registration.</summary>
        private static GameObject BuildPrefab()
        {
            GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(k_Model);

            if (model == null)
            {
                Debug.LogError($"FlashlightPickupBuilder: '{k_Model}' did not import.");
                return null;
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(model);
            instance.name = "FlashlightPickup";

            try
            {
                Bounds local = Measure(instance);

                // A capsule would hug the barrel better, but a box from the measured bounds needs
                // no guess about which local axis the torch runs along.
                BoxCollider collider = instance.AddComponent<BoxCollider>();
                collider.center = local.center;
                collider.size = local.size;

                Rigidbody body = instance.AddComponent<Rigidbody>();
                body.mass = k_Mass;

                CarriedItem item = instance.AddComponent<CarriedItem>();
                SerializedObject serializedItem = new SerializedObject(item);
                serializedItem.FindProperty("m_hand").enumValueIndex = (int)HandSide.Right;
                serializedItem.FindProperty("m_kind").enumValueIndex = (int)CarriedKind.Torch;
                serializedItem.FindProperty("m_body").objectReferenceValue = body;

                SerializedProperty colliders = serializedItem.FindProperty("m_colliders");
                colliders.arraySize = 1;
                colliders.GetArrayElementAtIndex(0).objectReferenceValue = collider;
                serializedItem.ApplyModifiedPropertiesWithoutUndo();

                GroundPickup pickup = instance.AddComponent<GroundPickup>();
                SerializedObject serializedPickup = new SerializedObject(pickup);
                serializedPickup.FindProperty("m_displayName").stringValue = k_DisplayName;
                serializedPickup.ApplyModifiedPropertiesWithoutUndo();

                Directory.CreateDirectory(k_PrefabDir);
                GameObject saved = PrefabUtility.SaveAsPrefabAsset(instance, k_Prefab);
                AssetDatabase.SaveAssets();

                Debug.Log($"FlashlightPickupBuilder: prefab at {k_Prefab}, collider {local.size:F3}.");

                return saved;
            }
            finally
            {
                Object.DestroyImmediate(instance);
            }
        }

        /// <summary>
        /// Replaces every bare torch in the scene with the pickup prefab, at the same pose. The
        /// bare ones are recognised by their source model rather than by name, so a renamed torch
        /// is still swapped and a pickup already swapped is left alone.
        /// </summary>
        private static void SwapInScene(GameObject prefab)
        {
            Scene scene = EditorSceneManager.OpenScene(k_Scene, OpenSceneMode.Single);
            GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(k_Model);
            List<GameObject> stale = new List<GameObject>();

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                Object source = PrefabUtility.GetCorrespondingObjectFromOriginalSource(root);

                if (source == model)
                {
                    stale.Add(root);
                }
            }

            foreach (GameObject old in stale)
            {
                Transform t = old.transform;
                GameObject swapped = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
                swapped.name = old.name;
                swapped.transform.SetPositionAndRotation(t.position, t.rotation);
                swapped.transform.localScale = t.localScale;
                swapped.transform.SetSiblingIndex(t.GetSiblingIndex());
                Object.DestroyImmediate(old);
            }

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            AssetDatabase.SaveAssets();

            Debug.Log($"FlashlightPickupBuilder: swapped {stale.Count} bare torches for pickups.");
        }

        /// <summary>Gives the player the proximity offer, and makes the beam need a torch in hand.</summary>
        private static void WirePlayer()
        {
            GameObject root = PrefabUtility.LoadPrefabContents(k_Player);

            if (root == null)
            {
                Debug.LogError($"FlashlightPickupBuilder: could not open {k_Player}.");
                return;
            }

            try
            {
                HandSocket socket = RightHand(root);

                if (socket == null)
                {
                    Debug.LogError("FlashlightPickupBuilder: no right HandSocket on the Player.");
                    return;
                }

                PickupProximityTrigger trigger = root.GetComponentInChildren<PickupProximityTrigger>(true);

                if (trigger == null)
                {
                    trigger = root.AddComponent<PickupProximityTrigger>();
                }

                SerializedObject serialized = new SerializedObject(trigger);
                serialized.FindProperty("m_socket").objectReferenceValue = socket;
                serialized.FindProperty("m_player").objectReferenceValue = root.transform;
                serialized.FindProperty("m_input").objectReferenceValue =
                    root.GetComponentInChildren<PlayerInputReader>(true);
                serialized.FindProperty("m_promptChanged").objectReferenceValue =
                    AssetDatabase.LoadAssetAtPath<StringEventChannelSO>(k_Prompt);
                serialized.ApplyModifiedPropertiesWithoutUndo();

                FlashlightController controller = root.GetComponentInChildren<FlashlightController>(true);

                if (controller != null)
                {
                    SerializedObject light = new SerializedObject(controller);
                    light.FindProperty("m_holdSocket").objectReferenceValue = socket;
                    light.ApplyModifiedPropertiesWithoutUndo();
                }

                PrefabUtility.SaveAsPrefabAsset(root, k_Player);
                AssetDatabase.SaveAssets();

                Debug.Log("FlashlightPickupBuilder: player offers pickups; the beam now needs a "
                    + "torch in the right hand.");
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(root);
            }
        }

        private static HandSocket RightHand(GameObject root)
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

        private static Bounds Measure(GameObject instance)
        {
            Bounds bounds = new Bounds();
            bool first = true;

            foreach (MeshFilter filter in instance.GetComponentsInChildren<MeshFilter>())
            {
                if (filter.sharedMesh == null)
                {
                    continue;
                }

                Bounds local = filter.sharedMesh.bounds;
                Vector3 centre = instance.transform.InverseTransformPoint(
                    filter.transform.TransformPoint(local.center));
                Vector3 size = Vector3.Scale(local.size, filter.transform.lossyScale);
                Bounds mapped = new Bounds(centre, size);

                if (first)
                {
                    bounds = mapped;
                    first = false;
                }
                else
                {
                    bounds.Encapsulate(mapped);
                }
            }

            return bounds;
        }
    }
}

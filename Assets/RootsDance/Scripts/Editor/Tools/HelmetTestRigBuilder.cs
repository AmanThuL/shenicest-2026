using RootsDance.Player;
using UnityEditor;
using UnityEditor.Animations;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Wires the first-person arms rig into PlayerTest_Gameplay so the helmet-removal clip can be
    /// judged in Play mode (hotkey H via <see cref="HelmetDebugTrigger"/>). Idempotent: running it
    /// again replaces the previous rig. Saves the gameplay scene, because unsaved scene edits are
    /// discarded by a Play-mode round trip.
    /// Menu: RootsDance > Build Helmet Test Rig.
    /// </summary>
    public static class HelmetTestRigBuilder
    {
        private const string k_EnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Environment.unity";
        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity";
        private const string k_ArmsFbx = "Assets/RootsDance/Meshes/Characters/Arms.fbx";
        private const string k_Controller = "Assets/RootsDance/Animations/Controllers/PlayerArms.controller";
        private const string k_HelmetMaterial = "Assets/RootsDance/Materials/HelmetPlaceholder.mat";
        private const string k_ArmsObjectName = "Arms";
        private const string k_StateName = "HelmetOff";

        /// <summary>The rig looks down -Z once Unity has converted it; yaw it to face the camera.</summary>
        private const float k_RigYaw = 180f;

        [MenuItem("RootsDance/Build Helmet Test Rig")]
        private static void Build()
        {
            GameObject fbx = AssetDatabase.LoadAssetAtPath<GameObject>(k_ArmsFbx);

            if (fbx == null)
            {
                Debug.LogError($"HelmetTestRigBuilder: {k_ArmsFbx} not found. Export it from Blender first.");
                return;
            }

            Scene gameplay = OpenLevel();
            Transform head = FindPlayerHead(gameplay);

            if (head == null)
            {
                return;
            }

            Transform existing = head.Find(k_ArmsObjectName);

            if (existing != null)
            {
                Object.DestroyImmediate(existing.gameObject);
            }

            GameObject arms = (GameObject)PrefabUtility.InstantiatePrefab(fbx, gameplay);
            arms.name = k_ArmsObjectName;
            arms.transform.SetParent(head, false);
            arms.transform.localScale = Vector3.one;
            arms.transform.localRotation = Quaternion.Euler(0f, k_RigYaw, 0f);
            AnchorByCameraBone(arms.transform);

            ConfigureAnimator(arms);
            AnimationClip clip = LoadClip();
            Transform helmet = FindDeep(arms.transform, "Helmet_Placeholder");
            AssignHelmetMaterial(helmet);

            HelmetAnimatorView view = arms.AddComponent<HelmetAnimatorView>();
            SerializedObject serializedView = new SerializedObject(view);
            serializedView.FindProperty("m_stateName").stringValue = k_StateName;
            serializedView.FindProperty("m_removeClip").objectReferenceValue = clip;
            serializedView.FindProperty("m_helmetRenderer").objectReferenceValue =
                helmet == null ? null : helmet.GetComponent<Renderer>();
            serializedView.ApplyModifiedPropertiesWithoutUndo();

            HelmetDebugTrigger trigger = arms.AddComponent<HelmetDebugTrigger>();
            SerializedObject serializedTrigger = new SerializedObject(trigger);
            serializedTrigger.FindProperty("m_viewBehaviour").objectReferenceValue = view;
            serializedTrigger.ApplyModifiedPropertiesWithoutUndo();

            LinkHelmetController(head, view);

            EditorSceneManager.MarkSceneDirty(gameplay);
            EditorSceneManager.SaveScene(gameplay);

            Scene environment = EditorSceneManager.GetSceneByPath(k_EnvironmentPath);

            if (environment.IsValid() && environment.isLoaded)
            {
                EditorSceneManager.SetActiveScene(environment);
            }

            Debug.Log($"HelmetTestRigBuilder: arms wired under {head.name} and {k_GameplayPath} saved. "
                + "Press Play and hit H to run the removal.");
        }

        private static Scene OpenLevel()
        {
            Scene environment = EditorSceneManager.GetSceneByPath(k_EnvironmentPath);

            if (!environment.isLoaded)
            {
                environment = EditorSceneManager.OpenScene(k_EnvironmentPath, OpenSceneMode.Single);
            }

            Scene gameplay = EditorSceneManager.GetSceneByPath(k_GameplayPath);

            if (!gameplay.isLoaded)
            {
                gameplay = EditorSceneManager.OpenScene(k_GameplayPath, OpenSceneMode.Additive);
            }

            return gameplay;
        }

        private static Transform FindPlayerHead(Scene gameplay)
        {
            foreach (GameObject root in gameplay.GetRootGameObjects())
            {
                if (root.name != "Player")
                {
                    continue;
                }

                // The playtest player ships with a "Head" child; older builds used "m_head".
                Transform head = root.transform.Find("Head");
                return head == null ? root.transform.Find("m_head") : head;
            }

            Debug.LogError($"HelmetTestRigBuilder: no 'Player' root in {k_GameplayPath}. "
                + "Run RootsDance > Build Player Playtest Level first.");
            return null;
        }

        /// <summary>
        /// Puts the rig's own "camera" bone on the player's head pivot, so the arms sit exactly where
        /// they were framed in Blender. That bone carries no keys in this clip, so the offset is constant.
        /// </summary>
        private static void AnchorByCameraBone(Transform arms)
        {
            Transform cameraBone = FindDeep(arms, "camera");

            if (cameraBone == null)
            {
                Debug.LogWarning("HelmetTestRigBuilder: no 'camera' bone in the rig; leaving the arms at the head pivot.");
                return;
            }

            arms.localPosition = Vector3.zero;
            arms.localPosition = -arms.InverseTransformPoint(cameraBone.position);
        }

        private static void ConfigureAnimator(GameObject arms)
        {
            Animator animator = arms.GetComponent<Animator>();

            if (animator == null)
            {
                animator = arms.AddComponent<Animator>();
            }

            animator.runtimeAnimatorController =
                AssetDatabase.LoadAssetAtPath<AnimatorController>(k_Controller);
            animator.applyRootMotion = false;
            animator.cullingMode = AnimatorCullingMode.AlwaysAnimate;

            foreach (Object asset in AssetDatabase.LoadAllAssetsAtPath(k_ArmsFbx))
            {
                Avatar avatar = asset as Avatar;

                if (avatar != null)
                {
                    animator.avatar = avatar;
                }
            }

            if (animator.runtimeAnimatorController == null)
            {
                Debug.LogWarning($"HelmetTestRigBuilder: {k_Controller} missing; the rig will not animate.");
            }
        }

        private static AnimationClip LoadClip()
        {
            foreach (Object asset in AssetDatabase.LoadAllAssetsAtPath(k_ArmsFbx))
            {
                AnimationClip clip = asset as AnimationClip;

                if (clip != null && !clip.name.StartsWith("__preview__"))
                {
                    return clip;
                }
            }

            return null;
        }

        /// <summary>The helmet mesh has no material slot in the .blend, so it would render magenta.</summary>
        private static void AssignHelmetMaterial(Transform helmet)
        {
            if (helmet == null)
            {
                return;
            }

            Renderer renderer = helmet.GetComponent<Renderer>();
            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_HelmetMaterial);

            if (renderer != null && material != null)
            {
                renderer.sharedMaterial = material;
            }
        }

        /// <summary>Points the shipping gameplay path (flag + Interact) at the same view.</summary>
        private static void LinkHelmetController(Transform head, HelmetAnimatorView view)
        {
            HelmetController controller = head.GetComponentInParent<HelmetController>();

            if (controller == null)
            {
                return;
            }

            SerializedObject serialized = new SerializedObject(controller);
            SerializedProperty property = serialized.FindProperty("m_viewBehaviour");

            if (property != null)
            {
                property.objectReferenceValue = view;
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }
        }

        private static Transform FindDeep(Transform parent, string name)
        {
            if (parent.name == name)
            {
                return parent;
            }

            foreach (Transform child in parent)
            {
                Transform found = FindDeep(child, name);

                if (found != null)
                {
                    return found;
                }
            }

            return null;
        }
    }
}

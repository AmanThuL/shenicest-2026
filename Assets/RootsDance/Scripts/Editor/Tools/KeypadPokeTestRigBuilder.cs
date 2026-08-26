using RootsDance.Player;
using UnityEditor;
using UnityEditor.Animations;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Adds the keypad-poke clip to the arms rig already wired into PlayerTest_Gameplay by
    /// <see cref="HelmetTestRigBuilder"/>, so it can be judged in Play mode (hotkey P via
    /// <see cref="ArmsClipDebugTrigger"/>). Idempotent: running it again refreshes the state, the
    /// key binding and the per-clip framing table.
    /// Menu: RootsDance > Build Keypad Poke Test Rig.
    /// </summary>
    public static class KeypadPokeTestRigBuilder
    {
        private const string k_EnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Environment.unity";
        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity";
        private const string k_Fbx = "Assets/RootsDance/Meshes/Characters/Arms_KeypadPoke.fbx";
        private const string k_Controller =
            "Assets/RootsDance/Animations/Controllers/PlayerArms.controller";
        private const string k_ArmsObjectName = "Arms";
        private const string k_StateName = "KeypadPoke";
        private const Key k_Key = Key.P;

        [MenuItem("RootsDance/Build Keypad Poke Test Rig")]
        private static void Build()
        {
            AnimationClip clip = LoadClip();

            if (clip == null)
            {
                Debug.LogError($"KeypadPokeTestRigBuilder: no clip in {k_Fbx}. Export it from Blender first.");
                return;
            }

            Scene gameplay = OpenLevel();
            Transform arms = FindArms(gameplay);

            if (arms == null)
            {
                Debug.LogError("KeypadPokeTestRigBuilder: no 'Arms' object in the level. "
                    + "Run RootsDance > Build Helmet Test Rig first.");
                return;
            }

            if (arms.GetComponent<Animator>() == null)
            {
                Debug.LogError("KeypadPokeTestRigBuilder: the Arms object has no Animator.");
                return;
            }

            AddState(clip);
            BindKey(arms);
            ArmsFramingBuilder.Refresh(arms);

            EditorSceneManager.MarkSceneDirty(gameplay);
            EditorSceneManager.SaveScene(gameplay);

            Debug.Log($"KeypadPokeTestRigBuilder: {k_StateName} wired. Press Play and hit {k_Key}. "
                + "Per-clip framing lives in ArmsViewOffset > Clips on the Arms object.");
        }

        private static void BindKey(Transform arms)
        {
            ArmsClipDebugTrigger trigger = arms.GetComponent<ArmsClipDebugTrigger>();

            if (trigger == null)
            {
                trigger = arms.gameObject.AddComponent<ArmsClipDebugTrigger>();
            }

            for (int i = 0; i < trigger.Bindings.Count; i++)
            {
                if (trigger.Bindings[i].m_stateName == k_StateName)
                {
                    return;
                }
            }

            ArmsClipDebugTrigger.Binding binding = new ArmsClipDebugTrigger.Binding();
            binding.m_key = k_Key;
            binding.m_stateName = k_StateName;
            trigger.Bindings.Add(binding);
            EditorUtility.SetDirty(trigger);
        }

        private static void AddState(AnimationClip clip)
        {
            AnimatorController controller =
                AssetDatabase.LoadAssetAtPath<AnimatorController>(k_Controller);

            if (controller == null)
            {
                Debug.LogError($"KeypadPokeTestRigBuilder: {k_Controller} not found.");
                return;
            }

            AnimatorStateMachine machine = controller.layers[0].stateMachine;

            foreach (ChildAnimatorState child in machine.states)
            {
                if (child.state.name == k_StateName)
                {
                    child.state.motion = clip;
                    EditorUtility.SetDirty(controller);
                    AssetDatabase.SaveAssets();
                    return;
                }
            }

            AnimatorState state = machine.AddState(k_StateName);
            state.motion = clip;
            state.writeDefaultValues = true;
            EditorUtility.SetDirty(controller);
            AssetDatabase.SaveAssets();
        }

        private static AnimationClip LoadClip()
        {
            foreach (Object asset in AssetDatabase.LoadAllAssetsAtPath(k_Fbx))
            {
                AnimationClip clip = asset as AnimationClip;

                if (clip != null && !clip.name.StartsWith("__preview__"))
                {
                    return clip;
                }
            }

            return null;
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

        private static Transform FindArms(Scene gameplay)
        {
            foreach (GameObject root in gameplay.GetRootGameObjects())
            {
                Transform arms = FindDeep(root.transform, k_ArmsObjectName);

                if (arms != null)
                {
                    return arms;
                }
            }

            return null;
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

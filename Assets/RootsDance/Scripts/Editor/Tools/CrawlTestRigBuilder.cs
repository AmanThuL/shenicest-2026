using RootsDance.Player;
using UnityEditor;
using UnityEditor.Animations;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Adds the crawl cycle to the arms rig already wired into PlayerTest_Gameplay by
    /// <see cref="HelmetTestRigBuilder"/>, so it can be judged in Play mode (hotkey C via
    /// <see cref="CrawlDebugTrigger"/>). Idempotent: running it again refreshes the state,
    /// the components and the per-clip framing table.
    /// Menu: RootsDance > Build Crawl Test Rig.
    /// </summary>
    public static class CrawlTestRigBuilder
    {
        private const string k_EnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Environment.unity";
        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity";
        private const string k_CrawlFbx = "Assets/RootsDance/Meshes/Characters/Arms_Crawl.fbx";
        private const string k_Controller = "Assets/RootsDance/Animations/Controllers/PlayerArms.controller";
        private const string k_ArmsObjectName = "Arms";
        private const string k_StateName = "Crawl";

        [MenuItem("RootsDance/Build Crawl Test Rig")]
        public static void Build()
        {
            AnimationClip clip = LoadCrawlClip();

            if (clip == null)
            {
                Debug.LogError($"CrawlTestRigBuilder: no clip in {k_CrawlFbx}. Export it from Blender first.");
                return;
            }

            Scene gameplay = OpenLevel();
            Transform arms = FindArms(gameplay);

            if (arms == null)
            {
                return;
            }

            AddCrawlState(clip);

            Animator animator = arms.GetComponent<Animator>();

            if (animator == null)
            {
                Debug.LogError("CrawlTestRigBuilder: the Arms object has no Animator.");
                return;
            }

            CrawlDebugTrigger trigger = arms.GetComponent<CrawlDebugTrigger>();

            if (trigger == null)
            {
                trigger = arms.gameObject.AddComponent<CrawlDebugTrigger>();
            }

            SerializedObject serializedTrigger = new SerializedObject(trigger);
            serializedTrigger.FindProperty("m_crawlState").stringValue = k_StateName;
            serializedTrigger.ApplyModifiedPropertiesWithoutUndo();

            ArmsFramingBuilder.Refresh(arms);

            EditorSceneManager.MarkSceneDirty(gameplay);
            EditorSceneManager.SaveScene(gameplay);

            Debug.Log("CrawlTestRigBuilder: crawl wired. Press Play and hit C to toggle it. "
                + "Per-clip framing lives in ArmsViewOffset > Clips on the Arms object; "
                + "the authored view bob is driven by CameraBoneViewBob on the same object.");
        }

        private static void AddCrawlState(AnimationClip clip)
        {
            AnimatorController controller = AssetDatabase.LoadAssetAtPath<AnimatorController>(k_Controller);

            if (controller == null)
            {
                Debug.LogError($"CrawlTestRigBuilder: {k_Controller} not found.");
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

        private static AnimationClip LoadCrawlClip()
        {
            foreach (Object asset in AssetDatabase.LoadAllAssetsAtPath(k_CrawlFbx))
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

            Debug.LogError("CrawlTestRigBuilder: no 'Arms' object in the level. "
                + "Run RootsDance > Build Helmet Test Rig first.");
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

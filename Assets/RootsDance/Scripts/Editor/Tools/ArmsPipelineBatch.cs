using System.Text;
using RootsDance.Player.Arms;
using UnityEditor;
using UnityEditor.Animations;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Batch entry points for the arms pipeline, so a headless Editor can rebuild and check it
    /// without a human clicking menus. Used by the `-executeMethod` commands in
    /// docs/architecture/systems/手臂动画统一驱动_实施计划.md.
    /// </summary>
    public static class ArmsPipelineBatch
    {
        /// <summary>Reimports the arms models, regenerates the action set, masks and controller.</summary>
        public static void Rebuild()
        {
            AssetDatabase.Refresh();

            foreach (string guid in AssetDatabase.FindAssets(
                "t:Model", new[] { "Assets/RootsDance/Meshes/Characters", "Assets/RootsDance/Meshes/Props" }))
            {
                AssetDatabase.ImportAsset(
                    AssetDatabase.GUIDToAssetPath(guid), ImportAssetOptions.ForceUpdate);
            }

            AssetDatabase.SaveAssets();
            ArmsControllerBuilder.CreateActionSet();
            ArmsControllerBuilder.BuildController();
            AssetDatabase.SaveAssets();
            Debug.Log("ArmsPipelineBatch: rebuild finished.");
        }

        /// <summary>
        /// Prints what the pipeline actually produced — clip lengths, layers, masks and every
        /// action's wiring — so a batch log is enough to tell whether the rebuild is sound.
        /// </summary>
        public static void Report()
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("ARMS PIPELINE REPORT");

            var set = AssetDatabase.LoadAssetAtPath<ArmsActionSetSO>(
                "Assets/RootsDance/Data/Arms/PlayerArmsActions.asset");

            if (set == null)
            {
                Debug.LogError("ArmsPipelineBatch: no action set.");
                return;
            }

            set.RebuildLookup();
            int problems = 0;

            foreach (ArmsActionSO action in set.Actions)
            {
                if (action == null)
                {
                    problems++;
                    sb.AppendLine("  NULL entry in the set");
                    continue;
                }

                string clip = action.Clip == null
                    ? "MISSING CLIP"
                    : $"{action.Clip.name} {action.Clip.length:F3}s loop={action.Clip.isLooping}";

                if (action.Clip == null)
                {
                    problems++;
                }

                if (!string.IsNullOrEmpty(action.ChainToId) && set.Find(action.ChainToId) == null)
                {
                    problems++;
                    sb.AppendLine($"  '{action.Id}' chains to unknown '{action.ChainToId}'");
                }

                sb.AppendLine($"  {action.Id,-14} L{action.Layer} {action.Scope,-6} {clip}");
            }

            var controller = AssetDatabase.LoadAssetAtPath<AnimatorController>(
                "Assets/RootsDance/Animations/Controllers/PlayerArms.controller");

            if (controller == null)
            {
                problems++;
                sb.AppendLine("  MISSING controller");
            }
            else
            {
                foreach (AnimatorControllerLayer layer in controller.layers)
                {
                    sb.AppendLine($"  layer {layer.name,-9} weight={layer.defaultWeight} "
                        + $"mask={(layer.avatarMask == null ? "none" : layer.avatarMask.name)} "
                        + $"states={layer.stateMachine.states.Length}");

                    foreach (ChildAnimatorState child in layer.stateMachine.states)
                    {
                        if (child.state.motion == null && child.state.name != set.EmptyStateName)
                        {
                            problems++;
                            sb.AppendLine($"    state '{child.state.name}' has no motion");
                        }
                    }
                }
            }

            sb.AppendLine(problems == 0 ? "ARMS PIPELINE OK" : $"ARMS PIPELINE PROBLEMS: {problems}");
            Debug.Log(sb.ToString());
        }
    }
}

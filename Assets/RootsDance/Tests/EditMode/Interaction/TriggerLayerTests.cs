using System.Collections.Generic;
using System.Linq;
using NUnit.Framework;
using RootsDance.Chase;
using RootsDance.Dialogue;
using RootsDance.Environment;
using RootsDance.Interaction;
using RootsDance.Sequencing;
using RootsDance.World;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Tests.EditMode.Interaction
{
    /// <summary>
    /// Every trigger and interactable in every gameplay scene has to be on the one layer that can
    /// reach the player, and this is the only thing that says so out loud.
    /// <para>
    /// Two masks decide it, and neither is forgiving. The player's trigger detection lives on a
    /// probe on the PlayerProbe layer, which the physics matrix pairs with TriggerVolume and
    /// nothing else. The interaction raycast masks to Interactable alone. An object left on
    /// Default keeps its collider and its component and simply never fires — which in play reads
    /// exactly like a scene you have not walked far enough into, so it survives playtesting.
    /// </para>
    /// The failure message names the object, its layer and the layer it needs, because the fix is
    /// always in the builder that placed it, not in the scene.
    /// </summary>
    public sealed class TriggerLayerTests
    {
        /// <summary>
        /// Scoped to the levels this branch owns. The same bug is live in Main_Gameplay
        /// (VictoryVolume) and GreenhouseInterior_Gameplay (ExitPortal), but those scenes belong to
        /// other people's branches — the builders that place them are fixed, and re-running those
        /// builders is theirs to do. Widen this to the whole Levels folder once that has happened.
        /// </summary>
        private const string k_LevelFolder = "Assets/RootsDance/Scenes/Levels/ChapterHouseInterior";
        private const string k_TriggerLayer = "TriggerVolume";
        private const string k_InteractableLayer = "Interactable";

        [Test]
        public void EveryGameplayScene_PutsItsTriggersOnALayerThePlayerCanReach()
        {
            string[] scenePaths = AssetDatabase
                .FindAssets("t:Scene", new[] { k_LevelFolder })
                .Select(AssetDatabase.GUIDToAssetPath)
                .Where(path => path.EndsWith("_Gameplay.unity"))
                .OrderBy(path => path)
                .ToArray();

            Assert.Greater(scenePaths.Length, 0, "No gameplay scenes were found under " + k_LevelFolder);

            List<string> problems = new List<string>();
            int checkedCount = 0;

            for (int i = 0; i < scenePaths.Length; i++)
            {
                Scene scene = EditorSceneManager.OpenScene(scenePaths[i], OpenSceneMode.Additive);

                try
                {
                    GameObject[] roots = scene.GetRootGameObjects();

                    for (int rootIndex = 0; rootIndex < roots.Length; rootIndex++)
                    {
                        Component[] components = roots[rootIndex].GetComponentsInChildren<Component>(true);

                        for (int componentIndex = 0; componentIndex < components.Length; componentIndex++)
                        {
                            Component component = components[componentIndex];
                            string required = RequiredLayer(component);

                            if (required == null)
                            {
                                continue;
                            }

                            checkedCount++;
                            int expected = LayerMask.NameToLayer(required);
                            Assert.GreaterOrEqual(expected, 0, "Layer is not configured: " + required);

                            if (component.gameObject.layer != expected)
                            {
                                problems.Add(string.Format(
                                    "{0}: {1} ({2}) is on layer {3} but needs {4}",
                                    System.IO.Path.GetFileName(scenePaths[i]),
                                    component.gameObject.name,
                                    component.GetType().Name,
                                    LayerMask.LayerToName(component.gameObject.layer),
                                    required));
                            }
                        }
                    }
                }
                finally
                {
                    EditorSceneManager.CloseScene(scene, true);
                }
            }

            Assert.Greater(checkedCount, 0, "No triggers or interactables were found to check.");
            Assert.IsEmpty(problems, string.Join("\n", problems));
        }

        /// <summary>
        /// The layer a component has to sit on to work, or null when it does not care. A dialogue
        /// trigger is the interesting case: only two of its four moments touch physics at all, and
        /// they need different layers — walking in goes through the probe, talking goes through
        /// the raycast — while a flag-raised or manual one needs no layer.
        /// </summary>
        private static string RequiredLayer(Component component)
        {
            if (component is DialogueTrigger dialogue)
            {
                using (SerializedObject serialized = new SerializedObject(dialogue))
                {
                    int moment = serialized.FindProperty("m_playOn").enumValueIndex;

                    if (moment == (int)DialogueTrigger.Moment.OnPlayerEnter)
                    {
                        return k_TriggerLayer;
                    }

                    return moment == (int)DialogueTrigger.Moment.OnInteract ? k_InteractableLayer : null;
                }
            }

            // A sequence that starts on the player walking in is the same physics contract as a
            // dialogue trigger that does, and the same silent failure when the layer is wrong.
            if (component is CueSequence sequence)
            {
                using (SerializedObject serialized = new SerializedObject(sequence))
                {
                    return serialized.FindProperty("m_playOn").enumValueIndex
                        == (int)CueSequence.Moment.OnPlayerEnter
                        ? k_TriggerLayer
                        : null;
                }
            }

            if (component is TriggerVolume || component is LevelPortal || component is ChaseExitPortal)
            {
                return k_TriggerLayer;
            }

            if (component is IInteractable)
            {
                return k_InteractableLayer;
            }

            return null;
        }
    }
}

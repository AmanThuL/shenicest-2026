using System.Collections.Generic;
using System.Text;
using RootsDance.Player;
using UnityEditor;
using UnityEditor.Animations;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Fills in the per-clip framing table on <see cref="ArmsViewOffset"/>, one entry per Animator
    /// state in the arms controller.
    /// <para>
    /// Why per clip: the rig is anchored by its bind-pose <c>camera</c> bone, but a clip may animate
    /// that bone — the crawl cycle pushes the prone head 0.2 m ahead of the shoulders, while the
    /// helmet clip leaves it alone. Unity's camera does not follow the bone, so any authored drift
    /// shows up as the arms sitting that far from the eye (they read as too long or too short). The
    /// correction is therefore a property of the clip, not of the rig, and a single shared offset
    /// gets it wrong for every clip but one.
    /// </para>
    /// <para>
    /// Only the machine-derived fields are written. <see cref="ArmsViewOffset.ClipFraming.m_tweak"/>
    /// is carried across by state name and the shared offsets are left alone, so re-running this
    /// never destroys hand-tuned framing.
    /// </para>
    /// Menu: RootsDance > Refresh Arms Framing. Also runs at the end of the two rig builders.
    /// </summary>
    public static class ArmsFramingBuilder
    {
        private const string k_EnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Environment.unity";
        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity";
        private const string k_Controller =
            "Assets/RootsDance/Animations/Controllers/PlayerArms.controller";
        private const string k_ArmsObjectName = "Arms";
        private const string k_CameraBoneName = "camera";

        [MenuItem("RootsDance/Refresh Arms Framing")]
        private static void RefreshFromMenu()
        {
            Scene gameplay = OpenLevel();
            Transform arms = FindArms(gameplay);

            if (arms == null)
            {
                Debug.LogError("ArmsFramingBuilder: no 'Arms' object in the level. "
                    + "Run RootsDance > Build Helmet Test Rig first.");
                return;
            }

            Refresh(arms);
            EditorSceneManager.MarkSceneDirty(gameplay);
            EditorSceneManager.SaveScene(gameplay);
        }

        /// <summary>
        /// Samples every clip in the controller and rewrites the framing table on <paramref name="arms"/>.
        /// Safe to call repeatedly; the caller owns marking and saving the scene.
        /// </summary>
        public static void Refresh(Transform arms)
        {
            Transform head = arms.parent;

            if (head == null)
            {
                Debug.LogError("ArmsFramingBuilder: the Arms object has no parent to frame against.");
                return;
            }

            ArmsViewOffset view = arms.GetComponent<ArmsViewOffset>();

            // Capture the anchor BEFORE touching the component: ArmsViewOffset is [ExecuteAlways],
            // so adding it fires OnEnable -> Apply() and overwrites the local pose immediately. On a
            // re-run the live pose is already anchor + offset + correction, so the stored anchor is
            // the only trustworthy source.
            Vector3 basePosition = view == null ? arms.localPosition : view.BasePosition;
            Vector3 baseRotation = view == null ? arms.localRotation.eulerAngles : view.BaseRotation;

            Dictionary<string, Vector3> tweaks = CaptureTweaks(view);

            if (view == null)
            {
                view = arms.gameObject.AddComponent<ArmsViewOffset>();
            }

            view.BasePosition = basePosition;
            view.BaseRotation = baseRotation;

            Transform cameraBone = FindDeep(arms, k_CameraBoneName);

            if (cameraBone == null)
            {
                Debug.LogWarning($"ArmsFramingBuilder: no '{k_CameraBoneName}' bone in the rig; "
                    + "the framing table is left empty and the view bob stays unwired.");
                return;
            }

            AnimatorController controller =
                AssetDatabase.LoadAssetAtPath<AnimatorController>(k_Controller);

            if (controller == null)
            {
                Debug.LogError($"ArmsFramingBuilder: {k_Controller} not found.");
                return;
            }

            List<ArmsViewOffset.ClipFraming> table = new List<ArmsViewOffset.ClipFraming>();
            Dictionary<string, AnimationClip> clipsByState = new Dictionary<string, AnimationClip>();
            StringBuilder report = new StringBuilder();

            foreach (ChildAnimatorState child in controller.layers[0].stateMachine.states)
            {
                AnimationClip clip = child.state.motion as AnimationClip;

                if (clip == null)
                {
                    continue;
                }

                // Sample from the anchored pose with no offset applied, so what is measured is the
                // clip's own drift off the head pivot and nothing else.
                AnchorPose(arms, basePosition, baseRotation);
                clip.SampleAnimation(arms.gameObject, 0f);

                ArmsViewOffset.ClipFraming entry = new ArmsViewOffset.ClipFraming();
                entry.m_stateName = child.state.name;
                entry.m_correction = head.InverseTransformVector(head.position - cameraBone.position);
                entry.m_referenceBonePosition = arms.InverseTransformPoint(cameraBone.position);
                entry.m_animatesCameraBone = AnimatesCameraBone(clip, arms, cameraBone);
                entry.m_tweak = tweaks.TryGetValue(child.state.name, out Vector3 tweak)
                    ? tweak
                    : Vector3.zero;

                table.Add(entry);
                clipsByState[entry.m_stateName] = clip;
                report.AppendLine($"  {entry.m_stateName,-12} correction {entry.m_correction:F4}"
                    + $"  bob {(entry.m_animatesCameraBone ? "yes" : "no")}"
                    + $"  tweak {entry.m_tweak:F4}");
            }

            view.Clips.Clear();
            view.Clips.AddRange(table);
            view.RebuildLookup();
            view.BindBonePosition = ResolveBindBonePosition(arms, table);

            if (string.IsNullOrEmpty(view.PreviewState) && table.Count > 0)
            {
                view.PreviewState = table[0].m_stateName;
            }

            WireViewBob(arms, head, cameraBone);

            // Leave the rig on the clip the Inspector claims to be previewing, so the Scene view
            // does not silently show whichever state happened to be sampled last.
            AnchorPose(arms, basePosition, baseRotation);

            if (clipsByState.TryGetValue(view.PreviewState ?? string.Empty, out AnimationClip preview))
            {
                preview.SampleAnimation(arms.gameObject, 0f);
                AnchorPose(arms, basePosition, baseRotation);
            }
            EditorUtility.SetDirty(view);

            // Migration guard: the previous crawl-only builder seeded the shared offset with the
            // crawl correction, which then shifted every other clip too. It is a human-owned field
            // now, so this tool will not silently overwrite it — but it must not go unnoticed.
            if (view.PositionOffset != Vector3.zero)
            {
                Debug.LogWarning($"ArmsFramingBuilder: Position Offset is {view.PositionOffset:F4} "
                    + "and applies to EVERY clip. If it was seeded by the old crawl-only builder, "
                    + "clear it (ArmsViewOffset context menu > Clear Shared Offset) — the crawl "
                    + "correction now lives in the per-clip table.");
            }

            Debug.Log($"ArmsFramingBuilder: framing table rebuilt for {table.Count} clip(s).\n"
                + report
                + "Tune per clip in ArmsViewOffset > Clips > m_tweak (this tool preserves it), or "
                + "for all clips at once in Position Offset. Set Preview State to judge one clip in "
                + "the Scene view without entering Play mode.");
        }

        /// <summary>
        /// The camera bone's position in the arms-root frame at bind pose — the reference used for
        /// any state with no entry in the table.
        /// <para>
        /// Read off the source model asset rather than the scene instance, because there is no
        /// reliable way to put the scene rig back on its bind pose from an editor script:
        /// <c>Animator.Rebind()</c> does not restore bone transforms in Edit mode, so measuring the
        /// instance yields whatever clip was sampled last. The asset's bones are always at bind pose.
        /// </para>
        /// Falls back to a clip that provably leaves the bone alone — its frame-0 reference is the
        /// bind pose by definition.
        /// </summary>
        private static Vector3 ResolveBindBonePosition(
            Transform arms, List<ArmsViewOffset.ClipFraming> table)
        {
            GameObject source = PrefabUtility.GetCorrespondingObjectFromSource(arms.gameObject);

            if (source != null)
            {
                Transform sourceBone = FindDeep(source.transform, k_CameraBoneName);

                if (sourceBone != null)
                {
                    return source.transform.InverseTransformPoint(sourceBone.position);
                }
            }

            foreach (ArmsViewOffset.ClipFraming entry in table)
            {
                if (!entry.m_animatesCameraBone)
                {
                    return entry.m_referenceBonePosition;
                }
            }

            Debug.LogWarning("ArmsFramingBuilder: could not determine the bind-pose camera bone "
                + "position (no source asset, and every clip animates the bone). A state with no "
                + "entry in the table will get no bob rather than a wrong one.");
            return Vector3.zero;
        }

        private static void AnchorPose(Transform arms, Vector3 basePosition, Vector3 baseRotation)
        {
            arms.localPosition = basePosition;
            arms.localRotation = Quaternion.Euler(baseRotation);
        }

        private static Dictionary<string, Vector3> CaptureTweaks(ArmsViewOffset view)
        {
            Dictionary<string, Vector3> tweaks = new Dictionary<string, Vector3>();

            if (view == null)
            {
                return tweaks;
            }

            foreach (ArmsViewOffset.ClipFraming entry in view.Clips)
            {
                if (!string.IsNullOrEmpty(entry.m_stateName))
                {
                    tweaks[entry.m_stateName] = entry.m_tweak;
                }
            }

            return tweaks;
        }

        /// <summary>
        /// Whether the clip actually moves the camera bone. The FBX bake writes a key per frame for
        /// every bone, so the presence of a curve proves nothing — a clip that leaves the bone at
        /// bind pose still carries a full set of identical keys. Only a curve whose values change
        /// counts as an authored bob.
        /// </summary>
        private static bool AnimatesCameraBone(AnimationClip clip, Transform arms, Transform cameraBone)
        {
            string path = AnimationUtility.CalculateTransformPath(cameraBone, arms);

            foreach (EditorCurveBinding binding in AnimationUtility.GetCurveBindings(clip))
            {
                if (binding.path != path)
                {
                    continue;
                }

                AnimationCurve curve = AnimationUtility.GetEditorCurve(clip, binding);

                if (curve == null || curve.length < 2)
                {
                    continue;
                }

                float first = curve.keys[0].value;

                for (int i = 1; i < curve.length; i++)
                {
                    if (!Mathf.Approximately(curve.keys[i].value, first))
                    {
                        return true;
                    }
                }
            }

            return false;
        }

        private static void WireViewBob(Transform arms, Transform head, Transform cameraBone)
        {
            CameraBoneViewBob bob = arms.GetComponent<CameraBoneViewBob>();

            if (bob == null)
            {
                bob = arms.gameObject.AddComponent<CameraBoneViewBob>();
            }

            SerializedObject serialized = new SerializedObject(bob);
            serialized.FindProperty("m_cameraBone").objectReferenceValue = cameraBone;
            serialized.FindProperty("m_viewTarget").objectReferenceValue = head;
            serialized.ApplyModifiedPropertiesWithoutUndo();
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

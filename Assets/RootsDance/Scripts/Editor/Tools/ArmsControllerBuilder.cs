using System;
using System.Collections.Generic;
using RootsDance.Player.Arms;
using UnityEditor;
using UnityEditor.Animations;
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Generates everything the arms state machine needs from one list of actions: the two arm
    /// avatar masks and the three-layer <c>PlayerArms</c> controller.
    /// <para>
    /// The point is that an animation is registered in exactly one place. Before this, a clip lived
    /// in a hand-built controller, in a bespoke trigger component, and in whichever view class
    /// happened to call <c>Animator.Play</c> — three places to keep in step, and they did not stay
    /// in step. Now a new animation is a new <see cref="ArmsActionSO"/> and one press of
    /// <c>Build Arms Controller</c>; the runtime, the debug keys and the controller all read that
    /// same asset.
    /// </para>
    /// Menu: <c>RootsDance &gt; Arms</c>.
    /// </summary>
    public static class ArmsControllerBuilder
    {
        private const string k_RigModel = "Assets/RootsDance/Meshes/Characters/Arms.fbx";
        private const string k_Controller = "Assets/RootsDance/Animations/Controllers/PlayerArms.controller";
        private const string k_MaskFolder = "Assets/RootsDance/Animations/Masks";
        private const string k_ActionFolder = "Assets/RootsDance/Data/Arms/Actions";
        private const string k_SetAsset = "Assets/RootsDance/Data/Arms/PlayerArmsActions.asset";
        private const string k_LeftMask = k_MaskFolder + "/ArmLeft.mask";
        private const string k_RightMask = k_MaskFolder + "/ArmRight.mask";

        /// <summary>One row of the shipped default table — the arms contract, as data.</summary>
        private struct Row
        {
            public string m_id;
            public string m_model;
            public string m_clip;
            public ArmsScope m_scope;
            public bool m_loop;
            public bool m_gate;
            public ArmsPose m_required;
            public ArmsPose m_result;
            public string m_chain;
            public bool m_hold;
            public ArmsHeightBase m_height;
            public float m_fadeIn;
            public Key m_key;
            public ArmsActionSO.HandEvent[] m_events;
        }

        private static ArmsActionSO.HandEvent Event(float t, HandSide hand, HandEventKind kind)
        {
            return new ArmsActionSO.HandEvent
            {
                m_normalizedTime = t,
                m_hand = hand,
                m_kind = kind,
            };
        }

        /// <summary>
        /// The default set. Poses and event times are taken from the arms contract and re-measured
        /// against the blend file; the comments carry the authored frame each number came from.
        /// </summary>
        private static Row[] DefaultRows()
        {
            const string arms = "Assets/RootsDance/Meshes/Characters/";

            return new[]
            {
                // The pose everything returns to: forearms down at the sides.
                new Row
                {
                    m_id = "neutral", m_model = arms + "Arms_Neutral.fbx", m_clip = "Arms_Neutral",
                    m_scope = ArmsScope.Both, m_loop = true, m_gate = false,
                    m_required = ArmsPose.HangLow, m_result = ArmsPose.HangLow,
                    m_height = ArmsHeightBase.Standing, m_fadeIn = 0.15f, m_key = Key.None,
                },

                // Right forearm raised, carrying something. Chained into, never requested.
                new Row
                {
                    m_id = "hold", m_model = arms + "Arms_Hold.fbx", m_clip = "Arms_Hold",
                    m_scope = ArmsScope.Right, m_loop = true, m_gate = false,
                    m_required = ArmsPose.ForearmRaised, m_result = ArmsPose.ForearmRaised,
                    m_height = ArmsHeightBase.Standing, m_fadeIn = 0.18f, m_key = Key.None,
                },

                // Crouch, take the object at frame 28 of 75, stand back up holding it.
                new Row
                {
                    m_id = "grabGround", m_model = arms + "Arms_GrabGround.fbx", m_clip = "Arms_GrabGround",
                    m_scope = ArmsScope.Both, m_loop = false, m_gate = true,
                    m_required = ArmsPose.HangLow, m_result = ArmsPose.ForearmRaised,
                    m_chain = "hold", m_height = ArmsHeightBase.Standing,
                    m_fadeIn = 0.25f, m_key = Key.G,
                    m_events = new[] { Event(27f / 74f, HandSide.Right, HandEventKind.Attach) },
                },

                // Opens the hand across frames 4-7 of 28; the object is physics from there.
                new Row
                {
                    m_id = "drop", m_model = arms + "Arms_Drop.fbx", m_clip = "Arms_Drop",
                    m_scope = ArmsScope.Right, m_loop = false, m_gate = true,
                    m_required = ArmsPose.ForearmRaised, m_result = ArmsPose.HangLow,
                    m_height = ArmsHeightBase.Standing, m_fadeIn = 0.08f, m_key = Key.H,
                    m_events = new[] { Event(4.5f / 27f, HandSide.Right, HandEventKind.Detach) },
                },

                // Ends held on the aim pose; nothing else may take the left arm until it comes down.
                new Row
                {
                    m_id = "scannerRaise", m_model = arms + "Arms_ScannerRaise.fbx", m_clip = "Arms_ScannerRaise",
                    m_scope = ArmsScope.Left, m_loop = false, m_gate = true,
                    m_required = ArmsPose.HangLow, m_result = ArmsPose.AimL,
                    m_hold = true, m_height = ArmsHeightBase.Standing,
                    m_fadeIn = 0.1f, m_key = Key.J,
                },
                new Row
                {
                    m_id = "scannerLower", m_model = arms + "Arms_ScannerLower.fbx", m_clip = "Arms_ScannerLower",
                    m_scope = ArmsScope.Left, m_loop = false, m_gate = true,
                    m_required = ArmsPose.AimL, m_result = ArmsPose.HangLow,
                    m_height = ArmsHeightBase.Standing, m_fadeIn = 0.08f, m_key = Key.K,
                },
                new Row
                {
                    m_id = "keypadPoke", m_model = arms + "Arms_KeypadPoke.fbx", m_clip = "Arms_KeypadPoke",
                    m_scope = ArmsScope.Both, m_loop = false, m_gate = true,
                    m_required = ArmsPose.HangLow, m_result = ArmsPose.HangLow,
                    m_height = ArmsHeightBase.Standing, m_fadeIn = 0.12f, m_key = Key.P,
                },

                // One press, one cycle. The clip's first and last frames are identical, so holding
                // the last frame leaves the body exactly where the cycle began — press again for
                // another stride, or stand up. Looping it instead would make the key a toggle,
                // which is not what a single stride should feel like.
                // No authored way into the crawl pose yet, so the gate is off for this one.
                new Row
                {
                    m_id = "crawl", m_model = arms + "Arms_Crawl.fbx", m_clip = "Arms_Crawl",
                    m_scope = ArmsScope.Both, m_loop = false, m_gate = false,
                    m_required = ArmsPose.CrawlPose, m_result = ArmsPose.CrawlPose,
                    m_hold = true, m_height = ArmsHeightBase.Ground,
                    m_fadeIn = 0.2f, m_key = Key.N,
                },
                new Row
                {
                    m_id = "standUp", m_model = arms + "Arms_StandUp.fbx", m_clip = "Arms_StandUp",
                    m_scope = ArmsScope.Both, m_loop = false, m_gate = true,
                    m_required = ArmsPose.CrawlPose, m_result = ArmsPose.HangLow,
                    m_height = ArmsHeightBase.GroundToStanding, m_fadeIn = 0.15f, m_key = Key.V,
                },

                // The helmet leaves the head into the right hand at frame 27 of 120 and stays a
                // carried object from there, so 'drop' can throw it like anything else.
                new Row
                {
                    m_id = "helmetOff", m_model = k_RigModel, m_clip = "Arms_HelmetOff",
                    m_scope = ArmsScope.Both, m_loop = false, m_gate = true,
                    m_required = ArmsPose.HangLow, m_result = ArmsPose.ForearmRaised,
                    m_chain = "hold", m_height = ArmsHeightBase.Standing,
                    m_fadeIn = 0.15f, m_key = Key.B,
                    m_events = new[] { Event(26f / 119f, HandSide.Right, HandEventKind.Attach) },
                },
            };
        }

        [MenuItem("RootsDance/Arms/Create Or Update Action Set")]
        public static void CreateActionSet()
        {
            EnsureFolder(k_ActionFolder);

            ArmsActionSetSO set = AssetDatabase.LoadAssetAtPath<ArmsActionSetSO>(k_SetAsset);

            if (set == null)
            {
                set = ScriptableObject.CreateInstance<ArmsActionSetSO>();
                AssetDatabase.CreateAsset(set, k_SetAsset);
            }

            var actions = new List<ArmsActionSO>();
            ArmsActionSO neutral = null;

            foreach (Row row in DefaultRows())
            {
                string path = $"{k_ActionFolder}/Arms_{row.m_id}.asset";
                ArmsActionSO action = AssetDatabase.LoadAssetAtPath<ArmsActionSO>(path);
                bool isNew = action == null;

                if (isNew)
                {
                    action = ScriptableObject.CreateInstance<ArmsActionSO>();
                    AssetDatabase.CreateAsset(action, path);
                }

                // An existing asset keeps its hand-tuned speed, fades and event times; only the
                // machine-derived fields are rewritten, the same bargain ArmsViewOffset makes.
                Write(action, row, isNew);
                actions.Add(action);

                if (row.m_id == "neutral")
                {
                    neutral = action;
                }
            }

            SerializedObject so = new SerializedObject(set);
            SerializedProperty list = so.FindProperty("m_actions");
            list.arraySize = actions.Count;

            for (int i = 0; i < actions.Count; i++)
            {
                list.GetArrayElementAtIndex(i).objectReferenceValue = actions[i];
            }

            so.FindProperty("m_neutral").objectReferenceValue = neutral;
            so.ApplyModifiedPropertiesWithoutUndo();

            EditorUtility.SetDirty(set);
            AssetDatabase.SaveAssets();
            Selection.activeObject = set;
            Debug.Log($"ArmsControllerBuilder: action set has {actions.Count} actions at {k_SetAsset}.");
        }

        private static void Write(ArmsActionSO action, Row row, bool isNew)
        {
            SerializedObject so = new SerializedObject(action);

            so.FindProperty("m_id").stringValue = row.m_id;
            so.FindProperty("m_stateName").stringValue = StateName(row.m_id);
            so.FindProperty("m_clip").objectReferenceValue = FindClip(row.m_model, row.m_clip);
            so.FindProperty("m_scope").enumValueIndex = (int)row.m_scope;
            so.FindProperty("m_loop").boolValue = row.m_loop;
            so.FindProperty("m_requiredPoseEnforced").boolValue = row.m_gate;
            so.FindProperty("m_requiredPose").enumValueIndex = (int)row.m_required;
            so.FindProperty("m_resultPose").enumValueIndex = (int)row.m_result;
            so.FindProperty("m_chainToId").stringValue = row.m_chain ?? string.Empty;
            so.FindProperty("m_holdAfterFinish").boolValue = row.m_hold;
            so.FindProperty("m_heightBase").enumValueIndex = (int)row.m_height;

            if (isNew)
            {
                so.FindProperty("m_fadeIn").floatValue = row.m_fadeIn;
                so.FindProperty("m_debugKey").enumValueIndex = EnumIndex<Key>(row.m_key);

                SerializedProperty events = so.FindProperty("m_handEvents");
                events.arraySize = row.m_events == null ? 0 : row.m_events.Length;

                for (int i = 0; i < events.arraySize; i++)
                {
                    SerializedProperty e = events.GetArrayElementAtIndex(i);
                    e.FindPropertyRelative("m_normalizedTime").floatValue = row.m_events[i].m_normalizedTime;
                    e.FindPropertyRelative("m_hand").enumValueIndex = (int)row.m_events[i].m_hand;
                    e.FindPropertyRelative("m_kind").enumValueIndex = (int)row.m_events[i].m_kind;
                }
            }

            so.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(action);
        }

        [MenuItem("RootsDance/Arms/Build Arms Controller")]
        public static void BuildController()
        {
            ArmsActionSetSO set = AssetDatabase.LoadAssetAtPath<ArmsActionSetSO>(k_SetAsset);

            if (set == null)
            {
                Debug.LogError("ArmsControllerBuilder: run RootsDance > Arms > Create Or Update "
                    + "Action Set first.");
                return;
            }

            set.RebuildLookup();

            AvatarMask left = BuildMask(k_LeftMask, ".L");
            AvatarMask right = BuildMask(k_RightMask, ".R");

            if (left == null || right == null)
            {
                return;
            }

            AssetDatabase.DeleteAsset(k_Controller);
            EnsureFolder("Assets/RootsDance/Animations/Controllers");
            AnimatorController controller = AnimatorController.CreateAnimatorControllerAtPath(k_Controller);

            for (int layer = 0; layer < 3; layer++)
            {
                controller.AddParameter(ArmsDirector.SpeedParameterName(layer), AnimatorControllerParameterType.Float);
            }

            SetParameterDefaults(controller);

            for (int layer = 1; layer < 3; layer++)
            {
                controller.AddLayer(set.LayerName(layer));
            }

            AnimatorControllerLayer[] layers = controller.layers;
            layers[0].name = set.LayerName(0);
            layers[0].defaultWeight = 1f;
            layers[1].avatarMask = left;
            layers[1].defaultWeight = 0f;
            layers[2].avatarMask = right;
            layers[2].defaultWeight = 0f;

            for (int i = 0; i < layers.Length; i++)
            {
                layers[i].blendingMode = AnimatorLayerBlendingMode.Override;
                layers[i].iKPass = false;
            }

            controller.layers = layers;

            int built = 0;

            for (int layer = 0; layer < 3; layer++)
            {
                AnimatorStateMachine machine = controller.layers[layer].stateMachine;
                machine.entryPosition = new Vector3(-260f, 0f, 0f);
                machine.anyStatePosition = new Vector3(-260f, 80f, 0f);
                machine.exitPosition = new Vector3(-260f, 160f, 0f);

                // Something for a masked layer to sit on while its weight is zero. The base
                // layer needs none — its default is the neutral pose.
                if (layer > 0)
                {
                    AnimatorState empty = machine.AddState(
                        set.EmptyStateName, new Vector3(0f, -80f, 0f));
                    empty.writeDefaultValues = true;
                    machine.defaultState = empty;
                }

                int row = 0;

                for (int i = 0; i < set.Actions.Count; i++)
                {
                    ArmsActionSO action = set.Actions[i];

                    if (action == null || action.Layer != layer)
                    {
                        continue;
                    }

                    AnimatorState state = machine.AddState(
                        action.StateName, new Vector3(220f, row * 60f, 0f));
                    state.motion = action.Clip;
                    state.writeDefaultValues = true;
                    state.speedParameterActive = true;
                    state.speedParameter = ArmsDirector.SpeedParameterName(layer);

                    if (layer == 0 && set.Neutral == action)
                    {
                        machine.defaultState = state;
                    }

                    if (action.Clip == null)
                    {
                        Debug.LogWarning($"ArmsControllerBuilder: action '{action.Id}' has no clip; "
                            + $"state '{action.StateName}' was created empty.");
                    }

                    row++;
                    built++;
                }
            }

            EditorUtility.SetDirty(controller);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log($"ArmsControllerBuilder: built {k_Controller} — 3 layers, {built} states, "
                + "masks regenerated.");
        }

        /// <summary>
        /// Builds one arm's mask from the rig's real hierarchy: every transform whose path contains
        /// a bone on that side is in, everything else is out. The root and camera bones therefore
        /// fall outside both masks, which is what keeps a single-arm clip from moving the view.
        /// </summary>
        private static AvatarMask BuildMask(string path, string suffix)
        {
            GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(k_RigModel);

            if (model == null)
            {
                Debug.LogError($"ArmsControllerBuilder: {k_RigModel} not found.");
                return null;
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(model);
            var paths = new List<string>();
            var active = new List<bool>();

            foreach (Transform t in instance.GetComponentsInChildren<Transform>(true))
            {
                string transformPath = AnimationUtility.CalculateTransformPath(t, instance.transform);
                paths.Add(transformPath);
                active.Add(IsOnSide(transformPath, suffix));
            }

            UnityEngine.Object.DestroyImmediate(instance);

            EnsureFolder(k_MaskFolder);
            AvatarMask mask = AssetDatabase.LoadAssetAtPath<AvatarMask>(path);
            bool isNew = mask == null;

            if (isNew)
            {
                mask = new AvatarMask();
            }

            mask.transformCount = paths.Count;

            for (int i = 0; i < paths.Count; i++)
            {
                mask.SetTransformPath(i, paths[i]);
                mask.SetTransformActive(i, active[i]);
            }

            if (isNew)
            {
                AssetDatabase.CreateAsset(mask, path);
            }
            else
            {
                EditorUtility.SetDirty(mask);
            }

            int on = active.FindAll(a => a).Count;
            Debug.Log($"ArmsControllerBuilder: {path} — {on} of {paths.Count} transforms enabled.");
            return mask;
        }

        private static bool IsOnSide(string transformPath, string suffix)
        {
            if (string.IsNullOrEmpty(transformPath))
            {
                return false;
            }

            foreach (string segment in transformPath.Split('/'))
            {
                if (segment.EndsWith(suffix, StringComparison.Ordinal))
                {
                    return true;
                }
            }

            return false;
        }

        private static void SetParameterDefaults(AnimatorController controller)
        {
            AnimatorControllerParameter[] parameters = controller.parameters;

            for (int i = 0; i < parameters.Length; i++)
            {
                parameters[i].defaultFloat = 1f;
            }

            controller.parameters = parameters;
        }

        private static AnimationClip FindClip(string modelPath, string clipName)
        {
            foreach (UnityEngine.Object o in AssetDatabase.LoadAllAssetsAtPath(modelPath))
            {
                AnimationClip clip = o as AnimationClip;

                if (clip != null && clip.name == clipName)
                {
                    return clip;
                }
            }

            Debug.LogWarning($"ArmsControllerBuilder: no clip '{clipName}' inside {modelPath}.");
            return null;
        }

        private static string StateName(string id)
        {
            return char.ToUpperInvariant(id[0]) + id.Substring(1);
        }

        private static int EnumIndex<T>(T value) where T : Enum
        {
            return Array.IndexOf(Enum.GetValues(typeof(T)), value);
        }

        private static void EnsureFolder(string folder)
        {
            if (AssetDatabase.IsValidFolder(folder))
            {
                return;
            }

            string parent = System.IO.Path.GetDirectoryName(folder).Replace('\\', '/');
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, System.IO.Path.GetFileName(folder));
        }
    }
}

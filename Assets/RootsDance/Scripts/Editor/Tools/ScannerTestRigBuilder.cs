using RootsDance.EditorTools;
using RootsDance.Player;
using RootsDance.Scanner;
using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.Animations;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Wires the scanner into the arms rig already sitting in PlayerTest_Gameplay
    /// (<see cref="HelmetTestRigBuilder"/>), so the whole read loop can be judged in Play mode
    /// (hotkey J via <see cref="ScannerDebugTrigger"/>): raise, sweep, the report blown up in front
    /// of the player, interact/click X to exit, lower. Idempotent: running it again replaces the
    /// previous wiring and saves the gameplay scene, so nothing needs placing by hand afterwards —
    /// press Play and hit J.
    /// <para>
    /// The scanner's grip pose comes from <c>GameScanner</c>, the CHILD_OF-constrained empty
    /// authored in <c>SourceArt/Blender/ArmsRig/arms_rig_all.blend</c> (contract:
    /// docs/architecture/contracts/手臂动画状态机.md — "其物体级变换就是握持偏移"). That offset was
    /// measured once by exporting a throwaway probe through the project's own Blender→FBX→Unity
    /// pipeline and reading the resulting <c>hand.L</c>→<c>GameScanner</c> relative transform back
    /// in this Editor, rather than hand-deriving the Blender→Unity axis conversion — the profile
    /// bakes axis conversion at import time (fps_arms.json), which a by-hand matrix conjugation
    /// cannot reproduce with confidence. See <see cref="k_HoldPosition"/> below for the numbers.
    /// </para>
    /// Menu: RootsDance > Build Scanner Test Rig.
    /// </summary>
    public static class ScannerTestRigBuilder
    {
        private const string k_EnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Environment.unity";
        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity";
        private const string k_ScannerPrefab = "Assets/RootsDance/Prefabs/Props/Scanner.prefab";
        private const string k_RaiseFbx = "Assets/RootsDance/Meshes/Characters/Arms_ScannerRaise.fbx";
        private const string k_LowerFbx = "Assets/RootsDance/Meshes/Characters/Arms_ScannerLower.fbx";
        private const string k_Controller =
            "Assets/RootsDance/Animations/Controllers/PlayerArms.controller";
        private const string k_ArmsObjectName = "Arms";
        private const string k_HandBoneName = "hand.L";
        private const string k_RaiseState = "ScannerRaise";
        private const string k_LowerState = "ScannerLower";

        /// <summary>
        /// hand.L → GameScanner, measured by literally bone-parenting a mesh stand-in for
        /// GameScanner onto hand.L in a scratch copy of arms_rig_all.blend (export_fbx.py only
        /// carries MESH/ARMATURE types, so a plain Empty is exported as a tiny cube instead),
        /// exporting it through the exact fps_arms profile production uses, and reading Unity's own
        /// baked <c>localPosition</c> / <c>localRotation</c> / <c>localScale</c> of the resulting
        /// literal hand.L child back — not a hand-derived matrix conjugation, which cannot be
        /// trusted against bakeAxisConversion's per-bone baking with confidence.
        /// <para>
        /// That measurement was taken against an isolated prefab instance, where hand.L's own scale
        /// is a clean uniform 100 (the file's unit-scale factor, same as every other bone).
        /// The hand socket deliberately does not inherit scale from hand.L at
        /// runtime — see its class summary for why — so the position here is expressed back out in
        /// real metres (the raw measured value, in hand.L's own 100×-scaled local frame, times
        /// that known 100) and consumed as a metres-and-rotation-only offset from the bone's
        /// position, not as a literal Transform.localPosition under hand.L.
        /// </para>
        /// </summary>
        private static readonly Vector3 k_HoldPositionMetres =
            new Vector3(-0.0188f, 0.0502f, -0.0093f);

        private static readonly Quaternion k_HoldRotation =
            new Quaternion(-0.163122f, -0.379590f, -0.759970f, 0.501745f);

        /// <summary>
        /// Places the prop where the hand holds it and leaves the tracking to the arms wiring.
        /// No scale is written here: the master was scaled to its in-hand size in Blender, so the
        /// prop is 1:1 and any compensating factor in code would be a second source of truth.
        /// </summary>
        private static void HandSocketFor(GameObject scanner, Transform handBone)
        {
            if (handBone == null)
            {
                return;
            }

            scanner.transform.SetPositionAndRotation(
                handBone.position + handBone.rotation * k_HoldPositionMetres,
                handBone.rotation * k_HoldRotation);
            scanner.transform.localScale = Vector3.one;
        }

        [MenuItem("RootsDance/Build Scanner Test Rig")]
        public static void Build()
        {
            GameObject scannerPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_ScannerPrefab);

            if (scannerPrefab == null)
            {
                Debug.LogError($"ScannerTestRigBuilder: {k_ScannerPrefab} not found. Run "
                    + "RootsDance > Build Scanner (all steps) first.");
                return;
            }

            AnimationClip raiseClip = LoadClip(k_RaiseFbx);
            AnimationClip lowerClip = LoadClip(k_LowerFbx);

            if (raiseClip == null || lowerClip == null)
            {
                Debug.LogError("ScannerTestRigBuilder: scanner_raise/scanner_lower clips missing. "
                    + "Export them from arms_rig_all.blend first.");
                return;
            }

            Scene gameplay = OpenLevel();
            Transform arms = FindArms(gameplay);

            if (arms == null)
            {
                Debug.LogError("ScannerTestRigBuilder: no 'Arms' object in the level. "
                    + "Run RootsDance > Build Helmet Test Rig first.");
                return;
            }

            Transform handBone = FindDeep(arms, k_HandBoneName);

            if (handBone == null)
            {
                Debug.LogError($"ScannerTestRigBuilder: no '{k_HandBoneName}' bone under Arms.");
                return;
            }

            AddState(k_RaiseState, raiseClip);
            AddState(k_LowerState, lowerClip);

            ScannerAnimatorView view = arms.GetComponent<ScannerAnimatorView>();

            if (view == null)
            {
                view = arms.gameObject.AddComponent<ScannerAnimatorView>();
            }

            SerializedObject viewSerialized = new SerializedObject(view);
            viewSerialized.FindProperty("m_raiseState").stringValue = k_RaiseState;
            viewSerialized.FindProperty("m_lowerState").stringValue = k_LowerState;
            viewSerialized.FindProperty("m_raiseClip").objectReferenceValue = raiseClip;
            viewSerialized.FindProperty("m_lowerClip").objectReferenceValue = lowerClip;
            viewSerialized.ApplyModifiedPropertiesWithoutUndo();

            // Parented on Arms, not on handBone: every bone in the imported rig carries a
            // decomposed local scale of about 100, and a rigid prop parented under one inherits it.
            // The prop is picked up from here by RootsDance > Arms > Wire Player Arms Rig, which
            // moves it onto an unscaled HandSocket outside the model — that is what keeps it the
            // size it was authored at, rather than a component writing a compensating scale.
            // Recursive on purpose: an earlier run may have left the prop parented far down the
            // bone chain, and a direct-child search would miss it and leave a second scanner in
            // the scene — one of them hanging off a bone rather than the socket.
            foreach (Transform child in arms.GetComponentsInChildren<Transform>(true))
            {
                if (child != arms && child.name == "Scanner")
                {
                    Object.DestroyImmediate(child.gameObject);
                    break;
                }
            }

            GameObject scanner = (GameObject)PrefabUtility.InstantiatePrefab(scannerPrefab, gameplay);
            scanner.name = "Scanner";
            scanner.transform.SetParent(arms, false);

            HandSocketFor(scanner, handBone);

            ScannerInspectController controller = scanner.GetComponent<ScannerInspectController>();
            WireController(controller, view, gameplay);

            EditorSceneManager.MarkSceneDirty(gameplay);
            EditorSceneManager.SaveScene(gameplay);

            Scene environment = EditorSceneManager.GetSceneByPath(k_EnvironmentPath);

            if (environment.IsValid() && environment.isLoaded)
            {
                EditorSceneManager.SetActiveScene(environment);
            }

            Debug.Log($"ScannerTestRigBuilder: Scanner wired under {handBone.name} and "
                + $"{k_GameplayPath} saved. Press Play and hit J to raise it.");
        }

        /// <summary>
        /// Points the standalone controller (built for the free-standing prop prefab) at the arm
        /// performance and the player's own look/move, so the raise actually plays and the player
        /// cannot spin the world about behind a report that fills the view.
        /// </summary>
        private static void WireController(ScannerInspectController controller,
            ScannerAnimatorView view, Scene gameplay)
        {
            if (controller == null)
            {
                Debug.LogError("ScannerTestRigBuilder: Scanner.prefab has no ScannerInspectController.");
                return;
            }

            SerializedObject serialized = new SerializedObject(controller);
            serialized.FindProperty("m_viewBehaviour").objectReferenceValue = view;

            Transform player = FindPlayerRoot(gameplay);

            if (player != null)
            {
                PlayerInputReader input = player.GetComponent<PlayerInputReader>();
                PlayerLook look = player.GetComponent<PlayerLook>();
                FirstPersonController move = player.GetComponent<FirstPersonController>();

                serialized.FindProperty("m_input").objectReferenceValue = input;

                SerializedProperty suspended = serialized.FindProperty("m_suspendedWhileReading");
                int count = (look != null ? 1 : 0) + (move != null ? 1 : 0);
                suspended.arraySize = count;
                int index = 0;

                if (look != null)
                {
                    suspended.GetArrayElementAtIndex(index++).objectReferenceValue = look;
                }

                if (move != null)
                {
                    suspended.GetArrayElementAtIndex(index).objectReferenceValue = move;
                }
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static Transform FindPlayerRoot(Scene gameplay)
        {
            foreach (GameObject root in gameplay.GetRootGameObjects())
            {
                if (root.name == "Player")
                {
                    return root.transform;
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
                if (root.name != "Player")
                {
                    continue;
                }

                Transform head = root.transform.Find("Head");
                head = head == null ? root.transform.Find("m_head") : head;

                return head == null ? null : head.Find(k_ArmsObjectName);
            }

            return null;
        }

        private static void AddState(string stateName, AnimationClip clip)
        {
            AnimatorController controller =
                AssetDatabase.LoadAssetAtPath<AnimatorController>(k_Controller);

            if (controller == null)
            {
                Debug.LogError($"ScannerTestRigBuilder: {k_Controller} not found.");
                return;
            }

            AnimatorStateMachine machine = controller.layers[0].stateMachine;

            foreach (ChildAnimatorState child in machine.states)
            {
                if (child.state.name == stateName)
                {
                    child.state.motion = clip;
                    EditorUtility.SetDirty(controller);
                    AssetDatabase.SaveAssets();
                    return;
                }
            }

            AnimatorState state = machine.AddState(stateName);
            state.motion = clip;
            state.writeDefaultValues = true;
            EditorUtility.SetDirty(controller);
            AssetDatabase.SaveAssets();
        }

        private static AnimationClip LoadClip(string fbxPath)
        {
            foreach (Object asset in AssetDatabase.LoadAllAssetsAtPath(fbxPath))
            {
                AnimationClip clip = asset as AnimationClip;

                if (clip != null && !clip.name.StartsWith("__preview__"))
                {
                    return clip;
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

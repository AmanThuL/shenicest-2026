using System.Collections.Generic;
using System.Text;
using RootsDance.Player;
using RootsDance.Player.Arms;
using RootsDance.Rendering;
using RootsDance.Scanner;
using RootsDance.UI;
using TMPro;
using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Assembles the whole scan loop in the open gameplay scene, so it can be played end to end:
    /// walk up to a sample, the hint appears, the key raises the scanner, the beam sweeps the
    /// sample, the report comes up magnified in front of the player, and closing it lowers the arm.
    /// <para>
    /// Idempotent, and it never saves — a scene with other work in it can be looked at first.
    /// Everything it makes is named, so a second run finds and updates rather than duplicates.
    /// </para>
    /// Menu: <c>RootsDance &gt; Scanner &gt; Build Scan Flow Test</c>.
    /// </summary>
    public static class ScannerFlowBuilder
    {
        private const string k_ScannableLayer = "Scannable";
        private const string k_LinesMaterial = "Assets/RootsDance/Materials/ScannerLines.mat";
        private const string k_FlowRoot = "ScannerFlow";
        private const string k_EffectName = "ScanEffect";
        private const string k_EmitterName = "ScanEmitter";
        private const string k_SampleName = "ScannableSample";
        private const string k_PassName = "ForwardOnly";

        [MenuItem("RootsDance/Scanner/Build Scan Flow Test")]
        public static void Build()
        {
            var log = new StringBuilder("ScannerFlowBuilder\n");

            int layer = EnsureLayer(k_ScannableLayer, log);

            if (layer < 0)
            {
                Debug.LogError("ScannerFlowBuilder: could not create the Scannable layer.");
                return;
            }

            // Before anything takes a reference: dedupe can destroy a controller, and a stale
            // reference to a destroyed object throws further down.
            DedupeScanners(log);

            ScannerInspectController controller =
                Object.FindFirstObjectByType<ScannerInspectController>(FindObjectsInactive.Include);

            if (controller == null)
            {
                Debug.LogError("ScannerFlowBuilder: no ScannerInspectController in the open scene. "
                    + "Run RootsDance > Build Scanner Test Rig first.");
                return;
            }

            // Built into the controller's own scene, not whichever scene happens to be active:
            // a serialized reference that crosses scenes is silently dropped when Unity saves, so
            // the beam would come back null at runtime and the scan stage would be skipped.
            DedupeFlowRoots(controller, log);

            GameObject root = EnsureChild(null, k_FlowRoot, log);

            if (root.scene != controller.gameObject.scene)
            {
                SceneManager.MoveGameObjectToScene(root, controller.gameObject.scene);
                log.Append("flow root moved into ").AppendLine(controller.gameObject.scene.name);
            }
            Transform player = FindPlayer();

            ScannerScanEffect effect = EnsureEffect(root, layer, log);
            ScannableTarget sample = EnsureSample(root, layer, player, log);
            ScannerProximityTrigger trigger = EnsureTrigger(controller, player, log);

            SetField(controller, "m_scanEffect", effect);
            SetField(trigger, "m_controller", controller);
            WireArmsView(controller, log);

            EnsurePromptPresenter(trigger, log);
            log.Append("sample at ").AppendLine(sample.transform.position.ToString("F2"));
            log.AppendLine("Scene left unsaved on purpose — review it, then save.");
            Debug.Log(log.ToString());
            EditorSceneManager.MarkSceneDirty(controller.gameObject.scene);
        }

        /// <summary>
        /// Points the read loop at the arms-driven view instead of the one that drove the Animator
        /// itself. Both implement IScannerView, so the controller does not change; what changes is
        /// that the raise now goes through the director, on the masked left-arm layer, and cannot
        /// stop whatever the right arm is doing.
        /// </summary>
        private static void WireArmsView(ScannerInspectController controller, StringBuilder log)
        {
            ArmsDirector director =
                Object.FindFirstObjectByType<ArmsDirector>(FindObjectsInactive.Include);

            if (director == null)
            {
                log.AppendLine("arms: no ArmsDirector — run RootsDance > Arms > Wire Player Arms Rig");
                return;
            }

            ScannerArmsView view = director.GetComponent<ScannerArmsView>();

            if (view == null)
            {
                view = Undo.AddComponent<ScannerArmsView>(director.gameObject);
                log.AppendLine("arms: added ScannerArmsView");
            }

            SetField(view, "m_director", director);
            SetField(controller, "m_viewBehaviour", view);

            // The prop the view hides and shows: the controller sits on the scanner's own root.
            SetField(view, "m_scannerRoot", controller.transform);

            ScannerAnimatorView legacy = director.GetComponent<ScannerAnimatorView>();

            if (legacy == null)
            {
                return;
            }

            // Carry the prop renderer across before the old view goes, then remove it so two
            // components cannot both answer PlayRaise.
            Undo.DestroyObjectImmediate(legacy);
            log.AppendLine("arms: removed the superseded ScannerAnimatorView");
        }

        /// <summary>
        /// Adds the layer the beam's custom pass filters on, if the project has not got it yet.
        /// Written through the TagManager's serialized object rather than by hand-editing
        /// ProjectSettings YAML, which guideline 06 forbids.
        /// </summary>
        private static int EnsureLayer(string name, StringBuilder log)
        {
            int existing = LayerMask.NameToLayer(name);

            if (existing >= 0)
            {
                log.Append("layer ").Append(name).AppendLine(": already present");
                return existing;
            }

            SerializedObject tagManager = new SerializedObject(
                AssetDatabase.LoadAllAssetsAtPath("ProjectSettings/TagManager.asset")[0]);
            SerializedProperty layers = tagManager.FindProperty("layers");

            // 0-7 are Unity's own; user layers start at 8.
            for (int i = 8; i < layers.arraySize; i++)
            {
                SerializedProperty slot = layers.GetArrayElementAtIndex(i);

                if (!string.IsNullOrEmpty(slot.stringValue))
                {
                    continue;
                }

                slot.stringValue = name;
                tagManager.ApplyModifiedProperties();
                log.Append("layer ").Append(name).Append(": created at ").AppendLine(i.ToString());
                return i;
            }

            return -1;
        }

        /// <summary>
        /// The beam: a global custom pass that redraws everything on the Scannable layer with the
        /// stripe material, plus an aimable emitter the effect sweeps from.
        /// </summary>
        private static ScannerScanEffect EnsureEffect(GameObject root, int layer, StringBuilder log)
        {
            GameObject holder = EnsureChild(root.transform, k_EffectName, log);
            ScannerScanEffect effect = holder.GetComponent<ScannerScanEffect>();

            if (effect == null)
            {
                effect = Undo.AddComponent<ScannerScanEffect>(holder);
            }

            CustomPassVolume volume = holder.GetComponent<CustomPassVolume>();

            if (volume == null)
            {
                volume = Undo.AddComponent<CustomPassVolume>(holder);
            }

            volume.isGlobal = true;
            volume.injectionPoint = CustomPassInjectionPoint.BeforePostProcess;

            if (volume.customPasses.Count == 0)
            {
                volume.customPasses.Add(new DrawRenderersCustomPass());
            }

            var pass = volume.customPasses[0] as DrawRenderersCustomPass;
            Material lines = AssetDatabase.LoadAssetAtPath<Material>(k_LinesMaterial);

            if (pass != null)
            {
                pass.name = "ScannerLines";
                pass.targetColorBuffer = CustomPass.TargetBuffer.Camera;
                pass.targetDepthBuffer = CustomPass.TargetBuffer.Camera;
                pass.layerMask = 1 << layer;
                pass.renderQueueType = CustomPass.RenderQueueType.AllOpaque;
                pass.overrideMaterial = lines;
                pass.overrideMaterialPassName = k_PassName;
            }

            if (lines == null)
            {
                log.AppendLine("beam: ScannerLines.mat not found, pass left without a material");
            }

            // Found by name across the whole scene, not under this object: the emitter is
            // reparented onto the hand socket below, so a child search here would miss it and
            // build another one every run. Extras from earlier runs are removed.
            GameObject emitter = AdoptOrCreateEmitter(holder.transform, log);

            SetField(effect, "m_volume", volume);
            SetField(effect, "m_emitter", emitter.transform);

            // The emitter rides the held scanner so the beam leaves the device, not the world origin.
            HandSocketFollow(emitter, log);
            return effect;
        }

        /// <summary>Keeps exactly one emitter, wherever a previous run left it.</summary>
        private static GameObject AdoptOrCreateEmitter(Transform fallbackParent, StringBuilder log)
        {
            GameObject kept = null;
            var extras = new List<GameObject>();

            foreach (Transform t in Object.FindObjectsByType<Transform>(
                FindObjectsInactive.Include, FindObjectsSortMode.None))
            {
                if (t == null || t.name != k_EmitterName)
                {
                    continue;
                }

                if (kept == null)
                {
                    kept = t.gameObject;
                }
                else
                {
                    extras.Add(t.gameObject);
                }
            }

            for (int i = 0; i < extras.Count; i++)
            {
                Undo.DestroyObjectImmediate(extras[i]);
            }

            if (extras.Count > 0)
            {
                log.Append("beam: removed ").Append(extras.Count).AppendLine(" duplicate emitter(s)");
            }

            return kept != null ? kept : EnsureChild(fallbackParent, k_EmitterName, log);
        }

        /// <summary>Parents the emitter to the left hand socket when the arms rig has one.</summary>
        private static void HandSocketFollow(GameObject emitter, StringBuilder log)
        {
            foreach (Component component
                in Object.FindObjectsByType<Component>(FindObjectsInactive.Include, FindObjectsSortMode.None))
            {
                if (component == null || component.GetType().Name != "HandSocket")
                {
                    continue;
                }

                SerializedObject so = new SerializedObject(component);
                SerializedProperty hand = so.FindProperty("m_hand");

                // 0 = Left, which is the hand the scanner is held in.
                if (hand == null || hand.enumValueIndex != 0)
                {
                    continue;
                }

                emitter.transform.SetParent(component.transform, false);
                log.AppendLine("beam: emitter parented to the left hand socket");
                return;
            }

            log.AppendLine("beam: no left HandSocket found, emitter left where it is");
        }

        /// <summary>A sample to walk up to, on the Scannable layer so the beam draws on it.</summary>
        private static ScannableTarget EnsureSample(GameObject root, int layer, Transform player,
            StringBuilder log)
        {
            Transform existing = root.transform.Find(k_SampleName);
            GameObject sample;

            if (existing != null)
            {
                sample = existing.gameObject;
            }
            else
            {
                sample = GameObject.CreatePrimitive(PrimitiveType.Cube);
                sample.name = k_SampleName;
                Undo.RegisterCreatedObjectUndo(sample, "Build Scan Flow Test");
                sample.transform.SetParent(root.transform, false);
                sample.transform.localScale = new Vector3(0.6f, 0.9f, 0.6f);

                Vector3 place = player == null
                    ? new Vector3(0f, 0.45f, 3f)
                    : player.position + player.forward * 3f + Vector3.up * 0.45f;
                sample.transform.position = place;
                log.AppendLine("sample: created");
            }

            sample.layer = layer;

            ScannableTarget target = sample.GetComponent<ScannableTarget>();

            if (target == null)
            {
                target = Undo.AddComponent<ScannableTarget>(sample);
                SetField(target, "m_displayName", "异色草样本");
            }

            return target;
        }

        private static ScannerProximityTrigger EnsureTrigger(ScannerInspectController controller,
            Transform player, StringBuilder log)
        {
            ScannerProximityTrigger trigger =
                controller.GetComponent<ScannerProximityTrigger>();

            if (trigger == null)
            {
                trigger = Undo.AddComponent<ScannerProximityTrigger>(controller.gameObject);
                log.AppendLine("trigger: added to " + controller.gameObject.name);
            }

            SetField(trigger, "m_player", player);

            // Reuse whatever channel the interaction raycaster already broadcasts prompts on, so
            // the hint lands in the HUD that is already listening.
            InteractionRaycasterPromptChannel(trigger, log);
            return trigger;
        }

        private static void InteractionRaycasterPromptChannel(ScannerProximityTrigger trigger,
            StringBuilder log)
        {
            foreach (Component component
                in Object.FindObjectsByType<Component>(FindObjectsInactive.Include, FindObjectsSortMode.None))
            {
                if (component == null || component.GetType().Name != "InteractionRaycaster")
                {
                    continue;
                }

                SerializedProperty channel =
                    new SerializedObject(component).FindProperty("m_promptChanged");

                if (channel == null || channel.objectReferenceValue == null)
                {
                    continue;
                }

                SetField(trigger, "m_promptChanged", channel.objectReferenceValue);
                log.AppendLine("hint: reusing the interaction prompt channel");
                return;
            }

            log.AppendLine("hint: no prompt channel found — assign one to see the hint text");
        }

        /// <summary>
        /// Keeps one scanner, and keeps it on the socket.
        /// <para>
        /// The test rig builder parents a fresh prop under the arms and clears the old one with a
        /// direct-child search, which misses a prop nested down on <c>hand.L</c>. That left two
        /// scanners in the scene: one adopted onto the unscaled socket, and one still hanging off
        /// the bone. Before the export pipeline was fixed the bone reported a lossy scale near 100,
        /// so the stray one rendered about a hundred times too large — and measuring the adopted
        /// one reported everything fine.
        /// </para>
        /// </summary>
        /// <summary>
        /// Collapses the flow root down to one. <see cref="EnsureChild"/> looks the root up with
        /// GameObject.Find, which only sees active objects and searches every loaded scene, so a
        /// run made with a different scene set open would build a second one beside the first; three
        /// had accumulated in the test level before this existed. The survivor is whichever root
        /// already sits in the controller's scene, because that is the one Build is about to wire.
        /// </summary>
        private static void DedupeFlowRoots(ScannerInspectController controller, StringBuilder log)
        {
            GameObject keep = null;
            var extras = new System.Collections.Generic.List<GameObject>();

            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (!scene.isLoaded)
                {
                    continue;
                }

                foreach (GameObject root in scene.GetRootGameObjects())
                {
                    if (root.name != k_FlowRoot)
                    {
                        continue;
                    }

                    bool preferred = keep == null
                        && scene == controller.gameObject.scene;

                    if (preferred)
                    {
                        keep = root;
                    }
                    else
                    {
                        extras.Add(root);
                    }
                }
            }

            if (keep == null && extras.Count > 0)
            {
                keep = extras[0];
                extras.RemoveAt(0);
            }

            foreach (GameObject extra in extras)
            {
                log.Append("flow: removed a duplicate ").Append(k_FlowRoot).Append(" from ")
                    .AppendLine(extra.scene.name);
                Undo.DestroyObjectImmediate(extra);
            }
        }

        private static void DedupeScanners(StringBuilder log)
        {
            ScannerInspectController[] scanners = Object.FindObjectsByType<ScannerInspectController>(
                FindObjectsInactive.Include, FindObjectsSortMode.None);

            if (scanners.Length <= 1)
            {
                return;
            }

            ScannerInspectController keep = null;

            foreach (ScannerInspectController candidate in scanners)
            {
                if (candidate.GetComponentInParent<HandSocket>() != null)
                {
                    keep = candidate;
                    break;
                }
            }

            keep = keep != null ? keep : scanners[0];

            foreach (ScannerInspectController extra in scanners)
            {
                if (extra == keep)
                {
                    continue;
                }

                log.Append("scanner: removed a duplicate parented to ")
                    .AppendLine(extra.transform.parent == null ? "<root>" : extra.transform.parent.name);
                Undo.DestroyObjectImmediate(extra.gameObject);
            }
        }

        /// <summary>
        /// Makes the hint visible. The HUD already carries an InteractPrompt label, but nothing was
        /// driving it — without a presenter the channel fires into nowhere and the prompt reads
        /// whatever was last typed into the prefab.
        /// </summary>
        private static void EnsurePromptPresenter(ScannerProximityTrigger trigger, StringBuilder log)
        {
            TextMeshProUGUI label = null;

            foreach (TextMeshProUGUI candidate
                in Object.FindObjectsByType<TextMeshProUGUI>(FindObjectsInactive.Include, FindObjectsSortMode.None))
            {
                if (candidate.gameObject.name == "InteractPrompt")
                {
                    label = candidate;
                    break;
                }
            }

            if (label == null)
            {
                log.AppendLine("hint: no InteractPrompt label in the HUD, presenter not added");
                return;
            }

            // On the label's parent, never on the label itself: the presenter hides the prompt by
            // deactivating the label's GameObject, so living there would switch itself off on the
            // first empty prompt and never hear another event again.
            GameObject host = label.transform.parent != null
                ? label.transform.parent.gameObject
                : label.gameObject;

            InteractionPromptPresenter existing =
                Object.FindFirstObjectByType<InteractionPromptPresenter>(FindObjectsInactive.Include);

            if (existing != null && existing.gameObject == host)
            {
                log.AppendLine("hint: presenter already on the right object");
                SetField(existing, "m_label", label);
                return;
            }

            if (existing != null)
            {
                log.Append("hint: moved the presenter off ").AppendLine(existing.gameObject.name);
                Undo.DestroyObjectImmediate(existing);
            }

            var presenter = Undo.AddComponent<InteractionPromptPresenter>(host);
            SetField(presenter, "m_label", label);

            // The label may have been left switched off by the presenter that used to live on it.
            label.gameObject.SetActive(true);

            SerializedProperty channel =
                new SerializedObject(trigger).FindProperty("m_promptChanged");

            if (channel != null && channel.objectReferenceValue != null)
            {
                SetField(presenter, "m_promptChanged", channel.objectReferenceValue);
            }

            log.AppendLine("hint: presenter added to the HUD's InteractPrompt label");
        }

        private static Transform FindPlayer()
        {
            FirstPersonController controller =
                Object.FindFirstObjectByType<FirstPersonController>(FindObjectsInactive.Include);
            return controller == null ? null : controller.transform;
        }

        private static GameObject EnsureChild(Transform parent, string name, StringBuilder log)
        {
            if (parent != null)
            {
                Transform found = parent.Find(name);

                if (found != null)
                {
                    return found.gameObject;
                }
            }
            else
            {
                GameObject existing = GameObject.Find(name);

                if (existing != null)
                {
                    return existing;
                }
            }

            var created = new GameObject(name);
            Undo.RegisterCreatedObjectUndo(created, "Build Scan Flow Test");

            if (parent != null)
            {
                created.transform.SetParent(parent, false);
            }

            log.Append("created ").AppendLine(name);
            return created;
        }

        private static void SetField(Object target, string field, Object value)
        {
            SerializedObject so = new SerializedObject(target);
            SerializedProperty property = so.FindProperty(field);

            if (property == null)
            {
                Debug.LogWarning($"ScannerFlowBuilder: {target.GetType().Name} has no '{field}'.");
                return;
            }

            property.objectReferenceValue = value;
            so.ApplyModifiedProperties();
        }

        private static void SetField(Object target, string field, string value)
        {
            SerializedObject so = new SerializedObject(target);
            SerializedProperty property = so.FindProperty(field);

            if (property == null)
            {
                return;
            }

            property.stringValue = value;
            so.ApplyModifiedProperties();
        }
    }
}

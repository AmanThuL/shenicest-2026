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

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Assembles the whole scan loop in the open gameplay scene, so it can be played end to end:
    /// walk up to a sample, the hint appears, the key raises the scanner, the beam sweeps the
    /// sample, the camera flies onto the screen, and closing the report lowers the arm again.
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

            ScannerInspectController controller =
                Object.FindFirstObjectByType<ScannerInspectController>(FindObjectsInactive.Include);

            if (controller == null)
            {
                Debug.LogError("ScannerFlowBuilder: no ScannerInspectController in the open scene. "
                    + "Run RootsDance > Build Scanner Test Rig first.");
                return;
            }

            GameObject root = EnsureChild(null, k_FlowRoot, log);
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

            ScannerAnimatorView legacy = director.GetComponent<ScannerAnimatorView>();

            if (legacy == null)
            {
                return;
            }

            // Carry the prop renderer across before the old view goes, then remove it so two
            // components cannot both answer PlayRaise.
            SerializedProperty renderer =
                new SerializedObject(legacy).FindProperty("m_scannerRenderer");

            if (renderer != null && renderer.objectReferenceValue != null)
            {
                SetField(view, "m_scannerRenderer", renderer.objectReferenceValue);
            }

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

            GameObject emitter = EnsureChild(holder.transform, k_EmitterName, log);
            SetField(effect, "m_volume", volume);
            SetField(effect, "m_emitter", emitter.transform);

            // The emitter rides the held scanner so the beam leaves the device, not the world origin.
            HandSocketFollow(emitter, log);
            return effect;
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
        /// Makes the hint visible. The HUD already carries an InteractPrompt label, but nothing was
        /// driving it — without a presenter the channel fires into nowhere and the prompt reads
        /// whatever was last typed into the prefab.
        /// </summary>
        private static void EnsurePromptPresenter(ScannerProximityTrigger trigger, StringBuilder log)
        {
            if (Object.FindFirstObjectByType<InteractionPromptPresenter>(FindObjectsInactive.Include) != null)
            {
                log.AppendLine("hint: a prompt presenter is already in the scene");
                return;
            }

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

            var presenter = Undo.AddComponent<InteractionPromptPresenter>(label.gameObject);
            SetField(presenter, "m_label", label);

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

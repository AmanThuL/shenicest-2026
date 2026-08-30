using System.Collections.Generic;
using System.Text;
using RootsDance.Player;
using RootsDance.Player.Arms;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Puts the arms driver into whatever scene is open, and takes the superseded pieces out.
    /// <para>
    /// Idempotent: running it twice changes nothing the second time, so it is safe on a scene that
    /// already has other work in it. It never saves — the human looks at the result and saves, or
    /// reverts the file.
    /// </para>
    /// The one structural change is a height anchor inserted above the arms. It has to be its own
    /// transform because <see cref="ArmsViewOffset"/> already writes the arms' local position for
    /// framing; two components writing one transform would fight, and framing and body height are
    /// different decisions with different owners.
    /// Menu: <c>RootsDance &gt; Arms &gt; Wire Player Arms Rig</c>.
    /// </summary>
    public static class ArmsRigWiringBuilder
    {
        private const string k_SetAsset = "Assets/RootsDance/Data/Arms/PlayerArmsActions.asset";
        private const string k_AnchorName = "ArmsHeightAnchor";
        private const string k_SocketRootName = "HandSockets";
        private const string k_LeftSocketName = "HandSocket_L";
        private const string k_RightSocketName = "HandSocket_R";
        private const string k_LeftBone = "hand.L";
        private const string k_RightBone = "hand.R";

        /// <summary>Components the director replaces. Matched by type name so this tool does not
        /// have to reference feature code that may not be committed yet.</summary>
        private static readonly string[] k_Superseded =
        {
            "ArmsClipDebugTrigger",
            "CrawlDebugTrigger",
            "HelmetDebugTrigger",
            "ScannerHandSocket",
        };

        [MenuItem("RootsDance/Arms/Wire Player Arms Rig")]
        public static void Wire()
        {
            var log = new StringBuilder("ArmsRigWiringBuilder\n");

            ArmsViewOffset offset = Object.FindFirstObjectByType<ArmsViewOffset>(FindObjectsInactive.Include);

            if (offset == null)
            {
                Debug.LogError("ArmsRigWiringBuilder: no ArmsViewOffset in the open scene, so the "
                    + "arms rig could not be found. Open the gameplay scene first.");
                return;
            }

            GameObject arms = offset.gameObject;
            ArmsActionSetSO set = AssetDatabase.LoadAssetAtPath<ArmsActionSetSO>(k_SetAsset);

            if (set == null)
            {
                Debug.LogError("ArmsRigWiringBuilder: run RootsDance > Arms > Create Or Update "
                    + "Action Set first.");
                return;
            }

            RemoveHeightAnchor(arms.transform, log);

            // Re-resolve across the reparent. Moving a prefab instance rebuilds it rather than
            // moving it, so every reference taken before this line can be dead afterwards — which
            // is exactly how the first attempt died, on a GameObject it had been handed itself.
            offset = Object.FindFirstObjectByType<ArmsViewOffset>(FindObjectsInactive.Include);

            if (offset == null)
            {
                Debug.LogError("ArmsRigWiringBuilder: the arms went missing across the reparent.");
                return;
            }

            arms = offset.gameObject;
            Transform socketRoot = arms.transform.parent;

            if (socketRoot == null)
            {
                Debug.LogError("ArmsRigWiringBuilder: the arms have no parent to hang sockets from.");
                return;
            }

            ArmsHeightRig height = Ensure<ArmsHeightRig>(arms, log);
            SetObjectField(height, "m_standingLocalY", 0f);

            ArmsDirector director = Ensure<ArmsDirector>(arms, log);
            SetObjectField(director, "m_actions", set);

            HandSocket left = EnsureSocket(socketRoot, k_LeftSocketName, HandSide.Left,
                FindBone(arms.transform, k_LeftBone), log);
            HandSocket right = EnsureSocket(socketRoot, k_RightSocketName, HandSide.Right,
                FindBone(arms.transform, k_RightBone), log);

            SetObjectField(director, "m_leftSocket", left);
            SetObjectField(director, "m_rightSocket", right);
            SetObjectField(director, "m_heightRig", height);

            ArmsDebugConsole console = Ensure<ArmsDebugConsole>(arms, log);
            SetObjectField(console, "m_director", director);
            SetObjectField(console, "m_actions", set);

            WireHelmet(arms, director, right, log);

            // Must run before the strip: the old socket component is where the grip offsets live,
            // and it is about to be removed.
            AdoptHeldProps(left, right, log);
            int stripped = StripSuperseded(log);

            log.Append("stripped ").Append(stripped).AppendLine(" superseded component(s)");
            log.AppendLine("Scene left unsaved on purpose — review it, then save.");
            Debug.Log(log.ToString());

            EditorSceneManager.MarkSceneDirty(arms.scene);
        }

        /// <summary>
        /// Takes the height anchor back out of the hierarchy, leaving the arms and the sockets
        /// hanging directly from the head.
        /// <para>
        /// It was a mistake to put it there. The framing tools read the arms' parent as "the head",
        /// so an object wedged between them silently became the head: the view bob was wired to it
        /// and moved the arms instead of the camera, and every per-clip correction was measured in
        /// the wrong frame. The height is a number on <see cref="ArmsHeightRig"/> now, applied by
        /// the one component that already owns the arms' pose.
        /// </para>
        /// </summary>
        private static void RemoveHeightAnchor(Transform arms, StringBuilder log)
        {
            Transform anchor = arms.parent;

            if (anchor == null || anchor.name != k_AnchorName)
            {
                return;
            }

            // The rig lives inside the Player prefab, and a prefab instance will not let its own
            // children be reparented in the scene: SetParent logs and returns, leaving the child
            // where it was. Doing the surgery on the asset is the only way it takes — and it also
            // means the change reaches every instance instead of this one scene.
            //
            // It has to be the OUTERMOST instance: the arms are an Arms.fbx model instance nested
            // inside the Player prefab, and a model is not an editable prefab. Asking the arms for
            // their nearest prefab hands back the FBX every time.
            GameObject outermost = PrefabUtility.GetOutermostPrefabInstanceRoot(anchor.gameObject);
            string assetPath = outermost == null
                ? null
                : PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(outermost);

            if (!string.IsNullOrEmpty(assetPath))
            {
                if (!assetPath.EndsWith(".prefab", System.StringComparison.OrdinalIgnoreCase))
                {
                    Debug.LogError("ArmsRigWiringBuilder: the height anchor sits inside "
                        + assetPath + ", which is not an editable prefab. Remove it by hand.");
                    return;
                }

                RemoveHeightAnchorFromPrefab(assetPath, log);
                return;
            }

            Transform head = anchor.parent;

            if (head == null)
            {
                log.AppendLine("height anchor: no grandparent to reparent onto, left in place");
                return;
            }

            if (!Reparent(anchor, head, log))
            {
                return;
            }

            log.Append("height anchor: removed, its children reparented onto ").AppendLine(head.name);
            Object.DestroyImmediate(anchor.gameObject);
        }

        /// <summary>
        /// Same surgery, performed on the prefab asset itself.
        /// </summary>
        private static void RemoveHeightAnchorFromPrefab(string assetPath, StringBuilder log)
        {
            GameObject contents = PrefabUtility.LoadPrefabContents(assetPath);

            try
            {
                Transform anchor = null;

                foreach (Transform t in contents.GetComponentsInChildren<Transform>(true))
                {
                    if (t.name == k_AnchorName)
                    {
                        anchor = t;
                        break;
                    }
                }

                if (anchor == null)
                {
                    log.Append("height anchor: not present in ").AppendLine(assetPath);
                    return;
                }

                Transform head = anchor.parent;

                if (head == null)
                {
                    log.AppendLine("height anchor: it is the prefab root, left in place");
                    return;
                }

                if (!Reparent(anchor, head, log))
                {
                    return;
                }

                Object.DestroyImmediate(anchor.gameObject);
                PrefabUtility.SaveAsPrefabAsset(contents, assetPath);
                log.Append("height anchor: removed from ").Append(assetPath)
                    .Append(", children reparented onto ").AppendLine(head.name);
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(contents);
            }
        }

        /// <summary>
        /// Moves every child of <paramref name="from"/> onto <paramref name="to"/>, keeping world
        /// placement. Returns false if a child would not move: Unity refuses some reparents by
        /// logging rather than throwing, and a loop that trusts childCount to fall spins forever.
        /// </summary>
        private static bool Reparent(Transform from, Transform to, StringBuilder log)
        {
            for (int i = from.childCount - 1; i >= 0; i--)
            {
                Transform child = from.GetChild(i);
                child.SetParent(to, true);

                if (child.parent == from)
                {
                    log.Append("height anchor: ").Append(child.name)
                        .AppendLine(" refused to reparent, anchor left in place");
                    return false;
                }
            }

            return true;
        }

        private static HandSocket EnsureSocket(Transform socketRoot, string name, HandSide hand,
            Transform bone, StringBuilder log)
        {
            Transform root = socketRoot.Find(k_SocketRootName);

            if (root == null)
            {
                var created = new GameObject(k_SocketRootName);
                Undo.RegisterCreatedObjectUndo(created, "Wire Player Arms Rig");
                created.transform.SetParent(socketRoot, false);
                root = created.transform;
            }

            Transform existing = root.Find(name);

            if (existing == null)
            {
                var created = new GameObject(name);
                Undo.RegisterCreatedObjectUndo(created, "Wire Player Arms Rig");
                created.transform.SetParent(root, false);
                existing = created.transform;
                log.Append("socket ").Append(name).AppendLine(": created");
            }

            HandSocket socket = existing.GetComponent<HandSocket>();

            if (socket == null)
            {
                socket = Undo.AddComponent<HandSocket>(existing.gameObject);
            }

            if (bone == null)
            {
                log.Append("socket ").Append(name).AppendLine(": bone not found, left unassigned");
            }

            socket.Configure(hand, bone, Vector3.zero, Quaternion.identity);
            EditorUtility.SetDirty(socket);
            return socket;
        }

        /// <summary>
        /// Points the helmet chain at the arms-driven view. The controller and the visor HUD both
        /// talk to IHelmetView, so only the reference changes; neither of them learns anything new.
        /// </summary>
        private static void WireHelmet(GameObject arms, ArmsDirector director, HandSocket right,
            StringBuilder log)
        {
            HelmetArmsView view = Ensure<HelmetArmsView>(arms, log);
            SetObjectField(view, "m_director", director);
            SetObjectField(view, "m_rightSocket", right);

            HelmetAnimatorView legacy = arms.GetComponent<HelmetAnimatorView>();

            if (legacy != null)
            {
                // The old view held the rigged helmet's renderer; carry it across before it goes.
                SerializedObject so = new SerializedObject(legacy);
                SerializedProperty renderer = so.FindProperty("m_helmetRenderer");

                if (renderer != null && renderer.objectReferenceValue != null)
                {
                    SetObjectField(view, "m_riggedHelmet", renderer.objectReferenceValue);
                }
            }

            foreach (HelmetController controller
                in Object.FindObjectsByType<HelmetController>(FindObjectsInactive.Include, FindObjectsSortMode.None))
            {
                SetObjectField(controller, "m_viewBehaviour", view);
                log.AppendLine("helmet: controller now points at HelmetArmsView");
            }
        }

        /// <summary>
        /// Moves whatever the old socket component was carrying onto the new socket, and this is
        /// the step that actually fixes the oversized prop.
        /// <para>
        /// The prop used to sit <em>inside</em> the imported arms hierarchy, where every bone
        /// carries a decomposed local scale of about 100. The old component hid that by writing a
        /// compensating 0.67 into the prop's local scale every late update. Removing it without
        /// moving the prop would leave the prop parented to a bone at lossy scale 100 with a stale
        /// local scale — which is exactly a prop roughly a hundred times too big. So the prop is
        /// reparented to the socket, which lives outside the model and is unscaled, and its local
        /// scale is reset to one. Its real size is its own prefab's business.
        /// </para>
        /// </summary>
        private static void AdoptHeldProps(HandSocket left, HandSocket right, StringBuilder log)
        {
            foreach (Component component
                in Object.FindObjectsByType<Component>(FindObjectsInactive.Include, FindObjectsSortMode.None))
            {
                if (component == null || component.GetType().Name != "ScannerHandSocket")
                {
                    continue;
                }

                SerializedObject old = new SerializedObject(component);
                SerializedProperty bone = old.FindProperty("m_handBone");
                SerializedProperty offset = old.FindProperty("m_holdPositionOffset");
                SerializedProperty rotation = old.FindProperty("m_holdRotationOffset");

                // The scanner is held in the left hand; that is what the old socket tracked.
                HandSocket socket = left != null ? left : right;

                if (socket == null)
                {
                    log.AppendLine("prop: no socket to adopt onto");
                    continue;
                }

                if (bone != null && bone.objectReferenceValue is Transform handBone)
                {
                    socket.Configure(
                        socket.Hand,
                        handBone,
                        offset == null ? Vector3.zero : offset.vector3Value,
                        rotation == null ? Quaternion.identity : rotation.quaternionValue);
                    EditorUtility.SetDirty(socket);
                }

                Transform prop = component.transform;
                Vector3 wasLossy = prop.lossyScale;

                Undo.SetTransformParent(prop, socket.transform, "Wire Player Arms Rig");
                prop.localPosition = Vector3.zero;
                prop.localRotation = Quaternion.identity;
                prop.localScale = Vector3.one;

                CarriedItem carried = prop.GetComponent<CarriedItem>();

                if (carried == null)
                {
                    carried = Undo.AddComponent<CarriedItem>(prop.gameObject);
                }

                SetObjectField(carried, "m_hand", (int)socket.Hand);

                log.Append("prop: ").Append(prop.name)
                    .Append(" adopted onto ").Append(socket.name)
                    .Append(" — world scale was ").Append(wasLossy.ToString("F3"))
                    .Append(", now ").AppendLine(prop.lossyScale.ToString("F3"));
            }
        }

        /// <summary>Removes the components the director makes redundant, wherever they sit.</summary>
        private static int StripSuperseded(StringBuilder log)
        {
            var doomed = new List<Component>();

            foreach (Component component
                in Object.FindObjectsByType<Component>(FindObjectsInactive.Include, FindObjectsSortMode.None))
            {
                if (component == null)
                {
                    continue;
                }

                string name = component.GetType().Name;

                for (int i = 0; i < k_Superseded.Length; i++)
                {
                    if (name == k_Superseded[i])
                    {
                        doomed.Add(component);
                        log.Append("strip ").Append(name).Append(" from ")
                            .AppendLine(component.gameObject.name);
                        break;
                    }
                }
            }

            for (int i = 0; i < doomed.Count; i++)
            {
                Undo.DestroyObjectImmediate(doomed[i]);
            }

            return doomed.Count;
        }

        private static T Ensure<T>(GameObject target, StringBuilder log) where T : Component
        {
            T component = target.GetComponent<T>();

            if (component != null)
            {
                return component;
            }

            log.Append("add ").Append(typeof(T).Name).Append(" to ").AppendLine(target.name);
            return Undo.AddComponent<T>(target);
        }

        private static Transform FindBone(Transform root, string boneName)
        {
            foreach (Transform t in root.GetComponentsInChildren<Transform>(true))
            {
                if (t.name == boneName)
                {
                    return t;
                }
            }

            return null;
        }

        private static void SetObjectField(Object target, string field, Object value)
        {
            SerializedObject so = new SerializedObject(target);
            SerializedProperty property = so.FindProperty(field);

            if (property == null)
            {
                Debug.LogWarning($"ArmsRigWiringBuilder: {target.GetType().Name} has no '{field}'.");
                return;
            }

            property.objectReferenceValue = value;
            so.ApplyModifiedProperties();
        }

        private static void SetObjectField(Object target, string field, int value)
        {
            SerializedObject so = new SerializedObject(target);
            SerializedProperty property = so.FindProperty(field);

            if (property == null)
            {
                return;
            }

            property.enumValueIndex = value;
            so.ApplyModifiedProperties();
        }

        private static void SetObjectField(Object target, string field, float value)
        {
            SerializedObject so = new SerializedObject(target);
            SerializedProperty property = so.FindProperty(field);

            if (property == null)
            {
                return;
            }

            property.floatValue = value;
            so.ApplyModifiedProperties();
        }
    }
}

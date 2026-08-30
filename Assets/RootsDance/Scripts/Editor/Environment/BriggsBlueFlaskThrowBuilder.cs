using RootsDance.Audio;
using RootsDance.Environment;
using RootsDance.Events;
using RootsDance.Interaction;
using RootsDance.Player;
using RootsDance.Player.Arms;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Wires the Briggs laboratory exit beat end to end: the blue flask becomes something the hand
    /// can take with the tube grab, the player learns to throw, the rune on the exit door becomes
    /// something to throw at, and the door stops opening for anyone who merely walks up to it.
    /// </summary>
    /// <remarks>
    /// <para>
    /// The flask, the door and the arms clips all landed separately and none of them knew about
    /// the others: the flask was a dressed prop with a collider, the door opened on proximity, and
    /// <c>grabGroundTube</c> / <c>holdTube</c> / <c>throw</c> were three clips with nothing asking
    /// for them. Everything this does is joining those up, which is why it is one tool rather than
    /// three — the wiring only makes sense as a whole, and half of it applied is a laboratory with
    /// an exit nobody can open.
    /// </para>
    /// <para>
    /// Idempotent: every step finds what it made last time and rewrites it, so this can be re-run
    /// after moving the flask or re-authoring the clips. It saves the scene and the prefabs it
    /// touches, which is the one thing to know before running it against a dirty checkout.
    /// </para>
    /// Menu: RootsDance &gt; Environment &gt; Wire Briggs Blue Flask Throw.
    /// </remarks>
    public static class BriggsBlueFlaskThrowBuilder
    {
        private const string k_LogPrefix = "BriggsBlueFlaskThrow";

        private const string k_GameplayScene =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";
        private const string k_FlaskPrefab = "Assets/RootsDance/Prefabs/Props/BlueFlask.prefab";
        private const string k_PlayerPrefab = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_ShatterPrefab = "Assets/RootsDance/Prefabs/VFX/BlueFlaskShatter.prefab";
        private const string k_ShatterMaterial = "Assets/RootsDance/VFX/VFX_BlueFlaskShatter.mat";
        private const string k_ShardSprite = "Assets/ThirdParty/VFX/KenneyParticlePack/circle_05.png";
        private const string k_PromptChannel = "Assets/RootsDance/Data/Events/InteractionPrompt.asset";
        private const string k_AudioChannel = "Assets/RootsDance/Data/Events/AudioCueRequested.asset";
        private const string k_ShatterCue = "Assets/RootsDance/Data/Audio/SFX_GlassShatter.asset";

        private const string k_DoorName = "BriggsAutomaticExitDoor";
        private const string k_TargetName = "BriggsExitRuneThrowTarget";
        private const string k_ImpactName = "ImpactPoint";
        private const string k_InteractablesRoot = "_Interactables";

        private const string k_FlaskDisplayName = "蓝色烧瓶";
        private const string k_GrabActionId = "grabGroundTube";

        /// <summary>Kilograms. Glassware: light, and never actually simulated once it is thrown.</summary>
        private const float k_FlaskMass = 0.5f;

        /// <summary>
        /// Metres, in the socket's own axes. The flask's pivot is on its base and the model is
        /// 1.08 m tall before the 0.45 the scene places it at, so this drops the origin far enough
        /// for the hand to close around the neck rather than around thin air below the base.
        /// Eyeball it in the Editor against <c>holdTube</c> — no measurement here can replace that.
        /// </summary>
        private static readonly Vector3 k_FlaskGrip = new Vector3(0f, -0.36f, 0f);

        /// <summary>
        /// Where the throw lands, in the exit door's own space: the middle of the rune inlay on the
        /// closed seam. The leaves are 4.6 m tall centred at y 2.25 and 0.28 m deep, and the inlay
        /// sits 0.148 m proud of the leaf centre on the room side — so this is the face of the
        /// rune, not the pivot of the door on the floor.
        /// </summary>
        private static readonly Vector3 k_ImpactLocal = new Vector3(0f, 2.25f, -0.15f);

        /// <summary>
        /// Where the player is measured from, in the door's own space: standing room in front of
        /// the door rather than the rune itself, so the offer follows the floor the player is on
        /// and not the height of the wall.
        /// </summary>
        private static readonly Vector3 k_ReachLocal = new Vector3(0f, 1.2f, -1.4f);

        /// <summary>Metres from the reach point. Roughly the front third of the laboratory.</summary>
        private const float k_ThrowRange = 6.5f;

        /// <summary>The rune's own glow, so the break and the door that answers it read as one colour.</summary>
        private static readonly Color k_ShatterColor = new Color(0.18f, 0.55f, 1f, 0.85f);

        [MenuItem("RootsDance/Environment/Wire Briggs Blue Flask Throw")]
        public static void Apply()
        {
            Material material = EnsureShatterMaterial();
            GameObject shatter = EnsureShatterPrefab(material);

            WireFlaskPrefab();
            WirePlayerPrefab();
            WireScene(shatter);

            AssetDatabase.SaveAssets();
            Debug.Log($"[{k_LogPrefix}] Flask, player, rune target and door are wired.");
        }

        /// <summary>One-shot entry point for <c>-batchmode -executeMethod</c>.</summary>
        public static void ApplyFromCommandLine()
        {
            EditorSceneManager.OpenScene(k_GameplayScene, OpenSceneMode.Single);
            Apply();

            if (Application.isBatchMode)
            {
                EditorApplication.Exit(0);
            }
        }

        // ---- The flask ------------------------------------------------------------------------

        /// <summary>
        /// Gives the dressed flask the four things a thrown pickup needs: physics so it can be put
        /// back down, a grip so the hand holds it by the neck, a registration so the proximity
        /// offer can see it, and the arc that carries it to the rune.
        /// </summary>
        private static void WireFlaskPrefab()
        {
            GameObject root = PrefabUtility.LoadPrefabContents(k_FlaskPrefab);

            if (root == null)
            {
                Debug.LogError($"[{k_LogPrefix}] could not open {k_FlaskPrefab}.");
                return;
            }

            try
            {
                Rigidbody body = Ensure<Rigidbody>(root);
                body.mass = k_FlaskMass;
                body.interpolation = RigidbodyInterpolation.Interpolate;

                Collider[] colliders = root.GetComponentsInChildren<Collider>(true);

                CarriedItem item = Ensure<CarriedItem>(root);
                SerializedObject serializedItem = new SerializedObject(item);
                serializedItem.FindProperty("m_hand").enumValueIndex = (int)HandSide.Right;
                serializedItem.FindProperty("m_kind").enumValueIndex = (int)CarriedKind.Flask;
                serializedItem.FindProperty("m_gripPosition").vector3Value = k_FlaskGrip;
                serializedItem.FindProperty("m_gripRotation").quaternionValue = Quaternion.identity;
                serializedItem.FindProperty("m_body").objectReferenceValue = body;

                SerializedProperty list = serializedItem.FindProperty("m_colliders");
                list.arraySize = colliders.Length;

                for (int i = 0; i < colliders.Length; i++)
                {
                    list.GetArrayElementAtIndex(i).objectReferenceValue = colliders[i];
                }

                serializedItem.ApplyModifiedPropertiesWithoutUndo();

                GroundPickup pickup = Ensure<GroundPickup>(root);
                SerializedObject serializedPickup = new SerializedObject(pickup);
                serializedPickup.FindProperty("m_displayName").stringValue = k_FlaskDisplayName;
                serializedPickup.FindProperty("m_pickupActionId").stringValue = k_GrabActionId;
                serializedPickup.ApplyModifiedPropertiesWithoutUndo();

                // Present on the prefab rather than added at throw time so the arc is tunable in
                // the Inspector; the thrower can add one, but only as a way not to soft-lock.
                Ensure<ThrownItemFlight>(root);

                PrefabUtility.SaveAsPrefabAsset(root, k_FlaskPrefab);
                Debug.Log($"[{k_LogPrefix}] flask is a '{k_GrabActionId}' pickup that can be thrown.");
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(root);
            }
        }

        // ---- The player -----------------------------------------------------------------------

        /// <summary>
        /// Adds the throw offer next to the pickup offer, and introduces the two: they share the
        /// prompt channel, and without the reference they take turns writing to it.
        /// </summary>
        private static void WirePlayerPrefab()
        {
            GameObject root = PrefabUtility.LoadPrefabContents(k_PlayerPrefab);

            if (root == null)
            {
                Debug.LogError($"[{k_LogPrefix}] could not open {k_PlayerPrefab}.");
                return;
            }

            try
            {
                HandSocket socket = RightHand(root);
                ArmsDirector director = root.GetComponentInChildren<ArmsDirector>(true);
                PlayerInputReader input = root.GetComponentInChildren<PlayerInputReader>(true);
                StringEventChannelSO prompt =
                    AssetDatabase.LoadAssetAtPath<StringEventChannelSO>(k_PromptChannel);

                if (socket == null || director == null)
                {
                    Debug.LogError($"[{k_LogPrefix}] the Player has no right HandSocket or no "
                        + "ArmsDirector; run 'RootsDance > Arms > Wire Player Arms Rig' first.");
                    return;
                }

                ThrowProximityTrigger throwTrigger = root.GetComponentInChildren<ThrowProximityTrigger>(true);

                if (throwTrigger == null)
                {
                    throwTrigger = root.AddComponent<ThrowProximityTrigger>();
                }

                SerializedObject serializedThrow = new SerializedObject(throwTrigger);
                serializedThrow.FindProperty("m_socket").objectReferenceValue = socket;
                serializedThrow.FindProperty("m_player").objectReferenceValue = root.transform;
                serializedThrow.FindProperty("m_input").objectReferenceValue = input;
                serializedThrow.FindProperty("m_director").objectReferenceValue = director;
                serializedThrow.FindProperty("m_promptChanged").objectReferenceValue = prompt;
                serializedThrow.FindProperty("m_range").floatValue = k_ThrowRange;
                serializedThrow.ApplyModifiedPropertiesWithoutUndo();

                PickupProximityTrigger pickTrigger =
                    root.GetComponentInChildren<PickupProximityTrigger>(true);

                if (pickTrigger != null)
                {
                    SerializedObject serializedPick = new SerializedObject(pickTrigger);
                    serializedPick.FindProperty("m_director").objectReferenceValue = director;
                    serializedPick.FindProperty("m_throwTrigger").objectReferenceValue = throwTrigger;
                    serializedPick.ApplyModifiedPropertiesWithoutUndo();
                }

                PrefabUtility.SaveAsPrefabAsset(root, k_PlayerPrefab);
                Debug.Log($"[{k_LogPrefix}] the player can throw what the right hand is holding.");
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(root);
            }
        }

        // ---- The rune wall --------------------------------------------------------------------

        /// <summary>
        /// Locks the exit door and puts the thing that unlocks it in front of the rune. The target
        /// is a scene object rather than a component on the door prefab because it is the one place
        /// in the game this happens: the prefab stays a door, and a second door somewhere else does
        /// not inherit a rune that opens this one.
        /// </summary>
        private static void WireScene(GameObject shatterEffect)
        {
            Scene scene = FindOrOpen(k_GameplayScene);
            Transform interactables = FindRoot(scene, k_InteractablesRoot);

            if (interactables == null)
            {
                Debug.LogError($"[{k_LogPrefix}] {k_GameplayScene} has no {k_InteractablesRoot} root.");
                return;
            }

            Transform doorTransform = interactables.Find(k_DoorName);

            if (doorTransform == null)
            {
                Debug.LogError($"[{k_LogPrefix}] no {k_DoorName} under {k_InteractablesRoot}; run "
                    + "'RootsDance > Environment > Apply Briggs Exit Door' first.");
                return;
            }

            AutomaticSlidingDoor door = doorTransform.GetComponent<AutomaticSlidingDoor>();
            SerializedObject serializedDoor = new SerializedObject(door);
            serializedDoor.FindProperty("m_opensOnApproach").boolValue = false;
            serializedDoor.ApplyModifiedPropertiesWithoutUndo();

            Transform target = interactables.Find(k_TargetName);

            if (target == null)
            {
                target = new GameObject(k_TargetName).transform;
                target.SetParent(interactables, false);
            }

            target.SetPositionAndRotation(
                doorTransform.TransformPoint(k_ReachLocal), doorTransform.rotation);

            Transform impact = target.Find(k_ImpactName);

            if (impact == null)
            {
                impact = new GameObject(k_ImpactName).transform;
                impact.SetParent(target, false);
            }

            impact.position = doorTransform.TransformPoint(k_ImpactLocal);

            ThrowTarget throwTarget = target.GetComponent<ThrowTarget>();

            if (throwTarget == null)
            {
                throwTarget = target.gameObject.AddComponent<ThrowTarget>();
            }

            SerializedObject serializedTarget = new SerializedObject(throwTarget);
            serializedTarget.FindProperty("m_impactPoint").objectReferenceValue = impact;
            serializedTarget.FindProperty("m_reachPoint").objectReferenceValue = target;
            serializedTarget.FindProperty("m_requiredKind").enumValueIndex = (int)CarriedKind.Flask;
            serializedTarget.FindProperty("m_door").objectReferenceValue = door;
            serializedTarget.FindProperty("m_shatterEffect").objectReferenceValue = shatterEffect;
            serializedTarget.FindProperty("m_shatterCue").objectReferenceValue =
                AssetDatabase.LoadAssetAtPath<AudioCueSO>(k_ShatterCue);
            serializedTarget.FindProperty("m_audioChannel").objectReferenceValue =
                AssetDatabase.LoadAssetAtPath<AudioCueEventChannelSO>(k_AudioChannel);
            serializedTarget.ApplyModifiedPropertiesWithoutUndo();

            if (AssetDatabase.LoadAssetAtPath<AudioCueSO>(k_ShatterCue) == null)
            {
                Debug.LogWarning($"[{k_LogPrefix}] {k_ShatterCue} does not exist yet; run "
                    + "'RootsDance > Audio > Bind Audio Clips' (or the batch build) and re-run "
                    + "this. The break will be silent until then.");
            }

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);

            Debug.Log($"[{k_LogPrefix}] the exit door is shut until the rune is broken at "
                + $"{impact.position:F2}.");
        }

        // ---- The break ------------------------------------------------------------------------

        private static Material EnsureShatterMaterial()
        {
            Texture2D sprite = AssetDatabase.LoadAssetAtPath<Texture2D>(k_ShardSprite);
            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_ShatterMaterial);
            bool created = material == null;

            if (created)
            {
                Shader shader = Shader.Find("HDRP/Unlit");

                if (shader == null)
                {
                    Debug.LogError($"[{k_LogPrefix}] HDRP/Unlit is missing.");
                    return null;
                }

                material = new Material(shader);
            }

            HDMaterial.SetSurfaceType(material, true);
            material.SetColor(Shader.PropertyToID("_UnlitColor"), k_ShatterColor);
            material.SetTexture(Shader.PropertyToID("_UnlitColorMap"), sprite);
            material.SetTexture(Shader.PropertyToID("_EmissiveColorMap"), sprite);
            HDMaterial.SetUseEmissiveIntensity(material, true);
            HDMaterial.SetEmissiveColor(material, k_ShatterColor);
            HDMaterial.SetEmissiveIntensity(material, 2600f, EmissiveIntensityUnit.Nits);
            HDMaterial.ValidateMaterial(material);

            if (created)
            {
                AssetDatabase.CreateAsset(material, k_ShatterMaterial);
            }
            else
            {
                EditorUtility.SetDirty(material);
            }

            return material;
        }

        /// <summary>
        /// The break itself: one burst of lit shards thrown out of the wall, gone in under a
        /// second. A placeholder in the same sense the opening's motes are — HDRP/Unlit ignores
        /// particle vertex colour, so the fade is size over lifetime rather than alpha.
        /// </summary>
        private static GameObject EnsureShatterPrefab(Material material)
        {
            GameObject root = new GameObject("BlueFlaskShatter");

            try
            {
                ParticleSystem system = root.AddComponent<ParticleSystem>();

                ParticleSystem.MainModule main = system.main;
                main.loop = false;
                main.duration = 0.4f;
                main.playOnAwake = true;
                main.simulationSpace = ParticleSystemSimulationSpace.World;
                main.startLifetime = new ParticleSystem.MinMaxCurve(0.35f, 0.9f);
                main.startSize = new ParticleSystem.MinMaxCurve(0.03f, 0.11f);
                main.startSpeed = new ParticleSystem.MinMaxCurve(1.8f, 5.5f);
                main.startColor = Color.white;
                main.gravityModifier = 1.1f;
                main.maxParticles = 90;

                ParticleSystem.EmissionModule emission = system.emission;
                emission.enabled = true;
                emission.rateOverTime = 0f;
                emission.SetBursts(new[] { new ParticleSystem.Burst(0f, 48) });

                // A hemisphere pointing back into the room: the flask hits a wall, so nothing
                // should come out of the far side of it.
                ParticleSystem.ShapeModule shape = system.shape;
                shape.enabled = true;
                shape.shapeType = ParticleSystemShapeType.Hemisphere;
                shape.radius = 0.08f;
                shape.rotation = new Vector3(-90f, 0f, 0f);

                ParticleSystem.SizeOverLifetimeModule sizeOverLifetime = system.sizeOverLifetime;
                sizeOverLifetime.enabled = true;
                AnimationCurve fade = new AnimationCurve(
                    new Keyframe(0f, 1f), new Keyframe(0.55f, 0.8f), new Keyframe(1f, 0f));
                sizeOverLifetime.size = new ParticleSystem.MinMaxCurve(1f, fade);

                ParticleSystemRenderer renderer = system.GetComponent<ParticleSystemRenderer>();
                renderer.renderMode = ParticleSystemRenderMode.Stretch;
                renderer.velocityScale = 0.05f;
                renderer.lengthScale = 2.4f;
                renderer.sharedMaterial = material;
                renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                renderer.receiveShadows = false;

                return PrefabUtility.SaveAsPrefabAsset(root, k_ShatterPrefab);
            }
            finally
            {
                Object.DestroyImmediate(root);
            }
        }

        // ---- Plumbing -------------------------------------------------------------------------

        private static T Ensure<T>(GameObject target) where T : Component
        {
            T component = target.GetComponent<T>();

            return component == null ? target.AddComponent<T>() : component;
        }

        private static HandSocket RightHand(GameObject root)
        {
            foreach (HandSocket socket in root.GetComponentsInChildren<HandSocket>(true))
            {
                if (socket.Hand == HandSide.Right)
                {
                    return socket;
                }
            }

            return null;
        }

        private static Scene FindOrOpen(string path)
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.path == path)
                {
                    return scene;
                }
            }

            return EditorSceneManager.OpenScene(path, OpenSceneMode.Additive);
        }

        private static Transform FindRoot(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == name)
                {
                    return root.transform;
                }
            }

            return null;
        }
    }
}

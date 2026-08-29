using System;
using RootsDance.App;
using RootsDance.Cameras;
using RootsDance.Chase;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Editor.DevPlay;
using RootsDance.Player;
using RootsDance.World;
using UnityEditor;
using UnityEditor.Animations;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Wires the wrong-cycle chase into both of its scenes: the boss and its director into the
    /// greenhouse interior (with the exit portal at the south entrance), the resuming director,
    /// the boss and the car-in-view victory volume into the outdoor level, plus the panic and
    /// free-fall camera extensions on each first-person camera and the Dev Play checkpoint that
    /// starts the whole segment. Repeatable: existing objects are found and re-pointed, never
    /// duplicated.
    /// </summary>
    public static class MonsterChaseSetupBuilder
    {
        private const string k_GreenhouseGameplayPath =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Gameplay.unity";
        private const string k_MainGameplayPath =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";

        private const string k_MonsterPrefabPath = "Assets/RootsDance/Prefabs/Characters/ChaseMonster.prefab";
        private const string k_BossFbxPath = "Assets/RootsDance/Meshes/Characters/Boss.fbx";
        private const string k_BossClipName = "Boss_Chase";
        private const string k_BossControllerPath =
            "Assets/RootsDance/Animations/Boss/Boss.controller";
        private const string k_EnemyConfigPath = "Assets/RootsDance/Data/Config/EnemyConfig.asset";

        private const string k_FlagChannelPath = "Assets/RootsDance/Data/Events/FlagRaised.asset";
        private const string k_LevelChannelPath = "Assets/RootsDance/Data/Events/LoadLevelRequested.asset";
        private const string k_MainLevelPath = "Assets/RootsDance/Data/Levels/Main.asset";
        private const string k_GreenhouseLevelPath =
            "Assets/RootsDance/Data/Levels/GreenhouseInterior.asset";

        private const string k_CheckpointPath =
            "Assets/RootsDance/Data/DevPlay/GreenhouseInterior/03-03_MonsterChase.asset";

        // Greenhouse leg. The chase gets its own anchor rather than borrowing 03-02's
        // Checkpoint_CentralGreenhouse: Dev Play ignores a checkpoint's Position entirely once its
        // anchor resolves, so sharing an anchor meant 03-03 started the player in exactly the spot
        // 03-02 does, with no room to run. The player stands at (0, 1.05, 2) facing +Z, the boss
        // tears out of the north beds ahead of them, and the escape turns round and runs -Z out
        // through the entrance they came in by (anchor (0, 1.05, -10)), where the portal waits:
        // a 14 m run rather than the old 12, and all of it inside the lit hall (z within +/-7).
        //
        // The birth distance is the number that decides whether a chase happens at all. The boss
        // holds a Desired Gap of 9 m and slows to a stop inside it, so a birth 3.5 m from the
        // player left it standing still through the whole reveal AND the first shoulder check —
        // the player looked back at a statue. At 6 m it is moving within a stride of the turn.
        private const string k_ChaseStartAnchorName = "Checkpoint_ChaseStart";
        private static readonly Vector3 k_ChaseStartAnchor = new Vector3(0f, 1.05f, 2f);
        private static readonly Vector3 k_GreenhouseMonsterSpawn = new Vector3(0f, 0f, 8f);
        private const float k_GreenhouseMonsterYaw = 180f;
        private static readonly Vector3 k_GreenhousePortal = new Vector3(0f, 1.6f, -12f);
        private static readonly Vector3 k_GreenhousePortalSize = new Vector3(6f, 3.2f, 1.2f);
        private static readonly Vector3 k_ChaseCheckpointPosition = new Vector3(0f, 1.05f, 2f);
        private const float k_ChaseCheckpointYaw = 0f;

        // Shoulder checks, in seconds from the start of each leg. The greenhouse leg is over in
        // about five seconds (1.1 s birth, a beat to turn, 14 m at the 4.4 m/s sprint), so the old
        // second check at 10 s fired into an unloaded scene and was never seen.
        private static readonly float[] k_GreenhouseLookBacks = { 2.6f, 4.4f };
        private static readonly float[] k_MainLookBacks = { 2.5f, 10f };

        // Forest leg: resume in the maintenance-entrance pit (design anchor (+52, +4, 108)) facing
        // back along the chapter-00 route; the boss re-emerges up-slope behind the player, and the
        // victory volume spans the route just past the outer ridge, where the wake-up lowland and
        // the car (about (0, 3, -10)) come into view.
        private static readonly Vector3 k_MainResumeSpawn = new Vector3(52f, 6f, 108f);
        private const float k_MainResumeYaw = 235f;
        private static readonly Vector3 k_MainMonsterSpawn = new Vector3(57f, 8f, 112f);
        private static readonly Vector3 k_MainVictory = new Vector3(0f, 8f, 8f);
        private static readonly Vector3 k_MainVictorySize = new Vector3(60f, 24f, 12f);

        private static readonly string[] k_CheckpointFlags =
        {
            WorldFlags.k_LeftStartArea,
            WorldFlags.k_RadioBriefingStarted,
            WorldFlags.k_RadioBriefingFinished,
            WorldFlags.k_HelmetRemovable,
            WorldFlags.k_HelmetRemoved,
            WorldFlags.k_EnteredGrassBelt,
            WorldFlags.k_FirstInvestigationDone,
            WorldFlags.k_SawUndergroundNetwork,
            WorldFlags.k_MetFlowerSprite,
            WorldFlags.k_HeardAboutHer,
            WorldFlags.k_EnteredGreenhouse,
            WorldFlags.k_CirculationCore,
            WorldFlags.k_ChaseStarted,
        };

        [MenuItem("RootsDance/Chase/Build Monster Chase Setup")]
        public static void ApplyFromMenu()
        {
            ApplyAndSave();
        }

        /// <summary>Batch entry point for the deterministic chase wiring pass.</summary>
        public static void ApplyFromCommandLine()
        {
            ApplyAndSave();
        }

        public static void ApplyAndSave()
        {
            ThrowIfAnyOpenSceneIsDirty();
            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                GameObject monsterPrefab = EnsureMonsterPrefab();
                WireGreenhouseGameplay(monsterPrefab);
                WireMainGameplay(monsterPrefab);
                EnsureChaseCheckpoint();
                AssetDatabase.SaveAssets();
            }
            finally
            {
                if (originalSetup.Length > 0)
                {
                    EditorSceneManager.RestoreSceneManagerSetup(originalSetup);
                }
            }

            Debug.Log("MonsterChaseSetupBuilder: wired the greenhouse leg, the forest leg and the "
                + "03-03 checkpoint. Play it from RootsDance > Dev Play > Window.");
        }

        /// <summary>
        /// The pursuit tuning asset. Created with the values the prefab used to carry inline, so
        /// re-running this on an existing project changes no behaviour; kept untouched if present,
        /// because after the first run this file is the designer's to edit.
        /// </summary>
        private static EnemyConfigSO EnsureEnemyConfig()
        {
            EnemyConfigSO existing = AssetDatabase.LoadAssetAtPath<EnemyConfigSO>(k_EnemyConfigPath);

            if (existing != null)
            {
                return existing;
            }

            EnemyConfigSO config = ScriptableObject.CreateInstance<EnemyConfigSO>();
            AssetDatabase.CreateAsset(config, k_EnemyConfigPath);
            return config;
        }

        /// <summary>
        /// A controller that just loops the boss's chase cycle. Speed is driven from code — the
        /// clip is retimed by how fast the thing is actually travelling — so there is no state
        /// machine here and nothing to parameterise.
        /// </summary>
        private static RuntimeAnimatorController EnsureBossController()
        {
            RuntimeAnimatorController existing =
                AssetDatabase.LoadAssetAtPath<RuntimeAnimatorController>(k_BossControllerPath);

            if (existing != null)
            {
                return existing;
            }

            AnimationClip clip = null;

            foreach (UnityEngine.Object asset in AssetDatabase.LoadAllAssetsAtPath(k_BossFbxPath))
            {
                AnimationClip candidate = asset as AnimationClip;

                if (candidate != null && candidate.name == k_BossClipName)
                {
                    clip = candidate;
                    break;
                }
            }

            if (clip == null)
            {
                throw new InvalidOperationException(
                    k_BossFbxPath + " has no '" + k_BossClipName + "' clip to drive the boss.");
            }

            EnsureFolder(k_BossControllerPath);
            return AnimatorController.CreateAnimatorControllerAtPathWithClip(k_BossControllerPath, clip);
        }

        /// <summary>
        /// The boss prefab: the authored Boss mesh under one ChaseMonster, animated by its chase
        /// cycle. Rebuilt when it is missing, and re-pointed at the config and controller when it
        /// already exists, so an older prefab built from the blockout bodies is migrated in place.
        /// </summary>
        private static GameObject EnsureMonsterPrefab()
        {
            EnemyConfigSO config = EnsureEnemyConfig();
            RuntimeAnimatorController controller = EnsureBossController();
            GameObject existing = AssetDatabase.LoadAssetAtPath<GameObject>(k_MonsterPrefabPath);

            if (existing != null && existing.GetComponentInChildren<SkinnedMeshRenderer>(true) != null)
            {
                WireMonster(existing, config, controller);
                return existing;
            }

            GameObject bossModel = LoadRequired<GameObject>(k_BossFbxPath);
            GameObject root = new GameObject("ChaseMonster");

            try
            {
                GameObject body = (GameObject)PrefabUtility.InstantiatePrefab(bossModel);
                body.name = "Boss";
                body.transform.SetParent(root.transform, false);

                root.AddComponent<ChaseMonster>();
                WireMonster(root, config, controller);

                return PrefabUtility.SaveAsPrefabAsset(root, k_MonsterPrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        /// <summary>Points a ChaseMonster at its config and its animator, on a prefab or an instance.</summary>
        private static void WireMonster(
            GameObject monsterRoot, EnemyConfigSO config, RuntimeAnimatorController controller)
        {
            ChaseMonster monster = EnsureComponent<ChaseMonster>(monsterRoot);
            Animator animator = monsterRoot.GetComponentInChildren<Animator>(true);

            if (animator != null)
            {
                animator.runtimeAnimatorController = controller;
                animator.applyRootMotion = false;
                animator.cullingMode = AnimatorCullingMode.CullUpdateTransforms;
            }

            using (SerializedObject serialized = new SerializedObject(monster))
            {
                serialized.FindProperty("m_config").objectReferenceValue = config;
                serialized.FindProperty("m_animator").objectReferenceValue = animator;
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }

            EditorUtility.SetDirty(monsterRoot);
        }

        /// <summary>Creates the folders an asset path needs, so CreateAsset does not fail on them.</summary>
        private static void EnsureFolder(string assetPath)
        {
            string folder = System.IO.Path.GetDirectoryName(assetPath).Replace('\\', '/');

            if (AssetDatabase.IsValidFolder(folder))
            {
                return;
            }

            string[] parts = folder.Split('/');
            string built = parts[0];

            for (int i = 1; i < parts.Length; i++)
            {
                string next = built + "/" + parts[i];

                if (!AssetDatabase.IsValidFolder(next))
                {
                    AssetDatabase.CreateFolder(built, parts[i]);
                }

                built = next;
            }
        }

        private static void WireGreenhouseGameplay(GameObject monsterPrefab)
        {
            Scene scene = EditorSceneManager.OpenScene(k_GreenhouseGameplayPath, OpenSceneMode.Single);

            Transform player = FindRequiredRoot(scene, "Player");
            PanicViewShake shake = EnsurePanicShake(scene, player);
            EnsureFreeFallView(scene, player);
            EnsureChaseStartAnchor(scene);
            Transform chaseRoot = EnsureRoot(scene, "_Chase");

            Transform spawn = EnsureChild(chaseRoot, "MonsterSpawn");
            spawn.SetPositionAndRotation(
                k_GreenhouseMonsterSpawn, Quaternion.Euler(0f, k_GreenhouseMonsterYaw, 0f));

            ChaseMonster monster = EnsureMonsterInstance(chaseRoot, monsterPrefab, spawn);

            GameObject portal = EnsureChild(chaseRoot, "ExitPortal").gameObject;
            portal.transform.position = k_GreenhousePortal;
            BoxCollider portalBox = EnsureComponent<BoxCollider>(portal);
            portalBox.isTrigger = true;
            portalBox.size = k_GreenhousePortalSize;
            ChaseExitPortal exitPortal = EnsureComponent<ChaseExitPortal>(portal);

            using (SerializedObject serialized = new SerializedObject(exitPortal))
            {
                serialized.FindProperty("m_loadLevelRequested").objectReferenceValue =
                    LoadRequired<UnityEngine.Object>(k_LevelChannelPath);
                serialized.FindProperty("m_level").objectReferenceValue =
                    LoadRequired<UnityEngine.Object>(k_MainLevelPath);
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }

            portal.SetActive(false);

            ChaseDirector director = EnsureComponent<ChaseDirector>(
                EnsureChild(chaseRoot, "ChaseDirector").gameObject);
            WireDirector(director, shake, monster, spawn, player, resumeSpawn: null, armed: portal,
                lookBackDelays: k_GreenhouseLookBacks);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
        }

        private static void WireMainGameplay(GameObject monsterPrefab)
        {
            Scene scene = EditorSceneManager.OpenScene(k_MainGameplayPath, OpenSceneMode.Single);

            Transform player = FindRequiredRoot(scene, "Player");
            PanicViewShake shake = EnsurePanicShake(scene, player);
            EnsureFreeFallView(scene, player);
            Transform chaseRoot = EnsureRoot(scene, "_Chase");

            Transform resume = EnsureChild(chaseRoot, "ResumeSpawn");
            resume.SetPositionAndRotation(k_MainResumeSpawn, Quaternion.Euler(0f, k_MainResumeYaw, 0f));

            Transform spawn = EnsureChild(chaseRoot, "MonsterSpawn");
            spawn.SetPositionAndRotation(
                k_MainMonsterSpawn,
                Quaternion.Euler(0f, k_MainResumeYaw, 0f));

            ChaseMonster monster = EnsureMonsterInstance(chaseRoot, monsterPrefab, spawn);

            GameObject victory = EnsureChild(chaseRoot, "VictoryVolume").gameObject;
            victory.transform.position = k_MainVictory;
            BoxCollider victoryBox = EnsureComponent<BoxCollider>(victory);
            victoryBox.isTrigger = true;
            victoryBox.size = k_MainVictorySize;
            TriggerVolume victoryTrigger = EnsureComponent<TriggerVolume>(victory);

            using (SerializedObject serialized = new SerializedObject(victoryTrigger))
            {
                serialized.FindProperty("m_flagId").stringValue = WorldFlags.k_ChaseEscaped;
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }

            victory.SetActive(false);

            ChaseDirector director = EnsureComponent<ChaseDirector>(
                EnsureChild(chaseRoot, "ChaseDirector").gameObject);
            WireDirector(director, shake, monster, spawn, player, resume, victory, k_MainLookBacks);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
        }

        private static void WireDirector(
            ChaseDirector director, PanicViewShake shake, ChaseMonster monster, Transform spawn,
            Transform player, Transform resumeSpawn, GameObject armed, float[] lookBackDelays)
        {
            using (SerializedObject serialized = new SerializedObject(director))
            {
                serialized.FindProperty("m_flagRaised").objectReferenceValue =
                    LoadRequired<UnityEngine.Object>(k_FlagChannelPath);
                serialized.FindProperty("m_panicShake").objectReferenceValue = shake;
                serialized.FindProperty("m_monster").objectReferenceValue = monster;
                serialized.FindProperty("m_monsterSpawn").objectReferenceValue = spawn;
                serialized.FindProperty("m_player").objectReferenceValue = player;
                serialized.FindProperty("m_resumeSpawn").objectReferenceValue = resumeSpawn;

                SerializedProperty armedList = serialized.FindProperty("m_armWhenChasing");
                armedList.arraySize = 1;
                armedList.GetArrayElementAtIndex(0).objectReferenceValue = armed;

                SerializedProperty delays = serialized.FindProperty("m_lookBackDelays");
                delays.arraySize = lookBackDelays.Length;

                for (int i = 0; i < lookBackDelays.Length; i++)
                {
                    delays.GetArrayElementAtIndex(i).floatValue = lookBackDelays[i];
                }

                serialized.ApplyModifiedPropertiesWithoutUndo();
            }
        }

        private static ChaseMonster EnsureMonsterInstance(
            Transform chaseRoot, GameObject monsterPrefab, Transform spawn)
        {
            Transform existing = chaseRoot.Find("ChaseMonster");

            if (existing == null)
            {
                GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(monsterPrefab);
                existing = instance.transform;
                existing.SetParent(chaseRoot, false);
            }

            existing.SetPositionAndRotation(spawn.position, spawn.rotation);
            existing.gameObject.SetActive(false);
            return existing.GetComponent<ChaseMonster>();
        }

        private static PanicViewShake EnsurePanicShake(Scene scene, Transform player)
        {
            Transform camera = FindTransform(scene, "FirstPersonCamera");

            if (camera == null)
            {
                throw new InvalidOperationException(
                    scene.name + " has no FirstPersonCamera to carry PanicViewShake.");
            }

            PanicViewShake shake = camera.GetComponent<PanicViewShake>();

            if (shake == null)
            {
                shake = camera.gameObject.AddComponent<PanicViewShake>();
            }

            // The director drives it by reference; the flag fields stay empty on purpose, so a
            // sequence-raised flag cannot double-trigger what the director already did.
            using (SerializedObject serialized = new SerializedObject(shake))
            {
                serialized.FindProperty("m_flagRaised").objectReferenceValue =
                    LoadRequired<UnityEngine.Object>(k_FlagChannelPath);

                // Without this the run cycle rides on the panic envelope alone and bobs at 2.9
                // footfalls per second while the player stands still.
                serialized.FindProperty("m_controller").objectReferenceValue =
                    player.GetComponentInChildren<FirstPersonController>(true);
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }

            return shake;
        }

        /// <summary>
        /// The chase's own Dev Play anchor, under the scene's <c>_Anchors</c> root. It has to be a
        /// real anchor object: Dev Play resolves a checkpoint by anchor name and drops its Position
        /// on the floor as soon as the name matches something.
        /// </summary>
        private static void EnsureChaseStartAnchor(Scene scene)
        {
            Transform anchors = EnsureRoot(scene, "_Anchors");
            Transform anchor = EnsureChild(anchors, k_ChaseStartAnchorName);
            anchor.SetPositionAndRotation(
                k_ChaseStartAnchor, Quaternion.Euler(0f, k_ChaseCheckpointYaw, 0f));
        }

        /// <summary>The free-fall camera extension, wired to the scene's player controller.</summary>
        private static void EnsureFreeFallView(Scene scene, Transform player)
        {
            Transform camera = FindTransform(scene, "FirstPersonCamera");

            if (camera == null)
            {
                throw new InvalidOperationException(
                    scene.name + " has no FirstPersonCamera to carry FreeFallView.");
            }

            FreeFallView fall = camera.GetComponent<FreeFallView>();

            if (fall == null)
            {
                fall = camera.gameObject.AddComponent<FreeFallView>();
            }

            FirstPersonController controller = player.GetComponent<FirstPersonController>();

            using (SerializedObject serialized = new SerializedObject(fall))
            {
                serialized.FindProperty("m_controller").objectReferenceValue = controller;
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }
        }

        private static void EnsureChaseCheckpoint()
        {
            DevCheckpointSO checkpoint = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(k_CheckpointPath);

            if (checkpoint == null)
            {
                checkpoint = ScriptableObject.CreateInstance<DevCheckpointSO>();
                AssetDatabase.CreateAsset(checkpoint, k_CheckpointPath);
            }

            using (SerializedObject serialized = new SerializedObject(checkpoint))
            {
                serialized.FindProperty("m_label").stringValue = "03-03 Monster Chase";
                serialized.FindProperty("m_level").objectReferenceValue =
                    LoadRequired<UnityEngine.Object>(k_GreenhouseLevelPath);
                serialized.FindProperty("m_anchorName").stringValue = k_ChaseStartAnchorName;
                serialized.FindProperty("m_position").vector3Value = k_ChaseCheckpointPosition;
                serialized.FindProperty("m_yaw").floatValue = k_ChaseCheckpointYaw;
                serialized.FindProperty("m_snapToGround").boolValue = false;
                serialized.FindProperty("m_groundClearance").floatValue = 0f;
                serialized.FindProperty("m_timeOfDay").enumValueIndex = (int)CheckpointTimeOfDay.Night;

                SerializedProperty flags = serialized.FindProperty("m_flags");
                flags.arraySize = k_CheckpointFlags.Length;

                for (int i = 0; i < k_CheckpointFlags.Length; i++)
                {
                    flags.GetArrayElementAtIndex(i).stringValue = k_CheckpointFlags[i];
                }

                serialized.ApplyModifiedPropertiesWithoutUndo();
            }

            EditorUtility.SetDirty(checkpoint);
        }

        // ---- Small scene helpers ----------------------------------------------------------------

        private static T LoadRequired<T>(string path) where T : UnityEngine.Object
        {
            T asset = AssetDatabase.LoadAssetAtPath<T>(path);

            if (asset == null)
            {
                throw new System.IO.FileNotFoundException("Chase setup needs " + path);
            }

            return asset;
        }

        private static T EnsureComponent<T>(GameObject target) where T : Component
        {
            T component = target.GetComponent<T>();
            return component != null ? component : target.AddComponent<T>();
        }

        private static Transform EnsureRoot(Scene scene, string name)
        {
            Transform existing = FindRoot(scene, name);

            if (existing != null)
            {
                return existing;
            }

            GameObject created = new GameObject(name);
            SceneManager.MoveGameObjectToScene(created, scene);
            return created.transform;
        }

        private static Transform EnsureChild(Transform parent, string name)
        {
            Transform existing = parent.Find(name);

            if (existing != null)
            {
                return existing;
            }

            GameObject created = new GameObject(name);
            created.transform.SetParent(parent, false);
            return created.transform;
        }

        private static Transform FindRequiredRoot(Scene scene, string name)
        {
            Transform found = FindRoot(scene, name);

            if (found == null)
            {
                throw new InvalidOperationException(scene.name + " is missing the " + name + " root.");
            }

            return found;
        }

        private static Transform FindRoot(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == name)
                {
                    return roots[i].transform;
                }
            }

            return null;
        }

        private static Transform FindTransform(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                Transform[] transforms = roots[i].GetComponentsInChildren<Transform>(true);

                for (int t = 0; t < transforms.Length; t++)
                {
                    if (transforms[t].name == name)
                    {
                        return transforms[t];
                    }
                }
            }

            return null;
        }

        private static void ThrowIfAnyOpenSceneIsDirty()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.isDirty)
                {
                    throw new InvalidOperationException(
                        "Chase setup stopped because an open scene has unsaved changes: " + scene.path);
                }
            }
        }
    }
}

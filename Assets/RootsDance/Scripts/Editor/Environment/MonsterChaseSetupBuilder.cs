using System;
using RootsDance.App;
using RootsDance.Cameras;
using RootsDance.Chase;
using RootsDance.Core;
using RootsDance.Editor.DevPlay;
using RootsDance.World;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Wires the wrong-cycle chase into both of its scenes: the boss and its director into the
    /// Briggs greenhouse (with the exit portal at the north door), the resuming director, the boss
    /// and the car-in-view victory volume into the outdoor level, plus the panic camera extension
    /// on each first-person camera and the Dev Play checkpoint that starts the whole segment.
    /// Repeatable: existing objects are found and re-pointed, never duplicated.
    /// </summary>
    public static class MonsterChaseSetupBuilder
    {
        private const string k_BriggsGameplayPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";
        private const string k_MainGameplayPath =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";

        private const string k_MonsterPrefabPath = "Assets/RootsDance/Prefabs/Characters/ChaseMonster.prefab";
        private const string k_RootedFbxPath = "Assets/RootsDance/Meshes/Characters/Boss_Blockout_Rooted.fbx";
        private const string k_UprootedFbxPath = "Assets/RootsDance/Meshes/Characters/Boss_Blockout_Uprooted.fbx";

        private const string k_FlagChannelPath = "Assets/RootsDance/Data/Events/FlagRaised.asset";
        private const string k_LevelChannelPath = "Assets/RootsDance/Data/Events/LoadLevelRequested.asset";
        private const string k_MainLevelPath = "Assets/RootsDance/Data/Levels/Main.asset";
        private const string k_BriggsLevelPath = "Assets/RootsDance/Data/Levels/BriggsInterior.asset";

        private const string k_CheckpointPath =
            "Assets/RootsDance/Data/DevPlay/BriggsInterior/02-13_MonsterChase.asset";

        // Greenhouse leg: the player stands at the greenhouse checkpoint (6.8, 1, -3.2) facing
        // -Z (yaw 180), so the birth happens right in front of them; the escape runs +Z through
        // the lab and out the round door in the north wall (hole centre x 0, wall at z ~4.4-5).
        private static readonly Vector3 k_BriggsMonsterSpawn = new Vector3(6.8f, 0f, -6.8f);
        private static readonly Vector3 k_BriggsPortal = new Vector3(0f, 1.6f, 6.6f);
        private static readonly Vector3 k_BriggsPortalSize = new Vector3(5f, 3.2f, 1.2f);

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
                WireBriggsGameplay(monsterPrefab);
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
                + "02-13 checkpoint. Play it with RootsDance > Dev Play > Play Monster Chase (F9).");
        }

        /// <summary>The boss prefab: both blockout bodies under one ChaseMonster. Kept if it exists.</summary>
        private static GameObject EnsureMonsterPrefab()
        {
            GameObject existing = AssetDatabase.LoadAssetAtPath<GameObject>(k_MonsterPrefabPath);

            if (existing != null)
            {
                return existing;
            }

            GameObject rootedModel = LoadRequired<GameObject>(k_RootedFbxPath);
            GameObject uprootedModel = LoadRequired<GameObject>(k_UprootedFbxPath);

            GameObject root = new GameObject("ChaseMonster");

            try
            {
                GameObject rooted = (GameObject)PrefabUtility.InstantiatePrefab(rootedModel);
                rooted.name = "Rooted";
                rooted.transform.SetParent(root.transform, false);

                GameObject uprooted = (GameObject)PrefabUtility.InstantiatePrefab(uprootedModel);
                uprooted.name = "Uprooted";
                uprooted.transform.SetParent(root.transform, false);
                uprooted.SetActive(false);

                ChaseMonster monster = root.AddComponent<ChaseMonster>();

                using (SerializedObject serialized = new SerializedObject(monster))
                {
                    serialized.FindProperty("m_rootedBody").objectReferenceValue = rooted;
                    serialized.FindProperty("m_uprootedBody").objectReferenceValue = uprooted;
                    serialized.ApplyModifiedPropertiesWithoutUndo();
                }

                return PrefabUtility.SaveAsPrefabAsset(root, k_MonsterPrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void WireBriggsGameplay(GameObject monsterPrefab)
        {
            Scene scene = EditorSceneManager.OpenScene(k_BriggsGameplayPath, OpenSceneMode.Single);

            PanicViewShake shake = EnsurePanicShake(scene);
            Transform player = FindRequiredRoot(scene, "Player");
            Transform chaseRoot = EnsureRoot(scene, "_Chase");

            Transform spawn = EnsureChild(chaseRoot, "MonsterSpawn");
            spawn.SetPositionAndRotation(k_BriggsMonsterSpawn, Quaternion.identity);

            ChaseMonster monster = EnsureMonsterInstance(chaseRoot, monsterPrefab, spawn);

            GameObject portal = EnsureChild(chaseRoot, "ExitPortal").gameObject;
            portal.transform.position = k_BriggsPortal;
            BoxCollider portalBox = EnsureComponent<BoxCollider>(portal);
            portalBox.isTrigger = true;
            portalBox.size = k_BriggsPortalSize;
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
            WireDirector(director, shake, monster, spawn, player, resumeSpawn: null, armed: portal);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
        }

        private static void WireMainGameplay(GameObject monsterPrefab)
        {
            Scene scene = EditorSceneManager.OpenScene(k_MainGameplayPath, OpenSceneMode.Single);

            PanicViewShake shake = EnsurePanicShake(scene);
            Transform player = FindRequiredRoot(scene, "Player");
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
            WireDirector(director, shake, monster, spawn, player, resume, victory);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
        }

        private static void WireDirector(
            ChaseDirector director, PanicViewShake shake, ChaseMonster monster, Transform spawn,
            Transform player, Transform resumeSpawn, GameObject armed)
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

        private static PanicViewShake EnsurePanicShake(Scene scene)
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
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }

            return shake;
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
                serialized.FindProperty("m_label").stringValue = "02-13 Monster Chase";
                serialized.FindProperty("m_level").objectReferenceValue =
                    LoadRequired<UnityEngine.Object>(k_BriggsLevelPath);
                serialized.FindProperty("m_anchorName").stringValue = "Checkpoint_Greenhouse";
                serialized.FindProperty("m_position").vector3Value = new Vector3(6.8f, 1f, -3.2f);
                serialized.FindProperty("m_yaw").floatValue = 180f;
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

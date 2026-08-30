using NUnit.Framework;
using RootsDance.Chase;
using RootsDance.Companion;
using RootsDance.Core;
using RootsDance.Editor.DevPlay;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Tests.EditMode.Chase
{
    public class MonsterChaseSetupTests
    {
        private const string k_MonsterPrefabPath =
            "Assets/RootsDance/Prefabs/Characters/ChaseMonster.prefab";
        private const string k_GreenhouseGameplayPath =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Gameplay.unity";
        private const string k_MainGameplayPath =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";
        private const string k_IndoorCheckpointPath =
            "Assets/RootsDance/Data/DevPlay/GreenhouseInterior/03-03_MonsterChase.asset";
        private const string k_OutdoorCheckpointPath =
            "Assets/RootsDance/Data/DevPlay/Main/03-04_OutdoorMonsterChase.asset";

        [Test]
        public void MonsterVisual_AuthoredBackward_FacesRootForward()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_MonsterPrefabPath);
            Animator animator = prefab.GetComponentInChildren<Animator>(true);

            float yaw = animator.transform.localEulerAngles.y;

            Assert.That(Mathf.Abs(Mathf.DeltaAngle(yaw, 180f)), Is.LessThan(0.1f),
                "The Boss FBX faces backward unless its visual root is turned 180 degrees.");
        }

        [Test]
        public void GreenhouseDirector_ChaseStarts_HidesFlowerSprite()
        {
            Scene scene = EditorSceneManager.OpenScene(k_GreenhouseGameplayPath, OpenSceneMode.Additive);

            try
            {
                ChaseDirector director = FindInScene<ChaseDirector>(scene);
                FollowCompanion flower = FindInScene<FollowCompanion>(scene);
                SerializedProperty hidden = new SerializedObject(director).FindProperty("m_hideWhenChasing");

                Assert.That(hidden, Is.Not.Null,
                    "ChaseDirector has no hand-off reference for the original flower sprite.");
                Assert.That(hidden.objectReferenceValue, Is.SameAs(flower.gameObject),
                    "The chase starts without hiding the original flower sprite.");
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
            }
        }

        [Test]
        public void GreenhouseSpawn_PlayerStandingStill_BossCanAdvanceImmediately()
        {
            Scene scene = EditorSceneManager.OpenScene(k_GreenhouseGameplayPath, OpenSceneMode.Additive);

            try
            {
                ChaseDirector director = FindInScene<ChaseDirector>(scene);
                SerializedObject serialized = new SerializedObject(director);
                Transform player = serialized.FindProperty("m_player").objectReferenceValue as Transform;
                Transform spawn = serialized.FindProperty("m_monsterSpawn").objectReferenceValue as Transform;
                ChaseMonster monster = serialized.FindProperty("m_monster").objectReferenceValue as ChaseMonster;
                SerializedProperty configProperty = new SerializedObject(monster).FindProperty("m_config");
                Object config = configProperty.objectReferenceValue;
                float desiredGap = new SerializedObject(config).FindProperty("m_desiredGapMeters").floatValue;

                float spawnGap = Vector3.Distance(player.position, spawn.position);

                Assert.That(spawnGap, Is.GreaterThan(desiredGap),
                    "The Boss starts inside its hold gap, so it cannot move until the player runs.");
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
            }
        }

        [Test]
        public void GreenhouseCheckpoint_PlayerStartsFacingAwayFromBoss()
        {
            Scene scene = EditorSceneManager.OpenScene(k_GreenhouseGameplayPath, OpenSceneMode.Additive);

            try
            {
                ChaseDirector director = FindInScene<ChaseDirector>(scene);
                SerializedObject serialized = new SerializedObject(director);
                Transform spawn = serialized.FindProperty("m_monsterSpawn").objectReferenceValue as Transform;
                DevCheckpointSO checkpoint =
                    AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(k_IndoorCheckpointPath);
                Vector3 playerForward = Quaternion.Euler(0f, checkpoint.Yaw, 0f) * Vector3.forward;
                Vector3 directionToBoss =
                    Vector3.ProjectOnPlane(spawn.position - checkpoint.Position, Vector3.up).normalized;

                Assert.That(Vector3.Dot(playerForward, directionToBoss), Is.LessThan(-0.98f),
                    "The indoor chase starts with the player looking at the Boss instead of away from it.");
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
            }
        }

        [Test]
        public void OutdoorLeg_StartsAtWarehouseDoor_AndFinishesAtCar()
        {
            Scene scene = EditorSceneManager.OpenScene(k_MainGameplayPath, OpenSceneMode.Additive);

            try
            {
                ChaseDirector director = FindInScene<ChaseDirector>(scene);
                SerializedObject serialized = new SerializedObject(director);
                Transform resume = serialized.FindProperty("m_resumeSpawn").objectReferenceValue as Transform;
                Transform spawn = serialized.FindProperty("m_monsterSpawn").objectReferenceValue as Transform;
                GameObject victory = serialized.FindProperty("m_armWhenChasing")
                    .GetArrayElementAtIndex(0).objectReferenceValue as GameObject;
                ChaseMonster monster = serialized.FindProperty("m_monster").objectReferenceValue as ChaseMonster;
                Object config = new SerializedObject(monster).FindProperty("m_config").objectReferenceValue;
                float desiredGap = new SerializedObject(config)
                    .FindProperty("m_desiredGapMeters").floatValue;

                Vector3 warehouseDoor = new Vector3(31.285f, 8.9f, 108.91f);
                Vector3 oldCar = new Vector3(0.394f, 3.017f, -9.882f);
                Vector3 flatForward = Vector3.ProjectOnPlane(resume.forward, Vector3.up).normalized;
                Vector3 routeToCar = Vector3.ProjectOnPlane(oldCar - resume.position, Vector3.up).normalized;

                Assert.That(Vector3.Distance(resume.position, warehouseDoor), Is.LessThan(5f),
                    "The outdoor chase no longer resumes at the first warehouse entrance.");
                Assert.That(Vector3.Dot(flatForward, routeToCar), Is.GreaterThan(0.98f),
                    "The player does not face down the warehouse-to-car escape route.");
                Assert.That(Vector3.Distance(resume.position, spawn.position), Is.GreaterThan(desiredGap),
                    "The outdoor Boss starts inside its hold gap and waits for the player to run.");
                Assert.That(Vector3.Distance(victory.transform.position, oldCar), Is.LessThan(3f),
                    "The chase can finish before the player reaches the old car.");
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
            }
        }

        [Test]
        public void OutdoorCheckpoint_StartsMainLevelWithActiveChase()
        {
            DevCheckpointSO checkpoint =
                AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(k_OutdoorCheckpointPath);

            Assert.That(checkpoint, Is.Not.Null,
                "There is no direct Dev Play checkpoint for the outdoor chase leg.");
            Assert.That(checkpoint.Label, Is.EqualTo("03-04 Outdoor Monster Chase"));
            Assert.That(checkpoint.Level.name, Is.EqualTo("Main"));
            Assert.That(checkpoint.Position, Is.EqualTo(new Vector3(30f, 8.9f, 105f)));
            Assert.That(checkpoint.Yaw, Is.EqualTo(195f));
            Assert.That(checkpoint.SnapToGround, Is.False);
            Assert.That(checkpoint.Flags, Does.Contain(WorldFlags.k_ChaseStarted));
            Assert.That(checkpoint.Flags, Does.Not.Contain(WorldFlags.k_ChaseEscaped));
        }

        private static T FindInScene<T>(Scene scene) where T : Component
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                T component = roots[i].GetComponentInChildren<T>(true);

                if (component != null)
                {
                    return component;
                }
            }

            Assert.Fail(scene.name + " has no " + typeof(T).Name + ".");
            return null;
        }
    }
}

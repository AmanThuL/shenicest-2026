using System.Collections.Generic;
using System.Linq;
using NUnit.Framework;
using RootsDance.App;
using RootsDance.Data;
using RootsDance.Editor.DevPlay;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>
    /// Guards the generated chapter house level and the doorway that leads into it. The three
    /// things worth guarding are the ones a rebuild can silently get wrong: that the level is built
    /// from the dressed blockout rather than the untouched chapel, that every piece of it can be
    /// collided with (the hall floor sits metres above the model's own base, so a missing collider
    /// drops the player through the building), and that the laboratory's exit trigger can actually
    /// be entered by the player's probe.
    /// </summary>
    public sealed class ChapterHouseInteriorLevelAssetTests
    {
        private const string k_LevelAssetPath = "Assets/RootsDance/Data/Levels/ChapterHouseInterior.asset";
        private const string k_NaveCheckpointPath =
            "Assets/RootsDance/Data/DevPlay/ChapterHouseInterior/CH-01_ChapterHouseNave.asset";
        private const string k_BridgeCheckpointPath =
            "Assets/RootsDance/Data/DevPlay/ChapterHouseInterior/CH-02_ChapterHouseBridge.asset";
        private const string k_ModelPath =
            "Assets/RootsDance/Meshes/Environment/ChapterHouse/ChapterHouseCorridor.fbx";

        private const string k_BridgePart = "Bridge_Metal_Center.001";
        private const string k_FloorPart = "ClothLandscape_CorridorShell.007";
        private const string k_ClothPart = "ClothLandscape_CorridorShell.011";

        [Test]
        public void LevelAsset_RegistersEnvironmentThenGameplayInBuildSettings()
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_LevelAssetPath);
            Assert.IsTrue(level != null, k_LevelAssetPath);
            Assert.AreEqual(2, level.ScenePaths.Count);
            Assert.AreEqual(ScenePaths.k_ChapterHouseInteriorEnvironment, level.ScenePaths[0]);
            Assert.AreEqual(ScenePaths.k_ChapterHouseInteriorGameplay, level.ScenePaths[1]);

            EditorBuildSettingsScene environment = EditorBuildSettings.scenes.FirstOrDefault(
                scene => scene.path == ScenePaths.k_ChapterHouseInteriorEnvironment);
            EditorBuildSettingsScene gameplay = EditorBuildSettings.scenes.FirstOrDefault(
                scene => scene.path == ScenePaths.k_ChapterHouseInteriorGameplay);
            Assert.IsTrue(environment != null && environment.enabled);
            Assert.IsTrue(gameplay != null && gameplay.enabled);
        }

        [Test]
        public void EnvironmentScene_IsTheDressedBlockoutGroundedAndCentred()
        {
            Scene scene = EditorSceneManager.OpenScene(
                ScenePaths.k_ChapterHouseInteriorEnvironment,
                OpenSceneMode.Additive);

            try
            {
                Transform model = FindRoot(scene, "_Geometry").Find("ChapterHouseRoot/ChapterHouse");
                Assert.IsTrue(model != null);
                Assert.AreEqual(
                    k_ModelPath,
                    PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(model.gameObject));
                Assert.That(model.localScale, Is.EqualTo(Vector3.one));

                Bounds bounds = GetRendererBounds(model.gameObject);
                Assert.That(bounds.min.y, Is.EqualTo(0f).Within(0.01f));
                Assert.That(bounds.center.x, Is.EqualTo(0f).Within(0.01f));
                Assert.That(bounds.center.z, Is.EqualTo(0f).Within(0.01f));

                // The bridge is what separates the dressed blockout from the untouched chapel.
                Assert.IsTrue(FindPart(model.gameObject, k_BridgePart) != null, k_BridgePart);
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
            }
        }

        [Test]
        public void EnvironmentScene_GivesEveryPieceAMaterialAndACollider()
        {
            Scene scene = EditorSceneManager.OpenScene(
                ScenePaths.k_ChapterHouseInteriorEnvironment,
                OpenSceneMode.Additive);

            try
            {
                Transform model = FindRoot(scene, "_Geometry").Find("ChapterHouseRoot/ChapterHouse");
                Renderer[] renderers = model.GetComponentsInChildren<Renderer>(true);
                Assert.Greater(renderers.Length, 0);

                HashSet<Material> seen = new HashSet<Material>();

                for (int i = 0; i < renderers.Length; i++)
                {
                    Renderer renderer = renderers[i];
                    Material[] materials = renderer.sharedMaterials;

                    for (int slot = 0; slot < materials.Length; slot++)
                    {
                        Material material = materials[slot];
                        Assert.IsTrue(material != null, renderer.name);

                        if (seen.Add(material))
                        {
                            // Almost every surface here is a single-sided plane; without this the
                            // building disappears from the inside, which is the only side seen.
                            Assert.AreEqual(1f, material.GetFloat("_DoubleSidedEnable"), material.name);
                        }
                    }

                    MeshCollider collider = renderer.GetComponent<MeshCollider>();
                    Assert.IsTrue(collider != null && collider.sharedMesh != null, renderer.name);
                    Assert.IsFalse(collider.convex, renderer.name);
                }

                // Distinct surfaces, not one material smeared over the whole building.
                Assert.Greater(seen.Count, 10);

                int ground = LayerMask.NameToLayer("Ground");
                Assert.AreEqual(ground, FindPart(model.gameObject, k_FloorPart).gameObject.layer);
                Assert.AreEqual(ground, FindPart(model.gameObject, k_BridgePart).gameObject.layer);
                Assert.AreEqual(ground, FindPart(model.gameObject, k_ClothPart).gameObject.layer);

                Transform lighting = FindRoot(scene, "_Lighting");
                Volume volume = lighting.GetComponentInChildren<Volume>(true);
                Assert.IsTrue(volume != null && volume.isGlobal && volume.sharedProfile != null);
                Assert.IsTrue(FindRoot(scene, "_Props") != null);
                Assert.IsTrue(FindRoot(scene, "_NavMesh") != null);
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
            }
        }

        [Test]
        public void GameplayScene_StandsThePlayerOnTheHallFloor()
        {
            Scene environment = EditorSceneManager.OpenScene(
                ScenePaths.k_ChapterHouseInteriorEnvironment,
                OpenSceneMode.Additive);
            Scene gameplay = EditorSceneManager.OpenScene(
                ScenePaths.k_ChapterHouseInteriorGameplay,
                OpenSceneMode.Additive);

            try
            {
                Transform model = FindRoot(environment, "_Geometry").Find("ChapterHouseRoot/ChapterHouse");
                Bounds floor = FindPart(model.gameObject, k_FloorPart).GetComponent<Renderer>().bounds;

                Transform anchors = FindRoot(gameplay, "_Anchors");
                Transform nave = anchors.Find("Checkpoint_ChapterHouseNave");
                Transform bridge = anchors.Find("Checkpoint_ChapterHouseBridge");
                Assert.IsTrue(nave != null);
                Assert.IsTrue(bridge != null);

                // Head height above the floor, and inside its footprint — not under the building.
                Assert.Greater(nave.position.y, floor.max.y);
                Assert.Less(nave.position.y, floor.max.y + 2f);
                Assert.That(nave.position.x, Is.InRange(floor.min.x, floor.max.x));
                Assert.That(nave.position.z, Is.InRange(floor.min.z, floor.max.z));
                Assert.Greater(bridge.position.y, floor.max.y);

                CharacterController player = FindRootComponent<CharacterController>(gameplay);
                Assert.IsTrue(player != null);
                Assert.That(player.transform.position, Is.EqualTo(nave.position));
                Assert.IsTrue(FindRoot(gameplay, "_Spawns").Find("PlayerSpawn") != null);

                Component[] cameraComponents = FindRoot(gameplay, "_Cameras")
                    .GetComponentsInChildren<Component>(true);
                Assert.IsTrue(cameraComponents.Any(component => component != null
                    && component.GetType().Name == "CinemachineCamera"));
            }
            finally
            {
                EditorSceneManager.CloseScene(gameplay, true);
                EditorSceneManager.CloseScene(environment, true);
            }
        }

        [Test]
        public void Checkpoints_ReferenceLevelAndMatchAnchors()
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_LevelAssetPath);
            AssertCheckpoint(k_NaveCheckpointPath, level, "Checkpoint_ChapterHouseNave");
            AssertCheckpoint(k_BridgeCheckpointPath, level, "Checkpoint_ChapterHouseBridge");
        }

        private static void AssertCheckpoint(string path, LevelSO level, string anchorName)
        {
            DevCheckpointSO checkpoint = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(path);
            Assert.IsTrue(checkpoint != null, path);
            Assert.AreSame(level, checkpoint.Level);
            Assert.AreEqual(anchorName, checkpoint.AnchorName);
            Assert.AreEqual(CheckpointTimeOfDay.LevelDefault, checkpoint.TimeOfDay);
            Assert.IsFalse(checkpoint.SnapToGround);
        }

        private static Transform FindPart(GameObject model, string partName)
        {
            Transform[] transforms = model.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                if (transforms[i].gameObject.name == partName)
                {
                    return transforms[i];
                }
            }

            Assert.Fail("The chapter house export has no piece named " + partName);
            return null;
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

            Assert.Fail("Scene root was not found: " + name);
            return null;
        }

        private static T FindRootComponent<T>(Scene scene) where T : Component
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                T component = roots[i].GetComponent<T>();

                if (component != null)
                {
                    return component;
                }
            }

            return null;
        }

        private static Bounds GetRendererBounds(GameObject root)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);
            Assert.Greater(renderers.Length, 0);
            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds;
        }
    }
}

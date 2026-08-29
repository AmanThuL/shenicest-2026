using System.Linq;
using NUnit.Framework;
using RootsDance.App;
using RootsDance.Data;
using RootsDance.Editor.DevPlay;
using RootsDance.Editor.Environment;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>Guards the generated Chapter 03 level, its scale, materials and Dev Play contract.</summary>
    public sealed class GreenhouseInteriorLevelAssetTests
    {
        private const string k_LevelAssetPath = "Assets/RootsDance/Data/Levels/GreenhouseInterior.asset";
        private const string k_EntranceCheckpointPath =
            "Assets/RootsDance/Data/DevPlay/GreenhouseInterior/03-01_GreenhouseEntrance.asset";
        private const string k_CentralCheckpointPath =
            "Assets/RootsDance/Data/DevPlay/GreenhouseInterior/03-02_CentralGreenhouse.asset";
        private const string k_ModelPath =
            "Assets/RootsDance/Meshes/Environment/GAIA1/Buildings/Briggs_Greenhouse.fbx";

        [Test]
        public void LevelAsset_RegistersEnvironmentThenGameplayInBuildSettings()
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_LevelAssetPath);
            Assert.IsTrue(level != null, k_LevelAssetPath);
            Assert.AreEqual(2, level.ScenePaths.Count);
            Assert.AreEqual(ScenePaths.k_GreenhouseInteriorEnvironment, level.ScenePaths[0]);
            Assert.AreEqual(ScenePaths.k_GreenhouseInteriorGameplay, level.ScenePaths[1]);

            EditorBuildSettingsScene environment = EditorBuildSettings.scenes.FirstOrDefault(
                scene => scene.path == ScenePaths.k_GreenhouseInteriorEnvironment);
            EditorBuildSettingsScene gameplay = EditorBuildSettings.scenes.FirstOrDefault(
                scene => scene.path == ScenePaths.k_GreenhouseInteriorGameplay);
            Assert.IsTrue(environment != null && environment.enabled);
            Assert.IsTrue(gameplay != null && gameplay.enabled);
        }

        [Test]
        public void EnvironmentScene_UsesFullModelAtThirtyOneMetresWithInteriorMaterials()
        {
            Scene scene = EditorSceneManager.OpenScene(
                ScenePaths.k_GreenhouseInteriorEnvironment,
                OpenSceneMode.Additive);

            try
            {
                Transform geometry = FindRoot(scene, "_Geometry");
                Transform model = geometry.Find("GreenhouseRoot/Briggs_Greenhouse");
                Assert.IsTrue(model != null);
                Assert.AreEqual(k_ModelPath, PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(model.gameObject));
                Assert.That(model.localScale.x, Is.EqualTo(1.2f).Within(0.01f));
                Assert.That(model.localScale.y, Is.EqualTo(model.localScale.x).Within(0.0001f));
                Assert.That(model.localScale.z, Is.EqualTo(model.localScale.x).Within(0.0001f));

                Bounds bounds = GetRendererBounds(model.gameObject);
                Assert.That(bounds.size.y, Is.EqualTo(GreenhouseInteriorLevelBuilder.k_TargetHeight).Within(0.01f));
                Assert.That(bounds.min.y, Is.EqualTo(0f).Within(0.01f));
                Assert.That(bounds.center.x, Is.EqualTo(0f).Within(0.01f));
                Assert.That(bounds.center.z, Is.EqualTo(0f).Within(0.01f));

                Renderer[] renderers = model.GetComponentsInChildren<Renderer>(true);
                int metalCount = 0;
                int glassCount = 0;
                int stainedCount = 0;

                for (int rendererIndex = 0; rendererIndex < renderers.Length; rendererIndex++)
                {
                    Material[] materials = renderers[rendererIndex].sharedMaterials;

                    for (int materialIndex = 0; materialIndex < materials.Length; materialIndex++)
                    {
                        Material material = materials[materialIndex];
                        Assert.IsTrue(material != null, renderers[rendererIndex].name);

                        if (material.name == "GreenHouseMetal_Interior")
                        {
                            metalCount++;
                        }
                        else if (material.name == "GreenHouseGlass_Interior")
                        {
                            glassCount++;
                        }
                        else if (material.name == "GreenHouseStained_Interior")
                        {
                            stainedCount++;
                        }
                    }
                }

                Assert.Greater(metalCount, 0);
                Assert.Greater(glassCount, 0);
                Assert.Greater(stainedCount, 0);
                Assert.AreEqual(1f, FindMaterial(renderers, "GreenHouseMetal_Interior")
                    .GetFloat("_DoubleSidedEnable"));
                Assert.AreEqual(1f, FindMaterial(renderers, "GreenHouseGlass_Interior")
                    .GetFloat("_DoubleSidedEnable"));
                Assert.AreEqual(1f, FindMaterial(renderers, "GreenHouseStained_Interior")
                    .GetFloat("_DoubleSidedEnable"));
                AssertMaterialTextures(renderers, "GreenHouseMetal_Interior");
                AssertMaterialTextures(renderers, "GreenHouseGlass_Interior");
                AssertMaterialTextures(renderers, "GreenHouseStained_Interior");

                Transform floor = geometry.Find("WalkableFloor");
                Assert.IsTrue(floor != null);
                Assert.AreEqual(LayerMask.NameToLayer("Ground"), floor.gameObject.layer);
                Assert.IsTrue(floor.GetComponent<BoxCollider>() != null);

                Transform lighting = FindRoot(scene, "_Lighting");
                Volume volume = lighting.GetComponentInChildren<Volume>(true);
                Assert.IsTrue(volume != null && volume.isGlobal && volume.sharedProfile != null);
                Assert.IsTrue(FindRoot(scene, "_Props") != null);
                Transform beds = FindRoot(scene, "_Props").Find("BotanicalBeds");
                Assert.IsTrue(beds != null);
                Assert.AreEqual(24, beds.childCount);
                Assert.IsTrue(FindRoot(scene, "_NavMesh") != null);
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
            }
        }

        [Test]
        public void GameplayScene_HasPlayerCameraAndDirectCheckpointAnchors()
        {
            Scene scene = EditorSceneManager.OpenScene(
                ScenePaths.k_GreenhouseInteriorGameplay,
                OpenSceneMode.Additive);

            try
            {
                Transform anchors = FindRoot(scene, "_Anchors");
                Transform entrance = anchors.Find("Checkpoint_GreenhouseEntrance");
                Transform central = anchors.Find("Checkpoint_CentralGreenhouse");
                Assert.IsTrue(entrance != null);
                Assert.IsTrue(central != null);
                Assert.AreSame(anchors, entrance.parent);
                Assert.AreSame(anchors, central.parent);

                CharacterController player = FindRootComponent<CharacterController>(scene);
                Assert.IsTrue(player != null);
                Assert.That(player.height, Is.EqualTo(1.8f).Within(0.001f));
                Assert.That(player.transform.localScale, Is.EqualTo(Vector3.one));
                Assert.That(player.transform.position, Is.EqualTo(entrance.position));

                Component[] cameraComponents = FindRoot(scene, "_Cameras")
                    .GetComponentsInChildren<Component>(true);
                Assert.IsTrue(cameraComponents.Any(component => component != null
                    && component.GetType().Name == "CinemachineCamera"));
                Assert.IsTrue(FindRoot(scene, "_Spawns").Find("PlayerSpawn") != null);
                Assert.IsTrue(FindRoot(scene, "_Triggers") != null);
                Assert.IsTrue(FindRoot(scene, "_Interactables") != null);
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
            }
        }

        [Test]
        public void Checkpoints_ReferenceLevelAndMatchDirectAnchors()
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_LevelAssetPath);
            AssertCheckpoint(k_EntranceCheckpointPath, level, "Checkpoint_GreenhouseEntrance");
            AssertCheckpoint(k_CentralCheckpointPath, level, "Checkpoint_CentralGreenhouse");
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

        private static Material FindMaterial(Renderer[] renderers, string name)
        {
            for (int rendererIndex = 0; rendererIndex < renderers.Length; rendererIndex++)
            {
                Material[] materials = renderers[rendererIndex].sharedMaterials;

                for (int materialIndex = 0; materialIndex < materials.Length; materialIndex++)
                {
                    if (materials[materialIndex] != null && materials[materialIndex].name == name)
                    {
                        return materials[materialIndex];
                    }
                }
            }

            Assert.Fail("Material was not found: " + name);
            return null;
        }

        private static void AssertMaterialTextures(Renderer[] renderers, string name)
        {
            Material material = FindMaterial(renderers, name);
            Assert.IsTrue(material.GetTexture("_BaseColorMap") != null, name + " Base Map");
            Assert.IsTrue(material.GetTexture("_MaskMap") != null, name + " Mask Map");
            Assert.IsTrue(material.GetTexture("_NormalMap") != null, name + " Normal Map");
        }
    }
}

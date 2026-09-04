using System.Collections.Generic;
using System.Linq;
using NUnit.Framework;
using RootsDance.App;
using RootsDance.Data;
using RootsDance.Editor.DevPlay;
using RootsDance.Editor.Environment;
using RootsDance.Environment;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
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
        private const string k_BaseAtmosphereProfilePath =
            "Assets/RootsDance/Settings/VolumeProfiles/GreenhouseInteriorProfile.asset";
        private const string k_BloomAtmosphereProfilePath =
            "Assets/RootsDance/Settings/VolumeProfiles/GreenhouseInteriorBloomProfile.asset";
        private const string k_FantasySkyPath =
            "Assets/RootsDance/Textures/Environment/GreenhouseFantasySunsetCubemap.png";

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
        public void EnvironmentScene_UsesExteriorSunAndBloomingFantasySky()
        {
            Scene scene = EditorSceneManager.OpenScene(
                ScenePaths.k_GreenhouseInteriorEnvironment,
                OpenSceneMode.Additive);

            try
            {
                Transform lighting = FindRoot(scene, "_Lighting");
                Light[] lights = lighting.GetComponentsInChildren<Light>(true);
                Assert.IsFalse(lights.Any(light => light.type == LightType.Spot),
                    "The environment must not fake window light with authored spotlights.");
                Assert.IsTrue(lights.Any(light => light.type == LightType.Directional && light.name == "Sun"));

                LocalVolumetricFog[] exteriorFog = lighting.GetComponentsInChildren<LocalVolumetricFog>(true)
                    .Where(fog => fog.name.StartsWith("ExteriorFog_"))
                    .ToArray();
                Assert.AreEqual(4, exteriorFog.Length);
                Assert.IsTrue(exteriorFog.All(fog => fog.parameters.blendingMode
                    == LocalVolumetricFogBlendingMode.Max));

                GreenhouseBloomAtmosphere atmosphere =
                    lighting.GetComponentInChildren<GreenhouseBloomAtmosphere>(true);
                Assert.IsTrue(atmosphere != null);
                Volume bloomVolume = atmosphere.GetComponent<Volume>();
                Assert.IsTrue(bloomVolume != null && bloomVolume.isGlobal);
                Assert.AreEqual(0f, bloomVolume.weight);
                Assert.AreEqual(k_BloomAtmosphereProfilePath,
                    AssetDatabase.GetAssetPath(bloomVolume.sharedProfile));

                AssertFantasySky(k_BaseAtmosphereProfilePath);
                AssertFantasySky(k_BloomAtmosphereProfilePath);
                AssertBloomBrightnessTarget();
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
            }
        }

        [Test]
        public void EnvironmentScene_SpiralStairRisesFitPlayerStepOffset()
        {
            Scene environment = EditorSceneManager.OpenScene(
                ScenePaths.k_GreenhouseInteriorEnvironment,
                OpenSceneMode.Additive);
            Scene gameplay = EditorSceneManager.OpenScene(
                ScenePaths.k_GreenhouseInteriorGameplay,
                OpenSceneMode.Additive);

            try
            {
                Transform stair = environment.GetRootGameObjects()
                    .SelectMany(root => root.GetComponentsInChildren<Transform>(true))
                    .Single(item => item.name == "GreenhouseSpiralStair");
                MeshCollider stairCollider = stair.GetComponentInChildren<MeshCollider>();
                CharacterController player = FindRootComponent<CharacterController>(gameplay);
                Assert.IsTrue(stairCollider != null && stairCollider.sharedMesh != null);
                Assert.IsTrue(player != null);

                Mesh mesh = stairCollider.sharedMesh;
                Vector3[] vertices = mesh.vertices;
                int[] triangles = mesh.triangles;
                Dictionary<float, float> horizontalAreaByHeight = new Dictionary<float, float>();

                for (int i = 0; i < triangles.Length; i += 3)
                {
                    Vector3 a = stairCollider.transform.TransformPoint(vertices[triangles[i]]);
                    Vector3 b = stairCollider.transform.TransformPoint(vertices[triangles[i + 1]]);
                    Vector3 c = stairCollider.transform.TransformPoint(vertices[triangles[i + 2]]);
                    Vector3 cross = Vector3.Cross(b - a, c - a);

                    if (cross.normalized.y <= 0.99f)
                    {
                        continue;
                    }

                    float height = Mathf.Round(((a.y + b.y + c.y) / 3f) * 1000f) / 1000f;
                    float area = cross.magnitude * 0.5f;
                    horizontalAreaByHeight.TryGetValue(height, out float accumulatedArea);
                    horizontalAreaByHeight[height] = accumulatedArea + area;
                }

                float playerFootprintArea = Mathf.PI * player.radius * player.radius;
                float[] treadLevels = horizontalAreaByHeight
                    .Where(pair => pair.Value >= playerFootprintArea
                        && pair.Value <= playerFootprintArea * 10f)
                    .Select(pair => pair.Key)
                    .OrderBy(height => height)
                    .ToArray();
                Assert.Greater(treadLevels.Length, 2, "The collider exposes no player-sized stair treads.");

                float largestRise = 0f;

                for (int i = 1; i < treadLevels.Length; i++)
                {
                    largestRise = Mathf.Max(largestRise, treadLevels[i] - treadLevels[i - 1]);
                }

                Assert.That(largestRise, Is.EqualTo(0.317f).Within(0.002f));
                Assert.LessOrEqual(largestRise, player.stepOffset,
                    $"The greenhouse stair rises {largestRise:F3}m per tread, but the Player can only step "
                    + $"{player.stepOffset:F3}m.");
            }
            finally
            {
                EditorSceneManager.CloseScene(gameplay, true);
                EditorSceneManager.CloseScene(environment, true);
            }
        }

        [Test]
        public void CollapseRestore_UsesStaticCompletedStateWithoutDebrisBodies()
        {
            Scene environment = EditorSceneManager.OpenScene(
                ScenePaths.k_GreenhouseInteriorEnvironment,
                OpenSceneMode.Additive);
            Scene collapseScene = EditorSceneManager.OpenScene(
                ScenePaths.k_GreenhouseInteriorEnvironment2,
                OpenSceneMode.Additive);

            try
            {
                GreenhouseStairCollapse collapse = FindRootComponent<GreenhouseStairCollapse>(collapseScene);
                Assert.IsTrue(collapse != null);

                var serializedCollapse = new SerializedObject(collapse);
                GameObject rig = serializedCollapse.FindProperty("m_collapseRig").objectReferenceValue as GameObject;
                Assert.IsTrue(rig != null);

                Transform intact = environment.GetRootGameObjects()
                    .SelectMany(root => root.GetComponentsInChildren<Transform>(true))
                    .Single(item => item.name == "GreenhouseSpiralStair");

                collapse.RestoreCollapsedState();
                collapse.RestoreCollapsedState();

                Assert.IsFalse(intact.gameObject.activeSelf);
                Assert.IsTrue(rig.activeSelf);
                Assert.AreEqual(0, rig.GetComponentsInChildren<Rigidbody>(true).Length,
                    "Checkpoint restore must not rebuild debris physics.");

                MeshFilter[] pieces = rig.GetComponentsInChildren<MeshFilter>(true);
                MeshFilter lower = pieces.Single(piece => piece.name == "SpiralStair_Lower");
                Assert.IsTrue(lower.gameObject.activeSelf);
                Assert.AreEqual(LayerMask.NameToLayer("Ground"), lower.gameObject.layer);
                Assert.IsTrue(lower.GetComponent<MeshCollider>() != null);
                Assert.AreEqual(1, lower.GetComponents<MeshCollider>().Length,
                    "Repeated restore must not add duplicate static colliders.");
                Assert.IsTrue(pieces.Where(piece => piece != lower)
                    .All(piece => !piece.gameObject.activeSelf),
                    "Every upper fragment should already be gone in the restored aftermath.");
            }
            finally
            {
                EditorSceneManager.CloseScene(collapseScene, true);
                EditorSceneManager.CloseScene(environment, true);
            }
        }

        [Test]
        public void Checkpoints_ReferenceLevelAndMatchDirectAnchors()
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_LevelAssetPath);
            AssertCheckpoint(k_EntranceCheckpointPath, level, "Checkpoint_GreenhouseEntrance");

            DevCheckpointSO central = AssertCheckpoint(
                k_CentralCheckpointPath,
                level,
                "Checkpoint_CentralGreenhouse");
            Assert.That(central.Position, Is.EqualTo(new Vector3(0f, 2.19f, -8f)));
            Assert.That(central.Yaw, Is.EqualTo(0f).Within(0.01f));
            Assert.IsTrue(central.SnapToGround);
            Assert.That(central.GroundClearance, Is.EqualTo(1f).Within(0.01f));
            Assert.IsFalse(central.UseAnchorHeight);
        }

        [Test]
        public void CentralCheckpoint_PlayerCapsuleHasMovementClearance()
        {
            Scene environment = EditorSceneManager.OpenScene(
                ScenePaths.k_GreenhouseInteriorEnvironment,
                OpenSceneMode.Additive);
            Scene gameplay = EditorSceneManager.OpenScene(
                ScenePaths.k_GreenhouseInteriorGameplay,
                OpenSceneMode.Additive);

            try
            {
                Transform central = FindRoot(gameplay, "_Anchors").Find("Checkpoint_CentralGreenhouse");
                Assert.That(central.position, Is.EqualTo(new Vector3(0f, 2.19f, -8f)));
                Assert.That(central.eulerAngles.y, Is.EqualTo(0f).Within(0.01f));
                Physics.SyncTransforms();
                Vector3 bottom = central.position + Vector3.down * 0.4f;
                Vector3 top = central.position + Vector3.up * 0.4f;
                Collider[] overlaps = Physics.OverlapCapsule(
                    bottom,
                    top,
                    0.48f,
                    ~0,
                    QueryTriggerInteraction.Ignore);
                Assert.AreEqual(0, overlaps.Length,
                    "The 03-02 checkpoint still overlaps a blocking collider.");
            }
            finally
            {
                EditorSceneManager.CloseScene(gameplay, true);
                EditorSceneManager.CloseScene(environment, true);
            }
        }

        private static DevCheckpointSO AssertCheckpoint(string path, LevelSO level, string anchorName)
        {
            DevCheckpointSO checkpoint = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(path);
            Assert.IsTrue(checkpoint != null, path);
            Assert.AreSame(level, checkpoint.Level);
            Assert.AreEqual(anchorName, checkpoint.AnchorName);
            Assert.AreEqual(CheckpointTimeOfDay.LevelDefault, checkpoint.TimeOfDay);
            return checkpoint;
        }

        private static void AssertFantasySky(string profilePath)
        {
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(profilePath);
            Assert.IsTrue(profile != null, profilePath);
            Assert.IsTrue(profile.TryGet(out HDRISky sky));
            Assert.IsTrue(sky.hdriSky.value != null, profilePath);
            Assert.AreEqual(k_FantasySkyPath, AssetDatabase.GetAssetPath(sky.hdriSky.value));
        }

        private static void AssertBloomBrightnessTarget()
        {
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_BloomAtmosphereProfilePath);
            Assert.IsTrue(profile.TryGet(out Exposure exposure));
            Assert.IsTrue(profile.TryGet(out HDRISky sky));
            Assert.IsTrue(profile.TryGet(out Fog fog));
            Assert.IsTrue(profile.TryGet(out ColorAdjustments color));
            Assert.LessOrEqual(exposure.fixedExposure.value, 9.8f);
            Assert.GreaterOrEqual(sky.exposure.value, 12.8f);
            Assert.GreaterOrEqual(color.postExposure.value, 0.45f);
            Assert.That(fog.albedo.value.r, Is.EqualTo(fog.albedo.value.b).Within(0.03f));
            Assert.LessOrEqual(color.colorFilter.value.r, 0.7f);
            Assert.GreaterOrEqual(color.colorFilter.value.g, 0.95f);
            Assert.GreaterOrEqual(color.colorFilter.value.b, 1f);
            Assert.LessOrEqual(color.saturation.value, -20f);
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

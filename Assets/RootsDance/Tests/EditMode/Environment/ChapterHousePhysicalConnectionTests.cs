using System.Linq;
using NUnit.Framework;
using RootsDance.App;
using RootsDance.Data;
using RootsDance.Environment;
using RootsDance.Player;
using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>Guards the continuous laboratory-to-Chapter-House route and its scene composition.</summary>
    public sealed class ChapterHousePhysicalConnectionTests
    {
        private const string k_BriggsLevelPath = "Assets/RootsDance/Data/Levels/BriggsInterior.asset";
        private const string k_BriggsEnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment.unity";
        private const string k_BriggsGameplayPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";
        private const string k_BriggsEnvironment2Path =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment_2.unity";

        [Test]
        public void BriggsLevel_LoadsBothConnectedPartScenes()
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_BriggsLevelPath);
            Assert.IsNotNull(level);
            Assert.AreEqual(5, level.ScenePaths.Count);
            Assert.AreEqual(k_BriggsEnvironmentPath, level.ScenePaths[0]);
            Assert.AreEqual(k_BriggsGameplayPath, level.ScenePaths[1]);
            Assert.AreEqual(k_BriggsEnvironment2Path, level.ScenePaths[2]);
            Assert.AreEqual(ScenePaths.k_ChapterHouseConnectedEnvironment, level.ScenePaths[3]);
            Assert.AreEqual(ScenePaths.k_ChapterHouseConnectedGameplay, level.ScenePaths[4]);

            Assert.IsTrue(EditorBuildSettings.scenes.Any(
                scene => scene.enabled && scene.path == ScenePaths.k_ChapterHouseConnectedEnvironment));
            Assert.IsTrue(EditorBuildSettings.scenes.Any(
                scene => scene.enabled && scene.path == ScenePaths.k_ChapterHouseConnectedGameplay));
        }

        [Test]
        public void ConnectedParts_HaveOnePlayerCameraAndChapterHouseLocalLighting()
        {
            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                OpenConnectedLevel();
                FirstPersonController[] players = Object.FindObjectsByType<FirstPersonController>(
                    FindObjectsInactive.Include, FindObjectsSortMode.None);
                Assert.AreEqual(1, players.Length);

                CinemachineCamera[] cameras = Object.FindObjectsByType<CinemachineCamera>(
                    FindObjectsInactive.Include, FindObjectsSortMode.None);
                int firstPersonCameraCount = cameras.Count(camera => camera.name == "FirstPersonCamera");
                Assert.AreEqual(1, firstPersonCameraCount);

                Scene environment = SceneManager.GetSceneByPath(ScenePaths.k_ChapterHouseConnectedEnvironment);
                Scene gameplay = SceneManager.GetSceneByPath(ScenePaths.k_ChapterHouseConnectedGameplay);
                GameObject lighting = FindRoot(environment, "_Lighting");
                Assert.IsNotNull(lighting);
                Light[] lights = lighting.GetComponentsInChildren<Light>(true);
                Light[] fills = lights.Where(light => light.name.StartsWith("ChapterHouseFill_")).ToArray();
                Assert.AreEqual(4, fills.Length);
                Assert.IsTrue(fills.All(light =>
                    light.type == LightType.Point && light.name.StartsWith("ChapterHouseFill_")));
                Assert.AreEqual(4, lights.Length);
                UnityEngine.Rendering.Volume[] volumes =
                    lighting.GetComponentsInChildren<UnityEngine.Rendering.Volume>(true);
                Assert.AreEqual(1, volumes.Length);
                Assert.IsFalse(volumes[0].isGlobal);
                Assert.AreEqual("ChapterHouseConnectedProfile", volumes[0].sharedProfile.name);
                Assert.Greater(volumes[0].priority, 0f);
                BoxCollider volumeBounds = volumes[0].GetComponent<BoxCollider>();
                Assert.IsNotNull(volumeBounds);
                Assert.IsTrue(volumeBounds.isTrigger);

                UnityEngine.Rendering.HighDefinition.IndirectLightingController indirect;
                Assert.IsTrue(volumes[0].sharedProfile.TryGet(out indirect));
                Assert.AreEqual(1f, indirect.indirectDiffuseLightingMultiplier.value);
                Assert.IsNull(FindRoot(gameplay, "Player"));
                Assert.IsNull(FindRoot(gameplay, "_Cameras"));
                Assert.IsNull(FindRoot(gameplay, "_Spawns"));
            }
            finally
            {
                RestoreSetup(setup);
            }
        }

        [Test]
        public void ConnectedGeometry_AlignsTheArchAndContinuousGround()
        {
            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                OpenConnectedLevel();
                Transform labDoor = FindTransform(
                    SceneManager.GetSceneByPath(k_BriggsGameplayPath), "BriggsAutomaticExitDoor");
                Transform entrance = FindTransform(
                    SceneManager.GetSceneByPath(ScenePaths.k_ChapterHouseConnectedEnvironment),
                    "ChapterHouseRoundEntrance");
                Assert.IsNotNull(labDoor);
                Assert.IsNotNull(entrance);

                Transform arch = FindChild(entrance, "RoundEntrance_ArchFrame");
                Transform floor = FindChild(entrance, "RoundEntrance_Floor");
                Assert.IsNotNull(arch);
                Assert.IsNotNull(floor);

                Bounds doorBounds = GetRendererBounds(labDoor.gameObject);
                Renderer archRenderer = arch.GetComponent<Renderer>();
                Renderer floorRenderer = floor.GetComponent<Renderer>();
                Assert.That(archRenderer.bounds.center.x, Is.EqualTo(doorBounds.center.x).Within(0.08f));
                Assert.That(floorRenderer.bounds.min.z, Is.EqualTo(7f).Within(0.03f));
                Assert.That(floorRenderer.bounds.max.z, Is.EqualTo(13.06f).Within(0.03f));
                Assert.That(floorRenderer.bounds.max.y, Is.EqualTo(0f).Within(0.03f));
                Assert.AreEqual(LayerMask.NameToLayer("Ground"), floor.gameObject.layer);
                Assert.IsNotNull(floor.GetComponent<MeshCollider>());

                MeshFilter tunnel = FindChild(entrance, "RoundEntrance_TunnelShell").GetComponent<MeshFilter>();
                float minimumX = tunnel.sharedMesh.vertices.Min(vertex =>
                {
                    Vector3 world = tunnel.transform.TransformPoint(vertex);
                    return world.x;
                });
                float maximumX = tunnel.sharedMesh.vertices.Max(vertex =>
                {
                    Vector3 world = tunnel.transform.TransformPoint(vertex);
                    return world.x;
                });
                Assert.That(maximumX - minimumX, Is.EqualTo(3.75f).Within(0.02f));
            }
            finally
            {
                RestoreSetup(setup);
            }
        }

        [Test]
        public void EntranceCut_PreservesFloorAndUpperStoreys()
        {
            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                Scene environment = EditorSceneManager.OpenScene(
                    ScenePaths.k_ChapterHouseConnectedEnvironment,
                    OpenSceneMode.Single);
                MeshFilter wall = FindTransform(environment, "ClothLandscape_CorridorShell.009")
                    .GetComponent<MeshFilter>();
                Assert.That(AssetDatabase.GetAssetPath(wall.sharedMesh), Does.Contain("/Generated/"));

                string[] preservedParts =
                {
                    "ClothLandscape_CorridorShell.005",
                    "ClothLandscape_CorridorShell.007",
                    "ClothLandscape_CorridorShell.012",
                    "ClothLandscape_CorridorShell.013",
                };

                for (int i = 0; i < preservedParts.Length; i++)
                {
                    MeshFilter filter = FindTransform(environment, preservedParts[i]).GetComponent<MeshFilter>();
                    Assert.That(
                        AssetDatabase.GetAssetPath(filter.sharedMesh),
                        Does.EndWith("ChapterHouseCorridor.fbx"),
                        preservedParts[i]);
                }

                Renderer upper = FindTransform(environment, "ClothLandscape_CorridorShell.012")
                    .GetComponent<Renderer>();
                Renderer arch = FindTransform(environment, "RoundEntrance_ArchFrame")
                    .GetComponent<Renderer>();
                Assert.LessOrEqual(arch.bounds.max.y, upper.bounds.min.y - 0.1f);
            }
            finally
            {
                RestoreSetup(setup);
            }
        }

        [Test]
        public void ConnectedEnvironment_PreservesMyceliumAndUsesDedicatedEntranceMaterials()
        {
            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                Scene environment = EditorSceneManager.OpenScene(
                    ScenePaths.k_ChapterHouseConnectedEnvironment,
                    OpenSceneMode.Single);
                Transform mycelium = FindTransform(environment, "MyceliumUndercroft");
                Assert.IsNotNull(mycelium);
                Assert.Greater(mycelium.GetComponentsInChildren<Renderer>(true).Length, 0);
                Assert.IsTrue(mycelium.gameObject.activeSelf);
                Assert.That(mycelium.lossyScale.x, Is.EqualTo(1f).Within(0.001f));
                Assert.That(mycelium.lossyScale.y, Is.EqualTo(1f).Within(0.001f));
                Assert.That(mycelium.lossyScale.z, Is.EqualTo(1f).Within(0.001f));

                Bounds myceliumBounds = GetRendererBounds(mycelium.gameObject);
                Bounds floorBounds = FindTransform(environment, "ClothLandscape_CorridorShell.007")
                    .GetComponent<Renderer>().bounds;
                Bounds clothBounds = FindTransform(environment, "ClothLandscape_CorridorShell.011")
                    .GetComponent<Renderer>().bounds;
                Assert.That(myceliumBounds.center.x, Is.EqualTo(floorBounds.center.x).Within(0.05f));
                Assert.That(myceliumBounds.center.y, Is.EqualTo(clothBounds.center.y).Within(0.05f));
                Assert.That(myceliumBounds.center.z, Is.EqualTo(clothBounds.center.z).Within(0.05f));
                Assert.Less(myceliumBounds.size.x, clothBounds.size.x * 0.5f);
                Assert.Less(myceliumBounds.size.z, clothBounds.size.z * 0.5f);
                Animator animator = mycelium.GetComponent<Animator>();
                Assert.IsNotNull(animator);
                Assert.IsNotNull(animator.runtimeAnimatorController);

                Transform entrance = FindTransform(environment, "ChapterHouseRoundEntrance");
                Assert.IsNotNull(entrance);
                Renderer[] renderers = entrance.GetComponentsInChildren<Renderer>(true);

                for (int i = 0; i < renderers.Length; i++)
                {
                    Material[] materials = renderers[i].sharedMaterials;

                    for (int slot = 0; slot < materials.Length; slot++)
                    {
                        Assert.That(
                            AssetDatabase.GetAssetPath(materials[slot]),
                            Does.Contain("/ChapterHouse/Entrance/"),
                            renderers[i].name);
                        Assert.IsNull(materials[slot].GetTexture("_BaseColorMap"), renderers[i].name);
                    }
                }

                Assert.IsNull(FindTransform(environment, "ChapterHouseUndercroftSeals"));
            }
            finally
            {
                RestoreSetup(setup);
            }
        }

        [Test]
        public void ChapterHouseCloth_UsesTheAuthoredBakeInsteadOfTheEdgeGradient()
        {
            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                Scene environment = EditorSceneManager.OpenScene(
                    ScenePaths.k_ChapterHouseConnectedEnvironment,
                    OpenSceneMode.Single);
                Renderer emission = FindTransform(environment, "ClothLandscape_CorridorShell.004")
                    .GetComponent<Renderer>();
                Assert.IsNotNull(emission);
                Assert.AreEqual("gradalpha", emission.sharedMaterial.GetTexture("_BaseColorMap").name);
                Assert.AreEqual("gradbake", emission.sharedMaterial.GetTexture("_EmissiveColorMap").name);
                Assert.Greater(emission.sharedMaterial.GetFloat("_EmissiveIntensity"), 1000f);
                Assert.AreEqual(1f, emission.sharedMaterial.GetFloat("_SurfaceType"));
                Assert.AreEqual(1f, emission.sharedMaterial.GetFloat("_BlendMode"));
                Assert.AreEqual(0f, emission.sharedMaterial.GetFloat("_TransparentZWrite"));
                Renderer cloth = FindTransform(environment, "ClothLandscape_CorridorShell.011")
                    .GetComponent<Renderer>();
                Assert.IsNotNull(cloth);
                Assert.AreEqual("plane", cloth.sharedMaterial.GetTexture("_BaseColorMap").name);
                Assert.AreEqual("plane", cloth.sharedMaterial.GetTexture("_EmissiveColorMap").name);
                Assert.AreEqual(0f, cloth.sharedMaterial.GetFloat("_SurfaceType"));
                Assert.Greater(cloth.sharedMaterial.GetFloat("_EmissiveIntensity"),
                    emission.sharedMaterial.GetFloat("_EmissiveIntensity"));
                Assert.AreEqual(0.3f, cloth.sharedMaterial.GetFloat("_Smoothness"), 0.001f);
                Assert.IsNull(FindTransform(environment, "ChapterHouseUnderglowLights"));
            }
            finally
            {
                RestoreSetup(setup);
            }
        }

        [Test]
        public void ChapterHouseArch_HasUnlockedWallMatchingAutomaticDoor()
        {
            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                Scene environment = EditorSceneManager.OpenScene(
                    ScenePaths.k_ChapterHouseConnectedEnvironment,
                    OpenSceneMode.Single);
                Transform entrance = FindTransform(environment, "ChapterHouseRoundEntrance");
                Transform doorRoot = FindTransform(environment, "ChapterHouseArchAutomaticDoor");
                Transform left = FindChild(entrance, "RoundEntrance_Door_Left");
                Transform right = FindChild(entrance, "RoundEntrance_Door_Right");
                Assert.IsNotNull(doorRoot);
                Assert.IsNotNull(left);
                Assert.IsNotNull(right);

                AutomaticSlidingDoor door = doorRoot.GetComponent<AutomaticSlidingDoor>();
                BoxCollider trigger = doorRoot.GetComponent<BoxCollider>();
                Assert.IsNotNull(door);
                Assert.IsTrue(door.OpensOnApproach);
                Assert.IsNotNull(trigger);
                Assert.IsTrue(trigger.isTrigger);
                Assert.AreEqual(LayerMask.NameToLayer("TriggerVolume"), doorRoot.gameObject.layer);
                Assert.IsFalse(left.gameObject.isStatic);
                Assert.IsFalse(right.gameObject.isStatic);
                Assert.AreSame(
                    FindChild(entrance, "RoundEntrance_FirstStoreySurround_Left")
                        .GetComponent<Renderer>().sharedMaterial,
                    left.GetComponent<Renderer>().sharedMaterial);
            }
            finally
            {
                RestoreSetup(setup);
            }
        }

        [Test]
        public void BriggsVisualFloor_StopsAtTheLaboratoryNorthWall()
        {
            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                Scene environment = EditorSceneManager.OpenScene(k_BriggsEnvironmentPath, OpenSceneMode.Single);
                Transform sourceFloor = FindTransform(environment, "Floor");
                Assert.IsNotNull(sourceFloor);
                Assert.IsFalse(sourceFloor.GetComponent<Renderer>().enabled);

                Transform visualFloor = FindTransform(environment, "BriggsVisualFloor_18x14m");
                Assert.IsNotNull(visualFloor);
                Bounds bounds = visualFloor.GetComponent<Renderer>().bounds;
                Assert.That(bounds.min.z, Is.EqualTo(-7f).Within(0.03f));
                Assert.That(bounds.max.z, Is.EqualTo(7f).Within(0.03f));
                Assert.That(bounds.max.y, Is.EqualTo(0f).Within(0.03f));
            }
            finally
            {
                RestoreSetup(setup);
            }
        }

        [Test]
        public void BriggsGameplay_HasNoLegacyPortalOrBlackTransitionSurface()
        {
            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                Scene gameplay = EditorSceneManager.OpenScene(k_BriggsGameplayPath, OpenSceneMode.Single);
                Assert.IsNull(FindTransform(gameplay, "BriggsChapterHousePortal"));
                Assert.IsNull(FindTransform(gameplay, "BlackTransitionSurface"));
                Assert.AreEqual(0, gameplay.GetRootGameObjects()
                    .SelectMany(root => root.GetComponentsInChildren<LevelPortal>(true)).Count());
            }
            finally
            {
                RestoreSetup(setup);
            }
        }

        [Test]
        public void ConnectedRoute_ClearsAPlayerCapsuleFromLabDoorToChapterHouse()
        {
            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                OpenConnectedLevel();
                Physics.SyncTransforms();
                int groundLayer = LayerMask.NameToLayer("Ground");
                Transform door = FindTransform(
                    SceneManager.GetSceneByPath(k_BriggsGameplayPath), "BriggsAutomaticExitDoor");
                Transform chapterHouseDoor = FindTransform(
                    SceneManager.GetSceneByPath(ScenePaths.k_ChapterHouseConnectedEnvironment),
                    "ChapterHouseArchAutomaticDoor");
                Transform chapterHouseLeftLeaf = FindTransform(
                    SceneManager.GetSceneByPath(ScenePaths.k_ChapterHouseConnectedEnvironment),
                    "RoundEntrance_Door_Left");
                Transform chapterHouseRightLeaf = FindTransform(
                    SceneManager.GetSceneByPath(ScenePaths.k_ChapterHouseConnectedEnvironment),
                    "RoundEntrance_Door_Right");
                Assert.IsNotNull(door);
                Assert.IsNotNull(chapterHouseDoor);
                Assert.IsNotNull(chapterHouseLeftLeaf);
                Assert.IsNotNull(chapterHouseRightLeaf);

                for (float z = 7.6f; z <= 18f; z += 0.25f)
                {
                    Collider[] hits = Physics.OverlapCapsule(
                        new Vector3(0f, 0.55f, z),
                        new Vector3(0f, 1.45f, z),
                        0.42f,
                        ~0,
                        QueryTriggerInteraction.Ignore);

                    for (int i = 0; i < hits.Length; i++)
                    {
                        Collider hit = hits[i];

                        if (hit.gameObject.layer == groundLayer
                            || hit.transform.IsChildOf(door)
                            || hit.transform.IsChildOf(chapterHouseDoor)
                            || hit.transform == chapterHouseDoor
                            || hit.transform == chapterHouseLeftLeaf
                            || hit.transform == chapterHouseRightLeaf)
                        {
                            continue;
                        }

                        Assert.Fail("Player route is blocked at Z " + z.ToString("F2") + " by " + hit.name + ".");
                    }
                }
            }
            finally
            {
                RestoreSetup(setup);
            }
        }

        private static void OpenConnectedLevel()
        {
            EditorSceneManager.OpenScene(k_BriggsEnvironmentPath, OpenSceneMode.Single);
            EditorSceneManager.OpenScene(k_BriggsGameplayPath, OpenSceneMode.Additive);
            EditorSceneManager.OpenScene(k_BriggsEnvironment2Path, OpenSceneMode.Additive);
            EditorSceneManager.OpenScene(ScenePaths.k_ChapterHouseConnectedEnvironment, OpenSceneMode.Additive);
            EditorSceneManager.OpenScene(ScenePaths.k_ChapterHouseConnectedGameplay, OpenSceneMode.Additive);
        }

        private static GameObject FindRoot(Scene scene, string name)
        {
            return scene.GetRootGameObjects().FirstOrDefault(root => root.name == name);
        }

        private static Transform FindTransform(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                Transform[] transforms = roots[i].GetComponentsInChildren<Transform>(true);
                Transform match = transforms.FirstOrDefault(transform => transform.name == name);

                if (match != null)
                {
                    return match;
                }
            }

            return null;
        }

        private static Transform FindChild(Transform root, string name)
        {
            return root.GetComponentsInChildren<Transform>(true)
                .FirstOrDefault(transform => transform.name == name);
        }

        private static Bounds GetRendererBounds(GameObject root)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);
            Assert.Greater(renderers.Length, 0, root.name);
            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds;
        }

        private static void RestoreSetup(SceneSetup[] setup)
        {
            if (setup.Any(scene => scene.isLoaded))
            {
                EditorSceneManager.RestoreSceneManagerSetup(setup);
                return;
            }

            EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
        }
    }
}

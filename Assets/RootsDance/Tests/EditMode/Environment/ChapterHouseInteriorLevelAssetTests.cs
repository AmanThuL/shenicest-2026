using System.Collections.Generic;
using System.Linq;
using NUnit.Framework;
using RootsDance.App;
using RootsDance.Data;
using RootsDance.Editor.DevPlay;
using RootsDance.Environment;
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
        private const string k_ConnectedLevelAssetPath = "Assets/RootsDance/Data/Levels/BriggsInterior.asset";
        private const string k_CorridorEntranceCheckpointPath =
            "Assets/RootsDance/Data/DevPlay/ChapterHouseInterior/02-04A_CorridorEntrance.asset";
        private const string k_FlowerSpriteEncounterCheckpointPath =
            "Assets/RootsDance/Data/DevPlay/ChapterHouseInterior/02-04B_FlowerSpriteEncounter.asset";
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
                Transform layoutRoot = model.parent;
                Assert.That(layoutRoot.localScale, Is.EqualTo(Vector3.one * 2f));
                Assert.That(bounds.min.y, Is.EqualTo(-3.5f).Within(0.01f));
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

                    MeshCollider meshCollider = renderer.GetComponent<MeshCollider>();

                    if (meshCollider != null)
                    {
                        Assert.IsTrue(meshCollider.sharedMesh != null, renderer.name);
                        Assert.IsFalse(meshCollider.convex, renderer.name);
                    }
                    else
                    {
                        // The door leaves rotate at runtime, so SeparateDoors gives them a
                        // BoxCollider instead of a non-convex MeshCollider — same guarantee that
                        // the piece can be collided with, cheaper to move every frame.
                        Assert.IsTrue(renderer.GetComponent<BoxCollider>() != null, renderer.name);
                    }
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
                Light[] underglow = lighting.GetComponentsInChildren<Light>(true)
                    .Where(light => light.name.StartsWith("ChapterHouseUnderglow_"))
                    .ToArray();
                Assert.AreEqual(4, underglow.Length);
                Assert.IsTrue(underglow.All(light => light.color.b > light.color.r));
                Assert.IsTrue(FindRoot(scene, "_Props") != null);
                Assert.IsTrue(FindRoot(scene, "_NavMesh") != null);
            }
            finally
            {
                EditorSceneManager.CloseScene(scene, true);
            }
        }

        [Test]
        public void EnvironmentScene_ReplacesDoorAAndKeepsDoorsBThroughD()
        {
            Scene scene = EditorSceneManager.OpenScene(
                ScenePaths.k_ChapterHouseInteriorEnvironment,
                OpenSceneMode.Additive);

            try
            {
                Transform model = FindRoot(scene, "_Geometry").Find("ChapterHouseRoot/ChapterHouse");
                SwingDoor[] doors = model.GetComponentsInChildren<SwingDoor>(true);

                Assert.AreEqual(3, doors.Length);
                Assert.IsNull(model.Find("ChapterHouseDoor_A"));
                Assert.IsNotNull(model.Find("ChapterHouseDoor_B"));
                Assert.IsNotNull(model.Find("ChapterHouseDoor_C"));
                Assert.IsNotNull(model.Find("ChapterHouseDoor_D"));

                for (int i = 0; i < doors.Length; i++)
                {
                    SwingDoor door = doors[i];
                    Assert.IsFalse(door.gameObject.isStatic, door.name);

                    BoxCollider trigger = door.GetComponent<BoxCollider>();
                    Assert.IsTrue(trigger != null && trigger.isTrigger, door.name);

                    // The probe only collides with TriggerVolume; on any other layer the door
                    // never sees the player and never opens.
                    Assert.AreEqual(LayerMask.NameToLayer("TriggerVolume"), door.gameObject.layer, door.name);

                    MeshRenderer leafRenderer = door.GetComponentInChildren<MeshRenderer>(true);
                    Assert.IsTrue(leafRenderer != null, door.name);
                    Assert.AreEqual(0, leafRenderer.gameObject.layer, door.name);
                }

                Assert.IsNull(FindPartOrNull(model.gameObject, "ClothLandscape_CorridorShell.006"));
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
                Transform corridorEntrance = anchors.Find("Checkpoint_CorridorEntrance");
                Transform flowerSpriteEncounter = anchors.Find("Checkpoint_FlowerSpriteEncounter");
                Assert.IsTrue(corridorEntrance != null);
                Assert.IsTrue(flowerSpriteEncounter != null);

                // Head height above the floor, and inside its footprint — not under the building.
                Assert.Greater(corridorEntrance.position.y, floor.max.y);
                Assert.Less(corridorEntrance.position.y, floor.max.y + 2f);
                Assert.That(corridorEntrance.position.x, Is.InRange(floor.min.x, floor.max.x));
                Assert.That(corridorEntrance.position.z, Is.InRange(floor.min.z, floor.max.z));
                Assert.Greater(flowerSpriteEncounter.position.y, floor.max.y);

                CharacterController player = FindRootComponent<CharacterController>(gameplay);
                Assert.IsTrue(player != null);
                Assert.That(player.transform.position, Is.EqualTo(corridorEntrance.position));
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
        public void GameplayScene_LeadsToTheGreenhouseBehindDoorD()
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
                Bounds doorway = FindPart(
                        model.gameObject, Editor.Environment.ChapterHouseGreenhousePortalBuilder.k_DoorName)
                    .GetComponentInChildren<Renderer>(true).bounds;

                Transform portal = FindRoot(gameplay, "_Triggers").Find("ChapterHouseGreenhousePortal");
                Assert.IsTrue(portal != null, "Run RootsDance/Environment/Apply Chapter House Greenhouse Portal.");
                Assert.AreEqual(LayerMask.NameToLayer("TriggerVolume"), portal.gameObject.layer);

                BoxCollider trigger = portal.GetComponent<BoxCollider>();
                Assert.IsTrue(trigger != null && trigger.isTrigger);

                // The probe's 0.45 m radius must not let the load fire from the corridor side of
                // the doorway plane — approaching the door has to open it, not leave the level.
                Assert.Greater(trigger.bounds.min.z, doorway.center.z + 0.45f);

                // And once through, the player cannot walk around the volume: it covers the
                // doorway's full width and from below the sill to above head height.
                Assert.LessOrEqual(trigger.bounds.min.x, doorway.min.x);
                Assert.GreaterOrEqual(trigger.bounds.max.x, doorway.max.x);
                Assert.LessOrEqual(trigger.bounds.min.y, doorway.min.y);
                Assert.GreaterOrEqual(trigger.bounds.max.y, doorway.min.y + 2f);

                LevelPortal levelPortal = portal.GetComponent<LevelPortal>();
                Assert.IsTrue(levelPortal != null);
                SerializedObject serialized = new SerializedObject(levelPortal);
                Assert.AreSame(
                    AssetDatabase.LoadAssetAtPath<LevelSO>("Assets/RootsDance/Data/Levels/GreenhouseInterior.asset"),
                    serialized.FindProperty("m_level").objectReferenceValue);
                Assert.IsTrue(serialized.FindProperty("m_loadLevelRequested").objectReferenceValue != null);

                MeshRenderer surface = portal.GetComponentInChildren<MeshRenderer>(true);
                Assert.IsTrue(surface != null && surface.sharedMaterial != null);
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
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_ConnectedLevelAssetPath);
            Scene gameplay = EditorSceneManager.OpenScene(
                ScenePaths.k_ChapterHouseConnectedGameplay, OpenSceneMode.Additive);

            try
            {
                AssertCheckpoint(
                    gameplay,
                    k_CorridorEntranceCheckpointPath,
                    "02-04A Corridor entrance",
                    level,
                    "Checkpoint_CorridorEntrance");
                AssertCheckpoint(
                    gameplay,
                    k_FlowerSpriteEncounterCheckpointPath,
                    "02-04B Flower sprite encounter",
                    level,
                    "Checkpoint_FlowerSpriteEncounter");
            }
            finally
            {
                EditorSceneManager.CloseScene(gameplay, true);
            }
        }

        private static void AssertCheckpoint(
            Scene gameplay,
            string path,
            string label,
            LevelSO level,
            string anchorName)
        {
            DevCheckpointSO checkpoint = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(path);
            Assert.IsTrue(checkpoint != null, path);
            Assert.AreEqual(label, checkpoint.Label);
            Assert.AreSame(level, checkpoint.Level);
            Assert.AreEqual(anchorName, checkpoint.AnchorName);
            Assert.AreEqual(CheckpointTimeOfDay.LevelDefault, checkpoint.TimeOfDay);
            Assert.IsFalse(checkpoint.SnapToGround);

            Transform anchor = gameplay.GetRootGameObjects()
                .SelectMany(root => root.GetComponentsInChildren<Transform>(true))
                .FirstOrDefault(transform => transform.name == anchorName);
            Assert.IsNotNull(anchor, anchorName);
            Assert.That(Vector3.Distance(checkpoint.Position, anchor.position), Is.LessThan(0.01f));
            Assert.That(Mathf.DeltaAngle(checkpoint.Yaw, anchor.eulerAngles.y), Is.EqualTo(0f).Within(0.01f));
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

        private static Transform FindPartOrNull(GameObject model, string partName)
        {
            Transform[] transforms = model.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                if (transforms[i].gameObject.name == partName)
                {
                    return transforms[i];
                }
            }

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

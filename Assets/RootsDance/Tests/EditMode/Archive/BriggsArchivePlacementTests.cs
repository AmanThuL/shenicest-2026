using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Archive;
using RootsDance.Data;
using RootsDance.Interaction;
using RootsDance.Player;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Tests.EditMode.Archive
{
    /// <summary>
    /// Guards the two archive sheets in Briggs: that they are in the level, on the desk, and that
    /// the player in that level can actually pick them up.
    /// </summary>
    public sealed class BriggsArchivePlacementTests
    {
        private const string k_ArchiveScenePath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment_2.unity";
        private const string k_EnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment.unity";
        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";
        private const string k_LevelPath = "Assets/RootsDance/Data/Levels/BriggsInterior.asset";

        private const float k_MinimumLift = 0.005f;
        private const float k_MaximumLift = 0.03f;
        private const float k_CentreTolerance = 0.03f;

        [Test]
        public void BriggsLevel_LoadsTheArchivePartScene()
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_LevelPath);
            Assert.IsTrue(level != null, k_LevelPath + " is missing.");

            SerializedProperty paths = new SerializedObject(level).FindProperty("m_scenePaths");
            bool listed = false;

            for (int i = 0; i < paths.arraySize; i++)
            {
                listed |= paths.GetArrayElementAtIndex(i).stringValue == k_ArchiveScenePath;
            }

            Assert.IsTrue(listed, "BriggsInterior.asset does not load the archive part scene.");

            bool inBuild = false;
            EditorBuildSettingsScene[] scenes = EditorBuildSettings.scenes;

            for (int i = 0; i < scenes.Length; i++)
            {
                inBuild |= scenes[i].path == k_ArchiveScenePath && scenes[i].enabled;
            }

            // Additive loads go through the build list, so a level path that is not in it loads
            // nothing at all — and does so silently in the Editor, where the scene is open anyway.
            Assert.IsTrue(inBuild, "The archive part scene is not an enabled build scene.");
        }

        [Test]
        public void BriggsArchiveScene_LaysBothDocumentsFaceUpOnTheDesk()
        {
            Scene archiveScene = SceneManager.GetSceneByPath(k_ArchiveScenePath);
            bool closeArchiveWhenDone = !archiveScene.IsValid() || !archiveScene.isLoaded;
            Scene environmentScene = SceneManager.GetSceneByPath(k_EnvironmentPath);
            bool closeEnvironmentWhenDone = !environmentScene.IsValid() || !environmentScene.isLoaded;

            if (closeArchiveWhenDone)
            {
                archiveScene = EditorSceneManager.OpenScene(k_ArchiveScenePath, OpenSceneMode.Additive);
            }

            if (closeEnvironmentWhenDone)
            {
                environmentScene = EditorSceneManager.OpenScene(k_EnvironmentPath, OpenSceneMode.Additive);
            }

            try
            {
                ArchiveDocumentPickup[] sheets = FindAll<ArchiveDocumentPickup>(archiveScene);
                Assert.AreEqual(2, sheets.Length, "Expected both sheets in the archive scene.");

                LayerMask interactable = InteractableLayers();
                HashSet<string> documentIds = new HashSet<string>();

                for (int i = 0; i < sheets.Length; i++)
                {
                    string sheetName = sheets[i].name;

                    Object document = new SerializedObject(sheets[i])
                        .FindProperty("m_document").objectReferenceValue;
                    Assert.IsTrue(document != null, sheetName + " has no document assigned.");
                    documentIds.Add(document.name);

                    string supportName = sheetName.EndsWith("DOC-001")
                        ? "BI_S9_Clipboard"
                        : "BI_S9_Binder";
                    Transform support = FindTransform(environmentScene, supportName);
                    Assert.IsTrue(support != null, supportName + " is missing from the Lab.");

                    Bounds supportBounds = CombinedRendererBounds(support);
                    float lift = sheets[i].transform.position.y - supportBounds.max.y;
                    Assert.That(lift, Is.InRange(k_MinimumLift, k_MaximumLift),
                        sheetName + " is embedded in or floating above " + supportName + ".");

                    Vector2 sheetCentre = new Vector2(
                        sheets[i].transform.position.x, sheets[i].transform.position.z);
                    Vector2 supportCentre = new Vector2(support.position.x, support.position.z);
                    Assert.That(Vector2.Distance(sheetCentre, supportCentre),
                        Is.LessThan(k_CentreTolerance),
                        sheetName + " is not centred on " + supportName + ".");

                    // The readable side looks back along the page's own forward, so a sheet flat on
                    // a table has its forward pointing at the table.
                    Assert.That(Vector3.Angle(sheets[i].transform.forward, Vector3.down),
                        Is.LessThan(1f), sheetName + " is not face up.");

                    Assert.AreNotEqual(0, interactable.value & (1 << sheets[i].gameObject.layer),
                        sheetName + " is on a layer interaction ignores.");
                }

                CollectionAssert.AreEquivalent(
                    new[] { "DOC-001_UndergroundNetwork", "DOC-002_RingExpansion" },
                    documentIds,
                    "The Lab must contain its two research sheets, not greenhouse-only documents.");
            }
            finally
            {
                if (closeEnvironmentWhenDone)
                {
                    EditorSceneManager.CloseScene(environmentScene, true);
                }

                if (closeArchiveWhenDone)
                {
                    EditorSceneManager.CloseScene(archiveScene, true);
                }
            }
        }

        [Test]
        public void BriggsGameplayScene_GivesThePlayerTheReadLoop()
        {
            Scene scene = SceneManager.GetSceneByPath(k_GameplayPath);
            bool closeWhenDone = !scene.IsValid() || !scene.isLoaded;

            if (closeWhenDone)
            {
                scene = EditorSceneManager.OpenScene(k_GameplayPath, OpenSceneMode.Additive);
            }

            try
            {
                DocumentInspectController[] readers = FindAll<DocumentInspectController>(scene);
                Assert.AreEqual(1, readers.Length, "Expected exactly one reader on the player.");

                SerializedObject reader = new SerializedObject(readers[0]);
                Assert.IsTrue(reader.FindProperty("m_holdAnchor").objectReferenceValue != null,
                    "The reader has no hold anchor.");
                Assert.IsTrue(reader.FindProperty("m_input").objectReferenceValue != null,
                    "The reader has no input reader.");

                // While a sheet is up it owns the mouse, so look, move and the interaction offer
                // all have to be in the suspend list or the player walks off while reading.
                SerializedProperty suspended = reader.FindProperty("m_suspendedWhileReading");
                Assert.AreEqual(3, suspended.arraySize, "The suspend list is incomplete.");

                // One driver offers every interactable, sheets included — there is no per-type
                // trigger and no aiming; the sheet is offered by being near it and on screen.
                InteractionProximityTrigger[] offers = FindAll<InteractionProximityTrigger>(scene);
                Assert.AreEqual(1, offers.Length, "Expected exactly one interaction driver.");

                SerializedObject offer = new SerializedObject(offers[0]);
                Assert.IsTrue(offer.FindProperty("m_config").objectReferenceValue != null,
                    "The driver has no InteractionConfigSO, so it has no reach.");
                Assert.IsTrue(offer.FindProperty("m_player").objectReferenceValue != null,
                    "The driver has no player transform to measure from.");
                Assert.IsTrue(offer.FindProperty("m_input").objectReferenceValue != null,
                    "The driver has no input reader.");
                Assert.IsTrue(offer.FindProperty("m_promptChanged").objectReferenceValue != null,
                    "The driver has no prompt channel, so the hint never reaches the HUD.");

                FirstPersonController[] players = FindAll<FirstPersonController>(scene);
                Assert.AreEqual(1, players.Length, "Expected exactly one player.");
                Assert.AreSame(players[0].gameObject, readers[0].gameObject,
                    "The reader has to sit on the player it suspends.");
            }
            finally
            {
                if (closeWhenDone)
                {
                    EditorSceneManager.CloseScene(scene, true);
                }
            }
        }

        private static LayerMask InteractableLayers()
        {
            string[] guids = AssetDatabase.FindAssets("t:InteractionConfigSO");
            Assert.AreNotEqual(0, guids.Length, "No InteractionConfigSO in the project.");

            InteractionConfigSO config = AssetDatabase.LoadAssetAtPath<InteractionConfigSO>(
                AssetDatabase.GUIDToAssetPath(guids[0]));
            Assert.IsTrue(config != null, "The interaction config failed to load.");

            return config.InteractableLayers;
        }

        /// <summary>Everything of one type in a single scene, ignoring the rest of the Editor.</summary>
        private static T[] FindAll<T>(Scene scene) where T : Component
        {
            List<T> found = new List<T>();
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                found.AddRange(roots[i].GetComponentsInChildren<T>(true));
            }

            return found.ToArray();
        }

        private static Transform FindTransform(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                Transform[] transforms = roots[i].GetComponentsInChildren<Transform>(true);

                for (int j = 0; j < transforms.Length; j++)
                {
                    if (transforms[j].name == name)
                    {
                        return transforms[j];
                    }
                }
            }

            return null;
        }

        private static Bounds CombinedRendererBounds(Transform root)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);
            Assert.AreNotEqual(0, renderers.Length, root.name + " has no visible renderer.");

            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds;
        }
    }
}

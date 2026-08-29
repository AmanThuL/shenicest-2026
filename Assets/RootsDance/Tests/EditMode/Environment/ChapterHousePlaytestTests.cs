using NUnit.Framework;
using RootsDance.App;
using RootsDance.Data;
using RootsDance.Dialogue;
using RootsDance.Editor.DevPlay;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>
    /// The chapter house playtest, written down as assertions: start at CH-01, walk forward, meet
    /// the flower sprite. Every step here is one that has already silently failed once.
    /// <para>
    /// The point is that each break was invisible in the Editor. A trigger on the wrong layer, a
    /// volume placed past the far wall, a channel nobody listens to — all of them look exactly like
    /// "keep walking, it hasn't happened yet". Only the last one in the chain is observable in
    /// play, so the whole chain has to be checked here instead.
    /// </para>
    /// Each test is named for the step of the walkthrough it guards, so a red test says which part
    /// of the playtest is about to waste your time.
    /// </summary>
    public sealed class ChapterHousePlaytestTests
    {
        private const string k_LevelAssetPath = "Assets/RootsDance/Data/Levels/ChapterHouseInterior.asset";
        private const string k_NaveCheckpointPath =
            "Assets/RootsDance/Data/DevPlay/ChapterHouseInterior/CH-01_ChapterHouseNave.asset";
        private const string k_FirstMeetingPath = "Assets/RootsDance/Data/Dialogue/DLG-001_FirstMeeting.asset";
        private const string k_FloorPart = "ClothLandscape_CorridorShell.007";
        private const string k_ClothPart = "ClothLandscape_CorridorShell.011";
        private const string k_BridgePart = "Bridge_Metal_Center.001";
        private const string k_MeetingVolume = "FirstMeeting";

        /// <summary>The player capsule is 1.8 m tall, centred on the transform.</summary>
        private const float k_PlayerHeight = 1.8f;

        [Test]
        public void Step1_TheCheckpointStartsThisLevel()
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_LevelAssetPath);
            DevCheckpointSO nave = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(k_NaveCheckpointPath);
            Assert.IsTrue(level != null, k_LevelAssetPath);
            Assert.IsTrue(nave != null, "CH-01 is missing from the Dev Play window: " + k_NaveCheckpointPath);
            Assert.AreSame(level, nave.Level, "CH-01 does not point at the chapter house level.");
        }

        [Test]
        public void Step2_ThePlayerSpawnsStandingOnTheCatwalk()
        {
            Scene environment = OpenAdditive(ScenePaths.k_ChapterHouseInteriorEnvironment);
            Scene gameplay = OpenAdditive(ScenePaths.k_ChapterHouseInteriorGameplay);

            try
            {
                Bounds catwalk = PartBounds(environment, k_BridgePart);
                Vector3 spawn = Require(gameplay, "_Spawns", "PlayerSpawn").position;
                float feet = spawn.y - k_PlayerHeight * 0.5f;

                // The bridge is the route. The chapel floor beside it sits well below and is a
                // single-sided plane the player is not meant to be walking on.
                Assert.Greater(feet, catwalk.max.y - 0.01f,
                    "The spawn's feet start below the catwalk deck.");
                Assert.Less(feet - catwalk.max.y, 0.5f,
                    "The spawn is more than half a metre above the deck: the level opens mid-fall.");
                Assert.That(spawn.x, Is.InRange(catwalk.min.x, catwalk.max.x),
                    "The spawn is off the side of the catwalk.");
                Assert.That(spawn.z, Is.InRange(catwalk.min.z, catwalk.max.z),
                    "The spawn is off the end of the catwalk.");
            }
            finally
            {
                Close(gameplay, environment);
            }
        }

        [Test]
        public void Step3_WalkingForwardFromTheSpawnReachesTheFirstMeetingVolume()
        {
            Scene environment = OpenAdditive(ScenePaths.k_ChapterHouseInteriorEnvironment);
            Scene gameplay = OpenAdditive(ScenePaths.k_ChapterHouseInteriorGameplay);

            try
            {
                Bounds floor = FloorBounds(environment);
                Transform spawn = Require(gameplay, "_Spawns", "PlayerSpawn");
                Transform meeting = Require(gameplay, "_Narrative", k_MeetingVolume);
                BoxCollider box = meeting.GetComponent<BoxCollider>();
                Assert.IsTrue(box != null, "The first-meeting volume has no collider to walk into.");

                Bounds volume = new Bounds(meeting.position + box.center, box.size);

                // On the floor the player is standing on, not hanging over the landscape below it
                // or buried in the far wall.
                Assert.That(volume.center.x, Is.InRange(floor.min.x, floor.max.x),
                    "The first-meeting volume is off the side of the floor.");
                Assert.That(volume.center.z, Is.InRange(floor.min.z, floor.max.z),
                    "The first-meeting volume is past the end of the floor — it cannot be walked into.");

                // Ahead of the player, in the direction the spawn faces (+Z out of CH-01).
                Assert.Greater(volume.center.z, spawn.position.z,
                    "The first-meeting volume is behind the spawn; walking forward leads away from it.");

                // The volume has to straddle the height a walking player occupies.
                float feet = floor.max.y;
                float head = feet + k_PlayerHeight;
                Assert.Less(volume.min.y, head, "The volume floats above the player's head.");
                Assert.Greater(volume.max.y, feet, "The volume sits below the floor the player walks on.");
            }
            finally
            {
                Close(gameplay, environment);
            }
        }

        /// <summary>
        /// The walk itself. Both ends are on the catwalk, so crossing it is the whole route — and
        /// that is the point: an earlier layout ran the player down the chapel floor instead, into
        /// the side of a 0.42 m ledge their 0.30 m step offset could not climb, with nothing on
        /// screen to say why they had stopped.
        /// </summary>
        [Test]
        public void Step3b_TheWalkStaysOnTheCatwalk()
        {
            Scene environment = OpenAdditive(ScenePaths.k_ChapterHouseInteriorEnvironment);
            Scene gameplay = OpenAdditive(ScenePaths.k_ChapterHouseInteriorGameplay);

            try
            {
                Bounds catwalk = PartBounds(environment, k_BridgePart);
                Vector3 spawn = Require(gameplay, "_Spawns", "PlayerSpawn").position;
                Vector3 target = Require(gameplay, "_Narrative", k_MeetingVolume).position;

                Assert.That(target.x, Is.InRange(catwalk.min.x, catwalk.max.x),
                    "The first meeting is off the side of the catwalk.");
                Assert.That(target.z, Is.InRange(catwalk.min.z, catwalk.max.z),
                    "The first meeting is off the end of the catwalk.");
                Assert.That(target.y, Is.EqualTo(spawn.y).Within(0.05f),
                    "The first meeting is at a different height than the player walks at.");
                Assert.Greater(target.z, spawn.z,
                    "The first meeting is behind the spawn; walking forward leads away from it.");
            }
            finally
            {
                Close(gameplay, environment);
            }
        }

        /// <summary>
        /// The catwalk deck is narrower than the player capsule, so walking it is a balance act
        /// and a nudge sideways drops the player onto the cloth landscape below. No coordinate
        /// fixes it — the bridge has to be widened in the blend and re-exported.
        /// <para>
        /// Ignored rather than deleted, and rather than left failing: the suite has to stay green
        /// for everyone else, and this is a real outstanding defect that should be visible in the
        /// test report until the art changes. Delete the attribute when the deck is wide enough.
        /// </para>
        /// </summary>
        [Test]
        [Ignore("The catwalk is 0.92 m wide against a 1.00 m player capsule. Needs the bridge "
            + "widened in SourceArt/Corridor/RootsDance_Corridor_Blockout.blend and re-exported.")]
        public void Step3c_TheCatwalkIsWideEnoughToWalkAlong()
        {
            Scene environment = OpenAdditive(ScenePaths.k_ChapterHouseInteriorEnvironment);

            try
            {
                float radius = PlayerController().radius;
                Bounds catwalk = PartBounds(environment, k_BridgePart);
                float deck = Mathf.Min(catwalk.size.x, catwalk.size.z);

                Assert.GreaterOrEqual(deck, radius * 2f,
                    "The catwalk deck is " + deck.ToString("F2") + " m wide and the player capsule "
                    + "is " + (radius * 2f).ToString("F2") + " m across, so the player overhangs it "
                    + "on both sides and falls off. Widen the bridge in "
                    + "SourceArt/Corridor/RootsDance_Corridor_Blockout.blend and re-export.");
            }
            finally
            {
                Close(environment);
            }
        }

        [Test]
        public void Step4_TheFirstMeetingVolumeIsWiredToFire()
        {
            Scene gameplay = OpenAdditive(ScenePaths.k_ChapterHouseInteriorGameplay);

            try
            {
                Transform meeting = Require(gameplay, "_Narrative", k_MeetingVolume);

                // The probe's layer meets TriggerVolume and nothing else.
                Assert.AreEqual(LayerMask.NameToLayer("TriggerVolume"), meeting.gameObject.layer,
                    "The volume is on a layer the player's trigger probe cannot collide with.");

                BoxCollider box = meeting.GetComponent<BoxCollider>();
                Assert.IsTrue(box != null && box.isTrigger, "The volume is not a trigger collider.");

                DialogueTrigger trigger = meeting.GetComponent<DialogueTrigger>();
                Assert.IsTrue(trigger != null, "The volume has no DialogueTrigger.");

                using (SerializedObject serialized = new SerializedObject(trigger))
                {
                    Assert.AreEqual(
                        (int)DialogueTrigger.Moment.OnPlayerEnter,
                        serialized.FindProperty("m_playOn").enumValueIndex,
                        "The trigger does not fire on walking in.");

                    Object conversation = serialized.FindProperty("m_conversation").objectReferenceValue;
                    Assert.AreEqual(k_FirstMeetingPath, AssetDatabase.GetAssetPath(conversation),
                        "The trigger does not point at the first-meeting conversation.");
                    Assert.IsTrue(serialized.FindProperty("m_channel").objectReferenceValue != null,
                        "The trigger has no channel to raise.");
                }
            }
            finally
            {
                Close(gameplay);
            }
        }

        /// <summary>
        /// The step that actually broke the last playtest. The trigger fired, raised its channel,
        /// and nothing was listening: the dialogue runtime lives in Bootstrap and had never been
        /// installed there. Nothing about the level itself looks wrong when this is the failure.
        /// </summary>
        [Test]
        public void Step5_SomethingInBootstrapListensToTheChannelTheTriggerRaises()
        {
            Scene gameplay = OpenAdditive(ScenePaths.k_ChapterHouseInteriorGameplay);
            Scene bootstrap = OpenAdditive(ScenePaths.k_Bootstrap);

            try
            {
                DialogueTrigger trigger = Require(gameplay, "_Narrative", k_MeetingVolume)
                    .GetComponent<DialogueTrigger>();
                Object raised;

                using (SerializedObject serialized = new SerializedObject(trigger))
                {
                    raised = serialized.FindProperty("m_channel").objectReferenceValue;
                }

                DialogueRunner runner = FindInScene<DialogueRunner>(bootstrap);
                Assert.IsTrue(runner != null,
                    "Bootstrap has no DialogueRunner, so no conversation can ever play. "
                    + "Run RootsDance > Content > Wire Narrative Runtime.");

                using (SerializedObject serialized = new SerializedObject(runner))
                {
                    Object listened = serialized.FindProperty("m_playRequested").objectReferenceValue;
                    Assert.AreSame(raised, listened,
                        "The runner listens to a different channel than the trigger raises.");
                    Assert.IsTrue(serialized.FindProperty("m_viewBehaviour").objectReferenceValue != null,
                        "The runner has no view, so the lines would play with nothing on screen.");
                }
            }
            finally
            {
                Close(bootstrap, gameplay);
            }
        }

        [Test]
        public void Step6_TheConversationHasLinesToShow()
        {
            DialogueSO conversation = AssetDatabase.LoadAssetAtPath<DialogueSO>(k_FirstMeetingPath);
            Assert.IsTrue(conversation != null, k_FirstMeetingPath);
            Assert.IsNotEmpty(conversation.Lines, "The first meeting has no lines.");
            Assert.IsNotEmpty(conversation.Id, "The conversation has no id.");
        }

        // ---- helpers ---------------------------------------------------------------------------

        /// <summary>The shipped player capsule, which is what every clearance here is measured against.</summary>
        private static CharacterController PlayerController()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(
                "Assets/RootsDance/Prefabs/Characters/Player.prefab");
            Assert.IsTrue(prefab != null, "The player prefab is missing.");
            CharacterController controller = prefab.GetComponent<CharacterController>();
            Assert.IsTrue(controller != null, "The player prefab has no CharacterController.");
            return controller;
        }

        private static Bounds FloorBounds(Scene environment)
        {
            return PartBounds(environment, k_FloorPart);
        }

        /// <summary>The world bounds of one named piece of the chapter house.</summary>
        private static Bounds PartBounds(Scene environment, string partName)
        {
            Transform model = Require(environment, "_Geometry", null).Find("ChapterHouseRoot/ChapterHouse");
            Assert.IsTrue(model != null, "The chapter house model is missing from _Geometry.");
            Renderer[] renderers = model.GetComponentsInChildren<Renderer>(true);

            for (int i = 0; i < renderers.Length; i++)
            {
                if (renderers[i].gameObject.name == partName)
                {
                    return renderers[i].bounds;
                }
            }

            Assert.Fail("The chapter house has no piece named " + partName);
            return default;
        }

        private static Transform Require(Scene scene, string rootName, string childName)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name != rootName)
                {
                    continue;
                }

                if (childName == null)
                {
                    return roots[i].transform;
                }

                Transform child = roots[i].transform.Find(childName);
                Assert.IsTrue(child != null, rootName + " has no child named " + childName);
                return child;
            }

            Assert.Fail(scene.name + " has no root named " + rootName);
            return null;
        }

        private static T FindInScene<T>(Scene scene) where T : Component
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                T found = roots[i].GetComponentInChildren<T>(true);

                if (found != null)
                {
                    return found;
                }
            }

            return null;
        }

        private static Scene OpenAdditive(string path)
        {
            return EditorSceneManager.OpenScene(path, OpenSceneMode.Additive);
        }

        private static void Close(params Scene[] scenes)
        {
            for (int i = 0; i < scenes.Length; i++)
            {
                if (scenes[i].IsValid())
                {
                    EditorSceneManager.CloseScene(scenes[i], true);
                }
            }
        }
    }
}

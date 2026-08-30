using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Editor.DevPlay;
using RootsDance.Investigation;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.DevPlay
{
    public class RescueCheckpointExporterTests
    {
        private const string k_Id = "c76953cfa37140e2bc80d0a09b1dbb26";
        private const string k_ScenePath = "Assets/RootsDance/Scenes/Bootstrap.unity";
        private DevCheckpointSO m_source;
        private RescueCheckpointCatalogSO m_catalog;
        private LevelSO m_level;

        [SetUp]
        public void SetUp()
        {
            m_source = ScriptableObject.CreateInstance<DevCheckpointSO>();
            m_catalog = ScriptableObject.CreateInstance<RescueCheckpointCatalogSO>();
            m_level = ScriptableObject.CreateInstance<LevelSO>();
            var serializedLevel = new SerializedObject(m_level);
            SerializedProperty paths = serializedLevel.FindProperty("m_scenePaths");
            paths.arraySize = 1;
            paths.GetArrayElementAtIndex(0).stringValue = k_ScenePath;
            serializedLevel.ApplyModifiedPropertiesWithoutUndo();
            ConfigureSource();
        }

        [TearDown]
        public void TearDown()
        {
            Object.DestroyImmediate(m_source);
            Object.DestroyImmediate(m_catalog);
            Object.DestroyImmediate(m_level);
        }

        [TestCase(null, false)]
        [TestCase("", false)]
        [TestCase("not-an-asset-guid", false)]
        [TestCase("c76953cf-a371-40e2-bc80-d0a09b1dbb26", false)]
        [TestCase(k_Id, true)]
        public void IsValidId_Input_RequiresCompactAssetGuid(string value, bool expected)
        {
            Assert.AreEqual(expected, RescueCheckpoint.IsValidId(value));
        }

        [Test]
        public void ExportCheckpoint_AuthoredSource_CopiesPlacementAndWorldState()
        {
            RescueCheckpoint result = RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id);

            Assert.AreEqual(k_Id, result.Id);
            Assert.AreEqual("01 Test checkpoint", result.Label);
            Assert.AreSame(m_level, result.Level);
            Assert.AreEqual("SafetyAnchor", result.AnchorName);
            Assert.AreEqual(new Vector3(3f, 7f, 11f), result.Position);
            Assert.AreEqual(90f, result.Yaw);
            Assert.IsFalse(result.SnapToGround);
            Assert.IsFalse(result.UseAnchorHeight);
            Assert.AreEqual(1 << 8, result.GroundLayers.value);
            Assert.AreEqual(1.25f, result.GroundClearance);
            Assert.IsTrue(result.OverrideTimeOfDay);
            Assert.AreEqual(TimeOfDay.Night, result.TimeOfDay);
            CollectionAssert.AreEqual(new[] { "AlreadyDone" }, result.Flags);
        }

        [Test]
        public void ExportCheckpoint_LevelDefault_DoesNotOverrideTimeOfDay()
        {
            m_source.SetTimeOfDay(CheckpointTimeOfDay.LevelDefault);

            Assert.IsFalse(RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id).OverrideTimeOfDay);
        }

        [Test]
        public void ExportCheckpoint_SourceArrayChanges_DoesNotMutateExport()
        {
            string[] flags = { "Before" };
            m_source.Configure("Checkpoint", m_level, "", Vector3.zero, 0f,
                CheckpointTimeOfDay.Day, flags, null);
            RescueCheckpoint result = RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id);
            flags[0] = "After";

            Assert.AreEqual("Before", result.Flags[0]);
            Assert.IsEmpty(result.RecordedTargets);
        }

        [Test]
        public void EnabledInPlayer_NewCatalog_EnablesOrdinaryTestingBuilds()
        {
            Assert.IsTrue(m_catalog.EnabledInPlayer);
        }

        [Test]
        public void ReplaceCheckpoints_DisabledCatalog_PreservesReleaseSwitch()
        {
            SetCatalogEnabled(false);
            m_catalog.ReplaceCheckpoints(new[] { RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id) });

            Assert.IsFalse(m_catalog.EnabledInPlayer);
            Assert.AreEqual(1, m_catalog.Checkpoints.Count);
        }

        [Test]
        public void ValidateCatalog_DisabledCatalog_SkipsMissingSourceAndScenes()
        {
            SetCatalogEnabled(false);

            Assert.IsEmpty(RescueCheckpointExporter.ValidateCatalog(m_catalog, null));
        }

        [Test]
        public void ValidateCatalog_MissingCatalog_ReportsActionableError()
        {
            Assert.That(RescueCheckpointExporter.ValidateCatalog(null, null)[0], Does.Contain("Refresh"));
        }

        [Test]
        public void MatchesSnapshot_IdenticalExport_ReturnsTrue()
        {
            RescueCheckpoint first = RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id);
            RescueCheckpoint second = RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id);

            Assert.IsTrue(RescueCheckpointExporter.MatchesSnapshot(new[] { first }, new[] { second }));
        }

        [Test]
        public void MatchesSnapshot_ChangedSource_ReturnsFalse()
        {
            RescueCheckpoint previous = RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id);
            m_source.SetTimeOfDay(CheckpointTimeOfDay.Day);
            RescueCheckpoint current = RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id);

            Assert.IsFalse(RescueCheckpointExporter.MatchesSnapshot(new[] { previous }, new[] { current }));
        }

        [Test]
        public void MatchesSnapshot_RemovedSource_ReturnsFalse()
        {
            RescueCheckpoint checkpoint = RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id);

            Assert.IsFalse(RescueCheckpointExporter.MatchesSnapshot(
                new[] { checkpoint }, new RescueCheckpoint[0]));
        }

        [Test]
        public void BuildSnapshot_UnchangedSources_HasStableOrderAndIds()
        {
            List<RescueCheckpoint> first = RescueCheckpointExporter.BuildSnapshot();
            List<RescueCheckpoint> second = RescueCheckpointExporter.BuildSnapshot();

            Assert.IsNotEmpty(first);
            Assert.IsTrue(RescueCheckpointExporter.MatchesSnapshot(first, second));
            foreach (RescueCheckpoint checkpoint in first)
            {
                Assert.IsTrue(RescueCheckpoint.IsValidId(checkpoint.Id));
            }
        }

        [Test]
        public void Bootstrap_InstalledRescue_ReferencesRuntimeCatalog()
        {
            CollectionAssert.Contains(AssetDatabase.GetDependencies(k_ScenePath, true),
                RescueCheckpointExporter.k_CatalogPath);
        }

        [Test]
        public void ValidateCheckpoints_IncludedTargetScene_HasNoErrors()
        {
            RescueCheckpoint checkpoint = RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id);

            Assert.IsEmpty(RescueCheckpointExporter.ValidateCheckpoints(new[] { checkpoint }, new[] { k_ScenePath }));
        }

        [Test]
        public void ValidateCheckpoints_MissingTargetScene_RejectsBuild()
        {
            RescueCheckpoint checkpoint = RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id);
            List<string> errors = RescueCheckpointExporter.ValidateCheckpoints(new[] { checkpoint }, new string[0]);

            Assert.That(errors[0], Does.Contain("not included"));
        }

        [Test]
        public void ValidateCheckpoints_EmptyCatalog_RejectsBuild()
        {
            List<string> errors = RescueCheckpointExporter.ValidateCheckpoints(
                new RescueCheckpoint[0], new[] { k_ScenePath });

            Assert.That(errors[0], Does.Contain("no checkpoints"));
        }

        [Test]
        public void ValidateCheckpoints_MissingLevel_RejectsBuild()
        {
            m_source.Configure("Checkpoint", null, "", Vector3.zero, 0f,
                CheckpointTimeOfDay.LevelDefault, null, null);
            RescueCheckpoint checkpoint = RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id);
            List<string> errors = RescueCheckpointExporter.ValidateCheckpoints(
                new[] { checkpoint }, new[] { k_ScenePath });

            Assert.That(errors[0], Does.Contain("no target level"));
        }

        [Test]
        public void ValidateCheckpoints_DuplicateIds_RejectsBuild()
        {
            RescueCheckpoint checkpoint = RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id);
            List<string> errors = RescueCheckpointExporter.ValidateCheckpoints(
                new[] { checkpoint, checkpoint }, new[] { k_ScenePath });

            Assert.That(errors[0], Does.Contain("duplicate"));
        }

        [Test]
        public void ValidateCheckpoints_MissingRecordedTarget_RejectsBuild()
        {
            m_source.Configure("Checkpoint", m_level, "", Vector3.zero, 0f,
                CheckpointTimeOfDay.Day, null, new InvestigationTargetSO[] { null });
            RescueCheckpoint checkpoint = RescueCheckpointExporter.ExportCheckpoint(m_source, k_Id);
            List<string> errors = RescueCheckpointExporter.ValidateCheckpoints(
                new[] { checkpoint }, new[] { k_ScenePath });

            Assert.That(errors[0], Does.Contain("target is missing"));
        }

        private void ConfigureSource()
        {
            m_source.Configure("01 Test checkpoint", m_level, "SafetyAnchor", new Vector3(3f, 7f, 11f),
                90f, CheckpointTimeOfDay.Night, new[] { "AlreadyDone" }, null, false, 1 << 8, 1.25f, false);
        }

        private void SetCatalogEnabled(bool enabled)
        {
            var serializedCatalog = new SerializedObject(m_catalog);
            serializedCatalog.FindProperty("m_enabledInPlayer").boolValue = enabled;
            serializedCatalog.ApplyModifiedPropertiesWithoutUndo();
        }
    }
}

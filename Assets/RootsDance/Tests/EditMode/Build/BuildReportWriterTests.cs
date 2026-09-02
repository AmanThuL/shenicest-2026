using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Editor.Build;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Build
{
    public class BuildReportWriterTests
    {
        private static PackedEntry Entry(string path, string type, long bytes)
        {
            return new PackedEntry { Path = path, Type = type, Bytes = bytes };
        }

        [Test]
        public void Aggregate_SumsByTypeSortedDescending()
        {
            var summary = new BuildReportSummary();
            BuildReportWriter.Aggregate(new List<PackedEntry>
            {
                Entry("A.png", "Texture2D", 10), Entry("B.fbx", "Mesh", 50), Entry("C.png", "Texture2D", 30),
            }, summary);
            Assert.AreEqual(2, summary.byType.Count);
            Assert.AreEqual("Mesh", summary.byType[0].type);
            Assert.AreEqual(50, summary.byType[0].bytes);
            Assert.AreEqual("Texture2D", summary.byType[1].type);
            Assert.AreEqual(40, summary.byType[1].bytes);
            Assert.AreEqual(2, summary.byType[1].count);
        }

        [Test]
        public void Aggregate_MergesSubAssetsOfOneSourceAndKeepsTopN()
        {
            var entries = new List<PackedEntry>();
            for (int i = 0; i < BuildReportWriter.k_TopAssetCount + 5; i++)
            {
                entries.Add(Entry("Assets/M" + i + ".fbx", "Mesh", 100 + i));
            }

            entries.Add(Entry("Assets/Big.fbx", "Mesh", 5000));
            entries.Add(Entry("Assets/Big.fbx", "Mesh", 6000));
            var summary = new BuildReportSummary();
            BuildReportWriter.Aggregate(entries, summary);
            Assert.AreEqual(BuildReportWriter.k_TopAssetCount, summary.topAssets.Count);
            Assert.AreEqual("Assets/Big.fbx", summary.topAssets[0].path);
            Assert.AreEqual(11000, summary.topAssets[0].bytes);
        }

        [Test]
        public void Aggregate_EmptyPathIsLabelledByType()
        {
            var summary = new BuildReportSummary();
            BuildReportWriter.Aggregate(new List<PackedEntry> { Entry("", "Shader", 7) }, summary);
            Assert.AreEqual("<Shader>", summary.topAssets[0].path);
        }

        [Test]
        public void Summary_RoundTripsThroughJsonUtility()
        {
            var summary = new BuildReportSummary { result = "Succeeded", totalSeconds = 1.5f, totalBytes = 42 };
            BuildReportWriter.Aggregate(new List<PackedEntry> { Entry("A.png", "Texture2D", 10) }, summary);
            summary.steps = new List<StepEntry> { new StepEntry { name = "Build player", depth = 0, seconds = 1.5f } };
            summary.files = new List<FileEntry>();
            string json = JsonUtility.ToJson(summary);
            BuildReportSummary back = JsonUtility.FromJson<BuildReportSummary>(json);
            Assert.AreEqual("Succeeded", back.result);
            Assert.AreEqual(42, back.totalBytes);
            Assert.AreEqual("Texture2D", back.byType[0].type);
            Assert.AreEqual("Build player", back.steps[0].name);
            StringAssert.Contains("\"topAssets\"", json);
        }
    }
}

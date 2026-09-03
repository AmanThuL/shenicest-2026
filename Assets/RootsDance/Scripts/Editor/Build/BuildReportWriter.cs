using System;
using System.Collections.Generic;
using System.IO;
using UnityEditor.Build.Reporting;
using UnityEngine;

namespace RootsDance.Editor.Build
{
    [Serializable]
    public struct StepEntry
    {
        public string name;
        public int depth;
        public float seconds;
    }

    [Serializable]
    public struct TypeEntry
    {
        public string type;
        public long bytes;
        public int count;
    }

    [Serializable]
    public struct AssetEntry
    {
        public string path;
        public string type;
        public long bytes;
    }

    [Serializable]
    public struct FileEntry
    {
        public string path;
        public long bytes;
    }

    /// <summary>What build.py reads back: the JSON shape is the contract with Tools/build/history.py.</summary>
    [Serializable]
    public class BuildReportSummary
    {
        public string result;
        public float totalSeconds;
        public long totalBytes;
        public string outputPath;
        public int warnings;
        public int errors;
        public List<StepEntry> steps = new List<StepEntry>();
        public List<TypeEntry> byType = new List<TypeEntry>();
        public List<AssetEntry> topAssets = new List<AssetEntry>();
        public List<FileEntry> files = new List<FileEntry>();
    }

    /// <summary>One packed asset as seen by the aggregation; decoupled from PackedAssetInfo for tests.</summary>
    public struct PackedEntry
    {
        public string Path;
        public string Type;
        public long Bytes;
    }

    /// <summary>
    /// Turns a <see cref="BuildReport"/> into Builds/&lt;profile&gt;/build-report.json so the build
    /// script can print step durations, size by type, the largest assets and the delta against
    /// the previous build without parsing the 600 MB Unity log.
    /// </summary>
    public static class BuildReportWriter
    {
        public const int k_TopAssetCount = 40;

        public static void Aggregate(IEnumerable<PackedEntry> entries, BuildReportSummary into)
        {
            var bytesByType = new Dictionary<string, long>();
            var countByType = new Dictionary<string, int>();
            var bytesByPath = new Dictionary<string, long>();
            var typeByPath = new Dictionary<string, string>();

            foreach (PackedEntry entry in entries)
            {
                string type = string.IsNullOrEmpty(entry.Type) ? "Unknown" : entry.Type;
                string path = string.IsNullOrEmpty(entry.Path) ? "<" + type + ">" : entry.Path;

                long typeBytes;
                bytesByType.TryGetValue(type, out typeBytes);
                bytesByType[type] = typeBytes + entry.Bytes;
                int typeCount;
                countByType.TryGetValue(type, out typeCount);
                countByType[type] = typeCount + 1;

                long pathBytes;
                bytesByPath.TryGetValue(path, out pathBytes);
                bytesByPath[path] = pathBytes + entry.Bytes;
                typeByPath[path] = type;
            }

            into.byType = new List<TypeEntry>();
            foreach (KeyValuePair<string, long> pair in bytesByType)
            {
                into.byType.Add(new TypeEntry { type = pair.Key, bytes = pair.Value, count = countByType[pair.Key] });
            }

            into.byType.Sort((a, b) => b.bytes.CompareTo(a.bytes));

            var assets = new List<AssetEntry>();
            foreach (KeyValuePair<string, long> pair in bytesByPath)
            {
                assets.Add(new AssetEntry { path = pair.Key, type = typeByPath[pair.Key], bytes = pair.Value });
            }

            assets.Sort((a, b) => b.bytes.CompareTo(a.bytes));
            if (assets.Count > k_TopAssetCount)
            {
                assets.RemoveRange(k_TopAssetCount, assets.Count - k_TopAssetCount);
            }

            into.topAssets = assets;
        }

        public static BuildReportSummary Summarize(BuildReport report)
        {
            BuildSummary summary = report.summary;
            var result = new BuildReportSummary
            {
                result = summary.result.ToString(),
                totalSeconds = (float)summary.totalTime.TotalSeconds,
                totalBytes = (long)summary.totalSize,
                outputPath = summary.outputPath,
                warnings = summary.totalWarnings,
                errors = summary.totalErrors,
            };

            foreach (BuildStep step in report.steps)
            {
                result.steps.Add(new StepEntry
                {
                    name = step.name,
                    depth = step.depth,
                    seconds = (float)step.duration.TotalSeconds,
                });
            }

            foreach (BuildFile file in report.GetFiles())
            {
                result.files.Add(new FileEntry { path = file.path, bytes = (long)file.size });
            }

            Aggregate(Packed(report), result);
            return result;
        }

        private static IEnumerable<PackedEntry> Packed(BuildReport report)
        {
            foreach (PackedAssets packed in report.packedAssets)
            {
                foreach (PackedAssetInfo info in packed.contents)
                {
                    yield return new PackedEntry
                    {
                        Path = info.sourceAssetPath,
                        Type = info.type != null ? info.type.Name : "Unknown",
                        Bytes = (long)info.packedSize,
                    };
                }
            }
        }

        public static string Write(BuildReport report, string path)
        {
            string json = JsonUtility.ToJson(Summarize(report), true);
            Directory.CreateDirectory(Path.GetDirectoryName(path));
            File.WriteAllText(path, json);
            return json;
        }
    }
}

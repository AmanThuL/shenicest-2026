using System;
using System.Collections.Generic;
using System.IO;
using RootsDance.Editor.Pipeline;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Build
{
    /// <summary>Result of one audit run; also the JSON written to Logs/asset-audit.json.</summary>
    [Serializable]
    public class AuditResult
    {
        public int scanned;
        public int fixedCount;
        public List<AssetViolation> violations = new List<AssetViolation>();

        public int Scanned => scanned;
        public int Fixed => fixedCount;
        public List<AssetViolation> Violations => violations;
    }

    /// <summary>
    /// Checks every texture, model, clip and scatter prefab under the policy roots against
    /// <see cref="AssetSizePolicy"/>. Report mode only reads importers (milliseconds per asset);
    /// fix mode rewrites the offending importers/prefabs through the Unity API and reimports
    /// them, so already-compliant assets are never touched and repeated runs are cheap.
    /// </summary>
    public static class AssetSizeAudit
    {
        public const string k_ReportPath = "Logs/asset-audit.json";

        /// <summary>Absolute path for <see cref="k_ReportPath"/>, resolved from the project root
        /// (<c>Application.dataPath</c>/..) rather than the process's current working directory, which is
        /// not always the project root (for example a menu-triggered run from an Editor launched elsewhere).</summary>
        public static string ReportAbsolutePath =>
            Path.GetFullPath(Path.Combine(Application.dataPath, "..", k_ReportPath));

        private static readonly string[] k_AssetRoots =
        {
            "Assets/RootsDance/Textures",
            "Assets/ThirdParty/Environment",
            "Assets/RootsDance/Meshes/Environment",
            "Assets/RootsDance/Audio",
            "Assets/RootsDance/Prefabs/Environment/Rocks",
        };

        [MenuItem("RootsDance/Build/Asset Size Audit (Report)")]
        private static void MenuReport()
        {
            Run(false, true);
        }

        [MenuItem("RootsDance/Build/Asset Size Audit (Fix)")]
        private static void MenuFix()
        {
            Run(true, true);
        }

        /// <summary>Entry point for build.py --audit [--fix].</summary>
        public static void RunFromCommandLine()
        {
            bool fix = Array.IndexOf(System.Environment.GetCommandLineArgs(), "-rdFix") >= 0;
            int exitCode = 0;
            try
            {
                Run(fix, true);
            }
            catch (Exception error)
            {
                Debug.LogError("[AssetSizeAudit] failed: " + error);
                exitCode = 1;
            }

            if (Application.isBatchMode)
            {
                EditorApplication.Exit(exitCode);
            }
        }

        public static AuditResult Run(bool fix, bool log)
        {
            var result = new AuditResult();
            ModelImportProfiles profiles = ModelImportProfiles.Load();

            // The asset path travels with its action so a failing fix can name the asset it
            // was working on; the closures run later, inside Start/StopAssetEditing.
            var fixes = new List<KeyValuePair<string, Action>>();

            foreach (string guid in AssetDatabase.FindAssets("", k_AssetRoots))
            {
                string path = AssetDatabase.GUIDToAssetPath(guid);
                if (AssetDatabase.IsValidFolder(path))
                {
                    continue;
                }

                AssetImporter importer = AssetImporter.GetAtPath(path);
                var found = new List<AssetViolation>();

                var textureImporter = importer as TextureImporter;
                var modelImporter = importer as ModelImporter;
                var audioImporter = importer as AudioImporter;
                if (textureImporter != null)
                {
                    result.scanned++;
                    AssetSizePolicy.Check(SnapshotTexture(path, textureImporter), found);
                    if (fix && AnyFixable(found))
                    {
                        QueueFix(fixes, path, () => FixTexture(path, textureImporter, found));
                    }
                }
                else if (modelImporter != null)
                {
                    result.scanned++;
                    bool owned = profiles != null && profiles.FindAsset(path) != null;
                    AssetSizePolicy.Check(SnapshotModel(path, modelImporter, owned), found);
                    if (fix && !owned && AnyFixable(found))
                    {
                        QueueFix(fixes, path, () => FixModel(modelImporter, found));
                    }
                }
                else if (audioImporter != null)
                {
                    result.scanned++;
                    AssetSizePolicy.Check(SnapshotAudio(path, audioImporter), found);
                    if (fix && AnyFixable(found))
                    {
                        // SaveAndReimport triggers AudioClipPostprocessor.OnPreprocessAudio, which applies the
                        // folder's AudioImportProfile; no settings are set here on purpose.
                        QueueFix(fixes, path, () => audioImporter.SaveAndReimport());
                    }
                }
                else if (path.EndsWith(".prefab", StringComparison.Ordinal)
                         && AssetSizePolicy.StartsWithAny(path, AssetSizePolicy.k_ScatterPrefabRoots))
                {
                    // Only scatter prefabs have a prefab rule, and loading every other prefab
                    // in the roots just to find no violation costs seconds per run.
                    result.scanned++;
                    CheckPrefab(path, found);
                    if (fix && found.Count > 0)
                    {
                        QueueFix(fixes, path, () => FixPrefab(path));
                    }
                }

                result.violations.AddRange(found);
            }

            if (fix && fixes.Count > 0)
            {
                AssetDatabase.StartAssetEditing();
                try
                {
                    foreach (KeyValuePair<string, Action> entry in fixes)
                    {
                        // One unfixable asset (a locked file, a broken prefab) must not abandon
                        // the other few hundred fixes and leave the project half-migrated.
                        try
                        {
                            entry.Value();
                            result.fixedCount++;
                        }
                        catch (Exception error)
                        {
                            Debug.LogError("[AssetSizeAudit] fix failed for " + entry.Key + ": " + error.Message);
                        }
                    }
                }
                finally
                {
                    AssetDatabase.StopAssetEditing();
                    AssetDatabase.SaveAssets();
                    AssetDatabase.Refresh();
                }
            }

            WriteReport(result);
            if (log)
            {
                Debug.Log(string.Format("[AssetSizeAudit] {0} assets, {1} violations, {2} fixed",
                    result.scanned, result.violations.Count, result.fixedCount));
                Debug.Log("[AssetSizeAudit] report: " + ReportAbsolutePath);
                foreach (AssetViolation violation in result.violations)
                {
                    Debug.Log(string.Format("[AssetSizeAudit] {0} {1}: {2}{3}", violation.rule, violation.assetPath,
                        violation.message, violation.fixable ? "" : " (no automatic fix)"));
                }
            }

            return result;
        }

        private static void QueueFix(List<KeyValuePair<string, Action>> fixes, string path, Action apply)
        {
            fixes.Add(new KeyValuePair<string, Action>(path, apply));
        }

        private static bool AnyFixable(List<AssetViolation> found)
        {
            foreach (AssetViolation violation in found)
            {
                if (violation.fixable)
                {
                    return true;
                }
            }

            return false;
        }

        private static TextureSnapshot SnapshotTexture(string path, TextureImporter importer)
        {
            int width;
            int height;
            importer.GetSourceTextureWidthAndHeight(out width, out height);
            TextureImporterPlatformSettings standalone = importer.GetPlatformTextureSettings("Standalone");
            return new TextureSnapshot
            {
                Path = path,
                SourceWidth = width,
                SourceHeight = height,
                IsCubemap = importer.textureShape != TextureImporterShape.Texture2D,
                Compression = importer.textureCompression,
                NpotScale = importer.npotScale,
                IsReadable = importer.isReadable,
                StandaloneOverridden = standalone.overridden,
                StandaloneMaxSize = standalone.maxTextureSize,
                StandaloneFormat = standalone.format,
            };
        }

        private static ModelSnapshot SnapshotModel(string path, ModelImporter importer, bool owned)
        {
            return new ModelSnapshot
            {
                Path = path,
                PipelineOwned = owned,
                IsReadable = importer.isReadable,
                ImportBlendShapes = importer.importBlendShapes,
                ImportCameras = importer.importCameras,
                ImportLights = importer.importLights,
            };
        }

        private static AudioSnapshot SnapshotAudio(string path, AudioImporter importer)
        {
            AudioImporterSampleSettings settings = importer.defaultSampleSettings;
            return new AudioSnapshot
            {
                Path = path,
                ForceToMono = importer.forceToMono,
                LoadType = settings.loadType,
                Format = settings.compressionFormat,
                Quality = settings.quality,
                SampleRateSetting = settings.sampleRateSetting,
                SampleRateOverride = settings.sampleRateOverride,
            };
        }

        private static void CheckPrefab(string path, List<AssetViolation> found)
        {
            GameObject root = AssetDatabase.LoadAssetAtPath<GameObject>(path);
            if (root == null)
            {
                return;
            }

            foreach (Renderer renderer in root.GetComponentsInChildren<Renderer>(true))
            {
                AssetSizePolicy.Check(new PrefabRendererSnapshot
                {
                    PrefabPath = path,
                    ObjectPath = HierarchyPath(renderer.transform),
                    Flags = GameObjectUtility.GetStaticEditorFlags(renderer.gameObject),
                }, found);
            }
        }

        private static string HierarchyPath(Transform transform)
        {
            string result = transform.name;
            while (transform.parent != null)
            {
                transform = transform.parent;
                result = transform.name + "/" + result;
            }

            return result;
        }

        private static void FixTexture(string path, TextureImporter importer, List<AssetViolation> found)
        {
            foreach (AssetViolation violation in found)
            {
                if (violation.rule == AssetRule.TextureNpot4.ToString())
                {
                    importer.npotScale = TextureImporterNPOTScale.ToNearest;
                }
                else if (violation.rule == AssetRule.TextureReadable.ToString())
                {
                    importer.isReadable = false;
                }
                else if (violation.rule == AssetRule.TextureStandaloneMax.ToString())
                {
                    int cap;
                    if (AssetSizePolicy.TryGetStandaloneMaxSize(path, out cap))
                    {
                        TextureImporterPlatformSettings standalone = importer.GetPlatformTextureSettings("Standalone");
                        standalone.overridden = true;
                        standalone.maxTextureSize = Mathf.Min(cap, importer.maxTextureSize);
                        standalone.format = TextureImporterFormat.Automatic;
                        importer.SetPlatformTextureSettings(standalone);
                    }
                }
            }

            importer.SaveAndReimport();
        }

        private static void FixModel(ModelImporter importer, List<AssetViolation> found)
        {
            foreach (AssetViolation violation in found)
            {
                if (violation.rule == AssetRule.ModelReadable.ToString())
                {
                    importer.isReadable = false;
                }
                else if (violation.rule == AssetRule.ModelExtras.ToString())
                {
                    importer.importBlendShapes = false;
                    importer.importCameras = false;
                    importer.importLights = false;
                }
            }

            importer.SaveAndReimport();
        }

        private static void FixPrefab(string path)
        {
            GameObject root = PrefabUtility.LoadPrefabContents(path);
            try
            {
                foreach (Renderer renderer in root.GetComponentsInChildren<Renderer>(true))
                {
                    StaticEditorFlags flags = GameObjectUtility.GetStaticEditorFlags(renderer.gameObject);
                    GameObjectUtility.SetStaticEditorFlags(
                        renderer.gameObject, flags & ~StaticEditorFlags.BatchingStatic);
                }

                PrefabUtility.SaveAsPrefabAsset(root, path);
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(root);
            }
        }

        private static void WriteReport(AuditResult result)
        {
            string absolutePath = ReportAbsolutePath;
            Directory.CreateDirectory(Path.GetDirectoryName(absolutePath));
            File.WriteAllText(absolutePath, JsonUtility.ToJson(result, true));
        }
    }
}

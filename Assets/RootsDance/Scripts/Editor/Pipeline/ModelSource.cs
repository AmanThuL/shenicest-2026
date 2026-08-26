using System;
using System.IO;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Pipeline
{
    /// <summary>
    /// The link between the .blend that authored a model and the FBX sitting in Assets/.
    /// </summary>
    /// <remarks>
    /// <para>
    /// Written by <c>Tools/blender/export_fbx.py</c> on every export (<c>--manifest</c>), read here so
    /// the Editor can say which action the imported clip came from and whether the source has moved
    /// on since. The traffic is one-way by design: Blender owns mesh/rig/animation, Unity owns
    /// materials and import settings, and nothing in Unity ever needs carrying back into the .blend.
    /// </para>
    /// <para>
    /// Nothing here is asset-specific. Any model exported with <c>--manifest</c> gets one of these,
    /// and the manifest path is a per-asset entry in <c>Tools/unity/model_import_profiles.json</c>.
    /// </para>
    /// <para>
    /// Paths inside the manifest are recorded relative to the project root when the exporter is run
    /// with <c>--project-root</c>, which is how the pipeline runs it. They are resolved against the
    /// project root here rather than against the process working directory, which Unity does not
    /// guarantee.
    /// </para>
    /// </remarks>
    [Serializable]
    public class ModelSource
    {
        [SerializeField] private string m_fbx;
        [SerializeField] private string m_blend;
        [SerializeField] private string m_blendModifiedUtc;
        [SerializeField] private string m_action;
        [SerializeField] private string m_armature;
        [SerializeField] private int m_frameStart;
        [SerializeField] private int m_frameEnd;
        [SerializeField] private int m_fps;
        [SerializeField] private string[] m_exportedObjects;
        [SerializeField] private string m_blenderVersion;
        [SerializeField] private string m_profile;
        [SerializeField] private string m_exportedUtc;

        public string Fbx => m_fbx;

        public string Blend => m_blend;

        public string Action => m_action;

        public string Armature => m_armature;

        public string Profile => m_profile;

        public string ExportedUtc => m_exportedUtc;

        public string[] ExportedObjects => m_exportedObjects ?? Array.Empty<string>();

        /// <summary>The project root — the folder containing Assets/, not Assets/ itself.</summary>
        public static string ProjectRoot =>
            Path.GetFullPath(Path.Combine(Application.dataPath, ".."));

        public string Summary
        {
            get
            {
                string clip = string.IsNullOrEmpty(m_action) ? "current animation" : m_action;
                string blendName = string.IsNullOrEmpty(m_blend)
                    ? "an unsaved .blend"
                    : Path.GetFileName(m_blend);

                return $"{clip} ({m_frameStart}-{m_frameEnd} @ {m_fps}fps) from {blendName} "
                    + $"via Blender {m_blenderVersion}, profile {m_profile}, exported {m_exportedUtc}";
            }
        }

        /// <summary>
        /// Reads the manifest at a project-root-relative path. Returns null when there is none,
        /// which is the normal state for a model exported without <c>--manifest</c>.
        /// </summary>
        public static ModelSource Load(string manifestPath)
        {
            if (string.IsNullOrEmpty(manifestPath))
            {
                return null;
            }

            string absolute = Resolve(manifestPath);

            if (!File.Exists(absolute))
            {
                return null;
            }

            try
            {
                // The exporter writes m_-prefixed keys so this maps straight onto the fields.
                return JsonUtility.FromJson<ModelSource>(File.ReadAllText(absolute));
            }
            catch (Exception exception)
            {
                Debug.LogWarning($"ModelSource: could not read {manifestPath}: {exception.Message}");
                return null;
            }
        }

        /// <summary>True when the .blend has been touched since the FBX in Assets/ was exported.</summary>
        public bool IsStale()
        {
            if (string.IsNullOrEmpty(m_blend))
            {
                return false;
            }

            string absolute = Resolve(m_blend);

            if (!File.Exists(absolute))
            {
                return false;
            }

            if (!DateTime.TryParse(m_blendModifiedUtc, out DateTime recorded))
            {
                return false;
            }

            DateTime actual = File.GetLastWriteTimeUtc(absolute);

            // One second of slack: the manifest timestamp is written at whole-second resolution.
            return actual > recorded.ToUniversalTime().AddSeconds(1);
        }

        /// <summary>Resolves a manifest path against the project root; absolute paths pass through.</summary>
        private static string Resolve(string path)
        {
            if (string.IsNullOrEmpty(path))
            {
                return path;
            }

            return Path.IsPathRooted(path)
                ? Path.GetFullPath(path)
                : Path.GetFullPath(Path.Combine(ProjectRoot, path));
        }

        /// <summary>
        /// Warns for every registered model whose FBX is behind its .blend. The failure mode of an
        /// iterative animation loop is testing a build of the clip you already changed.
        /// </summary>
        [MenuItem("RootsDance/Pipeline/Check Model Sources")]
        private static void CheckSources()
        {
            ModelImportProfiles profiles = ModelImportProfiles.Load();

            if (profiles == null)
            {
                Debug.LogWarning($"No {ModelImportProfiles.k_ConfigPath}; nothing to check.");
                return;
            }

            int checkedCount = 0;

            foreach (ModelImportProfiles.AssetEntry asset in profiles.Assets)
            {
                if (string.IsNullOrEmpty(asset.Manifest))
                {
                    continue;
                }

                ModelSource source = Load(asset.Manifest);

                if (source == null)
                {
                    Debug.LogWarning($"{asset.Path}: no manifest at {asset.Manifest}. Re-export with "
                        + "Tools/blender/export_fbx.py --manifest to record where the FBX came from.");
                    continue;
                }

                checkedCount++;

                if (source.IsStale())
                {
                    Debug.LogWarning($"{asset.Path} is BEHIND its source. {source.Summary}\n"
                        + $"{source.Blend} has changed since that export — re-run "
                        + "Tools/blender/export_fbx.py.");
                }
                else
                {
                    Debug.Log($"{asset.Path} is up to date with its source. {source.Summary}");
                }
            }

            if (checkedCount == 0)
            {
                Debug.LogWarning("No model manifests found. Nothing was checked.");
            }
        }
    }
}

using System;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Pipeline
{
    /// <summary>
    /// The Unity-side half of the model pipeline configuration: which import settings apply to which
    /// FBX, read from <c>Tools/unity/model_import_profiles.json</c>.
    /// </summary>
    /// <remarks>
    /// <para>
    /// This mirrors the Blender side deliberately. <c>Tools/blender/export_fbx.py</c> is generic code
    /// plus a JSON export profile plus per-asset command-line arguments;
    /// <see cref="BlenderModelPostprocessor"/> is generic code plus a JSON import profile plus a
    /// per-asset entry. Neither half names a specific asset in code.
    /// </para>
    /// <para>
    /// The config lives under <c>Tools/</c> rather than <c>Assets/</c> so that editing it does not
    /// churn a <c>.meta</c> file, and so the whole pipeline configuration sits in one place.
    /// Consequence: changing it does not by itself trigger a reimport — use
    /// <c>RootsDance/Pipeline/Reimport Pipeline Models</c> after editing.
    /// </para>
    /// <para>
    /// Enum-valued settings are written as the Unity enum member name (for example
    /// <c>"animationType": "Generic"</c>). An unrecognised name is reported and the importer default
    /// is kept, rather than silently importing with the wrong rig type.
    /// </para>
    /// </remarks>
    [Serializable]
    public class ModelImportProfiles
    {
        public const string k_ConfigPath = "Tools/unity/model_import_profiles.json";

        [SerializeField] private Profile[] m_profiles;
        [SerializeField] private AssetEntry[] m_assets;

        public IReadOnlyList<Profile> Profiles => m_profiles ?? Array.Empty<Profile>();

        public IReadOnlyList<AssetEntry> Assets => m_assets ?? Array.Empty<AssetEntry>();

        /// <summary>One named set of ModelImporter settings, shared by any number of assets.</summary>
        [Serializable]
        public class Profile
        {
            [SerializeField] private string m_name;

            [SerializeField] private bool m_bakeAxisConversion = true;
            [SerializeField] private float m_globalScale = 1f;
            [SerializeField] private bool m_useFileScale = true;
            [SerializeField] private bool m_importBlendShapes;
            [SerializeField] private bool m_importVisibility;
            [SerializeField] private bool m_importCameras;
            [SerializeField] private bool m_importLights;
            [SerializeField] private bool m_addCollider;
            [SerializeField] private bool m_isReadable;
            [SerializeField] private bool m_weldVertices = true;

            [SerializeField] private string m_animationType = "Generic";
            [SerializeField] private bool m_optimizeGameObjects;
            [SerializeField] private string[] m_extraExposedTransformPaths;

            [SerializeField] private bool m_importAnimation = true;
            [SerializeField] private string m_animationCompression = "Off";
            [SerializeField] private bool m_resampleCurves = true;

            [SerializeField] private string m_materialImportMode = "ImportStandard";
            [SerializeField] private string m_materialLocation = "External";
            [SerializeField] private string m_materialName = "BasedOnMaterialName";
            [SerializeField] private string m_materialSearch = "Everywhere";
            [SerializeField] private bool m_doubleSidedMaterials;

            public string Name => m_name;

            public bool BakeAxisConversion => m_bakeAxisConversion;

            public float GlobalScale => m_globalScale;

            public bool UseFileScale => m_useFileScale;

            public bool ImportBlendShapes => m_importBlendShapes;

            public bool ImportVisibility => m_importVisibility;

            public bool ImportCameras => m_importCameras;

            public bool ImportLights => m_importLights;

            public bool AddCollider => m_addCollider;

            public bool IsReadable => m_isReadable;

            public bool WeldVertices => m_weldVertices;

            public bool OptimizeGameObjects => m_optimizeGameObjects;

            public string[] ExtraExposedTransformPaths =>
                m_extraExposedTransformPaths ?? Array.Empty<string>();

            public bool ImportAnimation => m_importAnimation;

            public bool ResampleCurves => m_resampleCurves;

            public ModelImporterAnimationType AnimationType =>
                ParseEnum(m_animationType, ModelImporterAnimationType.Generic);

            public ModelImporterAnimationCompression AnimationCompression =>
                ParseEnum(m_animationCompression, ModelImporterAnimationCompression.Off);

            public ModelImporterMaterialImportMode MaterialImportMode =>
                ParseEnum(m_materialImportMode, ModelImporterMaterialImportMode.ImportStandard);

            public ModelImporterMaterialLocation MaterialLocation =>
                ParseEnum(m_materialLocation, ModelImporterMaterialLocation.External);

            public ModelImporterMaterialName MaterialName =>
                ParseEnum(m_materialName, ModelImporterMaterialName.BasedOnMaterialName);

            public ModelImporterMaterialSearch MaterialSearch =>
                ParseEnum(m_materialSearch, ModelImporterMaterialSearch.Everywhere);

            /// <summary>
            /// Draws both faces of every material this model owns. Architectural geometry exported
            /// from SketchUp-style tools is single-sided surface shells with inconsistent winding:
            /// Blender never culls backfaces, so it looks solid there, while Unity culls them and
            /// roughly half of every wall disappears. FBX carries no double-sided flag, so this
            /// cannot be answered on the Blender side short of giving the walls real thickness.
            /// </summary>
            public bool DoubleSidedMaterials => m_doubleSidedMaterials;

            private TEnum ParseEnum<TEnum>(string value, TEnum fallback)
                where TEnum : struct
            {
                if (string.IsNullOrEmpty(value))
                {
                    return fallback;
                }

                if (Enum.TryParse(value, out TEnum parsed) && Enum.IsDefined(typeof(TEnum), parsed))
                {
                    return parsed;
                }

                Debug.LogError($"{k_ConfigPath}: profile '{m_name}' has an unrecognised "
                    + $"{typeof(TEnum).Name} value '{value}'. Using {fallback} instead. "
                    + $"Valid values: {string.Join(", ", Enum.GetNames(typeof(TEnum)))}");

                return fallback;
            }
        }

        /// <summary>One FBX in Assets/, the profile it uses, and its asset-specific parameters.</summary>
        [Serializable]
        public class AssetEntry
        {
            [SerializeField] private string m_path;
            [SerializeField] private string m_profile;
            [SerializeField] private string m_manifest;
            [SerializeField] private string m_clipName;
            [SerializeField] private bool m_loopTime;
            [SerializeField] private MaterialRemap[] m_materials;

            /// <summary>Project-relative path of the FBX, for example <c>Assets/.../Arms.fbx</c>.</summary>
            public string Path => m_path;

            public string ProfileName => m_profile;

            /// <summary>Project-root-relative path of the exporter's provenance manifest, or empty.</summary>
            public string Manifest => m_manifest;

            /// <summary>Name for the imported clip. Empty keeps whatever the FBX carries.</summary>
            public string ClipName => m_clipName;

            /// <summary>
            /// Loop Time for the imported clip. Absent or <c>false</c> suits a one-shot action;
            /// a locomotion cycle whose first and last frame match sets it to <c>true</c>.
            /// </summary>
            public bool LoopTime => m_loopTime;

            public MaterialRemap[] Materials => m_materials ?? Array.Empty<MaterialRemap>();
        }

        /// <summary>Maps a Blender material name onto a material asset already in the project.</summary>
        [Serializable]
        public class MaterialRemap
        {
            [SerializeField] private string m_source;
            [SerializeField] private string m_asset;

            public string Source => m_source;

            public string Asset => m_asset;
        }

        /// <summary>Absolute path of the config, which lives outside Assets/ to avoid .meta churn.</summary>
        public static string AbsoluteConfigPath =>
            System.IO.Path.GetFullPath(System.IO.Path.Combine(ModelSource.ProjectRoot, k_ConfigPath));

        /// <summary>Reads the config. Returns null when it is missing or malformed.</summary>
        public static ModelImportProfiles Load()
        {
            string path = AbsoluteConfigPath;

            if (!File.Exists(path))
            {
                return null;
            }

            try
            {
                return JsonUtility.FromJson<ModelImportProfiles>(File.ReadAllText(path));
            }
            catch (Exception exception)
            {
                Debug.LogError($"{k_ConfigPath} could not be parsed, so no model import settings "
                    + $"were applied: {exception.Message}");
                return null;
            }
        }

        /// <summary>Finds the entry for an asset path, or null when the asset is not registered.</summary>
        public AssetEntry FindAsset(string assetPath)
        {
            foreach (AssetEntry entry in Assets)
            {
                if (string.Equals(entry.Path, assetPath, StringComparison.Ordinal))
                {
                    return entry;
                }
            }

            return null;
        }

        /// <summary>Finds a profile by name, reporting the mismatch rather than importing silently.</summary>
        public Profile FindProfile(string name)
        {
            foreach (Profile profile in Profiles)
            {
                if (string.Equals(profile.Name, name, StringComparison.Ordinal))
                {
                    return profile;
                }
            }

            Debug.LogError($"{k_ConfigPath}: no profile named '{name}'. That asset was imported with "
                + "Unity's defaults, which is almost certainly wrong.");

            return null;
        }

        /// <summary>
        /// Reimports every registered model. The config lives outside Assets/, so Unity does not
        /// notice edits to it on its own.
        /// </summary>
        [MenuItem("RootsDance/Pipeline/Reimport Pipeline Models")]
        private static void ReimportAll()
        {
            ModelImportProfiles profiles = Load();

            if (profiles == null)
            {
                Debug.LogWarning($"No {k_ConfigPath}; nothing to reimport.");
                return;
            }

            int count = 0;

            foreach (AssetEntry asset in profiles.Assets)
            {
                if (string.IsNullOrEmpty(asset.Path))
                {
                    continue;
                }

                if (AssetImporter.GetAtPath(asset.Path) == null)
                {
                    Debug.LogWarning($"{k_ConfigPath} lists {asset.Path}, which is not in the "
                        + "project. Export it, or remove the entry.");
                    continue;
                }

                AssetDatabase.ImportAsset(asset.Path, ImportAssetOptions.ForceUpdate);
                count++;
            }

            Debug.Log($"Reimported {count} pipeline model(s) from {k_ConfigPath}.");
        }
    }
}

using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Editor.Pipeline
{
    /// <summary>
    /// Applies the registered import settings to every model the pipeline owns, on every import.
    /// </summary>
    /// <remarks>
    /// <para>
    /// A re-export from Blender never needs the settings re-entered by hand, and they never silently
    /// revert to the importer defaults. Which settings apply to which FBX is data, not code:
    /// see <c>Tools/unity/model_import_profiles.json</c> and <see cref="ModelImportProfiles"/>.
    /// </para>
    /// <para>
    /// Only registered assets are touched. Everything else — third-party FBX, meshes another
    /// workflow owns — imports exactly as Unity would import it, so dropping this pipeline into the
    /// project changes nothing it was not asked to change.
    /// </para>
    /// <para>
    /// This is the Unity half of the boundary. Blender owns mesh, rig and animation and states its
    /// policy in an export profile; Unity owns import settings and materials and states its policy
    /// here. The settings Unity cannot reach — leaf bones, curve decimation, which objects are in
    /// the file — are export-side and belong to <c>Tools/blender/export_fbx.py</c>.
    /// </para>
    /// </remarks>
    public class BlenderModelPostprocessor : AssetPostprocessor
    {
        private static readonly int k_DoubleSidedEnable = Shader.PropertyToID("_DoubleSidedEnable");

        private static readonly int k_DoubleSidedNormalMode =
            Shader.PropertyToID("_DoubleSidedNormalMode");

        /// <summary>
        /// HDRP's <c>DoubleSidedNormalMode.Mirror</c>. The enum is internal to
        /// <c>com.unity.render-pipelines.high-definition</c>
        /// (<c>Runtime/Material/MaterialExtension.cs</c>, <c>Flip, Mirror, None</c>), so the value
        /// has to be written out here.
        /// </summary>
        private const float k_DoubleSidedNormalModeMirror = 1f;

        /// <summary>The entry for the asset being imported, or null when it is not ours.</summary>
        private ModelImportProfiles.AssetEntry FindEntry(out ModelImportProfiles profiles)
        {
            profiles = ModelImportProfiles.Load();
            return profiles?.FindAsset(assetPath);
        }

        private void OnPreprocessModel()
        {
            ModelImportProfiles.AssetEntry entry = FindEntry(out ModelImportProfiles profiles);

            if (entry == null)
            {
                return;
            }

            ModelImportProfiles.Profile profile = profiles.FindProfile(entry.ProfileName);

            if (profile == null)
            {
                return;
            }

            ModelImporter importer = (ModelImporter)assetImporter;

            // Model — Blender leaves the Z-up conversion on the child transforms; baking folds it
            // into the data instead. Apply Transform is NOT used on the Blender side, because
            // Blender documents bake_space_transform as broken for armatures and animation.
            importer.bakeAxisConversion = profile.BakeAxisConversion;
            importer.globalScale = profile.GlobalScale;
            importer.useFileScale = profile.UseFileScale;
            importer.importBlendShapes = profile.ImportBlendShapes;
            importer.importVisibility = profile.ImportVisibility;
            importer.importCameras = profile.ImportCameras;
            importer.importLights = profile.ImportLights;
            importer.addCollider = profile.AddCollider;           // D16
            importer.isReadable = profile.IsReadable;
            importer.weldVertices = profile.WeldVertices;

            importer.animationType = profile.AnimationType;

            // Unity enforces NoAvatar while AnimationType is None and logs an error on any
            // assignment to avatarSetup, so only rigged profiles may touch it.
            if (profile.AnimationType != ModelImporterAnimationType.None)
            {
                importer.avatarSetup = ModelImporterAvatarSetup.CreateFromThisModel;
            }
            importer.optimizeGameObjects = profile.OptimizeGameObjects;

            // Only meaningful while optimizeGameObjects is on, but harmless to set either way:
            // it records which transforms must survive the optimisation.
            importer.extraExposedTransformPaths = profile.ExtraExposedTransformPaths;

            // Materials — shared material assets under Materials/, never re-extracted next to the
            // mesh. BasedOnMaterialName is required for the remap key to be the Blender material
            // name; the default names the material after its texture instead.
            importer.materialImportMode = profile.MaterialImportMode;
            importer.materialLocation = profile.MaterialLocation;
            importer.materialName = profile.MaterialName;
            importer.materialSearch = profile.MaterialSearch;

            foreach (ModelImportProfiles.MaterialRemap remap in entry.Materials)
            {
                Remap(importer, remap);
            }

            // Stamp the .blend this FBX came from onto the importer, so the Inspector answers
            // "which source authored this?" without anyone opening Blender.
            ModelSource source = ModelSource.Load(entry.Manifest);

            if (source != null)
            {
                importer.userData = source.Summary;
            }
        }

        private static void Remap(ModelImporter importer, ModelImportProfiles.MaterialRemap remap)
        {
            if (string.IsNullOrEmpty(remap.Source) || string.IsNullOrEmpty(remap.Asset))
            {
                return;
            }

            Material material = AssetDatabase.LoadAssetAtPath<Material>(remap.Asset);

            if (material == null)
            {
                // Not an error on a first import: the material may not exist yet. It becomes one
                // only if it is still missing after the import settles, which the Inspector shows.
                return;
            }

            importer.AddRemap(
                new AssetImporter.SourceAssetIdentifier(typeof(Material), remap.Source),
                material);
        }

        /// <summary>
        /// Runs after the importer has built the materials, which is the only point where the
        /// generated HDRP materials exist and can still be edited as part of this import.
        /// </summary>
        private void OnPostprocessModel(GameObject root)
        {
            ModelImportProfiles.AssetEntry entry = FindEntry(out ModelImportProfiles profiles);

            if (entry == null)
            {
                return;
            }

            ModelImportProfiles.Profile profile = profiles.FindProfile(entry.ProfileName);

            if (profile == null || !profile.DoubleSidedMaterials)
            {
                return;
            }

            HashSet<Material> visited = new HashSet<Material>();

            foreach (Renderer renderer in root.GetComponentsInChildren<Renderer>(true))
            {
                foreach (Material material in renderer.sharedMaterials)
                {
                    if (material == null || !visited.Add(material))
                    {
                        continue;
                    }

                    MakeDoubleSided(material);
                }
            }
        }

        /// <summary>
        /// Turns one generated material double-sided. Mirror is the right normal mode here: the
        /// source shells wind inconsistently, so a backface's normal is as likely to be the correct
        /// one as the frontface's, and mirroring lights both sides plausibly. Flip would invert the
        /// half that was already facing the right way.
        /// </summary>
        private void MakeDoubleSided(Material material)
        {
            // A material the model does not own — a remapped project asset — belongs to whoever
            // authored it. Editing it here would silently change every other model using it.
            string materialPath = AssetDatabase.GetAssetPath(material);

            if (!string.IsNullOrEmpty(materialPath) && materialPath != assetPath)
            {
                return;
            }

            // Anything outside the HDRP Lit family has no such property; leave it untouched rather
            // than guessing at another shader's render state.
            if (!material.HasProperty(k_DoubleSidedEnable))
            {
                Debug.LogWarning($"{assetPath}: material '{material.name}' uses shader "
                    + $"'{material.shader.name}', which has no _DoubleSidedEnable. It stays "
                    + "single-sided, so backfaces will still be culled.");
                return;
            }

            material.SetFloat(k_DoubleSidedEnable, 1f);
            material.SetFloat(k_DoubleSidedNormalMode, k_DoubleSidedNormalModeMirror);

            // HDRP derives cull mode, keywords, render queue and _DoubleSidedConstants from those
            // two values. Setting them without validating leaves the material visually unchanged.
            HDMaterial.ValidateMaterial(material);
        }

        private void OnPreprocessAnimation()
        {
            ModelImportProfiles.AssetEntry entry = FindEntry(out ModelImportProfiles profiles);

            if (entry == null)
            {
                return;
            }

            ModelImportProfiles.Profile profile = profiles.FindProfile(entry.ProfileName);

            if (profile == null)
            {
                return;
            }

            ModelImporter importer = (ModelImporter)assetImporter;

            importer.importAnimation = profile.ImportAnimation;
            importer.animationCompression = profile.AnimationCompression;
            importer.resampleCurves = profile.ResampleCurves;

            if (string.IsNullOrEmpty(entry.ClipName))
            {
                return;
            }

            ModelImporterClipAnimation[] defaults = importer.defaultClipAnimations;
            ModelImporterClipAnimation[] clips = new ModelImporterClipAnimation[defaults.Length];

            for (int i = 0; i < defaults.Length; i++)
            {
                clips[i] = defaults[i];

                // One exported action is the normal case, so the clip takes the configured name
                // verbatim. A file carrying several gets suffixed rather than colliding.
                clips[i].name = defaults.Length == 1
                    ? entry.ClipName
                    : entry.ClipName + "_" + i;

                clips[i].loopTime = entry.LoopTime;
                clips[i].lockRootRotation = false;
            }

            importer.clipAnimations = clips;
        }
    }
}

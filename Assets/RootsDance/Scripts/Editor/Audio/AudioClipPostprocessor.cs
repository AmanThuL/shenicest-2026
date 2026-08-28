using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Audio
{
    /// <summary>
    /// Applies <see cref="AudioImportProfile"/> to every clip imported under
    /// <c>Assets/RootsDance/Audio/</c>, so import settings are a property of where a file lives
    /// rather than of who dragged it in.
    /// </summary>
    /// <remarks>
    /// A clip that lands directly in <c>Audio/</c> instead of one of its four folders is reported
    /// once and otherwise left exactly as it was imported — the same stance the texture pipeline
    /// takes, so this can never quietly overwrite a deliberate manual setting. Vendor audio under
    /// <c>ThirdParty/</c> is outside the root and is never touched.
    /// </remarks>
    public sealed class AudioClipPostprocessor : AssetPostprocessor
    {
        private void OnPreprocessAudio()
        {
            string path = assetPath.Replace('\\', '/');

            if (!path.StartsWith(AudioImportProfile.k_AudioRoot))
            {
                return;
            }

            AudioAssetKind kind = AudioImportProfile.KindForPath(path);

            if (!AudioImportProfile.TryGet(kind, out AudioImportProfile profile))
            {
                Debug.LogWarning(
                    $"[AudioPipeline] '{path}' is under {AudioImportProfile.k_AudioRoot} but not in "
                    + "Music/, Ambience/, SFX/ or Voice/, so no import settings were applied. "
                    + "Move it into one of those folders.");
                return;
            }

            AudioImporter importer = (AudioImporter)assetImporter;
            importer.forceToMono = profile.ForceToMono;

            AudioImporterSampleSettings settings = importer.defaultSampleSettings;
            settings.loadType = profile.LoadType;
            settings.compressionFormat = profile.CompressionFormat;
            settings.quality = profile.Quality;
            settings.sampleRateSetting = AudioSampleRateSetting.OverrideSampleRate;
            settings.sampleRateOverride = AudioImportProfile.k_SampleRate;

            importer.defaultSampleSettings = settings;
        }
    }
}

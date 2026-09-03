using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Audio
{
    /// <summary>What sort of sound a clip is, decided by the folder it was imported into.</summary>
    public enum AudioAssetKind
    {
        /// <summary>Not under one of the project's audio folders: settings are left alone.</summary>
        Unknown,

        /// <summary>A long stereo track. Streamed.</summary>
        Music,

        /// <summary>A long looping bed — room tone, water, leaves. Streamed.</summary>
        Ambience,

        /// <summary>A short mono one-shot. Decompressed into memory so it starts instantly.</summary>
        Sfx,

        /// <summary>Spoken lines. Mono, kept compressed in memory.</summary>
        Voice
    }

    /// <summary>
    /// The import settings for one kind of clip, and the folder rule that picks between them.
    /// <para>
    /// Deriving the settings from the folder rather than from a per-clip config is what makes an
    /// import reproducible: dropping a file into <c>Audio/SFX/</c> gives it the project's SFX
    /// settings with nobody clicking through the Inspector, and re-importing the project produces
    /// the same result. It mirrors what the texture pipeline already does with map suffixes.
    /// </para>
    /// The rules come from guideline 05 section 7 (mono, 44.1 kHz, streaming for music) and are
    /// deliberately only four: a jam does not have the time to tune per-clip compression, and the
    /// wrong choice here costs memory and load hitches rather than sounding wrong.
    /// </summary>
    public readonly struct AudioImportProfile
    {
        /// <summary>Everything the project's own audio lives under.</summary>
        public const string k_AudioRoot = "Assets/RootsDance/Audio/";

        /// <summary>The rate everything is resampled to. Nothing here needs 48 kHz.</summary>
        public const int k_SampleRate = 44100;

        private readonly bool m_forceToMono;
        private readonly AudioClipLoadType m_loadType;
        private readonly AudioCompressionFormat m_compressionFormat;
        private readonly float m_quality;

        private AudioImportProfile(bool forceToMono, AudioClipLoadType loadType,
            AudioCompressionFormat compressionFormat, float quality)
        {
            m_forceToMono = forceToMono;
            m_loadType = loadType;
            m_compressionFormat = compressionFormat;
            m_quality = quality;
        }

        /// <summary>
        /// Mono halves the memory and, for a positioned one-shot, is not a loss: a 3D source is
        /// panned by the engine, so a stereo clip's own image is thrown away anyway.
        /// </summary>
        public bool ForceToMono => m_forceToMono;

        public AudioClipLoadType LoadType => m_loadType;

        public AudioCompressionFormat CompressionFormat => m_compressionFormat;

        /// <summary>Vorbis quality, 0..1. Ignored by formats that have no quality setting.</summary>
        public float Quality => m_quality;

        /// <summary>Which folder under <c>Audio/</c> a path is in, if any.</summary>
        public static AudioAssetKind KindForPath(string assetPath)
        {
            if (string.IsNullOrEmpty(assetPath))
            {
                return AudioAssetKind.Unknown;
            }

            string path = assetPath.Replace('\\', '/');

            if (!path.StartsWith(k_AudioRoot))
            {
                return AudioAssetKind.Unknown;
            }

            string tail = path.Substring(k_AudioRoot.Length);

            if (tail.StartsWith("Music/"))
            {
                return AudioAssetKind.Music;
            }

            if (tail.StartsWith("Ambience/"))
            {
                return AudioAssetKind.Ambience;
            }

            if (tail.StartsWith("SFX/"))
            {
                return AudioAssetKind.Sfx;
            }

            if (tail.StartsWith("Voice/"))
            {
                return AudioAssetKind.Voice;
            }

            return AudioAssetKind.Unknown;
        }

        /// <summary>The settings for a kind. False for <see cref="AudioAssetKind.Unknown"/>.</summary>
        public static bool TryGet(AudioAssetKind kind, out AudioImportProfile profile)
        {
            switch (kind)
            {
                case AudioAssetKind.Music:
                    // Stereo and streamed; Vorbis 0.5 halves the 10 music tracks' 54 MB with no
                    // audible loss under the PSX mix.
                    profile = new AudioImportProfile(false, AudioClipLoadType.Streaming,
                        AudioCompressionFormat.Vorbis, 0.5f);
                    return true;

                case AudioAssetKind.Ambience:
                    // Stereo so a room has width, streamed because a bed runs for the whole level.
                    profile = new AudioImportProfile(false, AudioClipLoadType.Streaming,
                        AudioCompressionFormat.Vorbis, 0.6f);
                    return true;

                case AudioAssetKind.Sfx:
                    // Decompressed on load: a one-shot that has to decode first arrives late.
                    profile = new AudioImportProfile(true, AudioClipLoadType.DecompressOnLoad,
                        AudioCompressionFormat.Vorbis, 0.5f);
                    return true;

                case AudioAssetKind.Voice:
                    // Compressed in memory: lines are long enough that decompressing them all
                    // would be wasteful, and short enough that streaming is not worth a file handle.
                    profile = new AudioImportProfile(true, AudioClipLoadType.CompressedInMemory,
                        AudioCompressionFormat.Vorbis, 0.5f);
                    return true;

                default:
                    profile = default;
                    return false;
            }
        }
    }
}

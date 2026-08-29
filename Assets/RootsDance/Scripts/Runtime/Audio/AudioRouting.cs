namespace RootsDance.Audio
{
    /// <summary>
    /// The names the audio mixer is addressed by, in the one place they are spelled out.
    /// <para>
    /// Guideline 09 fixes the mixer's shape — one asset, groups <c>Master &gt; Music / SFX / UI</c>,
    /// exposed parameters <c>MusicVolume</c> / <c>SfxVolume</c> / <c>UiVolume</c> — but a mixer is
    /// authored in the Editor, not in code, so nothing can stop the two drifting apart except a
    /// check. <see cref="RootsDance.Editor.Audio.AudioMixerValidator"/> reads these constants and
    /// says so when the asset no longer matches.
    /// </para>
    /// Group paths are what <c>AudioMixer.FindMatchingGroups</c> takes; they are not asset paths.
    /// </summary>
    public static class AudioRouting
    {
        /// <summary>Where the single mixer asset lives. Guideline 02's naming table.</summary>
        public const string k_MixerAssetPath = "Assets/RootsDance/Audio/Mixers/Main.mixer";

        public const string k_MasterGroup = "Master";
        public const string k_MusicGroup = "Master/Music";
        public const string k_SfxGroup = "Master/SFX";
        public const string k_UiGroup = "Master/UI";

        public const string k_MusicVolume = "MusicVolume";
        public const string k_SfxVolume = "SfxVolume";
        public const string k_UiVolume = "UiVolume";

        /// <summary>Every group the project expects to exist, in mixer order.</summary>
        public static readonly string[] k_Groups =
        {
            k_MasterGroup,
            k_MusicGroup,
            k_SfxGroup,
            k_UiGroup
        };

        /// <summary>Every exposed parameter the project expects to be able to set.</summary>
        public static readonly string[] k_ExposedParameters =
        {
            k_MusicVolume,
            k_SfxVolume,
            k_UiVolume
        };
    }
}

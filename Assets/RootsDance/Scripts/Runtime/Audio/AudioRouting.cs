namespace RootsDance.Audio
{
    /// <summary>
    /// The names the audio mixer is addressed by, in the one place they are spelled out.
    /// <para>
    /// Guideline 09 fixes the mixer's shape — one asset, groups <c>Master &gt; Music / SFX / UI /
    /// Voice</c>, one exposed volume parameter per group — but a mixer is authored in the Editor,
    /// not in code, so nothing can stop the two drifting apart except a check.
    /// <see cref="RootsDance.Editor.Audio.AudioMixerValidator"/> reads these constants and says so
    /// when the asset no longer matches.
    /// </para>
    /// <para>
    /// <c>Voice</c> is its own group rather than part of SFX because the radio and the
    /// conversations are the only sounds in the game that carry information the player has to
    /// understand. Mixing them under the wind and the footsteps means the only way to make a line
    /// audible is to make everything else quieter; a separate group is also what lets a later
    /// ducking snapshot pull the beds down under a transmission.
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

        /// <summary>Radio transmissions and spoken dialogue — everything the player must hear.</summary>
        public const string k_VoiceGroup = "Master/Voice";

        public const string k_MusicVolume = "MusicVolume";
        public const string k_SfxVolume = "SfxVolume";
        public const string k_UiVolume = "UiVolume";
        public const string k_VoiceVolume = "VoiceVolume";

        /// <summary>Every group the project expects to exist, in mixer order.</summary>
        public static readonly string[] k_Groups =
        {
            k_MasterGroup,
            k_MusicGroup,
            k_SfxGroup,
            k_UiGroup,
            k_VoiceGroup
        };

        /// <summary>Every exposed parameter the project expects to be able to set.</summary>
        public static readonly string[] k_ExposedParameters =
        {
            k_MusicVolume,
            k_SfxVolume,
            k_UiVolume,
            k_VoiceVolume
        };

        /// <summary>
        /// Groups and parameters the game works without. A mixer is authored by hand — Unity has no
        /// API for adding a group or exposing a parameter — so a group added after the mixer was
        /// first built is a job someone has to do in the Audio Mixer window. Until then a cue that
        /// wanted it comes out of SFX and its slider does nothing, which is a mix worth improving,
        /// not a broken build. The validator says so in those words instead of failing.
        /// </summary>
        public static readonly string[] k_OptionalGroups =
        {
            k_VoiceGroup
        };

        public static readonly string[] k_OptionalExposedParameters =
        {
            k_VoiceVolume
        };

        /// <summary>Where a cue goes when the group it asked for has not been added yet.</summary>
        public const string k_FallbackGroup = k_SfxGroup;

        public static bool IsOptionalGroup(string groupPath)
        {
            return Contains(k_OptionalGroups, groupPath);
        }

        public static bool IsOptionalParameter(string parameterName)
        {
            return Contains(k_OptionalExposedParameters, parameterName);
        }

        private static bool Contains(string[] values, string value)
        {
            for (int i = 0; i < values.Length; i++)
            {
                if (values[i] == value)
                {
                    return true;
                }
            }

            return false;
        }
    }
}

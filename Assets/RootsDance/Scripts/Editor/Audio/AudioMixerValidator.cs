using RootsDance.Audio;
using UnityEditor;
using UnityEngine;
using UnityEngine.Audio;

namespace RootsDance.Editor.Audio
{
    /// <summary>
    /// Checks that the mixer asset still matches what the code addresses it by.
    /// <para>
    /// A mixer is the one piece of this pipeline that cannot be generated: Unity exposes no public
    /// API for creating groups or exposing parameters, so the asset is authored by hand, once.
    /// What can be automated is noticing when it drifts — a renamed group or an un-exposed
    /// parameter fails silently at runtime, with the volume slider simply doing nothing, and that
    /// is a bug nobody finds during a jam. This turns it into an error message with a fix in it.
    /// </para>
    /// Menu: RootsDance &gt; Audio &gt; Validate Mixer.
    /// </summary>
    public static class AudioMixerValidator
    {
        [MenuItem("RootsDance/Audio/Validate Mixer")]
        public static void Validate()
        {
            AudioMixer mixer = AssetDatabase.LoadAssetAtPath<AudioMixer>(AudioRouting.k_MixerAssetPath);

            if (mixer == null)
            {
                Debug.LogError(
                    $"[Audio] No mixer at {AudioRouting.k_MixerAssetPath}.\n"
                    + "Create it by hand — Unity has no API for this:\n"
                    + "  1. Right-click Assets/RootsDance/Audio/Mixers > Create > Audio Mixer, name it Main.\n"
                    + "  2. In the Audio Mixer window, add three groups under Master: Music, SFX, UI.\n"
                    + "  3. Select each group, right-click its Volume field in the Inspector > "
                    + "Expose 'Volume (of <group>)' to script.\n"
                    + "  4. In the window's Exposed Parameters dropdown, rename them to "
                    + $"{AudioRouting.k_MusicVolume}, {AudioRouting.k_SfxVolume}, {AudioRouting.k_UiVolume}.\n"
                    + "  5. Run this menu item again.");
                return;
            }

            int problems = 0;

            for (int i = 0; i < AudioRouting.k_Groups.Length; i++)
            {
                string path = AudioRouting.k_Groups[i];

                if (HasGroup(mixer, path))
                {
                    continue;
                }

                if (AudioRouting.IsOptionalGroup(path))
                {
                    Debug.LogWarning($"[Audio] Mixer has no group '{path}' yet, so its cues come "
                        + $"out of '{AudioRouting.k_FallbackGroup}' instead. To add it: open the "
                        + "mixer, right-click Master > Add child group, name it exactly "
                        + $"'{LeafOf(path)}', then re-run RootsDance/Audio/Build Audio Cue Library "
                        + "so the cues pick it up.", mixer);
                    continue;
                }

                Debug.LogError($"[Audio] Mixer has no group '{path}'. Code routes cues to it by "
                    + "this exact path.", mixer);
                problems++;
            }

            for (int i = 0; i < AudioRouting.k_ExposedParameters.Length; i++)
            {
                string parameter = AudioRouting.k_ExposedParameters[i];

                // GetFloat is the only public way to ask whether a name is exposed at all.
                if (mixer.GetFloat(parameter, out float _))
                {
                    continue;
                }

                if (AudioRouting.IsOptionalParameter(parameter))
                {
                    Debug.LogWarning($"[Audio] Mixer does not expose '{parameter}' yet, so that "
                        + "slider does nothing. To expose it: select the group, right-click its "
                        + "Volume in the Inspector > Expose to script, then rename it to "
                        + $"'{parameter}' under Exposed Parameters.", mixer);
                    continue;
                }

                Debug.LogError($"[Audio] Mixer does not expose '{parameter}', so the volume "
                    + "setting for it will do nothing at runtime.", mixer);
                problems++;
            }

            if (problems == 0)
            {
                // Counted from the mixer, not from the expectation: saying "5 groups" while one of
                // them is the group the warning above just said was missing is worse than silence.
                Debug.Log($"[Audio] Mixer at {AudioRouting.k_MixerAssetPath} has everything "
                    + $"AudioRouting requires: {Present(mixer, AudioRouting.k_Groups)} of "
                    + $"{AudioRouting.k_Groups.Length} groups, "
                    + $"{Exposed(mixer, AudioRouting.k_ExposedParameters)} of "
                    + $"{AudioRouting.k_ExposedParameters.Length} exposed parameters.", mixer);
            }
        }

        /// <summary>
        /// True when the mixer has a group whose leaf name is the last segment of
        /// <paramref name="groupPath"/>. FindMatchingGroups matches loosely, so the leaf name is
        /// compared as well — otherwise "Master" would match every group in the asset.
        /// </summary>
        private static int Present(AudioMixer mixer, string[] groups)
        {
            int count = 0;

            for (int i = 0; i < groups.Length; i++)
            {
                count += HasGroup(mixer, groups[i]) ? 1 : 0;
            }

            return count;
        }

        private static int Exposed(AudioMixer mixer, string[] parameters)
        {
            int count = 0;

            for (int i = 0; i < parameters.Length; i++)
            {
                count += mixer.GetFloat(parameters[i], out float _) ? 1 : 0;
            }

            return count;
        }

        /// <summary>The group's own name, which is what the Audio Mixer window asks for.</summary>
        private static string LeafOf(string groupPath)
        {
            int slash = groupPath.LastIndexOf('/');

            return slash < 0 ? groupPath : groupPath.Substring(slash + 1);
        }

        private static bool HasGroup(AudioMixer mixer, string groupPath)
        {
            AudioMixerGroup[] matches = mixer.FindMatchingGroups(groupPath);

            if (matches == null || matches.Length == 0)
            {
                return false;
            }

            int slash = groupPath.LastIndexOf('/');
            string leaf = slash < 0 ? groupPath : groupPath.Substring(slash + 1);

            for (int i = 0; i < matches.Length; i++)
            {
                if (matches[i] != null && matches[i].name == leaf)
                {
                    return true;
                }
            }

            return false;
        }
    }
}

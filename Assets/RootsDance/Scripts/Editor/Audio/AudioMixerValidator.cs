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

                if (!HasGroup(mixer, path))
                {
                    Debug.LogError($"[Audio] Mixer has no group '{path}'. Code routes cues to it by "
                        + "this exact path.", mixer);
                    problems++;
                }
            }

            for (int i = 0; i < AudioRouting.k_ExposedParameters.Length; i++)
            {
                string parameter = AudioRouting.k_ExposedParameters[i];

                // GetFloat is the only public way to ask whether a name is exposed at all.
                if (!mixer.GetFloat(parameter, out float _))
                {
                    Debug.LogError($"[Audio] Mixer does not expose '{parameter}', so the volume "
                        + "setting for it will do nothing at runtime.", mixer);
                    problems++;
                }
            }

            if (problems == 0)
            {
                Debug.Log($"[Audio] Mixer at {AudioRouting.k_MixerAssetPath} matches AudioRouting: "
                    + $"{AudioRouting.k_Groups.Length} groups, "
                    + $"{AudioRouting.k_ExposedParameters.Length} exposed parameters.", mixer);
            }
        }

        /// <summary>
        /// True when the mixer has a group whose leaf name is the last segment of
        /// <paramref name="groupPath"/>. FindMatchingGroups matches loosely, so the leaf name is
        /// compared as well — otherwise "Master" would match every group in the asset.
        /// </summary>
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

using RootsDance.Core;
using UnityEngine;
using UnityEngine.Audio;

namespace RootsDance.Audio
{
    /// <summary>
    /// The player's three volume sliders, saved between sessions and pushed onto the mixer.
    /// <para>
    /// Applied in <c>Start</c>, never in <c>Awake</c> or <c>OnEnable</c>: a mixer restores its own
    /// snapshot values during scene load, so anything written before that is silently overwritten
    /// and the setting appears not to work. Guideline 09 states the rule; this is the one place in
    /// the project that has to obey it.
    /// </para>
    /// Sliders are linear 0..1 and the mixer is in decibels — the conversion is
    /// <see cref="AudioMath"/>, which is where the perceptual mapping lives.
    /// </summary>
    public class AudioVolumeSettings : MonoBehaviour
    {
        private const string k_MusicKey = "audio.music";
        private const string k_SfxKey = "audio.sfx";
        private const string k_UiKey = "audio.ui";

        [Tooltip("The project's single mixer, Assets/RootsDance/Audio/Mixers/Main.mixer.")]
        [SerializeField] private AudioMixer m_mixer;

        [Header("Defaults for a first run")]
        [Range(0f, 1f)][SerializeField] private float m_defaultMusic = 0.8f;
        [Range(0f, 1f)][SerializeField] private float m_defaultSfx = 1f;
        [Range(0f, 1f)][SerializeField] private float m_defaultUi = 1f;

        /// <summary>Current linear music volume, 0..1, for a slider to show.</summary>
        public float Music { get; private set; }

        public float Sfx { get; private set; }

        public float Ui { get; private set; }

        private void Start()
        {
            Music = PlayerPrefs.GetFloat(k_MusicKey, m_defaultMusic);
            Sfx = PlayerPrefs.GetFloat(k_SfxKey, m_defaultSfx);
            Ui = PlayerPrefs.GetFloat(k_UiKey, m_defaultUi);

            Apply(AudioRouting.k_MusicVolume, Music);
            Apply(AudioRouting.k_SfxVolume, Sfx);
            Apply(AudioRouting.k_UiVolume, Ui);
        }

        public void SetMusic(float linear01)
        {
            Music = Mathf.Clamp01(linear01);
            PlayerPrefs.SetFloat(k_MusicKey, Music);
            Apply(AudioRouting.k_MusicVolume, Music);
        }

        public void SetSfx(float linear01)
        {
            Sfx = Mathf.Clamp01(linear01);
            PlayerPrefs.SetFloat(k_SfxKey, Sfx);
            Apply(AudioRouting.k_SfxVolume, Sfx);
        }

        public void SetUi(float linear01)
        {
            Ui = Mathf.Clamp01(linear01);
            PlayerPrefs.SetFloat(k_UiKey, Ui);
            Apply(AudioRouting.k_UiVolume, Ui);
        }

        private void Apply(string exposedParameter, float linear01)
        {
            if (m_mixer == null)
            {
                return;
            }

            if (!m_mixer.SetFloat(exposedParameter, AudioMath.LinearToDecibels(linear01)))
            {
                Log.Warning($"Audio mixer has no exposed parameter '{exposedParameter}'. "
                    + "Run RootsDance/Audio/Validate Mixer.", this);
            }
        }
    }
}

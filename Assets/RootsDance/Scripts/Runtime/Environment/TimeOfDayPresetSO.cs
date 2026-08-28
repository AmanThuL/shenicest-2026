using RootsDance.Core;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Rendering;

namespace RootsDance.Environment
{
    /// <summary>
    /// Everything one discrete time of day looks like: which volume profile fades in, and what the
    /// scene's Sun becomes. One asset per <see cref="TimeOfDay"/> value under
    /// <c>Assets/RootsDance/Data/Config/TimeOfDay/</c>; the controller picks the one whose
    /// <see cref="Phase"/> matches the world state.
    /// </summary>
    [CreateAssetMenu(fileName = "TimeOfDayPreset", menuName = "RootsDance/Config/Time Of Day Preset")]
    public class TimeOfDayPresetSO : ScriptableObject
    {
        [SerializeField, TitleGroup("Phase")]
        [Tooltip("Which world-state value this preset describes. One asset per value.")]
        private TimeOfDay m_phase = TimeOfDay.Day;

        [SerializeField, TitleGroup("Volume")]
        [Tooltip("Profile the time-of-day Volume fades in for this phase. Empty means 'no override': "
            + "the Volume fades to weight 0 and the scene-authored look shows through, which is what "
            + "Day wants.")]
        private VolumeProfile m_profile;

        [SerializeField, TitleGroup("Sun")]
        [Tooltip("Directional light intensity in lux. The Sun's Light Unit is Lux, so this goes "
            + "straight into Light.intensity. Day is around 12 000, night around 8.")]
        private float m_sunIntensityLux = 12000f;

        [SerializeField, TitleGroup("Sun")]
        [Tooltip("Filter colour of the Sun for this phase.")]
        private Color m_sunColor = new Color(1f, 0.96f, 0.88f, 1f);

        [SerializeField, TitleGroup("Sun"), Range(0f, 16f)]
        [Tooltip("HDRP light Volumetrics > Multiplier (HDAdditionalLightData.volumetricDimmer). "
            + "Lowering it at night keeps the moon from lighting the fog like a sun.")]
        private float m_sunVolumetricMultiplier = 1f;

        public TimeOfDay Phase => m_phase;
        public VolumeProfile Profile => m_profile;
        public bool HasProfile => m_profile != null;
        public float SunIntensityLux => m_sunIntensityLux;
        public Color SunColor => m_sunColor;
        public float SunVolumetricMultiplier => m_sunVolumetricMultiplier;

        /// <summary>
        /// Fills the asset from the builder. Editor-side seeding only — nothing at runtime writes a preset.
        /// </summary>
        public void Configure(TimeOfDay phase, VolumeProfile profile, float sunIntensityLux, Color sunColor,
            float sunVolumetricMultiplier)
        {
            m_phase = phase;
            m_profile = profile;
            m_sunIntensityLux = sunIntensityLux;
            m_sunColor = sunColor;
            m_sunVolumetricMultiplier = sunVolumetricMultiplier;
        }
    }
}

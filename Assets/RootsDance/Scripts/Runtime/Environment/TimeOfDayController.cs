using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Events;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Environment
{
    /// <summary>
    /// Turns the world's discrete time of day into a look: one global Volume whose profile and weight
    /// follow the current phase, plus the scene's Sun. Lives on <c>_Lighting/TimeOfDay</c> in the
    /// level's environment scene and owns nothing else — the truth is <see cref="WorldState"/>, this
    /// only listens and paints.
    /// </summary>
    public class TimeOfDayController : MonoBehaviour
    {
        [Header("Level")]
        [Tooltip("Phase this level starts in. Applied instantly in Start, then pushed into the world "
            + "state on the first frame the bootstrap exists.")]
        [SerializeField] private TimeOfDay m_levelDefault = TimeOfDay.PollutedDay;

        [Tooltip("One preset per phase. The first entry matching a phase wins.")]
        [SerializeField] private TimeOfDayPresetSO[] m_presets;

        [Tooltip("Seconds a phase change takes. 0 snaps.")]
        [SerializeField] private float m_blendSeconds = 2f;

        [Header("Listens to")]
        [Tooltip("Channel the bootstrap re-raises WorldState.TimeOfDayChanged on.")]
        [SerializeField] private TimeOfDayEventChannelSO m_timeOfDayChanged;

        [Header("Wiring")]
        [Tooltip("The global Volume on this GameObject (priority 20). Its profile and weight are "
            + "driven from here; do not hand-author them.")]
        [SerializeField] private Volume m_volume;

        [Tooltip("The level's directional Sun. Its Light Unit must be Lux — the builder guarantees it.")]
        [SerializeField] private Light m_sun;

        [Tooltip("Optional second global Volume BELOW the level's local volumes (priority 5): night fog "
            + "density for the open ground, which the opening segments' own density must still beat. Its "
            + "profile is authored in the scene; only its weight is driven, in step with the main Volume.")]
        [SerializeField] private Volume m_baseVolume;

        private HDAdditionalLightData m_sunData;
        private bool m_hasVolume;
        private bool m_hasBaseVolume;
        private bool m_hasSun;
        private bool m_hasSunData;

        private TimeOfDay m_target;
        private bool m_seeded;
        private bool m_isBlending;
        private bool m_missingPresetLogged;
        private float m_elapsed;

        private float m_fromWeight;
        private float m_toWeight;
        private float m_fromLux;
        private float m_toLux;
        private Color m_fromColor;
        private Color m_toColor;
        private float m_fromVolumetric;
        private float m_toVolumetric;

        /// <summary>Phase the look is on, or heading to while a blend runs.</summary>
        public TimeOfDay Target => m_target;

        private void Awake()
        {
            m_hasVolume = m_volume != null;
            m_hasBaseVolume = m_baseVolume != null;
            m_hasSun = m_sun != null;

            if (m_hasSun)
            {
                m_sunData = m_sun.GetComponent<HDAdditionalLightData>();
            }

            m_hasSunData = m_sunData != null;

            if (!m_hasVolume)
            {
                Log.Error("TimeOfDayController has no Volume; the night profile will never show.", this);
            }

            if (!m_hasSun)
            {
                Log.Error("TimeOfDayController has no Sun light; sun intensity and colour stay as authored.", this);
            }
            else if (!m_hasSunData)
            {
                Log.Error("The Sun light has no HDAdditionalLightData; its volumetric multiplier stays as authored.",
                    this);
            }

            if (m_presets == null || m_presets.Length == 0)
            {
                Log.Error("TimeOfDayController has no presets; nothing can be applied.", this);
            }

            if (m_timeOfDayChanged == null)
            {
                Log.Error("TimeOfDayController has no time-of-day channel; it will never react to a phase change.",
                    this);
            }
        }

        private void OnEnable()
        {
            if (m_timeOfDayChanged != null)
            {
                m_timeOfDayChanged.EventRaised += OnTimeOfDayChanged;
            }
        }

        // Frame 0 must already look right: a level that plays at night may never fade in from day.
        // Rescue snapshots already exist before this scene activates. A level-only Editor start
        // still has no bootstrap yet and uses the authored default.
        private void Start()
        {
            IWorldStateReader state = WorldAccess.State;
            ApplyImmediate(state != null && state.IsTimeOfDaySet ? state.TimeOfDay : m_levelDefault);
        }

        private void Update()
        {
            // Seed, not Set: a Dev Play checkpoint or a trigger that already chose a phase must win,
            // whichever of the two commands drains first.
            if (!m_seeded && WorldAccess.State != null)
            {
                WorldAccess.Enqueue(new SeedTimeOfDayCommand(m_levelDefault), this);
                m_seeded = true;
            }

            if (!m_isBlending)
            {
                return;
            }

            m_elapsed += Time.deltaTime;
            float t = TimeOfDayBlend.Weight01(m_elapsed, m_blendSeconds);
            ApplyBlend(t);

            if (t >= 1f)
            {
                m_isBlending = false;
            }
        }

        private void OnDisable()
        {
            if (m_timeOfDayChanged != null)
            {
                m_timeOfDayChanged.EventRaised -= OnTimeOfDayChanged;
            }
        }

        private void OnTimeOfDayChanged(TimeOfDay phase)
        {
            if (phase == m_target)
            {
                return;
            }

            BeginBlend(phase);
        }

        /// <summary>Snaps the whole look to a phase with no blend.</summary>
        private void ApplyImmediate(TimeOfDay phase)
        {
            TimeOfDayPresetSO preset = TimeOfDayBlend.Find(m_presets, phase);

            if (preset == null)
            {
                WarnMissingPreset(phase);
                return;
            }

            m_target = phase;
            m_isBlending = false;
            m_elapsed = 0f;

            m_fromWeight = m_toWeight = preset.HasProfile ? 1f : 0f;
            m_fromLux = m_toLux = preset.SunIntensityLux;
            m_fromColor = m_toColor = preset.SunColor;
            m_fromVolumetric = m_toVolumetric = preset.SunVolumetricMultiplier;

            if (m_hasVolume && preset.HasProfile)
            {
                m_volume.sharedProfile = preset.Profile;
            }

            ApplyBlend(1f);
        }

        /// <summary>
        /// Starts a fade to a phase from wherever the look currently is, so an interrupted blend does
        /// not pop. A phase with no profile (Day) simply fades the single Volume out to weight 0;
        /// between two profiled phases the profile swaps at the start of the blend. PollutedDay and Day
        /// both use the scene-authored volumes; adding another profiled phase needs a second Volume.
        /// </summary>
        private void BeginBlend(TimeOfDay phase)
        {
            TimeOfDayPresetSO preset = TimeOfDayBlend.Find(m_presets, phase);

            if (preset == null)
            {
                WarnMissingPreset(phase);
                return;
            }

            m_target = phase;

            m_fromWeight = m_hasVolume ? m_volume.weight : 0f;
            m_fromLux = m_hasSun ? m_sun.intensity : 0f;
            m_fromColor = m_hasSun ? m_sun.color : Color.white;
            m_fromVolumetric = m_hasSunData ? m_sunData.volumetricDimmer : 1f;

            m_toWeight = preset.HasProfile ? 1f : 0f;
            m_toLux = preset.SunIntensityLux;
            m_toColor = preset.SunColor;
            m_toVolumetric = preset.SunVolumetricMultiplier;

            if (m_hasVolume && preset.HasProfile)
            {
                m_volume.sharedProfile = preset.Profile;
            }

            m_elapsed = 0f;
            m_isBlending = m_blendSeconds > 0f;

            if (!m_isBlending)
            {
                ApplyBlend(1f);
            }
        }

        /// <summary>
        /// Writes the blend at progress <paramref name="t"/>. Runs every frame while blending and does
        /// no lookups and no allocations: every value it reads was cached in Awake or BeginBlend.
        /// </summary>
        private void ApplyBlend(float t)
        {
            float weight = Mathf.Lerp(m_fromWeight, m_toWeight, t);

            if (m_hasVolume)
            {
                m_volume.weight = weight;
            }

            if (m_hasBaseVolume)
            {
                m_baseVolume.weight = weight;
            }

            if (m_hasSun)
            {
                // Light Unit is Lux on the Sun, so intensity is the lux value straight from the preset.
                m_sun.intensity = TimeOfDayBlend.LerpLux(m_fromLux, m_toLux, t);
                m_sun.color = Color.Lerp(m_fromColor, m_toColor, t);
            }

            if (m_hasSunData)
            {
                m_sunData.volumetricDimmer = Mathf.Lerp(m_fromVolumetric, m_toVolumetric, t);
            }
        }

        private void WarnMissingPreset(TimeOfDay phase)
        {
            if (m_missingPresetLogged)
            {
                return;
            }

            m_missingPresetLogged = true;
            Log.Warning("No time-of-day preset for " + phase + "; keeping the current look.", this);
        }
    }
}

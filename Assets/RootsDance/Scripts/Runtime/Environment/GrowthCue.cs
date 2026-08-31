using RootsDance.App;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// Starts a <see cref="GrowthDriver"/> when the story reaches the beat it belongs to.
    /// <para>
    /// The statue blooms on <see cref="WorldFlags.k_CirculationOuter"/> — the player choosing Outer
    /// Boundary at the circulation console, which is the ecology's actual state and the one answer
    /// of the three that does not wake the boss. The other two start the chase; this one starts the
    /// ending. <c>MusicWiring</c> already scores the same flag with <c>MUS_EndingBloom</c>, and the
    /// driver's 45 s is that track's length: the statue finishes when the music does.
    /// </para>
    /// <para>
    /// A component rather than a <see cref="RootsDance.Sequencing.CueStepKind"/> for the same
    /// reason the driver is one — a cue step can raise a flag and switch an object on, and this is
    /// neither. It listens on the bootstrap's FlagRaised channel exactly the way
    /// <see cref="RootsDance.Audio.FlagMusicCues"/> does, so gameplay still knows nothing about the
    /// statue: the console raises a flag for its own reasons and what that means is wiring.
    /// </para>
    /// <para>
    /// Catching up matters as much as starting. The statue's scene is additive and the flag can
    /// already be raised by the time it loads — a checkpoint dropped past the console, or a level
    /// switch during the ending. Growing again from bare stone would replay a beat the player has
    /// already watched, so an already-raised flag jumps straight to fully grown.
    /// </para>
    /// </summary>
    [RequireComponent(typeof(GrowthDriver))]
    public class GrowthCue : MonoBehaviour, IRescueStateRestoredParticipant
    {
        [Tooltip("The bootstrap's FlagRaised channel. Data/Events/FlagRaised.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Tooltip("The flag that starts the growth, exactly as RootsDance.Core.WorldFlags spells it.")]
        [SerializeField] private string m_flagId = WorldFlags.k_CirculationOuter;

        private GrowthDriver m_driver;
        private bool m_caughtUp;

        private void Awake()
        {
            m_driver = GetComponent<GrowthDriver>();
        }

        private void OnEnable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised += OnFlagRaised;
            }
        }

        private void OnDisable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised -= OnFlagRaised;
            }
        }

        /// <summary>
        /// The catch-up check lives in Update because the bootstrap may not have answered yet in
        /// OnEnable — the same reason <see cref="RootsDance.Chase.ChaseDirector"/> checks there. It
        /// runs exactly once, on the first frame there is a world state to ask.
        /// </summary>
        private void Update()
        {
            if (m_caughtUp)
            {
                return;
            }

            IWorldStateReader state = WorldAccess.State;

            if (state == null)
            {
                return;
            }

            m_caughtUp = true;

            if (state.HasFlag(m_flagId))
            {
                m_driver.SetGrowth(1f);
            }
        }

        private void OnFlagRaised(string flagId)
        {
            if (flagId != m_flagId)
            {
                return;
            }

            // The catch-up check has nothing left to do: this is the beat, live.
            m_caughtUp = true;
            m_driver.Play();
        }

        /// <summary>
        /// A checkpoint seed or a rescue lands its flags silently, so the bloom flag never arrives
        /// as an event. Unlike a scene loading mid-ending — where the growth already happened and
        /// jumping to grown is right — a seed that carries the flag is asking for the beat: the
        /// spawn exists to show the ecology coming back, so it grows from bare stone.
        /// </summary>
        public void RestoreAfterRescue(RescueCheckpoint checkpoint)
        {
            if (checkpoint == null)
            {
                return;
            }

            for (int i = 0; i < checkpoint.Flags.Count; i++)
            {
                if (checkpoint.Flags[i] == m_flagId)
                {
                    m_caughtUp = true;
                    m_driver.SetGrowth(0f);
                    m_driver.Play();
                    return;
                }
            }
        }
    }
}

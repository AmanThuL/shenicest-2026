using RootsDance.App;
using RootsDance.Core;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.World
{
    /// <summary>
    /// An invisible wall that one world flag opens, for good. It is the physical half of a beat the
    /// story will not let the player walk past yet — the seal that has to come off before the grass
    /// belt — and it exists so the refusal is a wall the player can feel rather than a line of text
    /// they can ignore.
    /// <para>
    /// The gate is deliberately dumb: it never raises anything, never re-closes, and says nothing.
    /// Whatever raised the flag owns the hint on the visor; this only stops the legs. Re-closing
    /// would strand a player who walked back through it after the beat was over.
    /// </para>
    /// <para>
    /// The opening flag is read from world state as well as listened for, so a dev checkpoint that
    /// seeds the flag starts with the way already open instead of a wall in the middle of the field.
    /// </para>
    /// </summary>
    public class FlagGate : MonoBehaviour, IRescueStateRestoredParticipant
    {
        [Header("Listens to")]
        [Tooltip("The bootstrap's FlagRaised channel. Data/Events/FlagRaised.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Tooltip("Flag that opens the gate. Until it is raised, the blockers below stand in the way.")]
        [SerializeField] private string m_openFlag = WorldFlags.k_HelmetRemoved;

        [Header("What blocks")]
        [Tooltip("Colliders switched off when the gate opens. Empty = every collider on this "
            + "object and its children, found in Awake.")]
        [SerializeField] private Collider[] m_blockers;

        private bool m_isOpen;
        private bool m_isSeeded;

        /// <summary>
        /// A checkpoint seeds flags silently, after the one-shot Update check has already read an
        /// unseeded world. Clearing the latch makes the very next Update read the seeded truth —
        /// otherwise the gate stands shut in a field the player was dropped past.
        /// </summary>
        public void RestoreAfterRescue(RootsDance.Data.RescueCheckpoint checkpoint)
        {
            m_isSeeded = false;
        }

        /// <summary>True once the flag has been seen and the way is clear.</summary>
        public bool IsOpen => m_isOpen;

        private void Awake()
        {
            if (m_blockers == null || m_blockers.Length == 0)
            {
                m_blockers = GetComponentsInChildren<Collider>(includeInactive: true);
            }

            if (m_blockers.Length == 0)
            {
                Log.Warning("FlagGate has no collider to block with; it will never stop anyone.", this);
            }
        }

        private void OnEnable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised += OnFlagRaised;
            }
        }

        private void Update()
        {
            if (m_isSeeded)
            {
                return;
            }

            // Not in Start: a level-only Play session has no bootstrap yet on the first frames, and
            // a checkpoint's seeded flags must count — otherwise the gate stands in a field the
            // player was dropped past.
            IWorldStateReader state = WorldAccess.State;

            if (state == null)
            {
                return;
            }

            m_isSeeded = true;

            if (!string.IsNullOrEmpty(m_openFlag) && state.HasFlag(m_openFlag))
            {
                Open();
            }
        }

        private void OnDisable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised -= OnFlagRaised;
            }
        }

        private void OnFlagRaised(string flagId)
        {
            if (m_isOpen || string.IsNullOrEmpty(m_openFlag) || flagId != m_openFlag)
            {
                return;
            }

            Open();
        }

        private void Open()
        {
            m_isOpen = true;

            for (int i = 0; i < m_blockers.Length; i++)
            {
                if (m_blockers[i] != null)
                {
                    m_blockers[i].enabled = false;
                }
            }
        }
    }
}

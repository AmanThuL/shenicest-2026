using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Audio
{
    /// <summary>
    /// The player's own footsteps. Watches the controller's speed and grounding and raises a cue
    /// every stride.
    /// <para>
    /// It reads the controller rather than being called by it, which is the presentation contract's
    /// D20 the same way the rest of this folder is: movement code stays a movement problem and
    /// never learns that audio exists. An animation event would be the other option, but the first
    /// person controller drives a capsule, not a walk cycle — there is no foot to plant.
    /// </para>
    /// <para>
    /// The cue is one field, not a table of surfaces. Chapter 00 walks on contaminated dirt, grass
    /// and then a metal service duct, and telling those apart needs a ground query per step that
    /// nothing else in the game currently needs; the contract already lists surface-aware footsteps
    /// as P1. Until then, a scene that changes underfoot can hold a second emitter.
    /// </para>
    /// </summary>
    public class FootstepAudio : MonoBehaviour
    {
        [Header("Reads")]
        [Tooltip("Empty finds the controller on this object or a parent in Awake.")]
        [SerializeField] private FirstPersonController m_controller;

        [Header("Broadcasts on")]
        [Tooltip("Data/Events/AudioCueRequested.")]
        [SerializeField] private AudioCueEventChannelSO m_channel;

        [Header("What")]
        [SerializeField] private AudioCueSO m_cue;

        [Header("Cadence")]
        [Tooltip("Metres between steps. Roughly the player's stride: shorter sounds like running "
            + "on the spot, longer sounds like the sound is late.")]
        [Min(0.1f)]
        [SerializeField] private float m_strideLength = 0.8f;

        [Tooltip("Below this speed nothing sounds, so leaning against a wall is silent.")]
        [Min(0f)]
        [SerializeField] private float m_minimumSpeed = 0.4f;

        private float m_distanceSinceStep;

        private void Awake()
        {
            if (m_controller == null)
            {
                m_controller = GetComponentInParent<FirstPersonController>();
            }
        }

        private void Update()
        {
            if (m_controller == null || m_cue == null || m_channel == null)
            {
                return;
            }

            if (!m_controller.IsGrounded || m_controller.HorizontalSpeed < m_minimumSpeed)
            {
                // Mid-air or standing still: the next step falls a full stride after landing or
                // setting off, not immediately because of distance banked beforehand.
                m_distanceSinceStep = 0f;
                return;
            }

            int steps = FootstepCadence.Advance(ref m_distanceSinceStep,
                m_controller.HorizontalSpeed * Time.deltaTime, m_strideLength);

            for (int i = 0; i < steps; i++)
            {
                m_channel.RaiseEvent(new AudioCueRequest(m_cue, transform.position));
            }
        }
    }
}

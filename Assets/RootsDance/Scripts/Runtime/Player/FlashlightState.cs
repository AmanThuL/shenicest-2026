using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Player
{
    /// <summary>
    /// Whether the beam should be lit, and nothing else — no Light, no input, no Unity objects — so
    /// "night switches it on, the button flips it" is unit-testable on its own.
    /// <see cref="FlashlightController"/> owns everything visible and drives this from the input
    /// reader and the time-of-day channel.
    /// </summary>
    public sealed class FlashlightState
    {
        public FlashlightState(bool autoOnAtNight)
        {
            AutoOnAtNight = autoOnAtNight;
        }

        /// <summary>True while the beam should be lit.</summary>
        public bool IsOn { get; private set; }

        /// <summary>
        /// When false the phase is ignored entirely and only <see cref="Toggle"/> changes the beam —
        /// for a scripted moment that wants the torch off at night, or on in daylight.
        /// </summary>
        public bool AutoOnAtNight { get; }

        /// <summary>
        /// The world moved to <paramref name="phase"/>: night lights the beam, day puts it out.
        /// A no-op when <see cref="AutoOnAtNight"/> is false.
        /// </summary>
        public void OnPhase(TimeOfDay phase)
        {
            if (!AutoOnAtNight)
            {
                return;
            }

            IsOn = phase == TimeOfDay.Night;
        }

        /// <summary>Flips the beam — what the flashlight button does, at any time of day.</summary>
        public void Toggle()
        {
            IsOn = !IsOn;
        }

        /// <summary>
        /// Moves <paramref name="current"/> toward <paramref name="target"/> by at most
        /// <paramref name="maxDelta"/>: one frame of the controller's intensity fade. Static and
        /// side-effect free so the fade can be tested without a Light.
        /// </summary>
        public static float StepIntensity(float current, float target, float maxDelta)
        {
            return Mathf.MoveTowards(current, target, maxDelta);
        }
    }
}

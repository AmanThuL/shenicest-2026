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

        /// <summary>True while the switch is on. Not the same as the beam being lit.</summary>
        public bool IsOn { get; private set; }

        /// <summary>
        /// True while the torch is actually in a hand. A switch left on in a pocket is still a
        /// switch left on, so this is tracked apart from <see cref="IsOn"/> rather than folded
        /// into it - put the torch back in the hand and it is lit again at the setting it had.
        /// </summary>
        public bool IsHeld { get; private set; } = true;

        /// <summary>
        /// True only when the switch is on *and* the torch is in a hand. This is what drives the
        /// Light and the reveal: nothing in the world may react to a beam nobody is carrying.
        /// </summary>
        public bool IsLit => IsOn && IsHeld;

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

        /// <summary>Flips the switch — what the flashlight button does, at any time of day.</summary>
        public void Toggle()
        {
            IsOn = !IsOn;
        }

        /// <summary>Records whether a hand is holding the torch.</summary>
        public void SetHeld(bool held)
        {
            IsHeld = held;
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

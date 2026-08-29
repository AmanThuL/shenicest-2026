using System;

namespace RootsDance.Player.Arms
{
    /// <summary>
    /// The one way to make the first-person arms do something. Gameplay names an action id and
    /// waits; it never touches the Animator, never freezes it, and never needs to know which layer
    /// or clip is involved.
    /// <para>
    /// The existing presentation contracts (<see cref="RootsDance.Player.IHelmetView"/>,
    /// <c>IScannerView</c>, <see cref="RootsDance.Interaction.IToolView"/> — 表现层驱动契约 D17)
    /// keep their signatures and are implemented as thin adapters over this.
    /// </para>
    /// </summary>
    public interface IArmsDirector
    {
        /// <summary>Pose the left arm is currently resting in.</summary>
        ArmsPose LeftPose { get; }

        /// <summary>Pose the right arm is currently resting in.</summary>
        ArmsPose RightPose { get; }

        /// <summary>True while a non-looping action owns that arm.</summary>
        bool IsBusy(ArmsScope scope);

        /// <summary>
        /// Requests an action. Returns false without playing anything when the id is unknown or
        /// the arm is already busy; both log why. A false return is a refusal, not an error.
        /// The pose the arms are in never refuses anything.
        /// </summary>
        bool TryPlay(string actionId);

        /// <summary>Raised with the action id when a non-looping action has played through.</summary>
        event Action<string> ActionFinished;

        /// <summary>Raised at each authored attach/detach moment inside a clip.</summary>
        event Action<HandSide, HandEventKind> HandEventRaised;
    }
}

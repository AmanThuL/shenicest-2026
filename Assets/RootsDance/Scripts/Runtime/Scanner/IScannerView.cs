using System;

namespace RootsDance.Scanner
{
    /// <summary>
    /// Presentation contract for the hand scanner. Gameplay asks for a performance and waits; the
    /// two finished events are the only callbacks from art back to code, exactly like
    /// <see cref="RootsDance.Player.IHelmetView"/>.
    /// <para>
    /// The two calls are the two clips of the arms contract: <c>scanner_raise</c> ends held on the
    /// <c>aim_L</c> pose and <c>scanner_lower</c> starts from it, so raise must always be followed
    /// by lower — nothing else may take the left arm while the scanner is up.
    /// </para>
    /// </summary>
    public interface IScannerView
    {
        /// <summary>hang_low to aim_L. The pose is held after the clip ends.</summary>
        void PlayRaise();

        /// <summary>aim_L back to hang_low.</summary>
        void PlayLower();

        event Action RaiseFinished;

        event Action LowerFinished;
    }
}

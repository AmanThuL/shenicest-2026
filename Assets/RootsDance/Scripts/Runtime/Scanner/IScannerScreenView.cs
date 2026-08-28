using System;

namespace RootsDance.Scanner
{
    /// <summary>
    /// What the inspect flow needs from whatever draws the scanner's screen. Keeps the flow free of
    /// any UI type: gameplay powers the screen on, powers it off, and listens for the one thing the
    /// screen can ask for — to be closed.
    /// </summary>
    public interface IScannerScreenView
    {
        /// <summary>Powers the screen up and lets it take input.</summary>
        void Open();

        /// <summary>Powers it down. Called again on an already-closed screen is a no-op.</summary>
        void Close();

        /// <summary>Raised when the player uses the screen's own close control.</summary>
        event Action CloseRequested;
    }
}

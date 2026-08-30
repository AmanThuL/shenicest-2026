using System;

namespace RootsDance.Player
{
    /// <summary>
    /// Presentation contract for taking the helmet off (node 00-05). Implemented on the art side;
    /// gameplay only asks for the performance and waits for <see cref="RemoveFinished"/>.
    /// A placeholder implementation that fades the HUD and raises the event next frame is enough
    /// to run the whole slice without any animation asset.
    /// </summary>
    public interface IHelmetView
    {
        void PlayRemove();

        /// <summary>Restores an already-removed checkpoint state without replaying the performance.</summary>
        void SetRemovedImmediately();

        /// <summary>Raised when the removal performance begins, with its duration in seconds, so
        /// synchronised presentation (the visor HUD lifting away) can ride the same clock.</summary>
        event Action<float> RemoveStarted;

        event Action RemoveFinished;
    }
}

using System;

namespace RootsDance.Interaction
{
    /// <summary>
    /// Presentation contract for using a hand tool (sampler, identifier). Gameplay asks for the
    /// performance and waits; <see cref="UseFinished"/> is the only callback from art back to code.
    /// </summary>
    public interface IToolView
    {
        void PlayUse();

        event Action UseFinished;
    }
}

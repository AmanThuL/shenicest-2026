using System;

namespace RootsDance.Core
{
    /// <summary>The screen lifecycle used by a physical terminal's reading controller.</summary>
    public interface ITerminalScreenView
    {
        event Action Closed;

        void Open();

        void Close();
    }
}

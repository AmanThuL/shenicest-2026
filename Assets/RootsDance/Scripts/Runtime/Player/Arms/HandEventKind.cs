namespace RootsDance.Player.Arms
{
    /// <summary>What a hand event does to whatever the hand is carrying.</summary>
    public enum HandEventKind
    {
        /// <summary>The pending item becomes carried: physics off, parented to the socket.</summary>
        Attach = 0,

        /// <summary>The carried item is let go: unparented, physics back on, socket velocity handed over.</summary>
        Detach = 1,
    }
}

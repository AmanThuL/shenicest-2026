namespace RootsDance.Player.Arms
{
    /// <summary>
    /// What a carried prop is, for the systems that care which one is in the hand.
    /// <para>
    /// A kind rather than a reference to one specific item: there are five torches lying around the
    /// route and any of them lights the beam, so asking "is the hand holding a torch" is the
    /// question, not "is the hand holding that torch".
    /// </para>
    /// </summary>
    public enum CarriedKind
    {
        Prop = 0,
        Torch = 1,
        Scanner = 2,
        Helmet = 3,
    }
}

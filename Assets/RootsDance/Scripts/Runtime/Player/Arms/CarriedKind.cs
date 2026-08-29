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

        /// <summary>
        /// The glowing blue flask from the Briggs laboratory. Its own kind rather than a plain
        /// <see cref="Prop"/> because the rune wall has to be able to refuse everything else: a
        /// throw that opens the exit door must not be satisfied by lobbing the torch at it.
        /// </summary>
        Flask = 4,
    }
}

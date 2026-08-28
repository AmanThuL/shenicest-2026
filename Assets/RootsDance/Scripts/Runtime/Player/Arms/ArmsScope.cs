namespace RootsDance.Player.Arms
{
    /// <summary>
    /// Which arm an action owns, which is the same thing as which Animator layer it plays on.
    /// Single-arm clips carry no camera and no root curves (arms contract), so they can be masked
    /// onto one arm while the other arm keeps doing whatever it was doing.
    /// </summary>
    public enum ArmsScope
    {
        /// <summary>Base layer. Both arms plus the camera and root bones.</summary>
        Both = 0,

        /// <summary>Left-arm masked layer.</summary>
        Left = 1,

        /// <summary>Right-arm masked layer.</summary>
        Right = 2,
    }
}

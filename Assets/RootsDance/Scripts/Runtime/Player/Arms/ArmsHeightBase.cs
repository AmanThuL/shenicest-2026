namespace RootsDance.Player.Arms
{
    /// <summary>
    /// Which body height an action is authored against. The clips themselves carry no overall
    /// height displacement (arms contract — "高度基准"); the difference between lying on the ground
    /// and standing is applied by <see cref="ArmsHeightRig"/> on the rig anchor instead, so one clip
    /// can serve both without being re-authored.
    /// </summary>
    public enum ArmsHeightBase
    {
        /// <summary>Standing baseline. A crouch inside the clip is the clip's own business.</summary>
        Standing = 0,

        /// <summary>Prone baseline = standing − (player height − offset).</summary>
        Ground = 1,

        /// <summary>Interpolates from the ground baseline to the standing one over the action.</summary>
        GroundToStanding = 2,
    }
}

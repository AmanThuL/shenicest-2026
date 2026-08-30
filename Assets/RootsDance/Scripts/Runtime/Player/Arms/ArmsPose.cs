namespace RootsDance.Player.Arms
{
    /// <summary>
    /// The poses the arms rig is allowed to rest in, from the arms contract
    /// (docs/architecture/contracts/手臂动画状态机.md — "状态(pose)定义"). Every action declares which
    /// pose it starts from and which it leaves behind, and <see cref="ArmsDirector"/> refuses a
    /// request whose start pose does not match what the arms are actually in.
    /// </summary>
    public enum ArmsPose
    {
        /// <summary>Neutral. Arms hanging at the sides, forearms down. Hands at (±0.22, 0, 1.05).</summary>
        HangLow = 0,

        /// <summary>Forearm raised in front, the pose an object is carried in. (±0.31, −0.25, 1.52).</summary>
        ForearmRaised = 1,

        /// <summary>Left forearm level, scanner aimed forward. (0.20, −0.32, 1.30).</summary>
        AimL = 2,

        /// <summary>Prone crawling hand placement.</summary>
        CrawlPose = 3,
    }
}

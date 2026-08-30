namespace RootsDance.Player.Arms
{
    /// <summary>
    /// Where the arms end up after an action, as plain static logic.
    /// <para>
    /// Pulled out of <see cref="ArmsDirector"/> so the part of the contract it still encodes
    /// (docs/architecture/contracts/手臂动画状态机.md) is covered by EditMode tests rather than only
    /// by playing the game. Poses are bookkeeping now: nothing refuses an action because of them.
    /// </para>
    /// </summary>
    public static class ArmsPoseGate
    {
        /// <summary>
        /// Applies an action's result pose to the arms it owns. A two-armed action moves both; a
        /// single-arm action leaves the other side exactly where it was, which is what lets the
        /// right hand keep holding something while the left arm raises the scanner.
        /// </summary>
        public static void ApplyResult(ArmsScope scope, ArmsPose result,
            ref ArmsPose left, ref ArmsPose right)
        {
            if (scope != ArmsScope.Right)
            {
                left = result;
            }

            if (scope != ArmsScope.Left)
            {
                right = result;
            }
        }
    }
}

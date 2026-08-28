namespace RootsDance.Player.Arms
{
    /// <summary>
    /// The rule that keeps the arms state machine honest: an action may only start from the pose
    /// its first frame was authored against.
    /// <para>
    /// Pulled out of <see cref="ArmsDirector"/> as plain static logic so the contract it encodes
    /// (docs/architecture/contracts/手臂动画状态机.md — "衔接规则") is covered by EditMode tests rather
    /// than only by playing the game and watching for a broken seam.
    /// </para>
    /// </summary>
    public static class ArmsPoseGate
    {
        /// <summary>
        /// Whether an action may start. A two-armed action needs both arms in the required pose; a
        /// single-arm action only cares about its own side.
        /// </summary>
        /// <param name="scope">Which arm the action owns.</param>
        /// <param name="required">The pose the action's first frame assumes.</param>
        /// <param name="enforced">False for actions with no authored entry pose yet.</param>
        /// <param name="left">Pose the left arm is currently in.</param>
        /// <param name="right">Pose the right arm is currently in.</param>
        public static bool Allows(ArmsScope scope, ArmsPose required, bool enforced,
            ArmsPose left, ArmsPose right)
        {
            if (!enforced)
            {
                return true;
            }

            switch (scope)
            {
                case ArmsScope.Left:
                    return left == required;
                case ArmsScope.Right:
                    return right == required;
                default:
                    return left == required && right == required;
            }
        }

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

using NUnit.Framework;
using RootsDance.Player.Arms;

namespace RootsDance.Tests.EditMode.Player
{
    /// <summary>
    /// How an action leaves the arms: a two-armed action moves both, a single-arm action leaves the
    /// other one alone. Nothing here refuses an action — poses are bookkeeping, not a gate.
    /// </summary>
    public class ArmsPoseGateTests
    {
        [Test]
        public void ApplyResult_RightArmAction_LeavesLeftArmUntouched()
        {
            ArmsPose left = ArmsPose.AimL;
            ArmsPose right = ArmsPose.ForearmRaised;

            ArmsPoseGate.ApplyResult(ArmsScope.Right, ArmsPose.HangLow, ref left, ref right);

            Assert.AreEqual(ArmsPose.AimL, left);
            Assert.AreEqual(ArmsPose.HangLow, right);
        }

        [Test]
        public void ApplyResult_TwoArmedAction_MovesBothArms()
        {
            ArmsPose left = ArmsPose.CrawlPose;
            ArmsPose right = ArmsPose.CrawlPose;

            ArmsPoseGate.ApplyResult(ArmsScope.Both, ArmsPose.HangLow, ref left, ref right);

            Assert.AreEqual(ArmsPose.HangLow, left);
            Assert.AreEqual(ArmsPose.HangLow, right);
        }

        [Test]
        public void GrabThenDrop_LeavesTheArmsWhereTheContractSaysTheyEnd()
        {
            ArmsPose left = ArmsPose.HangLow;
            ArmsPose right = ArmsPose.HangLow;

            // grab_ground: two-armed, ends holding.
            ArmsPoseGate.ApplyResult(ArmsScope.Both, ArmsPose.ForearmRaised, ref left, ref right);

            // hold is chained onto the right arm and keeps it there.
            ArmsPoseGate.ApplyResult(ArmsScope.Right, ArmsPose.ForearmRaised, ref left, ref right);

            // drop: right arm only, back to neutral, left arm never involved.
            ArmsPoseGate.ApplyResult(ArmsScope.Right, ArmsPose.HangLow, ref left, ref right);

            Assert.AreEqual(ArmsPose.HangLow, right);
            Assert.AreEqual(ArmsPose.ForearmRaised, left,
                "grab_ground raises both arms; only the right one is put down by drop.");
        }
    }
}

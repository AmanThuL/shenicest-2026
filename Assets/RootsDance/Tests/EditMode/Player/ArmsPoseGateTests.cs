using NUnit.Framework;
using RootsDance.Player.Arms;

namespace RootsDance.Tests.EditMode.Player
{
    /// <summary>
    /// The arms contract's connection rules, as tests: which action may follow which pose, and how
    /// a single-arm action leaves the other arm alone. These are the seams that used to break
    /// silently when every clip drove the Animator directly.
    /// </summary>
    public class ArmsPoseGateTests
    {
        [Test]
        public void Allows_ScannerRaiseFromNeutral_ReturnsTrue()
        {
            bool allowed = ArmsPoseGate.Allows(
                ArmsScope.Left, ArmsPose.HangLow, true, ArmsPose.HangLow, ArmsPose.HangLow);

            Assert.IsTrue(allowed);
        }

        [Test]
        public void Allows_ScannerLowerBeforeRaise_ReturnsFalse()
        {
            // scanner_lower starts on the aim pose; asking for it from neutral would jump a seam.
            bool allowed = ArmsPoseGate.Allows(
                ArmsScope.Left, ArmsPose.AimL, true, ArmsPose.HangLow, ArmsPose.HangLow);

            Assert.IsFalse(allowed);
        }

        [Test]
        public void Allows_DropWithNothingHeld_ReturnsFalse()
        {
            bool allowed = ArmsPoseGate.Allows(
                ArmsScope.Right, ArmsPose.ForearmRaised, true, ArmsPose.HangLow, ArmsPose.HangLow);

            Assert.IsFalse(allowed);
        }

        [Test]
        public void Allows_DropWhileHolding_ReturnsTrue()
        {
            bool allowed = ArmsPoseGate.Allows(
                ArmsScope.Right, ArmsPose.ForearmRaised, true,
                ArmsPose.HangLow, ArmsPose.ForearmRaised);

            Assert.IsTrue(allowed);
        }

        [Test]
        public void Allows_LeftActionIgnoresRightArmPose_ReturnsTrue()
        {
            // The scanner can be raised while the right hand is holding something: separate layers,
            // separate poses.
            bool allowed = ArmsPoseGate.Allows(
                ArmsScope.Left, ArmsPose.HangLow, true,
                ArmsPose.HangLow, ArmsPose.ForearmRaised);

            Assert.IsTrue(allowed);
        }

        [Test]
        public void Allows_TwoArmedActionWithOneArmBusy_ReturnsFalse()
        {
            bool allowed = ArmsPoseGate.Allows(
                ArmsScope.Both, ArmsPose.HangLow, true,
                ArmsPose.HangLow, ArmsPose.ForearmRaised);

            Assert.IsFalse(allowed);
        }

        [Test]
        public void Allows_GateDisabled_ReturnsTrueFromAnyPose()
        {
            bool allowed = ArmsPoseGate.Allows(
                ArmsScope.Both, ArmsPose.CrawlPose, false, ArmsPose.HangLow, ArmsPose.AimL);

            Assert.IsTrue(allowed);
        }

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
        public void GrabThenDrop_FollowsTheContractRoundTrip()
        {
            ArmsPose left = ArmsPose.HangLow;
            ArmsPose right = ArmsPose.HangLow;

            // grab_ground: two-armed, ends holding.
            Assert.IsTrue(ArmsPoseGate.Allows(ArmsScope.Both, ArmsPose.HangLow, true, left, right));
            ArmsPoseGate.ApplyResult(ArmsScope.Both, ArmsPose.ForearmRaised, ref left, ref right);

            // hold is chained onto the right arm and keeps it there.
            ArmsPoseGate.ApplyResult(ArmsScope.Right, ArmsPose.ForearmRaised, ref left, ref right);

            // drop: right arm only, back to neutral, left arm never involved.
            Assert.IsTrue(ArmsPoseGate.Allows(
                ArmsScope.Right, ArmsPose.ForearmRaised, true, left, right));
            ArmsPoseGate.ApplyResult(ArmsScope.Right, ArmsPose.HangLow, ref left, ref right);

            Assert.AreEqual(ArmsPose.HangLow, right);
            Assert.AreEqual(ArmsPose.ForearmRaised, left,
                "grab_ground raises both arms; only the right one is put down by drop.");
        }
    }
}

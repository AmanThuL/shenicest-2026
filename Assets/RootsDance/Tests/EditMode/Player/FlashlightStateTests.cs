using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Player;

namespace RootsDance.Tests.EditMode.Player
{
    /// <summary>
    /// The flashlight's decision layer: when the beam is on and how fast it fades. No Light, no
    /// input, no scene — <see cref="FlashlightController"/> only translates these answers into HDRP.
    /// </summary>
    public class FlashlightStateTests
    {
        [Test]
        public void OnPhase_Night_TurnsTheBeamOn()
        {
            FlashlightState state = new FlashlightState(true);

            state.OnPhase(TimeOfDay.Night);

            Assert.IsTrue(state.IsOn);
        }

        [Test]
        public void OnPhase_Day_TurnsTheBeamOff()
        {
            FlashlightState state = new FlashlightState(true);
            state.OnPhase(TimeOfDay.Night);

            state.OnPhase(TimeOfDay.Day);

            Assert.IsFalse(state.IsOn);
        }

        [Test]
        public void OnPhase_PollutedDay_TurnsTheBeamOff()
        {
            FlashlightState state = new FlashlightState(true);
            state.OnPhase(TimeOfDay.Night);

            state.OnPhase(TimeOfDay.PollutedDay);

            Assert.IsFalse(state.IsOn);
        }

        [Test]
        public void OnPhase_AutoOnAtNightDisabled_LeavesTheBeamAlone()
        {
            FlashlightState state = new FlashlightState(false);

            state.OnPhase(TimeOfDay.Night);

            Assert.IsFalse(state.IsOn, "With auto-on off, only the button may light the beam.");
        }

        [Test]
        public void Toggle_WhenOff_TurnsTheBeamOn()
        {
            FlashlightState state = new FlashlightState(true);

            state.Toggle();

            Assert.IsTrue(state.IsOn);
        }

        [Test]
        public void Toggle_AtNight_TurnsTheBeamOff()
        {
            FlashlightState state = new FlashlightState(true);
            state.OnPhase(TimeOfDay.Night);

            state.Toggle();

            Assert.IsFalse(state.IsOn, "The player can always kill the beam, night or not.");
        }

        [Test]
        public void StepIntensity_StepLargerThanTheGap_StopsAtTheTarget()
        {
            Assert.AreEqual(2000f, FlashlightState.StepIntensity(0f, 2000f, 5000f), 0.001f);
        }

        [Test]
        public void StepIntensity_FadingOut_StopsAtZero()
        {
            Assert.AreEqual(0f, FlashlightState.StepIntensity(100f, 0f, 5000f), 0.001f);
        }

        [Test]
        public void StepIntensity_SmallStep_MovesPartWayOnly()
        {
            Assert.AreEqual(300f, FlashlightState.StepIntensity(0f, 2000f, 300f), 0.001f);
        }

        [Test]
        public void IsLit_SwitchOnButNotHeld_IsFalse()
        {
            FlashlightState state = new FlashlightState(autoOnAtNight: false);
            state.Toggle();
            state.SetHeld(false);

            Assert.That(state.IsOn, Is.True, "the switch keeps its setting");
            Assert.That(state.IsLit, Is.False, "but nothing is lit by a torch nobody holds");
        }

        [Test]
        public void IsLit_PickedBackUpWhileSwitchedOn_IsTrueAgain()
        {
            FlashlightState state = new FlashlightState(autoOnAtNight: false);
            state.Toggle();
            state.SetHeld(false);
            state.SetHeld(true);

            Assert.That(state.IsLit, Is.True);
        }

        [Test]
        public void IsLit_HeldButSwitchedOff_IsFalse()
        {
            FlashlightState state = new FlashlightState(autoOnAtNight: false);
            state.SetHeld(true);

            Assert.That(state.IsLit, Is.False);
        }

        // ---- The corridor torch: found dead, lit by the algae ----------------------------------

        [Test]
        public void HasPower_ByDefault_IsTrue()
        {
            // Every torch that came before the corridor one has to keep working untouched.
            FlashlightState state = new FlashlightState(autoOnAtNight: false);

            Assert.That(state.HasPower, Is.True);
        }

        [Test]
        public void IsLit_SwitchedOnWithoutPower_IsFalse()
        {
            FlashlightState state = new FlashlightState(autoOnAtNight: false);
            state.SetHeld(true);
            state.SetPower(false);

            state.Toggle();

            Assert.That(state.IsOn, Is.True, "the switch still moves on a dead torch");
            Assert.That(state.IsLit, Is.False);
        }

        [Test]
        public void SetPower_AfterTheSwitchWasLeftOn_LightsTheBeam()
        {
            // The beat the corridor wants: click the dead torch, find the algae, and it comes up
            // without having to be clicked again.
            FlashlightState state = new FlashlightState(autoOnAtNight: false);
            state.SetHeld(true);
            state.SetPower(false);
            state.Toggle();

            state.SetPower(true);

            Assert.That(state.IsLit, Is.True);
        }

        [Test]
        public void SetPower_WithTheSwitchOff_LeavesTheBeamDark()
        {
            // Powering the torch is not the same as switching it on: dropping the algae in must
            // not light a torch the player deliberately left off.
            FlashlightState state = new FlashlightState(autoOnAtNight: false);
            state.SetHeld(true);

            state.SetPower(true);

            Assert.That(state.IsLit, Is.False);
        }

        [Test]
        public void IsLit_PoweredButNotHeld_IsFalse()
        {
            FlashlightState state = new FlashlightState(autoOnAtNight: false);
            state.SetPower(true);
            state.Toggle();
            state.SetHeld(false);

            Assert.That(state.IsLit, Is.False);
        }

        [Test]
        public void OnPhase_Night_DoesNotLightADeadTorch()
        {
            // Auto-on-at-night moves the switch, never the power. A dead torch stays dark at dusk.
            FlashlightState state = new FlashlightState(autoOnAtNight: true);
            state.SetHeld(true);
            state.SetPower(false);

            state.OnPhase(TimeOfDay.Night);

            Assert.That(state.IsOn, Is.True);
            Assert.That(state.IsLit, Is.False);
        }
    }
}

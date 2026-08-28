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
    }
}

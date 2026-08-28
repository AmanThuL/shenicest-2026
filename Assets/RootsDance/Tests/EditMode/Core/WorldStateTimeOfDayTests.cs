using NUnit.Framework;
using RootsDance.Core;

namespace RootsDance.Tests.EditMode.Core
{
    /// <summary>
    /// Time of day is the one piece of world truth that is not monotonic, so it gets its own fixture:
    /// the interesting cases are "changing back is allowed" and "setting the current value is a no-op".
    /// </summary>
    public class WorldStateTimeOfDayTests
    {
        [Test]
        public void TimeOfDay_NewState_IsDay()
        {
            WorldState state = new WorldState();

            Assert.AreEqual(TimeOfDay.Day, state.TimeOfDay);
        }

        [Test]
        public void SetTimeOfDay_NewValue_IsAccepted()
        {
            WorldState state = new WorldState();

            Assert.IsTrue(state.SetTimeOfDay(TimeOfDay.Night));
        }

        [Test]
        public void SetTimeOfDay_NewValue_StoresIt()
        {
            WorldState state = new WorldState();

            state.SetTimeOfDay(TimeOfDay.Night);

            Assert.AreEqual(TimeOfDay.Night, state.TimeOfDay);
        }

        [Test]
        public void SetTimeOfDay_NewValue_AnnouncesItOnce()
        {
            WorldState state = new WorldState();
            int changedCount = 0;
            state.TimeOfDayChanged += _ => changedCount++;

            state.SetTimeOfDay(TimeOfDay.Night);

            Assert.AreEqual(1, changedCount);
        }

        [Test]
        public void SetTimeOfDay_NewValue_AnnouncesTheNewPhase()
        {
            WorldState state = new WorldState();
            TimeOfDay announced = TimeOfDay.Day;
            state.TimeOfDayChanged += phase => announced = phase;

            state.SetTimeOfDay(TimeOfDay.Night);

            Assert.AreEqual(TimeOfDay.Night, announced);
        }

        [Test]
        public void SetTimeOfDay_SameValue_IsRejected()
        {
            WorldState state = new WorldState();
            state.SetTimeOfDay(TimeOfDay.Night);

            bool accepted = state.SetTimeOfDay(TimeOfDay.Night);

            Assert.IsFalse(accepted, "Re-entering a trigger volume must not restart the lighting blend.");
        }

        [Test]
        public void SetTimeOfDay_SameValue_AnnouncesNothing()
        {
            WorldState state = new WorldState();
            state.SetTimeOfDay(TimeOfDay.Night);
            int changedCount = 0;
            state.TimeOfDayChanged += _ => changedCount++;

            state.SetTimeOfDay(TimeOfDay.Night);

            Assert.AreEqual(0, changedCount);
        }

        [Test]
        public void SetTimeOfDay_BackToDay_IsAccepted()
        {
            WorldState state = new WorldState();
            state.SetTimeOfDay(TimeOfDay.Night);

            bool accepted = state.SetTimeOfDay(TimeOfDay.Day);

            Assert.IsTrue(accepted, "Time of day is not monotonic, unlike flags.");
        }

        [Test]
        public void SetTimeOfDay_BackToDay_StoresDay()
        {
            WorldState state = new WorldState();
            state.SetTimeOfDay(TimeOfDay.Night);

            state.SetTimeOfDay(TimeOfDay.Day);

            Assert.AreEqual(TimeOfDay.Day, state.TimeOfDay);
        }
    }
}

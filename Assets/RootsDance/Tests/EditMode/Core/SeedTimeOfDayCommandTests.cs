using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Core.Commands;

namespace RootsDance.Tests.EditMode.Core
{
    /// <summary>
    /// The level default and an explicit choice (checkpoint, trigger) race through the same queue with no
    /// ordering guarantee; the explicit choice must win in both orders.
    /// </summary>
    public class SeedTimeOfDayCommandTests
    {
        [Test]
        public void Execute_NothingChosenYet_AppliesTheDefault()
        {
            WorldState state = new WorldState();
            CommandQueue queue = new CommandQueue();
            queue.Enqueue(new SeedTimeOfDayCommand(TimeOfDay.Night));

            queue.Drain(state);

            Assert.AreEqual(TimeOfDay.Night, state.TimeOfDay);
        }

        [Test]
        public void Execute_AfterAnExplicitSet_LeavesTheChoiceAlone()
        {
            WorldState state = new WorldState();
            CommandQueue queue = new CommandQueue();
            queue.Enqueue(new SetTimeOfDayCommand(TimeOfDay.Day));
            queue.Enqueue(new SeedTimeOfDayCommand(TimeOfDay.Night));

            queue.Drain(state);

            Assert.AreEqual(TimeOfDay.Day, state.TimeOfDay);
        }

        [Test]
        public void Execute_BeforeAnExplicitSet_IsOverriddenByIt()
        {
            WorldState state = new WorldState();
            CommandQueue queue = new CommandQueue();
            queue.Enqueue(new SeedTimeOfDayCommand(TimeOfDay.Night));
            queue.Enqueue(new SetTimeOfDayCommand(TimeOfDay.Day));

            queue.Drain(state);

            Assert.AreEqual(TimeOfDay.Day, state.TimeOfDay);
        }

        [Test]
        public void IsTimeOfDaySet_AfterSettingTheCurrentValue_IsTrue()
        {
            WorldState state = new WorldState();

            state.SetTimeOfDay(TimeOfDay.Day);

            Assert.IsTrue(state.IsTimeOfDaySet);
        }
    }
}

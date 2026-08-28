using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Core.Commands;

namespace RootsDance.Tests.EditMode.Core
{
    /// <summary>
    /// The command is the only sanctioned way for a checkpoint, trigger or Dev Play button to change
    /// the time of day, so it is checked through the queue rather than against the state directly.
    /// </summary>
    public class SetTimeOfDayCommandTests
    {
        [Test]
        public void Execute_AfterDrain_SetsTheRequestedPhase()
        {
            WorldState state = new WorldState();
            CommandQueue queue = new CommandQueue();
            queue.Enqueue(new SetTimeOfDayCommand(TimeOfDay.Night));

            queue.Drain(state);

            Assert.AreEqual(TimeOfDay.Night, state.TimeOfDay);
        }

        [Test]
        public void Execute_BeforeDrain_ChangesNothing()
        {
            WorldState state = new WorldState();
            CommandQueue queue = new CommandQueue();

            queue.Enqueue(new SetTimeOfDayCommand(TimeOfDay.Night));

            Assert.AreEqual(TimeOfDay.Day, state.TimeOfDay);
        }

        [Test]
        public void Execute_SecondCommandBackToDay_SetsDay()
        {
            WorldState state = new WorldState();
            CommandQueue queue = new CommandQueue();
            queue.Enqueue(new SetTimeOfDayCommand(TimeOfDay.Night));
            queue.Enqueue(new SetTimeOfDayCommand(TimeOfDay.Day));

            queue.Drain(state);

            Assert.AreEqual(TimeOfDay.Day, state.TimeOfDay);
        }

        [Test]
        public void Execute_SamePhaseTwice_AnnouncesOnce()
        {
            WorldState state = new WorldState();
            CommandQueue queue = new CommandQueue();
            int changedCount = 0;
            state.TimeOfDayChanged += _ => changedCount++;
            queue.Enqueue(new SetTimeOfDayCommand(TimeOfDay.Night));
            queue.Enqueue(new SetTimeOfDayCommand(TimeOfDay.Night));

            queue.Drain(state);

            Assert.AreEqual(1, changedCount);
        }
    }
}

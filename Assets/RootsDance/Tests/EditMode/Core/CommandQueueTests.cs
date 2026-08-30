using System;
using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Core.Commands;

namespace RootsDance.Tests.EditMode.Core
{
    /// <summary>
    /// The queue is what replaces a simulation tick: it guarantees every world change lands at one
    /// point in the frame, and that a change raised from inside a handler cannot recurse.
    /// </summary>
    public class CommandQueueTests
    {
        [Test]
        public void BeginReset_PendingAndTeardownCommands_DiscardsBoth()
        {
            var state = new WorldState();
            var queue = new CommandQueue();
            queue.Enqueue(new RaiseFlagCommand("pending"));

            queue.BeginReset();
            queue.Enqueue(new RaiseFlagCommand("teardown"));
            queue.Drain(state);

            Assert.That(queue.PendingCount, Is.Zero);
            Assert.That(state.HasFlag("pending"), Is.False);
            Assert.That(state.HasFlag("teardown"), Is.False);
        }

        [Test]
        public void EndReset_FreshSceneCommand_IsAccepted()
        {
            var state = new WorldState();
            var queue = new CommandQueue();
            queue.BeginReset();
            queue.EndReset();
            queue.Enqueue(new RaiseFlagCommand("fresh"));

            queue.Drain(state);

            Assert.That(state.HasFlag("fresh"), Is.True);
        }

        [Test]
        public void EndReset_AlreadyResumed_PreservesFreshPendingCommands()
        {
            var state = new WorldState();
            var queue = new CommandQueue();
            queue.BeginReset();
            queue.EndReset();
            queue.Enqueue(new RaiseFlagCommand("fresh"));

            queue.EndReset();
            queue.Drain(state);

            Assert.That(state.HasFlag("fresh"), Is.True);
        }

        [Test]
        public void Drain_ExecutesEveryQueuedCommand()
        {
            WorldState state = new WorldState();
            CommandQueue queue = new CommandQueue();
            queue.Enqueue(new RaiseFlagCommand("a"));
            queue.Enqueue(new RaiseFlagCommand("b"));

            queue.Drain(state);

            Assert.IsTrue(state.HasFlag("a"));
            Assert.IsTrue(state.HasFlag("b"));
            Assert.AreEqual(0, queue.PendingCount);
        }

        [Test]
        public void Drain_CommandQueuedDuringDrain_WaitsForTheNextDrain()
        {
            WorldState state = new WorldState();
            CommandQueue queue = new CommandQueue();
            queue.Enqueue(new ActionCommand(() => queue.Enqueue(new RaiseFlagCommand("late"))));

            queue.Drain(state);

            Assert.IsFalse(state.HasFlag("late"), "A command queued mid-drain must not run in the same drain.");
            Assert.AreEqual(1, queue.PendingCount);

            queue.Drain(state);

            Assert.IsTrue(state.HasFlag("late"));
        }

        [Test]
        public void Drain_CalledReentrantly_IsIgnored()
        {
            WorldState state = new WorldState();
            CommandQueue queue = new CommandQueue();
            int executions = 0;

            queue.Enqueue(new ActionCommand(() =>
            {
                executions++;
                // A handler that reacts to a state change and drains again must not recurse.
                queue.Drain(state);
            }));

            queue.Drain(state);

            Assert.AreEqual(1, executions);
        }

        [Test]
        public void Enqueue_Null_IsIgnored()
        {
            CommandQueue queue = new CommandQueue();

            queue.Enqueue(null);

            Assert.AreEqual(0, queue.PendingCount);
        }

        private sealed class ActionCommand : IWorldCommand
        {
            private readonly Action m_action;

            public ActionCommand(Action action)
            {
                m_action = action;
            }

            public void Execute(WorldState state)
            {
                m_action();
            }
        }
    }
}

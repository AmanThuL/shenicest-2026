using NUnit.Framework;
using RootsDance.Core;

namespace RootsDance.Tests.EditMode.Core
{
    /// <summary>
    /// The interaction gate is pure C#: acquire and release it with plain objects, check who wins.
    /// </summary>
    public class InteractionLockTests
    {
        [Test]
        public void TryAcquire_Free_LocksForOwner()
        {
            var gate = new InteractionLock();
            var owner = new object();

            Assert.IsTrue(gate.TryAcquire(owner));
            Assert.IsTrue(gate.IsLocked);
            Assert.AreSame(owner, gate.Owner);
        }

        [Test]
        public void TryAcquire_HeldByOther_Refuses()
        {
            var gate = new InteractionLock();
            var first = new object();
            gate.TryAcquire(first);

            Assert.IsFalse(gate.TryAcquire(new object()));
            Assert.AreSame(first, gate.Owner);
        }

        [Test]
        public void TryAcquire_HeldBySameOwner_SucceedsWithoutChange()
        {
            var gate = new InteractionLock();
            var owner = new object();
            gate.TryAcquire(owner);

            Assert.IsTrue(gate.TryAcquire(owner));
            Assert.AreSame(owner, gate.Owner);
        }

        [Test]
        public void TryAcquire_NullOwner_Refuses()
        {
            var gate = new InteractionLock();

            Assert.IsFalse(gate.TryAcquire(null));
            Assert.IsFalse(gate.IsLocked);
        }

        [Test]
        public void Release_ByOwner_Opens()
        {
            var gate = new InteractionLock();
            var owner = new object();
            gate.TryAcquire(owner);

            Assert.IsTrue(gate.Release(owner));
            Assert.IsFalse(gate.IsLocked);
            Assert.IsNull(gate.Owner);
        }

        [Test]
        public void Release_ByStranger_ChangesNothing()
        {
            var gate = new InteractionLock();
            var owner = new object();
            gate.TryAcquire(owner);

            Assert.IsFalse(gate.Release(new object()));
            Assert.IsTrue(gate.IsLocked);
            Assert.AreSame(owner, gate.Owner);
        }

        [Test]
        public void Release_WhenFree_IsSafeNoOp()
        {
            var gate = new InteractionLock();

            Assert.IsFalse(gate.Release(new object()));
            Assert.IsFalse(gate.IsLocked);
        }

        [Test]
        public void Release_ThenAcquireByOther_Succeeds()
        {
            var gate = new InteractionLock();
            var first = new object();
            var second = new object();
            gate.TryAcquire(first);
            gate.Release(first);

            Assert.IsTrue(gate.TryAcquire(second));
            Assert.AreSame(second, gate.Owner);
        }

        [Test]
        public void ForceRelease_HeldByAnyone_Opens()
        {
            var gate = new InteractionLock();
            gate.TryAcquire(new object());

            gate.ForceRelease();

            Assert.IsFalse(gate.IsLocked);
            Assert.IsTrue(gate.TryAcquire(new object()));
        }
    }
}

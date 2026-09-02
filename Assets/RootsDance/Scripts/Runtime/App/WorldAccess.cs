using RootsDance.Core;
using UnityEngine;

namespace RootsDance.App
{
    /// <summary>
    /// Lazy access to the bootstrap services for content-scene components. Never call this from
    /// Awake/OnEnable/Start: when Play starts in a level scene the bootstrap arrives one frame later.
    /// </summary>
    public static class WorldAccess
    {
        /// <summary>
        /// Read-only view of the ground truth, or null while the bootstrap has not arrived yet.
        /// There is deliberately no way to get the writable object from here: changes go through
        /// <see cref="Enqueue"/>.
        /// </summary>
        public static IWorldStateReader State
        {
            get
            {
                GameBootstrap bootstrap = GameBootstrap.Instance;
                return bootstrap == null ? null : bootstrap.WorldState;
            }
        }

        /// <summary>
        /// True while any exclusive interaction — a tool performance, the scanner, a document, a
        /// terminal, the keypad — holds the player. Proximity offers and the interaction ray check
        /// this before starting another one. False while the bootstrap has not arrived yet.
        /// </summary>
        public static bool IsInteractionLocked
        {
            get
            {
                GameBootstrap bootstrap = GameBootstrap.Instance;
                return bootstrap != null && bootstrap.InteractionLock != null
                    && bootstrap.InteractionLock.IsLocked;
            }
        }

        /// <summary>
        /// Takes the exclusive-interaction gate for <paramref name="owner"/>. Returns false while
        /// another interaction holds it — the caller must then not start. Succeeds trivially while
        /// the bootstrap has not arrived yet, so a level-only Play session still plays.
        /// </summary>
        public static bool TryBeginExclusiveInteraction(object owner)
        {
            GameBootstrap bootstrap = GameBootstrap.Instance;
            return bootstrap == null || bootstrap.InteractionLock == null
                || bootstrap.InteractionLock.TryAcquire(owner);
        }

        /// <summary>
        /// Opens the exclusive-interaction gate, but only if <paramref name="owner"/> holds it.
        /// Safe to call from any teardown path without checking first.
        /// </summary>
        public static void EndExclusiveInteraction(object owner)
        {
            GameBootstrap bootstrap = GameBootstrap.Instance;

            if (bootstrap != null && bootstrap.InteractionLock != null)
            {
                bootstrap.InteractionLock.Release(owner);
            }
        }

        /// <summary>
        /// Queues a world change. Returns false (and logs) when the bootstrap is not available,
        /// which in practice only happens on the very first frame of a level-only Play session.
        /// </summary>
        public static bool Enqueue(IWorldCommand command, Object context)
        {
            GameBootstrap bootstrap = GameBootstrap.Instance;

            if (bootstrap == null || bootstrap.Commands == null)
            {
                Log.Warning("No GameBootstrap yet; command dropped.", context);
                return false;
            }

            bootstrap.Commands.Enqueue(command);
            return true;
        }
    }
}

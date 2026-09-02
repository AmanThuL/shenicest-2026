using DG.Tweening;
using RootsDance.Core;
using RootsDance.Interaction;
using RootsDance.Player;
using RootsDance.Scanner;
using UnityEngine;

namespace RootsDance.App
{
    /// <summary>
    /// Puts static state back to how a fresh process would find it, once per play session.
    /// <para>
    /// This exists so that Play mode can be entered without a domain reload. A reload is what
    /// normally clears every static in the project, and it is also most of the wait before a
    /// session starts. Turning it off trades that wait for one rule: anything static has to be
    /// reset here instead.
    /// </para>
    /// <para>
    /// The list is deliberately short, and stays short. Most of the project already avoids
    /// statics — <see cref="WorldAccess"/> reads the bootstrap through
    /// <see cref="RootsDance.Core.PersistentSingleton{T}"/> every time rather than caching it. That
    /// singleton's own static is cleared here rather than left to Unity's destroyed-equals-null
    /// rule: leaning on the rule means the next session starts holding the last session's object.
    /// What is left is the four self-registration lists, the flashlight's last published beam, and
    /// DOTween, whose own state outlives the component it drives.
    /// </para>
    /// <see cref="RuntimeInitializeLoadType.SubsystemRegistration"/> is the earliest hook and the
    /// one Unity documents for exactly this: it runs before any scene is loaded, so nothing can
    /// register itself before the clear-out.
    /// </summary>
    public static class PlaySessionReset
    {
        [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
        private static void Reset()
        {
            PersistentSingleton<GameBootstrap>.ResetInstance();
            ScannableTarget.ResetRegistry();
            GroundPickup.ResetRegistry();
            HarvestPoint.ResetRegistry();
            ThrowTarget.ResetRegistry();
            FlashlightBeamBroadcaster.ResetBeam();

            // DOTween keeps its tween pool and its driver GameObject in statics. The GameObject is
            // destroyed when Play stops; without this the pool would still hold tweens pointing at
            // it. Harmless when DOTween was never initialised.
            DOTween.Clear(true);
        }
    }
}

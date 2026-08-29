using DG.Tweening;
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
    /// <see cref="RootsDance.Core.PersistentSingleton{T}"/> every time rather than caching it, and
    /// that singleton re-finds itself because Unity's destroyed objects compare equal to null. What
    /// is left is the two self-registration lists, the flashlight's last published beam, and
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
            ScannableTarget.ResetRegistry();
            GroundPickup.ResetRegistry();
            HarvestPoint.ResetRegistry();
            FlashlightBeamBroadcaster.ResetBeam();

            // DOTween keeps its tween pool and its driver GameObject in statics. The GameObject is
            // destroyed when Play stops; without this the pool would still hold tweens pointing at
            // it. Harmless when DOTween was never initialised.
            DOTween.Clear(true);
        }
    }
}

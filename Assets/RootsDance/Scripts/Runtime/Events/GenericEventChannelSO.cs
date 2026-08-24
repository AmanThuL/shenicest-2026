using System;
using UnityEngine;

namespace RootsDance.Events
{
    /// <summary>Base for every payload-carrying event channel. One concrete type per payload.</summary>
    public abstract class GenericEventChannelSO<T> : ScriptableObject
    {
        public event Action<T> EventRaised;

        public void RaiseEvent(T payload)
        {
            EventRaised?.Invoke(payload);
        }
    }
}

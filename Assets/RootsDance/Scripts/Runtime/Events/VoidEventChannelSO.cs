using System;
using UnityEngine;

namespace RootsDance.Events
{
    [CreateAssetMenu(fileName = "VoidEventChannel", menuName = "RootsDance/Events/Void Event Channel")]
    public class VoidEventChannelSO : ScriptableObject
    {
        public event Action EventRaised;

        public void RaiseEvent()
        {
            EventRaised?.Invoke();
        }
    }
}

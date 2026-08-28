using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Events
{
    /// <summary>Carries the world's new time of day so lighting and the flashlight can react.</summary>
    [CreateAssetMenu(fileName = "TimeOfDayEventChannel", menuName = "RootsDance/Events/Time Of Day Event Channel")]
    public class TimeOfDayEventChannelSO : GenericEventChannelSO<TimeOfDay>
    {
    }
}

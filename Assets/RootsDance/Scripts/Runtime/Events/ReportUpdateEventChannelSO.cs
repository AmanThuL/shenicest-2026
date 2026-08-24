using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Events
{
    /// <summary>Announces one accepted official-report entry and its section count. Pumped by GameBootstrap.</summary>
    [CreateAssetMenu(fileName = "ReportUpdateEventChannel", menuName = "RootsDance/Events/Report Update Event Channel")]
    public class ReportUpdateEventChannelSO : GenericEventChannelSO<ReportUpdate>
    {
    }
}

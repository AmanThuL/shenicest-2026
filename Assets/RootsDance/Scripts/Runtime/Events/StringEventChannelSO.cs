using UnityEngine;

namespace RootsDance.Events
{
    /// <summary>Carries a single line of text — inner monologue, radio line, interaction prompt.</summary>
    [CreateAssetMenu(fileName = "StringEventChannel", menuName = "RootsDance/Events/String Event Channel")]
    public class StringEventChannelSO : GenericEventChannelSO<string>
    {
    }
}

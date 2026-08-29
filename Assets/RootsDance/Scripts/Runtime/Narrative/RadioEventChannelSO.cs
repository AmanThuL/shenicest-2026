using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Narrative
{
    /// <summary>
    /// Carries "play this transmission". The mirror of
    /// <see cref="RootsDance.Dialogue.DialogueEventChannelSO"/>, and there for the same reason: a
    /// trigger in a content scene raises it, and the player component — which lives wherever the
    /// radio is heard — answers, with no serialized reference crossing the scene boundary.
    /// </summary>
    [CreateAssetMenu(fileName = "RadioEventChannel", menuName = "RootsDance/Events/Radio Event Channel")]
    public class RadioEventChannelSO : GenericEventChannelSO<RadioSequenceSO>
    {
    }
}

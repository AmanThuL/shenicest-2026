using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Dialogue
{
    /// <summary>
    /// Carries "play this conversation". A trigger in a content scene raises it; the runner, which
    /// lives with the player, answers — the same reason the audio cues use a channel, and the same
    /// reason nothing needs a static access point to find the runner.
    /// </summary>
    [CreateAssetMenu(fileName = "DialogueEventChannel", menuName = "RootsDance/Events/Dialogue Event Channel")]
    public class DialogueEventChannelSO : GenericEventChannelSO<DialogueSO>
    {
    }
}

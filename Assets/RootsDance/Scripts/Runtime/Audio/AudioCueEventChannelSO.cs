using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Audio
{
    /// <summary>
    /// Carries one "play this cue" request. The project has two of these assets under
    /// <c>Data/Events/</c>: <c>AudioCueRequested</c>, which the one-shot director answers, and
    /// <c>MusicRequested</c>, which the music director answers.
    /// <para>
    /// Audio is reached this way rather than through a static, because the director lives in
    /// <c>Bootstrap.unity</c> and everything that makes a sound lives in a content scene: no
    /// serialized reference can cross that boundary, and a channel asset can. It also keeps the
    /// dependency pointing one way — gameplay raises, audio listens, and gameplay never links
    /// against the audio code.
    /// </para>
    /// </summary>
    [CreateAssetMenu(fileName = "AudioCueEventChannel", menuName = "RootsDance/Events/Audio Cue Event Channel")]
    public class AudioCueEventChannelSO : GenericEventChannelSO<AudioCueRequest>
    {
    }
}

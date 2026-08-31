using DG.Tweening;
using RootsDance.Events;
using UnityEngine;
using UnityEngine.Rendering;

namespace RootsDance.Environment
{
    /// <summary>
    /// Fades out the baked-sky Volume once the real exterior scene has finished streaming in behind
    /// it, so the switch from painted backdrop to real geometry reads as a soft cross-fade instead of
    /// a pop. Lives next to the Volume it fades, in the same scene as the baked sky it is replacing.
    /// </summary>
    [RequireComponent(typeof(Volume))]
    public class BakedSkyRevealController : MonoBehaviour
    {
        [Tooltip("Data/Events/StreamSceneRequested — the same channel SceneLoader echoes back once "
            + "the requested scene has finished streaming in.")]
        [SerializeField] private StringEventChannelSO m_additiveContentStreamed;

        [Tooltip("Only react when the streamed scene matches this path (see RootsDance.App.ScenePaths).")]
        [SerializeField] private string m_awaitedScenePath;

        [Min(0f)]
        [SerializeField] private float m_fadeSeconds = 1f;

        private Volume m_volume;

        private void Awake()
        {
            m_volume = GetComponent<Volume>();
        }

        private void OnEnable()
        {
            if (m_additiveContentStreamed != null)
            {
                m_additiveContentStreamed.EventRaised += OnAdditiveContentStreamed;
            }
        }

        private void OnDisable()
        {
            if (m_additiveContentStreamed != null)
            {
                m_additiveContentStreamed.EventRaised -= OnAdditiveContentStreamed;
            }

            DOTween.Kill(m_volume);
        }

        private void OnAdditiveContentStreamed(string scenePath)
        {
            if (scenePath != m_awaitedScenePath)
            {
                return;
            }

            DOTween.To(() => m_volume.weight, w => m_volume.weight = w, 0f, m_fadeSeconds)
                .SetEase(Ease.InOutSine)
                .SetTarget(m_volume);
        }
    }
}

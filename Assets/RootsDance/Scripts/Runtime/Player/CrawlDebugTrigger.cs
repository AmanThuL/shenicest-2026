using RootsDance.Core;
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.Player
{
    /// <summary>
    /// TEST SCAFFOLDING — the sibling of <see cref="HelmetDebugTrigger"/>, for judging the crawl
    /// cycle in Play mode. C toggles the looping crawl state on and off; releasing it returns the
    /// rig to the idle state frozen on its first frame, which is the pose
    /// <see cref="HelmetAnimatorView"/> parks the arms in.
    /// Deliberately reads the keyboard device instead of the project-wide action asset
    /// (guideline 04 / rule 5): a throwaway key must not add churn to the shared
    /// Input/RootsDance.inputactions that every teammate merges.
    /// </summary>
    [RequireComponent(typeof(Animator))]
    public class CrawlDebugTrigger : MonoBehaviour
    {
        [SerializeField] private Key m_key = Key.C;

        [Tooltip("Looping crawl state in the controller's base layer.")]
        [SerializeField] private string m_crawlState = "Crawl";

        [Tooltip("State the rig returns to, held on frame 0.")]
        [SerializeField] private string m_idleState = "HelmetOff";

        private Animator m_animator;
        private int m_crawlHash;
        private int m_idleHash;
        private bool m_isCrawling;

        private void Awake()
        {
            m_animator = GetComponent<Animator>();
            m_crawlHash = Animator.StringToHash(m_crawlState);
            m_idleHash = Animator.StringToHash(m_idleState);
        }

        private void Update()
        {
            Keyboard keyboard = Keyboard.current;

            if (keyboard == null || m_animator == null)
            {
                return;
            }

            if (!keyboard[m_key].wasPressedThisFrame)
            {
                return;
            }

            m_isCrawling = !m_isCrawling;

            if (m_isCrawling)
            {
                m_animator.speed = 1f;
                m_animator.Play(m_crawlHash, 0, 0f);
                Log.Info($"CrawlDebugTrigger: {m_key} pressed, crawl started.", this);
            }
            else
            {
                m_animator.Play(m_idleHash, 0, 0f);
                m_animator.speed = 0f;
                Log.Info($"CrawlDebugTrigger: {m_key} pressed, crawl stopped.", this);
            }
        }
    }
}

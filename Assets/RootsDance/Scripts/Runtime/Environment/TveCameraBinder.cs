using TheVisualEngine;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// Late-binds the camera to the co-located <see cref="TVEManager"/>. The manager captures
    /// <c>Camera.main</c> once when it enables — but when a level scene is played directly in the
    /// editor, <c>BootstrapLoader</c> brings the bootstrap scene (and with it the project's only
    /// camera) in additively a frame later, so the manager caches null and throws from LateUpdate
    /// every frame. Until a camera exists the manager is held disabled; the moment one appears it is
    /// handed over and re-enabled, and this component switches itself off. In a build the bootstrap
    /// scene loads first, the camera is already there, and this never holds the manager back.
    /// </summary>
    [RequireComponent(typeof(TVEManager))]
    public class TveCameraBinder : MonoBehaviour
    {
        private TVEManager m_manager;

        private void Awake()
        {
            m_manager = GetComponent<TVEManager>();

            if (Camera.main == null)
            {
                m_manager.enabled = false;
            }
        }

        private void Update()
        {
            Camera main = Camera.main;

            if (main == null)
            {
                return;
            }

            m_manager.mainCamera = main;
            m_manager.enabled = true;
            enabled = false;
        }
    }
}

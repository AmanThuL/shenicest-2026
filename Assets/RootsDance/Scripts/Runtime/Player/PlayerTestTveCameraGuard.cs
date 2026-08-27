using System.Reflection;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Player
{
    /// <summary>
    /// PlayerTest-only guard for The Visual Engine's manager. TVEManager captures Camera.main once
    /// when it enables — but playing a PlayerTest scene directly, BootstrapLoader brings the
    /// bootstrap scene (and with it the project's only camera) in additively a frame later, so the
    /// manager caches null and throws from LateUpdate every frame. This guard holds the manager
    /// disabled until the camera exists, hands it over, and removes itself.
    /// <para>
    /// Deliberately scoped to the PlayerTest flow alone: it self-installs only when the active scene
    /// is a PlayerTest scene, and reaches the third-party manager via reflection, so no assembly
    /// definition, prefab or environment-side file changes.
    /// </para>
    /// </summary>
    public class PlayerTestTveCameraGuard : MonoBehaviour
    {
        private const string k_ManagerTypeName = "TheVisualEngine.TVEManager";
        private const int k_ScanIntervalFrames = 30;

        private Behaviour m_manager;
        private FieldInfo m_cameraField;
        private int m_nextScanFrame;

        [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
        private static void Install()
        {
            if (!SceneManager.GetActiveScene().name.StartsWith("PlayerTest"))
            {
                return;
            }

            new GameObject("PlayerTestTveCameraGuard", typeof(PlayerTestTveCameraGuard));
        }

        private void Awake()
        {
            // AfterSceneLoad runs before the first frame's updates, so a manager found here is
            // parked before its LateUpdate ever dereferences the missing camera.
            TryBindManager();
        }

        private void Update()
        {
            if (m_manager == null && !TryBindManager())
            {
                return;
            }

            Camera main = Camera.main;

            if (main == null)
            {
                return;
            }

            m_cameraField.SetValue(m_manager, main);
            m_manager.enabled = true;
            Destroy(gameObject);
        }

        /// <summary>Finds the TVE manager, parking it while no camera exists. Rescans are throttled:
        /// the environment scene may still be loading when the guard comes up.</summary>
        private bool TryBindManager()
        {
            if (Time.frameCount < m_nextScanFrame)
            {
                return false;
            }

            m_nextScanFrame = Time.frameCount + k_ScanIntervalFrames;

            foreach (MonoBehaviour behaviour in FindObjectsByType<MonoBehaviour>(
                FindObjectsInactive.Include, FindObjectsSortMode.None))
            {
                if (behaviour == null || behaviour.GetType().FullName != k_ManagerTypeName)
                {
                    continue;
                }

                FieldInfo field = behaviour.GetType().GetField("mainCamera");

                if (field == null)
                {
                    break;
                }

                m_manager = behaviour;
                m_cameraField = field;

                // The cast matters: reflection hands back Unity's fake-null wrapper for an
                // unassigned reference, and only Camera's overloaded == sees through it.
                Camera assigned = field.GetValue(behaviour) as Camera;

                if (Camera.main == null && assigned == null)
                {
                    m_manager.enabled = false;
                }

                return true;
            }

            return false;
        }
    }
}

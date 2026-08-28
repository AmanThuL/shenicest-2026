using System.Reflection;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

namespace RootsDance.Player
{
    /// <summary>
    /// Holds The Visual Engine's manager disabled until the bootstrap camera exists, then binds the
    /// camera before the manager's next LateUpdate. Level scenes can start before Bootstrap finishes
    /// loading additively, so TVE's one-shot Camera.main lookup is allowed to return null.
    /// </summary>
    public class TveCameraGuard : MonoBehaviour
    {
        private const string k_ManagerTypeName = "TheVisualEngine.TVEManager";

        private Behaviour m_manager;
        private FieldInfo m_cameraField;
        private Camera m_mainCamera;

        [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
        private static void Install()
        {
            GameObject guard = new GameObject("TveCameraGuard", typeof(TveCameraGuard));
            DontDestroyOnLoad(guard);
        }

        private void Awake()
        {
            m_mainCamera = Camera.main;
            TryBindManager();
        }

        private void OnEnable()
        {
            SceneManager.sceneLoaded += OnSceneLoaded;
            RenderPipelineManager.beginCameraRendering += OnBeginCameraRendering;
        }

        private void OnDisable()
        {
            SceneManager.sceneLoaded -= OnSceneLoaded;
            RenderPipelineManager.beginCameraRendering -= OnBeginCameraRendering;
        }

        private void OnSceneLoaded(Scene scene, LoadSceneMode mode)
        {
            if (m_manager == null)
            {
                TryBindManager();
            }
        }

        private void OnBeginCameraRendering(ScriptableRenderContext context, Camera camera)
        {
            if (!camera.CompareTag("MainCamera"))
            {
                return;
            }

            m_mainCamera = camera;
            TryCompleteBinding();
        }

        private bool TryBindManager()
        {
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

                Camera assigned = field.GetValue(behaviour) as Camera;

                if (assigned != null)
                {
                    Destroy(gameObject);
                    return true;
                }

                m_manager.enabled = false;
                TryCompleteBinding();
                return true;
            }

            return false;
        }

        private void TryCompleteBinding()
        {
            if (m_manager == null || m_cameraField == null || m_mainCamera == null)
            {
                return;
            }

            m_cameraField.SetValue(m_manager, m_mainCamera);
            m_manager.enabled = true;
            Destroy(gameObject);
        }
    }
}

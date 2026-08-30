using RootsDance.Core;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Environment
{
    /// <summary>
    /// Keeps an emissive renderer at the brightness it was authored at, whatever fixed exposure the
    /// current Volume stack asks for. The opening motes are HDRP/Unlit emitters in nits tuned under
    /// the day look's EV 12.5; at the night's EV 5 the same nits sit ten stops over and every mote
    /// near the camera renders as a white disc. This scales the material's <c>_EmissiveColor</c> by
    /// 2^(EV − authored EV) on the renderer's own material instance — the shared asset is never
    /// written, and the instance is released in OnDestroy.
    /// </summary>
    [RequireComponent(typeof(Renderer))]
    public class EmissiveExposureFollower : MonoBehaviour
    {
        private static readonly int k_EmissiveColorId = Shader.PropertyToID("_EmissiveColor");
        private const float k_RewriteThreshold = 0.02f;

        [Tooltip("Fixed exposure (EV100) the material's emissive nits were authored under. The Main level's "
            + "day look is 12.5.")]
        [SerializeField] private float m_authoredEv100 = 12.5f;

        private Renderer m_renderer;
        private Material m_material;
        private Color m_baseEmissive;
        private VolumeStack m_stack;
        private Transform m_anchor;
        private LayerMask m_layerMask = -1;
        private float m_appliedScale = -1f;

        private void Awake()
        {
            m_renderer = GetComponent<Renderer>();
            Material shared = m_renderer.sharedMaterial;

            if (shared == null || !shared.HasProperty(k_EmissiveColorId))
            {
                Log.Warning("EmissiveExposureFollower needs a material with _EmissiveColor; disabled.", this);
                enabled = false;
                return;
            }

            m_baseEmissive = shared.GetColor(k_EmissiveColorId);
            m_material = m_renderer.material;
        }

        private void LateUpdate()
        {
            // The VolumeManager only exists once the render pipeline has been created — after every Awake
            // and, when Play starts from a level scene, after the first frame. CreateStack throws before that.
            if (m_stack == null)
            {
                if (!VolumeManager.instance.isInitialized)
                {
                    return;
                }

                m_stack = VolumeManager.instance.CreateStack();
            }

            if (!TryResolveAnchor())
            {
                return;
            }

            VolumeManager.instance.Update(m_stack, m_anchor, m_layerMask);
            Exposure exposure = m_stack.GetComponent<Exposure>();

            if (exposure == null || exposure.mode.value != ExposureMode.Fixed)
            {
                return;
            }

            float scale = EmissiveExposure.Scale(m_authoredEv100, exposure.fixedExposure.value);

            // The night fade changes EV over two seconds; rewrite only when it moved enough to see.
            if (m_appliedScale > 0f && Mathf.Abs(scale - m_appliedScale) / m_appliedScale < k_RewriteThreshold)
            {
                return;
            }

            m_appliedScale = scale;
            m_material.SetColor(k_EmissiveColorId, m_baseEmissive * scale);
        }

        private void OnDestroy()
        {
            if (m_stack != null)
            {
                VolumeManager.instance.DestroyStack(m_stack);
            }

            if (m_material != null)
            {
                Destroy(m_material);
            }
        }

        /// <summary>The camera decides which Volumes apply; it may arrive a frame after this scene.</summary>
        private bool TryResolveAnchor()
        {
            if (m_anchor != null)
            {
                return true;
            }

            Camera camera = Camera.main;

            if (camera == null)
            {
                return false;
            }

            m_anchor = camera.transform;
            HDAdditionalCameraData cameraData = camera.GetComponent<HDAdditionalCameraData>();

            if (cameraData != null)
            {
                m_layerMask = cameraData.volumeLayerMask;
            }

            return true;
        }
    }
}

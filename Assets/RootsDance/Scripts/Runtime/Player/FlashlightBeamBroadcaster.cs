using RootsDance.Core;
using UnityEngine;
using UnityEngine.Rendering;

namespace RootsDance.Player
{
    /// <summary>
    /// Publishes the flashlight beam as shader globals, so materials can react to being lit by it.
    /// </summary>
    /// <remarks>
    /// <para>
    /// Shader globals rather than serialized references, because the two ends live in different
    /// scenes: the flashlight is on the Player in the gameplay scene and the surfaces that react to
    /// it are dressed into environment scenes, which no serialized field can reach across. There is
    /// exactly one flashlight in the game, so one set of globals is the whole state — the same
    /// arrangement <see cref="Rendering.ScannerScanEffect"/> uses for the scan stripes.
    /// </para>
    /// <para>
    /// Written per camera rather than per frame: <see cref="FlashlightController"/> snaps the Light
    /// onto the camera right before it renders, so the pose that matters only exists at that point.
    /// Both handlers hang off the same event and their order is not defined, so this may read the
    /// Light one event before it is snapped — a centimetre or two of camera damping, which no
    /// reveal falloff can show. Reading the Light rather than the camera is what keeps this correct
    /// once the beam moves onto a torch bone and stops sitting on the eye.
    /// </para>
    /// </remarks>
    public class FlashlightBeamBroadcaster : MonoBehaviour
    {
        /// <summary>Cone apex in absolute world space; <c>w</c> is unused.</summary>
        public const string k_PositionProperty = "_RootsFlashlightPosition";

        /// <summary>Beam axis, normalised; <c>w</c> is unused.</summary>
        public const string k_DirectionProperty = "_RootsFlashlightDirection";

        /// <summary>x: cos(outer half-angle), y: cos(inner half-angle), z: range, w: 0..1 fade.</summary>
        public const string k_ConeProperty = "_RootsFlashlightCone";

        [Header("Wiring")]
        [Tooltip("The Spot light on Head/Flashlight — the same one the controller drives.")]
        [SerializeField] private Light m_light;

        [Tooltip("Supplies the beam's fade level. Without it the beam reads as fully on whenever " +
                 "the Light component is enabled.")]
        [SerializeField] private FlashlightController m_controller;

        [Header("Tuning")]
        [Tooltip("Widens the published cone past the Light's own outer angle. The visible beam " +
                 "washes a little past its cone in fog, and marks that stop dead at the geometric " +
                 "edge read as a projected texture rather than as ink catching the light.")]
        [Range(0f, 20f)][SerializeField] private float m_coneMarginDegrees = 4f;

        private static readonly int k_PositionId = Shader.PropertyToID(k_PositionProperty);
        private static readonly int k_DirectionId = Shader.PropertyToID(k_DirectionProperty);
        private static readonly int k_ConeId = Shader.PropertyToID(k_ConeProperty);

        private bool m_hasLight;

        /// <summary>
        /// The beam as it was last published: apex, axis, cone cosines, range and fade. Read by
        /// gameplay that has to answer "is this lit?" without going through the GPU.
        /// </summary>
        public static FlashlightBeam Beam { get; private set; }

        private void Awake()
        {
            m_hasLight = m_light != null;

            if (!m_hasLight)
            {
                Log.Error("FlashlightBeamBroadcaster has no Light assigned; nothing will react to "
                    + "the beam.", this);
            }
        }

        private void OnEnable()
        {
            RenderPipelineManager.beginCameraRendering += OnBeginCameraRendering;
        }

        private void OnDisable()
        {
            RenderPipelineManager.beginCameraRendering -= OnBeginCameraRendering;

            // Leave the world dark rather than frozen at the last pose: a disabled player would
            // otherwise keep a beam painted on every surface that reacts to one.
            Publish(default);
        }

        private void OnBeginCameraRendering(ScriptableRenderContext context, Camera camera)
        {
            if (!m_hasLight || !FlashlightCameraLock.ShouldFollow(camera.cameraType))
            {
                return;
            }

            Publish(Sample());
        }

        private FlashlightBeam Sample()
        {
            Transform beam = m_light.transform;

            // Unity's spotAngle is the full cone; innerSpotAngle is the full angle at which the
            // falloff starts. Both are halved here because the shader compares against the cosine
            // of the angle away from the axis.
            float outerDegrees = Mathf.Min(m_light.spotAngle * 0.5f + m_coneMarginDegrees, 89.9f);
            float innerDegrees = Mathf.Min(m_light.innerSpotAngle * 0.5f, outerDegrees);

            float strength = m_controller != null ? m_controller.BeamStrength : 1f;

            return new FlashlightBeam(
                beam.position,
                beam.forward,
                Mathf.Cos(outerDegrees * Mathf.Deg2Rad),
                Mathf.Cos(innerDegrees * Mathf.Deg2Rad),
                m_light.range,
                m_light.enabled ? Mathf.Clamp01(strength) : 0f);
        }

        private static void Publish(FlashlightBeam beam)
        {
            Beam = beam;

            Shader.SetGlobalVector(k_PositionId, beam.Origin);
            Shader.SetGlobalVector(k_DirectionId, beam.Direction);
            Shader.SetGlobalVector(
                k_ConeId,
                new Vector4(beam.OuterCos, beam.InnerCos, beam.Range, beam.Strength));
        }
    }
}

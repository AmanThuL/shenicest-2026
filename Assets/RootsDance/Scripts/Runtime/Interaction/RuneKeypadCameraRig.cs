using System.Threading;
using Unity.Cinemachine;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// The keypad close-up's camera, on its own. Owns the fixed Cinemachine camera parked in front
    /// of the panel: switching it on and off with the right brain blend, tweening it between its
    /// home pose and the confirm pose, and putting the shared brain's blend back afterwards.
    /// <para>
    /// A plain class built by <see cref="RuneKeypadInteractable"/> in <c>Awake</c>, not a
    /// component: the camera reference stays serialized on the interactable, so the prefab and its
    /// builder are unchanged. The home pose is captured at construction, before anything moves it.
    /// </para>
    /// </summary>
    public sealed class RuneKeypadCameraRig
    {
        private readonly CinemachineCamera m_camera;
        private readonly int m_activePriority;
        private readonly Vector3 m_homePosition;
        private readonly Quaternion m_homeRotation;
        private CinemachineBrain m_brain;
        private CinemachineBlendDefinition m_previousBlend;
        private bool m_hasStoredBlend;

        public RuneKeypadCameraRig(CinemachineCamera camera, int activePriority)
        {
            m_camera = camera;
            m_activePriority = activePriority;

            if (m_camera != null)
            {
                m_homePosition = m_camera.transform.localPosition;
                m_homeRotation = m_camera.transform.localRotation;
            }
        }

        /// <summary>Raises the close-up camera over the first-person one with the given blend.</summary>
        public void Activate(float blendSeconds)
        {
            if (m_camera == null)
            {
                return;
            }

            m_brain = CinemachineCore.FindPotentialTargetBrain(m_camera);
            SetBlendDuration(blendSeconds);
            m_camera.Priority = m_activePriority;
            m_camera.gameObject.SetActive(true);
        }

        /// <summary>Hands the view back with the given blend. The blend is restored by Finish.</summary>
        public void Deactivate(float blendSeconds)
        {
            if (m_camera == null)
            {
                return;
            }

            SetBlendDuration(blendSeconds);
            m_camera.gameObject.SetActive(false);
        }

        /// <summary>Eases the camera to a keypad-local pose, e.g. squarely over the confirm key.</summary>
        public async Awaitable TweenToAsync(Vector3 localPosition, Quaternion localRotation,
            float seconds, CancellationToken cancellationToken)
        {
            if (m_camera == null)
            {
                return;
            }

            Transform cameraTransform = m_camera.transform;
            Vector3 fromPosition = cameraTransform.localPosition;
            Quaternion fromRotation = cameraTransform.localRotation;

            for (float elapsed = 0f; elapsed < seconds; elapsed += Time.unscaledDeltaTime)
            {
                float t = Smooth(elapsed / seconds);
                cameraTransform.localPosition = Vector3.Lerp(fromPosition, localPosition, t);
                cameraTransform.localRotation = Quaternion.Slerp(fromRotation, localRotation, t);
                await Awaitable.NextFrameAsync(cancellationToken);
            }

            cameraTransform.localPosition = localPosition;
            cameraTransform.localRotation = localRotation;
        }

        /// <summary>Eases the camera back to the pose it was authored in.</summary>
        public Awaitable TweenHomeAsync(float seconds, CancellationToken cancellationToken)
        {
            return TweenToAsync(m_homePosition, m_homeRotation, seconds, cancellationToken);
        }

        /// <summary>
        /// Puts the camera back on its home pose and the shared brain back on its own blend. The
        /// last step of every exit path, clean or aborted.
        /// </summary>
        public void Finish()
        {
            if (m_camera != null)
            {
                m_camera.transform.localPosition = m_homePosition;
                m_camera.transform.localRotation = m_homeRotation;
            }

            if (m_brain != null && m_hasStoredBlend)
            {
                m_brain.DefaultBlend = m_previousBlend;
            }

            m_hasStoredBlend = false;
            m_brain = null;
        }

        /// <summary>Cuts the close-up immediately: camera off, pose and blend restored.</summary>
        public void Stop()
        {
            if (m_camera != null)
            {
                m_camera.gameObject.SetActive(false);
            }

            Finish();
        }

        private void SetBlendDuration(float seconds)
        {
            if (m_brain == null)
            {
                return;
            }

            if (!m_hasStoredBlend)
            {
                m_previousBlend = m_brain.DefaultBlend;
                m_hasStoredBlend = true;
            }

            m_brain.DefaultBlend = new CinemachineBlendDefinition(
                CinemachineBlendDefinition.Styles.EaseInOut, seconds);
        }

        private static float Smooth(float t)
        {
            float clamped = Mathf.Clamp01(t);

            return clamped * clamped * (3f - 2f * clamped);
        }
    }
}

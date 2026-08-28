using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Player
{
    /// <summary>
    /// Copies the animated <c>camera</c> bone's bob onto the view. The Blender rig animates its
    /// camera bone (the prone head sits ahead of the shoulders, plus a bob cycle), but Unity's
    /// camera never follows that bone — it follows the Head transform via the Cinemachine
    /// first-person camera. So this measures how far the bone has moved from the reference pose of
    /// whichever clip is playing and shifts the view target by the same amount; the authored bob
    /// moves the view.
    /// <para>
    /// The split with <see cref="ArmsViewOffset"/> is deliberate. A clip's camera bone offset has a
    /// constant part and a time-varying part, and they want opposite treatment: the constant part
    /// must move the <i>arms</i> (moving the view would pop the player's eye at the state cut), the
    /// varying part must move the <i>view</i> (that is the bob). <see cref="ArmsViewOffset"/> owns
    /// the constant part per clip; the remainder lands here.
    /// </para>
    /// Position only, by design: <see cref="PlayerLook"/> owns the view's rotation (yaw on the
    /// player root, pitch on the head), and one owner per axis keeps the view from fighting itself.
    /// References are written by RootsDance > Refresh Arms Framing.
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(Animator))]
    [RequireComponent(typeof(ArmsViewOffset))]
    public class CameraBoneViewBob : MonoBehaviour
    {
        [Header("Tune these")]
        [Tooltip("Scales the whole bob. 1 plays it as authored; 0 disables the effect.")]
        [SerializeField, Range(0f, 2f)] private float m_weight = 1f;

        [Tooltip("Seconds the bob takes to fade in and out as clips with and without an authored "
            + "bob take over. Stops the view snapping back when a bob clip is cut mid-cycle.")]
        [SerializeField] private float m_fadeTime = 0.15f;

        [Header("Wired by RootsDance > Refresh Arms Framing")]
        [Tooltip("The animated bone whose motion becomes the view bob.")]
        [SerializeField] private Transform m_cameraBone;

        [Tooltip("What the Cinemachine camera follows — the head. Its local position is driven.")]
        [SerializeField] private Transform m_viewTarget;

        private ArmsViewOffset m_framing;
        private Vector3 m_viewBaseLocalPosition;
        private float m_smoothedWeight;

        private void Awake()
        {
            m_framing = GetComponent<ArmsViewOffset>();

            if (m_viewTarget == null)
            {
                m_viewTarget = transform.parent;
            }

            if (m_cameraBone == null)
            {
                m_cameraBone = FindDeep(transform, "camera");
            }

            if (m_cameraBone == null || m_viewTarget == null)
            {
                Log.Warning("CameraBoneViewBob: references missing; run RootsDance > Refresh Arms Framing.", this);
            }

            if (m_viewTarget != null)
            {
                m_viewBaseLocalPosition = m_viewTarget.localPosition;
            }
        }

        // LateUpdate reads the bones after this frame's Animator evaluation, so the view never
        // trails the arms by a frame. ArmsViewOffset resolved the current blend back in Update,
        // so both components agree on which clip's reference is in force this frame.
        private void LateUpdate()
        {
            if (m_cameraBone == null || m_viewTarget == null || m_framing == null)
            {
                return;
            }

            float targetWeight = m_framing.ResolvedAnimatesCameraBone ? m_weight : 0f;
            float t = m_fadeTime <= 0f ? 1f : 1f - Mathf.Exp(-Time.deltaTime / m_fadeTime);
            m_smoothedWeight = Mathf.Lerp(m_smoothedWeight, targetWeight, t);

            // InverseTransformPoint cancels the arms root's own pose, so this measures the bone's
            // animated motion alone; the arms-root rotation then carries it into the head frame.
            Vector3 boneInRoot = transform.InverseTransformPoint(m_cameraBone.position);
            Vector3 deltaInRoot = boneInRoot - m_framing.ResolvedReferenceBonePosition;
            Vector3 deltaInView = transform.localRotation * deltaInRoot;

            m_viewTarget.localPosition = m_viewBaseLocalPosition + deltaInView * m_smoothedWeight;
        }

        private static Transform FindDeep(Transform parent, string name)
        {
            if (parent.name == name)
            {
                return parent;
            }

            foreach (Transform child in parent)
            {
                Transform found = FindDeep(child, name);

                if (found != null)
                {
                    return found;
                }
            }

            return null;
        }
    }
}

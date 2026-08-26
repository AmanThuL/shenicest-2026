using System;
using System.Collections.Generic;
using UnityEngine;

namespace RootsDance.Player
{
    /// <summary>
    /// Framing control for the first-person arms: the one place that decides where the arms sit
    /// relative to the eye.
    /// <para>
    /// Three things are added together, and they are kept apart on purpose because they have three
    /// different owners:
    /// </para>
    /// <list type="bullet">
    /// <item><b>anchor</b> (<see cref="m_basePosition"/>) — puts the rig's bind-pose <c>camera</c>
    /// bone on the head pivot. Written once by the rig builder.</item>
    /// <item><b>per-clip correction</b> (<see cref="ClipFraming.m_correction"/>) — cancels the eye
    /// drift a specific clip bakes into the camera bone. Every clip needs its own: the crawl cycle
    /// pushes the prone head 0.2 m ahead of the shoulders, the helmet clip does not move the bone at
    /// all. Written by the rig builder, one entry per Animator state.</item>
    /// <item><b>taste</b> (<see cref="m_positionOffset"/> globally,
    /// <see cref="ClipFraming.m_tweak"/> per clip) — yours. The rig builder never overwrites these,
    /// so re-running it cannot destroy hand-tuned framing.</item>
    /// </list>
    /// <para>
    /// Runs with <c>[ExecuteAlways]</c> so the Scene and Game views update while values are dragged,
    /// without entering Play mode. Outside Play mode the Animator has no meaningful state, so the
    /// clip named in <see cref="m_previewState"/> is used instead — that is how a single clip's
    /// framing gets judged in the Scene view.
    /// </para>
    /// The Animator drives the bones underneath this object, not this Transform, so writing the
    /// local pose here is safe.
    /// </summary>
    [ExecuteAlways]
    [DisallowMultipleComponent]
    public class ArmsViewOffset : MonoBehaviour
    {
        /// <summary>Framing for one Animator state. One entry per state that has a clip.</summary>
        [Serializable]
        public struct ClipFraming
        {
            [Tooltip("Animator state in the base layer that this framing belongs to.")]
            public string m_stateName;

            [Tooltip("Rig builder writes this. Cancels the eye drift the clip bakes into the camera "
                + "bone, so the authored eye lands on the head pivot. Do not hand-edit — it is "
                + "recomputed from the clip every time the rig is built.")]
            public Vector3 m_correction;

            [Tooltip("Rig builder writes this. Camera bone position in the arms-root frame at the "
                + "clip's frame 0; CameraBoneViewBob measures the authored bob against it.")]
            public Vector3 m_referenceBonePosition;

            [Tooltip("Rig builder writes this. False when the clip leaves the camera bone at bind "
                + "pose, which means the clip has no bob to drive the view with.")]
            public bool m_animatesCameraBone;

            [Tooltip("Yours. Extra framing for this clip only, on top of the shared offset below. "
                + "The rig builder preserves it.")]
            public Vector3 m_tweak;
        }

        [Header("Tune these — apply to every clip")]
        [Tooltip("Metres. +Z pushes the arms away from the eye, -Z pulls them closer "
            + "(closer = shorter-looking arms). +Y raises them, +X moves them right.")]
        [SerializeField] private Vector3 m_positionOffset;

        [Tooltip("Degrees, applied on top of the anchored rotation.")]
        [SerializeField] private Vector3 m_rotationOffset;

        [Header("Tune these — per clip")]
        [Tooltip("One entry per Animator state. Tune 'm_tweak'; the other fields are written by "
            + "RootsDance > Refresh Arms Framing.")]
        [SerializeField] private List<ClipFraming> m_clips = new List<ClipFraming>();

        [Tooltip("Which clip's framing to show in the Scene view outside Play mode. Ignored while "
            + "playing — the Animator's own state wins there.")]
        [SerializeField] private string m_previewState;

        [Header("Anchor (written by RootsDance > Refresh Arms Framing)")]
        [Tooltip("Local position that places the rig's bind-pose eye on the head pivot.")]
        [SerializeField] private Vector3 m_basePosition;

        [Tooltip("Local euler rotation of the anchored rig.")]
        [SerializeField] private Vector3 m_baseRotation;

        [Tooltip("Camera bone position in the arms-root frame at bind pose. Used as the bob "
            + "reference for any state with no entry above, so an unregistered clip cannot throw "
            + "the view across the room.")]
        [SerializeField] private Vector3 m_bindBonePosition;

        private Animator m_animator;
        private Dictionary<int, int> m_indexByStateHash;

        // Resolved once per frame in Apply() so CameraBoneViewBob (LateUpdate) reads exactly the
        // same blend this Transform was posed with. Update always runs before LateUpdate.
        private Vector3 m_resolvedReferenceBone;
        private bool m_resolvedAnimatesCameraBone;

        /// <summary>Local pose the offsets are measured from.</summary>
        public Vector3 BasePosition
        {
            get { return m_basePosition; }
            set { m_basePosition = value; }
        }

        public Vector3 BaseRotation
        {
            get { return m_baseRotation; }
            set { m_baseRotation = value; }
        }

        public Vector3 PositionOffset
        {
            get { return m_positionOffset; }
            set { m_positionOffset = value; }
        }

        public Vector3 RotationOffset
        {
            get { return m_rotationOffset; }
            set { m_rotationOffset = value; }
        }

        public Vector3 BindBonePosition
        {
            get { return m_bindBonePosition; }
            set { m_bindBonePosition = value; }
        }

        public string PreviewState
        {
            get { return m_previewState; }
            set { m_previewState = value; }
        }

        /// <summary>
        /// The per-clip table. The rig builder rewrites the machine-derived fields in place and
        /// carries <see cref="ClipFraming.m_tweak"/> across, so editing this list from the editor
        /// tooling is the supported path.
        /// </summary>
        public List<ClipFraming> Clips
        {
            get { return m_clips; }
        }

        /// <summary>Camera bone reference for the state playing this frame, transitions blended.</summary>
        public Vector3 ResolvedReferenceBonePosition
        {
            get { return m_resolvedReferenceBone; }
        }

        /// <summary>Whether the state playing this frame has an authored bob to contribute.</summary>
        public bool ResolvedAnimatesCameraBone
        {
            get { return m_resolvedAnimatesCameraBone; }
        }

        /// <summary>Call after the table changes so the state-name lookup matches it again.</summary>
        public void RebuildLookup()
        {
            m_indexByStateHash = new Dictionary<int, int>();

            if (m_clips == null)
            {
                return;
            }

            for (int i = 0; i < m_clips.Count; i++)
            {
                string stateName = m_clips[i].m_stateName;

                if (string.IsNullOrEmpty(stateName))
                {
                    continue;
                }

                m_indexByStateHash[Animator.StringToHash(stateName)] = i;
            }
        }

        private void OnEnable()
        {
            m_animator = GetComponent<Animator>();
            RebuildLookup();
            Apply();
        }

        private void Update()
        {
            Apply();
        }

        private void OnValidate()
        {
            m_animator = GetComponent<Animator>();
            RebuildLookup();
            Apply();
        }

        private void Apply()
        {
            Vector3 framing = Resolve();

            transform.localPosition = m_basePosition + m_positionOffset + framing;
            transform.localRotation = Quaternion.Euler(m_baseRotation + m_rotationOffset);
        }

        /// <summary>
        /// Picks the framing for whatever is playing, and caches the bob reference alongside it.
        /// During an Animator transition both states' entries are blended by the transition's own
        /// progress, so the arms slide between two clips' framings instead of snapping at the cut.
        /// </summary>
        private Vector3 Resolve()
        {
            m_resolvedReferenceBone = m_bindBonePosition;
            m_resolvedAnimatesCameraBone = false;

            if (m_clips == null || m_clips.Count == 0)
            {
                return Vector3.zero;
            }

            if (m_indexByStateHash == null)
            {
                RebuildLookup();
            }

            // Edit mode: GetCurrentAnimatorStateInfo is meaningless, so preview one named clip.
            if (!Application.isPlaying || m_animator == null
                || m_animator.runtimeAnimatorController == null)
            {
                if (TryGet(Animator.StringToHash(m_previewState), out ClipFraming preview))
                {
                    m_resolvedReferenceBone = preview.m_referenceBonePosition;
                    m_resolvedAnimatesCameraBone = preview.m_animatesCameraBone;
                    return preview.m_correction + preview.m_tweak;
                }

                return Vector3.zero;
            }

            bool hasCurrent = TryGet(
                m_animator.GetCurrentAnimatorStateInfo(0).shortNameHash, out ClipFraming current);

            if (!m_animator.IsInTransition(0))
            {
                if (!hasCurrent)
                {
                    return Vector3.zero;
                }

                m_resolvedReferenceBone = current.m_referenceBonePosition;
                m_resolvedAnimatesCameraBone = current.m_animatesCameraBone;
                return current.m_correction + current.m_tweak;
            }

            bool hasNext = TryGet(
                m_animator.GetNextAnimatorStateInfo(0).shortNameHash, out ClipFraming next);
            float t = Mathf.Clamp01(m_animator.GetAnimatorTransitionInfo(0).normalizedTime);

            Vector3 from = hasCurrent ? current.m_correction + current.m_tweak : Vector3.zero;
            Vector3 to = hasNext ? next.m_correction + next.m_tweak : Vector3.zero;

            m_resolvedReferenceBone = Vector3.Lerp(
                hasCurrent ? current.m_referenceBonePosition : m_bindBonePosition,
                hasNext ? next.m_referenceBonePosition : m_bindBonePosition,
                t);
            m_resolvedAnimatesCameraBone = (hasCurrent && current.m_animatesCameraBone)
                || (hasNext && next.m_animatesCameraBone);

            return Vector3.Lerp(from, to, t);
        }

        private bool TryGet(int stateHash, out ClipFraming entry)
        {
            entry = default;

            if (m_indexByStateHash == null
                || !m_indexByStateHash.TryGetValue(stateHash, out int index)
                || index < 0 || index >= m_clips.Count)
            {
                return false;
            }

            entry = m_clips[index];
            return true;
        }

        /// <summary>Folds the shared offset into the anchor and zeroes it.</summary>
        [ContextMenu("Bake Shared Offset Into Anchor")]
        private void BakeOffsetIntoAnchor()
        {
            m_basePosition += m_positionOffset;
            m_baseRotation += m_rotationOffset;
            m_positionOffset = Vector3.zero;
            m_rotationOffset = Vector3.zero;
            Apply();
        }

        [ContextMenu("Clear Shared Offset")]
        private void ClearOffset()
        {
            m_positionOffset = Vector3.zero;
            m_rotationOffset = Vector3.zero;
            Apply();
        }
    }
}

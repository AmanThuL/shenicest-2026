using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// Rides the scanner prop on the arms rig's <c>hand.L</c> bone without inheriting the bone's
    /// scale.
    /// <para>
    /// <c>hand.L</c>'s position and rotation import correctly — they match the Blender rig exactly
    /// — but its decomposed local scale does not: baking axis and unit conversion through a chain
    /// of arbitrarily-rotated (Blender bone-roll) joints leaves <c>forearm.L</c>/<c>hand.L</c> with
    /// a non-uniform residual scale that is a decomposition artifact, not a real deformation (the
    /// skinned arms mesh renders fine because GPU skinning uses the full bone matrix, not this
    /// decomposition). A rigid prop parented the ordinary way inherits that artifact directly and
    /// renders visibly sheared. Tracking position and rotation from the bone but supplying a fixed,
    /// independently-authored world scale sidesteps it entirely.
    /// </para>
    /// <see cref="m_holdPositionOffset"/>/<see cref="m_holdRotationOffset"/>/
    /// <see cref="m_holdWorldScale"/> come from the CHILD_OF-constrained <c>GameScanner</c> empty in
    /// <c>SourceArt/Blender/ArmsRig/arms_rig_all.blend</c> (docs/architecture/contracts/手臂动画状态机.md
    /// — "其物体级变换就是握持偏移"), measured by literally bone-parenting a stand-in mesh onto
    /// <c>hand.L</c> in Blender and reading Unity's own baked transform back through the project's
    /// real Blender→FBX→Unity pipeline (fps_arms profile) — see <see cref="RootsDance.Editor.Tools.
    /// ScannerTestRigBuilder"/> for the exact reproduction steps.
    /// </summary>
    [ExecuteAlways]
    [DisallowMultipleComponent]
    public class ScannerHandSocket : MonoBehaviour
    {
        [Tooltip("The hand.L bone this prop rides on.")]
        [SerializeField] private Transform m_handBone;

        [Tooltip("Grip offset from the bone origin, in the bone's own rotated axes, in metres.")]
        [SerializeField] private Vector3 m_holdPositionOffset;

        [Tooltip("Grip orientation relative to the bone's own rotation.")]
        [SerializeField] private Quaternion m_holdRotationOffset = Quaternion.identity;

        [Tooltip("Fixed world scale. Independent of the bone's scale on purpose — see class summary.")]
        [SerializeField] private Vector3 m_holdWorldScale = Vector3.one;

        private void LateUpdate()
        {
            if (m_handBone == null)
            {
                return;
            }

            transform.SetPositionAndRotation(
                m_handBone.position + m_handBone.rotation * m_holdPositionOffset,
                m_handBone.rotation * m_holdRotationOffset);
            transform.localScale = m_holdWorldScale;
        }

        public void Configure(Transform handBone, Vector3 holdPositionOffset,
            Quaternion holdRotationOffset, Vector3 holdWorldScale)
        {
            m_handBone = handBone;
            m_holdPositionOffset = holdPositionOffset;
            m_holdRotationOffset = holdRotationOffset;
            m_holdWorldScale = holdWorldScale;
        }
    }
}

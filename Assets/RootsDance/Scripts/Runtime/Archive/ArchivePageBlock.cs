using System;
using UnityEngine;

namespace RootsDance.Archive
{
    /// <summary>
    /// One thing on the sheet and the rect that draws it: the block it is, the object to move, and
    /// the pale wash that goes under it. Serialized as a list on the page so the prefab is built
    /// once and re-arranged per document kind, rather than there being a prefab per kind.
    /// </summary>
    [Serializable]
    public class ArchivePageBlock
    {
        [Tooltip("Which thing on the sheet this is.")]
        [SerializeField] private ArchivePageLayout.Block m_block;

        [Tooltip("The rect that gets moved to the block's place on the sheet.")]
        [SerializeField] private RectTransform m_target;

        [Tooltip("Optional pale patch laid under the block. Moved and sized with it.")]
        [SerializeField] private RectTransform m_wash;

        public ArchivePageLayout.Block Block => m_block;

        public RectTransform Target => m_target;

        public RectTransform Wash => m_wash;

        /// <summary>
        /// Builds a binding from plain values. The fields are private and serialized, so this is
        /// how anything outside Unity's own deserializer — the prefab builder, a test — makes one.
        /// </summary>
        public static ArchivePageBlock Create(ArchivePageLayout.Block block, RectTransform target,
            RectTransform wash)
        {
            return new ArchivePageBlock { m_block = block, m_target = target, m_wash = wash };
        }
    }
}

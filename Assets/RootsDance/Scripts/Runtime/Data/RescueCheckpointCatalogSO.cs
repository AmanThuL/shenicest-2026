using System;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Data
{
    /// <summary>Generated player checkpoint data. Disable explicitly before a public release.</summary>
    public sealed class RescueCheckpointCatalogSO : ScriptableObject
    {
        [SerializeField, TitleGroup("Basic Info")]
        [Tooltip("Allow the hidden rescue panel in ordinary player builds as well as Development Builds.")]
        private bool m_enabledInPlayer = true;

        [SerializeField, TitleGroup("Scene Change"), Required, ReadOnly]
        [Tooltip("Generated from Dev Play assets. Refresh through Tools > RootsDance > Dev Play.")]
        private RescueCheckpoint[] m_checkpoints = Array.Empty<RescueCheckpoint>();

        public bool EnabledInPlayer => m_enabledInPlayer;
        public IReadOnlyList<RescueCheckpoint> Checkpoints => m_checkpoints;

        /// <summary>Editor generation only; preserves the separately authored player enable switch.</summary>
        public void ReplaceCheckpoints(IReadOnlyList<RescueCheckpoint> checkpoints)
        {
            m_checkpoints = new RescueCheckpoint[checkpoints == null ? 0 : checkpoints.Count];
            for (int i = 0; i < m_checkpoints.Length; i++)
            {
                m_checkpoints[i] = checkpoints[i];
            }
        }
    }
}

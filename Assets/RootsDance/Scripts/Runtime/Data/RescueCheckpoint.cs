using System;
using System.Collections.Generic;
using RootsDance.Core;
using RootsDance.Investigation;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Data
{
    /// <summary>A player-safe snapshot exported from an Editor Dev Play checkpoint.</summary>
    [Serializable]
    public sealed class RescueCheckpoint
    {
        [SerializeField, ValidateInput(nameof(IsValidId)), ReadOnly] private string m_id;
        [SerializeField, ReadOnly] private string m_label;
        [SerializeField, Required, AssetsOnly, ReadOnly] private LevelSO m_level;
        [SerializeField, ReadOnly] private string m_anchorName;
        [SerializeField, ReadOnly] private Vector3 m_position;
        [SerializeField, ReadOnly] private float m_yaw;
        [SerializeField, ReadOnly] private bool m_snapToGround;
        [SerializeField, ReadOnly] private LayerMask m_groundLayers;
        [SerializeField, ReadOnly] private float m_groundClearance;
        [SerializeField, ReadOnly] private bool m_useAnchorHeight;
        [SerializeField, ReadOnly] private bool m_overrideTimeOfDay;
        [SerializeField, ReadOnly] private TimeOfDay m_timeOfDay;
        [SerializeField, ReadOnly] private string[] m_flags = Array.Empty<string>();
        [SerializeField, Required, AssetsOnly, ReadOnly]
        private InvestigationTargetSO[] m_recordedTargets = Array.Empty<InvestigationTargetSO>();

        public string Id => m_id;
        public string Label => m_label;
        public LevelSO Level => m_level;
        public string AnchorName => m_anchorName;
        public Vector3 Position => m_position;
        public float Yaw => m_yaw;
        public bool SnapToGround => m_snapToGround;
        public LayerMask GroundLayers => m_groundLayers;
        public float GroundClearance => m_groundClearance;
        public bool UseAnchorHeight => m_useAnchorHeight;
        public bool OverrideTimeOfDay => m_overrideTimeOfDay;
        public TimeOfDay TimeOfDay => m_timeOfDay;
        public IReadOnlyList<string> Flags => m_flags;
        public IReadOnlyList<InvestigationTargetSO> RecordedTargets => m_recordedTargets;

        public RescueCheckpoint(
            string id, string label, LevelSO level, string anchorName, Vector3 position, float yaw,
            bool overrideTimeOfDay, TimeOfDay timeOfDay, IReadOnlyList<string> flags,
            IReadOnlyList<InvestigationTargetSO> recordedTargets, bool snapToGround = true,
            int groundLayerMask = 1 << 8, float groundClearance = 0.05f, bool useAnchorHeight = true)
        {
            m_id = id;
            m_label = label;
            m_level = level;
            m_anchorName = anchorName;
            m_position = position;
            m_yaw = yaw;
            m_overrideTimeOfDay = overrideTimeOfDay;
            m_timeOfDay = timeOfDay;
            m_flags = CopyItems(flags);
            m_recordedTargets = CopyItems(recordedTargets);
            m_snapToGround = snapToGround;
            m_groundLayers = groundLayerMask;
            m_groundClearance = groundClearance;
            m_useAnchorHeight = useAnchorHeight;
        }

        /// <summary>Export IDs use Unity's stable, 32-character asset GUID representation.</summary>
        public static bool IsValidId(string value)
        {
            return value != null && value.Length == 32 && Guid.TryParseExact(value, "N", out _);
        }

        private static T[] CopyItems<T>(IReadOnlyList<T> items)
        {
            if (items == null)
            {
                return Array.Empty<T>();
            }

            var copy = new T[items.Count];
            for (int i = 0; i < items.Count; i++)
            {
                copy[i] = items[i];
            }

            return copy;
        }
    }
}

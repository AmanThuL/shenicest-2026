using System.Collections.Generic;
using UnityEngine;

namespace RootsDance.Player.Arms
{
    /// <summary>
    /// Every arms action the player rig can perform, in one list. This asset is the single tuning
    /// surface asked for by the arms pipeline: one row per animation, and the same rows drive the
    /// runtime (<see cref="ArmsDirector"/>), the generated Animator controller
    /// (<c>RootsDance > Build Arms Controller</c>) and the debug keys
    /// (<see cref="ArmsDebugConsole"/>). There is no second place where an animation is registered,
    /// so tuning one cannot leave another behind.
    /// </summary>
    [CreateAssetMenu(fileName = "PlayerArmsActions", menuName = "RootsDance/Arms/Action Set")]
    public class ArmsActionSetSO : ScriptableObject
    {
        [Tooltip("Every action. Order is only cosmetic — lookups go by id.")]
        [SerializeField] private List<ArmsActionSO> m_actions = new List<ArmsActionSO>();

        [Tooltip("The looping action the base layer falls back to: the neutral pose, forearms down. "
            + "Also the state the rig starts in.")]
        [SerializeField] private ArmsActionSO m_neutral;

        [Tooltip("Names of the generated Animator layers, base first. Must be three entries.")]
        [SerializeField] private string[] m_layerNames = { "Base", "LeftArm", "RightArm" };

        [Tooltip("Empty state placed on each masked layer so it has something to sit on at weight 0.")]
        [SerializeField] private string m_emptyStateName = "Empty";

        private Dictionary<string, ArmsActionSO> m_byId;

        public IReadOnlyList<ArmsActionSO> Actions => m_actions;
        public ArmsActionSO Neutral => m_neutral;
        public string EmptyStateName => m_emptyStateName;

        public string LayerName(int layer)
        {
            if (m_layerNames == null || layer < 0 || layer >= m_layerNames.Length)
            {
                return "Layer" + layer;
            }

            return m_layerNames[layer];
        }

        /// <summary>Finds an action by id. Returns null when the id is unknown or blank.</summary>
        public ArmsActionSO Find(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return null;
            }

            if (m_byId == null)
            {
                RebuildLookup();
            }

            return m_byId.TryGetValue(id, out ArmsActionSO action) ? action : null;
        }

        /// <summary>Call after the list changes so the id lookup matches it again.</summary>
        public void RebuildLookup()
        {
            m_byId = new Dictionary<string, ArmsActionSO>();

            for (int i = 0; i < m_actions.Count; i++)
            {
                ArmsActionSO action = m_actions[i];

                if (action == null || string.IsNullOrEmpty(action.Id))
                {
                    continue;
                }

                m_byId[action.Id] = action;
            }
        }

        private void OnEnable()
        {
            RebuildLookup();
        }

        private void OnValidate()
        {
            RebuildLookup();
        }
    }
}

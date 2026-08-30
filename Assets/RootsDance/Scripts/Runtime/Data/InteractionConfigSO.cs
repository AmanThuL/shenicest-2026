using UnityEngine;

namespace RootsDance.Data
{
    /// <summary>Reach and filtering of the centre-screen interaction ray.</summary>
    [CreateAssetMenu(fileName = "InteractionConfig", menuName = "RootsDance/Config/Interaction")]
    public class InteractionConfigSO : ScriptableObject
    {
        [Tooltip("How far the player can reach, in metres.")]
        [SerializeField] private float m_range = 3f;

        [Tooltip("Layers the interaction ray may hit. Interactables live on their own layer.")]
        [SerializeField] private LayerMask m_interactableLayers = ~0;

        [Tooltip("Whether the ray should stop on trigger colliders.")]
        [SerializeField] private QueryTriggerInteraction m_triggerInteraction = QueryTriggerInteraction.Ignore;

        public float Range => m_range;
        public LayerMask InteractableLayers => m_interactableLayers;
        public QueryTriggerInteraction TriggerInteraction => m_triggerInteraction;
    }
}

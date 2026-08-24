using UnityEngine;

namespace RootsDance.Narrative
{
    /// <summary>An ordered radio transmission, authored by the writer under Data/Narrative/.</summary>
    [CreateAssetMenu(fileName = "RadioSequence", menuName = "RootsDance/Narrative/Radio Sequence")]
    public class RadioSequenceSO : ScriptableObject
    {
        [SerializeField] private RadioLine[] m_lines;

        [Tooltip("Seconds before the first line, counted from the trigger.")]
        [SerializeField] private float m_startDelay = 0.5f;

        public RadioLine[] Lines => m_lines;
        public float StartDelay => m_startDelay;
    }
}

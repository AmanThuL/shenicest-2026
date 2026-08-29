using RootsDance.Audio;
using RootsDance.Data;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Narrative
{
    /// <summary>
    /// An ordered radio transmission, authored by the writer under <c>Data/Narrative/</c>.
    /// <para>
    /// A transmission is deliberately not a <see cref="RootsDance.Dialogue.DialogueSO"/>: it has no
    /// options and the player never answers it — mission control is talking into a helmet. What it
    /// has instead is a signal that can degrade and then fail, which is the whole point of the beat
    /// it serves.
    /// </para>
    /// </summary>
    [CreateAssetMenu(fileName = "RadioSequence", menuName = "RootsDance/Narrative/Radio Sequence")]
    [TypeInfoBox("One radio transmission. Lines play in order; each carries its own recording. IDs "
        + "follow RAD-001.")]
    public class RadioSequenceSO : ScriptableObject
    {
        // ---- Basic Info -------------------------------------------------------------------------
        [SerializeField, TitleGroup("Basic Info")]
        [ValidateInput("IsValidId", "Use the form RAD-001.")]
        [Tooltip("Stable id, for example RAD-001. Empty is tolerated on the transmissions that "
            + "predate the id scheme.")]
        private string m_id;

        [SerializeField, TitleGroup("Basic Info")]
        [Tooltip("What this transmission is, for the person scrolling the folder: 出发简报, 信号中断.")]
        private string m_title;

        // ---- Result -----------------------------------------------------------------------------
        [SerializeField, TitleGroup("Result")]
        [Tooltip("The lines, in order.")]
        private RadioLine[] m_lines = new RadioLine[0];

        [SerializeField, TitleGroup("Result"), Min(0f)]
        [Tooltip("Seconds before the first line, counted from the trigger.")]
        private float m_startDelay = 0.5f;

        // ---- Interaction ------------------------------------------------------------------------
        [SerializeField, TitleGroup("Interaction")]
        [Tooltip("The cue that mixes this transmission — group, volume, spatial blend. One cue "
            + "serves every line; the recordings live on the lines. Empty plays the subtitles "
            + "silently.")]
        private AudioCueSO m_voiceCue;

        public string Id => m_id;
        public string Title => m_title;
        public RadioLine[] Lines => m_lines;
        public float StartDelay => m_startDelay;
        public AudioCueSO VoiceCue => m_voiceCue;

        [Button("Fill Id From Asset Name"), ButtonGroup("Basic Info/Tools")]
        private void FillIdFromAssetName()
        {
            m_id = ContentId.FromAssetName(name);
        }

        private static bool IsValidId(string value)
        {
            return string.IsNullOrEmpty(value) || ContentId.IsValid(value);
        }
    }
}

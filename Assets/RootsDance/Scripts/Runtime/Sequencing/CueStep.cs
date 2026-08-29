using System;
using RootsDance.Audio;
using RootsDance.Dialogue;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Sequencing
{
    /// <summary>
    /// One step of a scripted moment. Which fields matter depends on
    /// <see cref="CueStepKind"/>; Odin hides the rest so a row reads as one instruction.
    /// </summary>
    [Serializable]
    public class CueStep
    {
        [SerializeField, HorizontalGroup("Row", 110f), HideLabel]
        private CueStepKind m_kind = CueStepKind.Wait;

        [SerializeField, HorizontalGroup("Row"), LabelWidth(60f), Min(0f)]
        [Tooltip("Seconds before the next step. Every kind has one, so a beat can be given room "
            + "without adding a Wait row after it.")]
        private float m_delay = 0.5f;

        [SerializeField, ShowIf("m_kind", CueStepKind.RaiseFlag)]
        [Tooltip("The flag id, exactly as RootsDance.Core.WorldFlags or the trigger spells it.")]
        private string m_flagId;

        [SerializeField, ShowIf("m_kind", CueStepKind.SetActive)]
        private GameObject m_target;

        [SerializeField, ShowIf("m_kind", CueStepKind.SetActive)]
        [Tooltip("On switches the target on; off switches it off.")]
        private bool m_isActive = true;

        [SerializeField, ShowIf("m_kind", CueStepKind.PlayAudio)]
        private AudioCueSO m_cue;

        [SerializeField, ShowIf("m_kind", CueStepKind.PlayAudio)]
        [Tooltip("Empty plays flat, at the listener. Otherwise the cue sounds from here.")]
        private Transform m_cueSource;

        [SerializeField, ShowIf("m_kind", CueStepKind.PlayDialogue)]
        private DialogueSO m_conversation;

        public CueStepKind Kind => m_kind;
        public float Delay => m_delay;
        public string FlagId => m_flagId;
        public GameObject Target => m_target;
        public bool IsActive => m_isActive;
        public AudioCueSO Cue => m_cue;
        public Transform CueSource => m_cueSource;
        public DialogueSO Conversation => m_conversation;
    }
}

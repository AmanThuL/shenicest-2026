using System;
using UnityEngine;

namespace RootsDance.Narrative
{
    /// <summary>One radio line and how long the player reads it before the next one arrives.</summary>
    [Serializable]
    public struct RadioLine
    {
        [TextArea(1, 4)]
        [SerializeField] private string m_text;

        [Tooltip("Seconds this line stays up before the next one.")]
        [SerializeField] private float m_holdSeconds;

        public string Text => m_text;
        public float HoldSeconds => m_holdSeconds;
    }
}

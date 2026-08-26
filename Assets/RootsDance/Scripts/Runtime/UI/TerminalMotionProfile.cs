using System;
using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// Timing knobs for <see cref="TerminalMotion"/>, serialized on whichever presenter drives the
    /// motion. Kept as a plain serializable class rather than a ScriptableObject so a presenter can
    /// be dropped into a scene with no asset wiring; promote it to an SO under
    /// <c>Assets/RootsDance/Data/Config/</c> once several screens need to share one tuning.
    /// </summary>
    [Serializable]
    public class TerminalMotionProfile
    {
        /// <summary>Floor on the refresh step so a sequence always has a non-zero duration.</summary>
        private const float k_MinStepSeconds = 0.001f;

        [Tooltip("Nominal terminal refresh step. Every interval below is a multiple of this.")]
        [SerializeField] private float m_stepSeconds = 1f / 15f;

        [Tooltip("How many terminal steps a one-off flash stays inverted.")]
        [SerializeField] private int m_flashSteps = 2;

        [Tooltip("Characters revealed per step by TerminalWrite. Chunked, never one-by-one.")]
        [SerializeField] private int m_writeChunkSize = 4;

        [Tooltip("How many scrambled values a readout shows before it settles on the real one.")]
        [SerializeField] private int m_jitterSteps = 4;

        [Tooltip("Terminal steps the opening raster bands are held before the image arrives (P1).")]
        [SerializeField] private int m_rasterHoldSteps = 6;

        [Tooltip("Steps Reconstruct takes to bring block coverage from its start value to full (P3-P4).")]
        [SerializeField] private int m_reconstructSteps = 12;

        [Tooltip("Block coverage the image arrives at, before Reconstruct resolves the rest (P2).")]
        [Range(0f, 1f)]
        [SerializeField] private float m_reconstructStartCoverage = 0.4f;

        public float StepSeconds => Mathf.Max(k_MinStepSeconds, m_stepSeconds);

        public int FlashSteps => Mathf.Max(0, m_flashSteps);

        public int WriteChunkSize => Mathf.Max(1, m_writeChunkSize);

        public int JitterSteps => Mathf.Max(0, m_jitterSteps);

        public int RasterHoldSteps => Mathf.Max(1, m_rasterHoldSteps);

        public int ReconstructSteps => Mathf.Max(1, m_reconstructSteps);

        public float ReconstructStartCoverage => Mathf.Clamp01(m_reconstructStartCoverage);
    }
}

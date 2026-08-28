using System.Collections.Generic;
using CurvedUIUtility;
using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// Keeps the visor's readouts curved at runtime.
    /// <para>
    /// The curve library applies the curve at most once per frame, guarded by
    /// <see cref="ICurveable.HasCurvedThisFrame"/>. On the frame a readout first resolves its
    /// controller it curves itself immediately; if TextMeshPro then rebuilds that same text later
    /// in the frame, the rebuild's own attempt is refused by the guard and the freshly built, flat
    /// mesh is what stays on the canvas renderer. Nothing re-triggers it afterwards: a static HUD
    /// never moves and never changes its character count, which are the library's only other
    /// triggers. In the Editor it self-heals, because edit-mode rendering marks the graphics dirty
    /// every frame — which is exactly why the HUD looked curved there and flat in a build.
    /// </para>
    /// <para>
    /// Re-asserting also re-reads the canvas size, so a curve computed against the size the canvas
    /// had before the scaler settled cannot survive: a readout caught in that state measured about
    /// a quarter of its authored tilt, which is what "the HUD is flat in a build" looks like.
    /// </para>
    /// <para>
    /// Honest limit: the flat state is intermittent and was not reproducible on demand, so this
    /// removes the whole class of stale-curve failures by construction rather than being proven
    /// against a captured repro. Turn on <c>m_logCurvatureChanges</c> if it is ever seen again —
    /// the line it prints names the canvas size the curve was computed against.
    /// </para>
    /// <para>
    /// Cost: one refill of a few small meshes per frame, allocating nothing once the vertex lists
    /// have grown.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(Canvas))]
    public class CurvedHudKeeper : MonoBehaviour
    {
        [Tooltip("Logs a line whenever the readouts' curvature changes, naming the canvas size it "
            + "was computed against. For diagnosing a flat HUD; leave off otherwise.")]
        [SerializeField] private bool m_logCurvatureChanges;

        // Held as MonoBehaviour rather than ICurveable so the destroyed-object check still works:
        // an interface reference to a dead Unity object does not compare equal to null.
        private readonly List<MonoBehaviour> m_curveables = new List<MonoBehaviour>();

        private float m_lastLoggedSlope = float.NaN;

        private void OnEnable()
        {
            Refresh();
        }

        /// <summary>Re-scans the canvas. Call after adding or removing curved widgets.</summary>
        public void Refresh()
        {
            m_curveables.Clear();

            foreach (MonoBehaviour behaviour in GetComponentsInChildren<MonoBehaviour>(true))
            {
                if (behaviour is ICurveable)
                {
                    m_curveables.Add(behaviour);
                }
            }
        }

        private void LateUpdate()
        {
            for (int i = 0; i < m_curveables.Count; i++)
            {
                MonoBehaviour behaviour = m_curveables[i];

                if (behaviour == null || !behaviour.isActiveAndEnabled)
                {
                    continue;
                }

                ICurveable curveable = (ICurveable)behaviour;

                // Clearing the guard is the whole trick: it is what the library sets to refuse a
                // second curve in one frame, and the refused one is the one that mattered.
                curveable.HasCurvedThisFrame = false;
                curveable.UpdateCurvature();
            }

            if (m_logCurvatureChanges)
            {
                ReportCurvatureChange();
            }
        }

        /// <summary>
        /// Prints the curvature and the canvas it was measured against, but only when it moves, so
        /// a session's log holds one line per change rather than one per frame.
        /// </summary>
        private void ReportCurvatureChange()
        {
            float slope = MeasureSlope();

            if (Mathf.Abs(slope - m_lastLoggedSlope) < 0.02f)
            {
                return;
            }

            m_lastLoggedSlope = slope;
            var canvas = (RectTransform)transform;
            Debug.Log($"CurvedHudKeeper: curvature now {slope:F3} on a {canvas.rect.size} canvas.", this);
        }

        /// <summary>Slope of the first curved readout's mesh — a cheap stand-in for "how curved".</summary>
        private float MeasureSlope()
        {
            for (int i = 0; i < m_curveables.Count; i++)
            {
                var text = m_curveables[i] as TMPro.TMP_Text;

                if (text == null || text.mesh == null)
                {
                    continue;
                }

                Vector3[] vertices = text.mesh.vertices;

                if (vertices.Length < 8)
                {
                    continue;
                }

                double sx = 0, sy = 0, sxx = 0, sxy = 0;

                foreach (Vector3 v in vertices)
                {
                    sx += v.x; sy += v.y; sxx += v.x * v.x; sxy += v.x * v.y;
                }

                double denominator = vertices.Length * sxx - sx * sx;
                return denominator == 0 ? 0f : (float)((vertices.Length * sxy - sx * sy) / denominator);
            }

            return 0f;
        }
    }
}

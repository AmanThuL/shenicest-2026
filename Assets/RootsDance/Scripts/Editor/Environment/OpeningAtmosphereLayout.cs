using System.Collections.Generic;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Pure geometry over <see cref="OpeningAtmosphereParams"/>: mirrors how HDRP weighs a local Box Volume
    /// (1 inside the collider, quadratic falloff to 0 across Blend Distance measured from the box surface —
    /// weight = 1 − d²/b², as in VolumeManager).
    /// </summary>
    public static class OpeningAtmosphereLayout
    {
        /// <summary>Blend weight of one segment at a world position, 0..1.</summary>
        public static float Weight(OpeningSegment segment, Vector3 position)
        {
            Vector3 half = segment.Size * 0.5f;
            Vector3 local = position - segment.Center;
            Vector3 outside = new Vector3(
                Mathf.Max(0f, Mathf.Abs(local.x) - half.x),
                Mathf.Max(0f, Mathf.Abs(local.y) - half.y),
                Mathf.Max(0f, Mathf.Abs(local.z) - half.z));
            float distance = outside.magnitude;

            if (distance <= 0f)
            {
                return 1f;
            }

            if (segment.BlendDistance <= 0f)
            {
                return 0f;
            }

            return Mathf.Clamp01(1f - (distance * distance) / (segment.BlendDistance * segment.BlendDistance));
        }

        /// <summary>Number of segments whose weight is above zero at a world position.</summary>
        public static int CountCovering(OpeningAtmosphereParams p, Vector3 position)
        {
            int count = 0;

            for (int i = 0; i < p.Segments.Length; i++)
            {
                if (Weight(p.Segments[i], position) > 0f)
                {
                    count++;
                }
            }

            return count;
        }

        /// <summary>
        /// World positions every <paramref name="step"/> metres along the route polyline, both ends included.
        /// </summary>
        public static List<Vector3> SampleRoute(OpeningAtmosphereParams p, float step)
        {
            List<Vector3> samples = new List<Vector3>();

            for (int i = 0; i < p.RouteNodes.Length - 1; i++)
            {
                Vector3 a = p.RouteNodes[i];
                Vector3 b = p.RouteNodes[i + 1];
                float length = Vector3.Distance(a, b);
                int divisions = Mathf.Max(1, Mathf.CeilToInt(length / step));

                for (int j = 0; j < divisions; j++)
                {
                    samples.Add(Vector3.Lerp(a, b, (float)j / divisions));
                }
            }

            samples.Add(p.RouteNodes[p.RouteNodes.Length - 1]);
            return samples;
        }
    }
}

using UnityEngine;

namespace RootsDance.Player
{
    /// <summary>
    /// A snapshot of the flashlight cone, in the same terms the reveal shader works in.
    /// </summary>
    /// <remarks>
    /// The cone is stored as cosines rather than angles because that is what both the shader and
    /// <see cref="Energy"/> compare against; converting once at the source keeps a trigonometric
    /// call out of every consumer. A default-constructed beam has zero strength, which every
    /// consumer must read as "the flashlight is off".
    /// </remarks>
    public readonly struct FlashlightBeam
    {
        public FlashlightBeam(Vector3 origin, Vector3 direction, float outerCos, float innerCos,
            float range, float strength, float spillCos, float spillLevel)
        {
            Origin = origin;
            Direction = direction;
            OuterCos = outerCos;
            InnerCos = innerCos;
            Range = range;
            Strength = strength;
            SpillCos = spillCos;
            SpillLevel = spillLevel;
        }

        /// <summary>Apex of the cone, in world space.</summary>
        public Vector3 Origin { get; }

        /// <summary>Beam axis, normalised.</summary>
        public Vector3 Direction { get; }

        /// <summary>Cosine of the half-angle at which the beam has fallen off completely.</summary>
        public float OuterCos { get; }

        /// <summary>Cosine of the half-angle inside which the beam is at full strength.</summary>
        public float InnerCos { get; }

        /// <summary>Metres at which the beam has faded out.</summary>
        public float Range { get; }

        /// <summary>Fade level of the beam itself, 0 while it is off and 1 at full brightness.</summary>
        public float Strength { get; }

        /// <summary>
        /// Cosine of the half-angle of the wash around the beam. A real torch does not stop at the
        /// edge of its bright cone: there is a wide, weak spill around it, and it is what lets a
        /// player notice a mark is there before the beam is squarely on it.
        /// </summary>
        public float SpillCos { get; }

        /// <summary>How much of full strength the spill carries, 0..1. Well under half.</summary>
        public float SpillLevel { get; }

        /// <summary>
        /// How much of the beam reaches a world point, 0..1 — the CPU twin of the shader's
        /// BeamEnergy, minus the surface-facing term the caller may not have a normal for.
        /// </summary>
        /// <remarks>
        /// Kept in sync with FluorescentReveal.shader by hand. It is the same four factors in the
        /// same order, so a change on one side is a visible mismatch on the other rather than a
        /// silent drift.
        /// </remarks>
        public float Energy(Vector3 point)
        {
            if (Strength <= 0f)
            {
                return 0f;
            }

            Vector3 toPoint = point - Origin;
            float distance = toPoint.magnitude;

            if (distance > Range || distance <= 1e-5f)
            {
                return 0f;
            }

            float axis = Vector3.Dot(toPoint / distance, Direction);
            float cone = Mathf.InverseLerp(OuterCos, InnerCos, axis);
            cone = cone * cone * (3f - 2f * cone); // smoothstep, matching the shader

            // The wash outside the bright cone, faded from its own edge in to the cone's edge.
            float spill = Mathf.InverseLerp(SpillCos, OuterCos, axis);
            spill = spill * spill * (3f - 2f * spill) * Mathf.Clamp01(SpillLevel);

            cone = Mathf.Max(cone, spill);

            float range = Mathf.Clamp01(Mathf.InverseLerp(Range * 0.75f, Range, distance));
            range = 1f - range * range * (3f - 2f * range);

            return cone * range * Mathf.Clamp01(Strength);
        }
    }
}

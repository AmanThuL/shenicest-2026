namespace RootsDance.World
{
    /// <summary>
    /// Presentation contract for the ecological gradient of node 00-02: dead vegetation thinning out,
    /// new growth appearing, contamination motes fading. Gameplay only supplies the progress value;
    /// whether it is driven by shader parameters, prefab swaps or Volume blending is an art decision.
    /// </summary>
    public interface IZoneView
    {
        /// <param name="progress01">0 = contaminated zone, 1 = discoloured grass belt.</param>
        void SetZoneProgress(float progress01);
    }
}

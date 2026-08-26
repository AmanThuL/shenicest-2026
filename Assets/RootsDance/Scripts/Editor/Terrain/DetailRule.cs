using System;

namespace RootsDance.Editor.Terrain
{
    /// <summary>One Terrain detail layer: a prototype prefab key, its ring band and its per-cell density.</summary>
    [Serializable]
    public class DetailRule
    {
        public string Name = "Detail";
        /// <summary>Prefab key (== prefab file name) used as the detail prototype mesh.</summary>
        public string PrefabKey;
        public float RadiusMin;
        public float RadiusMax = 1000f;
        /// <summary>Metres over which the band fades in/out at its edges.</summary>
        public float EdgeFade = 6f;
        /// <summary>Instances per detail cell at full density.</summary>
        public int MaxPerCell = 4;
        /// <summary>Perlin patchiness; zero = uniform.</summary>
        public float ClumpThreshold = 0.3f;
        public float ClumpFrequency = 0.08f;
        /// <summary>Density multiplier inside the trail corridor (0 = none on the mud).</summary>
        public float TrailFactor;
        public float MaxSlopeDegrees = 35f;
        public bool ExcludeTerrace = true;
        public float TerraceClearance = 1f;
    }
}

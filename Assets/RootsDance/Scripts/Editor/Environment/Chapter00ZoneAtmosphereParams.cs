using System;
using RootsDance.App;
using RootsDance.Editor.Terrain;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    public enum Chapter00ZoneId
    {
        A = 0,
        B = 1,
        C = 2,
        D = 3,
        E = 4,
    }

    public enum Chapter00ZoneVolumeShape
    {
        Global = 0,
        Sphere = 1,
        Box = 2,
    }

    /// <summary>
    /// The deliberately small override set carried by one A-E profile. Exposure, sky, tonemapping and the PSX
    /// effect are absent by design: MainProfile and TimeOfDay remain the single owners of those baselines.
    /// </summary>
    [Serializable]
    public class Chapter00ZoneLook
    {
        public float MeanFreePath;
        public float BaseHeight;
        public float MaximumHeight;
        public Color FogTint;
        public Color FogAlbedo;
        public float Anisotropy;
        public float AmbientDimmer;
        public float VolumetricDistance;
        public float MultipleScattering;
        public float Contrast;
        public float Saturation;
        public Color ColorFilter;
    }

    [Serializable]
    public class Chapter00ZoneDefinition
    {
        public Chapter00ZoneId Id;
        public string Name;
        public string ProfileName;
        public Chapter00ZoneVolumeShape Shape;
        public Vector3 Center;
        public float Radius;
        public Vector3 BoxSize;
        public float YawDegrees;
        public float BlendDistance;
        public float Priority;
        public Chapter00ZoneLook Look;
    }

    /// <summary>
    /// Seed data for the continuous A-E exterior atmosphere. A is the fallback global layer; B-D are nested
    /// spheres centred on the terrain composition; E is the rotated facility terrace box. Higher-priority inner
    /// layers replace the outer look, while each local volume blends for 8 m outside its authored boundary.
    /// </summary>
    [Serializable]
    public class Chapter00ZoneAtmosphereParams
    {
        public const string k_ProfileFolder =
            "Assets/RootsDance/Settings/VolumeProfiles/Chapter00Zones";
        public const string k_RootName = "Chapter00ExteriorAtmosphere";

        public string ScenePath = ScenePaths.k_MainEnvironment;
        public string ProfileFolder = k_ProfileFolder;
        public Chapter00ZoneDefinition[] Zones;

        public static Chapter00ZoneAtmosphereParams CreateDefault()
        {
            TerrainGreyboxParams terrain = TerrainGreyboxParams.CreateDefault();
            Vector3 ringCenter = new Vector3(terrain.RingCenter.x, 8f, terrain.RingCenter.y);

            Chapter00ZoneAtmosphereParams p = new Chapter00ZoneAtmosphereParams();
            p.Zones = new[]
            {
                Zone(Chapter00ZoneId.A, "ZoneA_OuterPollution", "Chapter00ZoneAProfile",
                    Chapter00ZoneVolumeShape.Global, ringCenter, 0f, Vector3.zero, 0f, 8f, 6f,
                    Look(9f, new Color(0.88f, 0.82f, 0.62f), new Color(0.72f, 0.68f, 0.50f),
                        0.20f, 0.05f, 1.20f, 10f, -36f, new Color(0.94f, 0.89f, 0.76f))),
                Zone(Chapter00ZoneId.B, "ZoneB_DeadHumus", "Chapter00ZoneBProfile",
                    Chapter00ZoneVolumeShape.Sphere, ringCenter, terrain.RingRadiusAB, Vector3.zero, 0f, 8f, 7f,
                    Look(13.5f, new Color(0.88f, 0.84f, 0.72f), new Color(0.70f, 0.65f, 0.54f),
                        0.16f, 0.10f, 1.12f, 8f, -25f, new Color(0.94f, 0.90f, 0.82f))),
                Zone(Chapter00ZoneId.C, "ZoneC_AnomalousGrass", "Chapter00ZoneCProfile",
                    Chapter00ZoneVolumeShape.Sphere, ringCenter, terrain.RingRadiusBC, Vector3.zero, 0f, 8f, 8f,
                    Look(19f, new Color(0.78f, 0.90f, 1.00f), new Color(0.58f, 0.69f, 0.74f),
                        0.12f, 0.18f, 1.05f, 12f, 16f, new Color(0.86f, 0.96f, 1.08f))),
                Zone(Chapter00ZoneId.D, "ZoneD_StableEcology", "Chapter00ZoneDProfile",
                    Chapter00ZoneVolumeShape.Sphere, ringCenter, terrain.RingRadiusCD, Vector3.zero, 0f, 8f, 9f,
                    Look(25.5f, new Color(0.88f, 0.98f, 0.90f), new Color(0.64f, 0.73f, 0.65f),
                        0.10f, 0.24f, 1.00f, 5f, -3f, new Color(0.91f, 1.02f, 0.92f))),
                Zone(Chapter00ZoneId.E, "ZoneE_FacilityTerrace", "Chapter00ZoneEProfile",
                    Chapter00ZoneVolumeShape.Box,
                    new Vector3(terrain.TerraceCenter.x, terrain.TerraceHeight + 9f, terrain.TerraceCenter.y),
                    0f, new Vector3(terrain.TerraceHalfExtents.x * 2f, 36f,
                        terrain.TerraceHalfExtents.y * 2f), terrain.TerraceYawDegrees, 10f, 10f,
                    Look(33f, new Color(0.90f, 0.97f, 1.00f), new Color(0.72f, 0.78f, 0.82f),
                        0.08f, 0.30f, 0.95f, 8f, -10f, new Color(0.92f, 0.99f, 1.06f))),
            };
            return p;
        }

        private static Chapter00ZoneDefinition Zone(Chapter00ZoneId id, string name, string profileName,
            Chapter00ZoneVolumeShape shape, Vector3 center, float radius, Vector3 boxSize, float yaw,
            float blend, float priority, Chapter00ZoneLook look)
        {
            return new Chapter00ZoneDefinition
            {
                Id = id,
                Name = name,
                ProfileName = profileName,
                Shape = shape,
                Center = center,
                Radius = radius,
                BoxSize = boxSize,
                YawDegrees = yaw,
                BlendDistance = blend,
                Priority = priority,
                Look = look,
            };
        }

        private static Chapter00ZoneLook Look(float meanFreePath, Color tint, Color albedo, float anisotropy,
            float ambientDimmer, float multipleScattering, float contrast, float saturation, Color colorFilter)
        {
            return new Chapter00ZoneLook
            {
                MeanFreePath = meanFreePath,
                BaseHeight = 10f,
                MaximumHeight = 48f,
                FogTint = tint,
                FogAlbedo = albedo,
                Anisotropy = anisotropy,
                AmbientDimmer = ambientDimmer,
                VolumetricDistance = 140f,
                MultipleScattering = multipleScattering,
                Contrast = contrast,
                Saturation = saturation,
                ColorFilter = colorFilter,
            };
        }
    }
}

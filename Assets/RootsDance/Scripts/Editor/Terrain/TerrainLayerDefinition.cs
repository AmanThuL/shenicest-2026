using System;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// Textures and tint for one Terrain layer; a null <see cref="Albedo"/> falls back to the flat
    /// greybox colour.
    /// </summary>
    [Serializable]
    public class TerrainLayerDefinition
    {
        [SerializeField, ReadOnly] private string m_name;

        // Deliberately not [Required]: the flat greybox fallback (TerrainGreyboxBuilder.ApplyFlatLayer)
        // depends on m_albedo being null, so a null texture here is a valid, expected state rather than
        // a misconfiguration.
        [SerializeField] private Texture2D m_albedo;
        [SerializeField] private Texture2D m_normal;
        [SerializeField] private Texture2D m_mask;
        [SerializeField, MinValue(0.5f)] private float m_tileSize = 6f;
        [SerializeField] private Color m_tint = Color.white;
        [SerializeField] private Color m_tintMin = Color.black;
        [SerializeField, Range(0f, 1f)] private float m_smoothness = 0.1f;
        [SerializeField, Range(0f, 2f)] private float m_normalScale = 1f;

        /// <summary>Parameterless constructor for Unity's serializer and the Inspector's "add element".</summary>
        public TerrainLayerDefinition()
        {
        }

        /// <summary>Creates an untextured definition; the builder wires its textures on the next build.</summary>
        /// <param name="name">Layer stem, matching <c>TerrainGreyboxBuilder.k_LayerNames</c>.</param>
        /// <param name="tileSize">World size in metres of one texture repeat.</param>
        /// <param name="tint">Albedo remap ceiling — the layer's overall colour cast.</param>
        public TerrainLayerDefinition(string name, float tileSize, Color tint)
            : this(name, tileSize, tint, Color.black)
        {
        }

        /// <summary>Creates an untextured definition whose albedo is remapped into a narrower range.</summary>
        /// <param name="name">Layer stem, matching <c>TerrainGreyboxBuilder.k_LayerNames</c>.</param>
        /// <param name="tileSize">World size in metres of one texture repeat.</param>
        /// <param name="tint">Albedo remap ceiling — the layer's overall colour cast.</param>
        /// <param name="tintMin">Albedo remap floor — lifting it off black desaturates and flattens the set.</param>
        public TerrainLayerDefinition(string name, float tileSize, Color tint, Color tintMin)
        {
            m_name = name;
            m_tileSize = tileSize;
            m_tint = tint;
            m_tintMin = tintMin;
        }

        /// <summary>Layer stem, matching <c>TerrainGreyboxBuilder.k_LayerNames</c>.</summary>
        public string Name => m_name;

        /// <summary>Albedo texture, or null while the layer is still a flat greybox colour.</summary>
        public Texture2D Albedo => m_albedo;

        /// <summary>Tangent-space (OpenGL) normal map.</summary>
        public Texture2D Normal => m_normal;

        /// <summary>Packed mask map — R metallic, G occlusion, B height, A smoothness.</summary>
        public Texture2D Mask => m_mask;

        /// <summary>World size in metres of one texture repeat.</summary>
        public float TileSize => m_tileSize;

        /// <summary>Albedo remap ceiling — the layer's overall colour cast.</summary>
        public Color Tint => m_tint;

        /// <summary>
        /// Albedo remap floor. Black keeps the source set's full contrast; lifting it towards the tint
        /// compresses the range, which is how a saturated CC0 set is desaturated without a new texture.
        /// </summary>
        public Color TintMin => m_tintMin;

        /// <summary>Smoothness ceiling for the packed mask's alpha channel.</summary>
        public float Smoothness => m_smoothness;

        /// <summary>Strength of the normal map.</summary>
        public float NormalScale => m_normalScale;

        /// <summary>True once an albedo is assigned; false keeps the flat greybox colour path.</summary>
        public bool HasTextures => m_albedo != null;
    }
}

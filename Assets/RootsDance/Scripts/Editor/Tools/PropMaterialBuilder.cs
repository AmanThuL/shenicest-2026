using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Builds the HDRP materials that imported props ask for by name, from the channel-packed
    /// texture sets the asset pipeline writes into <c>Assets/RootsDance/Textures/</c>.
    /// <para>
    /// A prop arrives from Blender with its DCC material names intact
    /// (<c>small_plastic_torch</c>, <c>Material.017</c>); which project material each of those
    /// slots resolves to is stated in <c>Tools/unity/model_import_profiles.json</c>. This tool
    /// creates those materials, so their paths are part of that contract and must not be renamed
    /// casually.
    /// </para>
    /// <para>
    /// Idempotent, and deliberately non-destructive: an existing material keeps whatever a human
    /// tuned on it and only has its texture slots rewired. Adding a prop is one entry in
    /// <see cref="k_Specs"/>, not new code.
    /// </para>
    /// Menu: RootsDance > Build Prop Materials.
    /// </summary>
    public static class PropMaterialBuilder
    {
        private const string k_Shader = "HDRP/Lit";

        /// <summary>
        /// Falls back to a constant when a set ships no mask map. 0.35 reads as a used object
        /// rather than a showroom one.
        /// </summary>
        private const float k_FallbackSmoothness = 0.35f;

        private static readonly Spec[] k_Specs =
        {
            new Spec(
                "Assets/RootsDance/Materials/Environment/CarRustyOpenDoor.mat",
                "Assets/RootsDance/Textures/Environment",
                "CarRustyOpenDoor",
                false),
            // Both FBX slots (poster_mat, pushpin_mat) resolve here: the Sketchfab source ships
            // one 2K texture set for the whole prop, so splitting it would only duplicate it.
            new Spec(
                "Assets/RootsDance/Materials/Environment/BandPoster.mat",
                "Assets/RootsDance/Textures/Environment",
                "BandPoster",
                false),
            // A photogrammetry scan: the source ships an albedo and nothing else, so this one
            // falls back to the constant smoothness rather than reading a mask.
            new Spec(
                "Assets/RootsDance/Materials/Environment/SHA2017Poster.mat",
                "Assets/RootsDance/Textures/Environment",
                "SHA2017Poster",
                false),
            new Spec(
                "Assets/RootsDance/Materials/Flashlight.mat",
                "Assets/RootsDance/Textures/Props",
                "Flashlight",
                false),

            // The torch's lens shares the body's texture set: the alpha the Poly Haven source
            // keeps in its own map is packed into the BaseMap's alpha channel, and only the lens
            // submesh reads the region where it is not opaque.
            new Spec(
                "Assets/RootsDance/Materials/FlashlightLens.mat",
                "Assets/RootsDance/Textures/Props",
                "Flashlight",
                true),

            // The greenhouse carries SketchUp's box-mapped UVs, which cover roughly 1.5 million
            // percent of the 0-1 square: nothing sampled through them lands where it should. Its
            // three sets are therefore triplanar, and the world scale matches the tile size the
            // maps were baked at in Blender.
            new Spec(
                "Assets/RootsDance/Materials/Environment/GreenHouse/GreenHouseMetal.mat",
                "Assets/RootsDance/Textures/Environment",
                "GreenHouseMetal",
                false,
                0.22f),
            new Spec(
                "Assets/RootsDance/Materials/Environment/GreenHouse/GreenHouseGlass.mat",
                "Assets/RootsDance/Textures/Environment",
                "GreenHouseGlass",
                true,
                0.16f,
                0.30f),
            new Spec(
                "Assets/RootsDance/Materials/Environment/GreenHouse/GreenHouseStained.mat",
                "Assets/RootsDance/Textures/Environment",
                "GreenHouseStained",
                true,
                0.16f,
                0.62f),
        };

        [MenuItem("RootsDance/Build Prop Materials")]
        public static void Build()
        {
            Shader shader = Shader.Find(k_Shader);

            if (shader == null)
            {
                Debug.LogError($"PropMaterialBuilder: shader '{k_Shader}' not found. Is the "
                    + "project still on HDRP?");
                return;
            }

            int textured = 0;

            for (int i = 0; i < k_Specs.Length; i++)
            {
                if (BuildOne(shader, k_Specs[i]))
                {
                    textured++;
                }
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log($"PropMaterialBuilder: {textured} of {k_Specs.Length} materials written with "
                + "a base map. Reimport the model if its slots still read as default.");
        }

        private static bool BuildOne(Shader shader, Spec spec)
        {
            Material material = AssetDatabase.LoadAssetAtPath<Material>(spec.MaterialPath);

            if (material == null)
            {
                material = new Material(shader);
                Directory.CreateDirectory(Path.GetDirectoryName(spec.MaterialPath));
                AssetDatabase.CreateAsset(material, spec.MaterialPath);
            }

            Texture2D baseMap = Load(spec, "BaseMap");
            Texture2D mask = Load(spec, "Mask");
            Texture2D normal = Load(spec, "Normal");

            if (baseMap == null)
            {
                Debug.LogWarning($"PropMaterialBuilder: no BaseMap for set '{spec.TextureSet}' in "
                    + $"{spec.TextureFolder}; the material was created but left untextured.");
            }

            material.SetTexture(k_BaseColorMap, baseMap);
            material.SetTexture(k_MaskMap, mask);
            material.SetTexture(k_NormalMap, normal);

            // Without the packed mask there is no smoothness channel to read, so the material
            // falls back to a constant.
            if (mask == null)
            {
                material.SetFloat(k_Smoothness, k_FallbackSmoothness);
            }

            // Meshes whose UVs cannot be sampled sanely are driven from world space instead.
            if (spec.TriplanarWorldScale > 0f)
            {
                material.SetFloat(k_UVBase, k_TriplanarMapping);
                material.SetFloat(k_UVDetail, 0f);
                material.SetFloat(k_TexWorldScale, spec.TriplanarWorldScale);
            }

            // Surface type drives keywords and the render queue, so it goes through the HDRP
            // helper rather than a raw SetFloat; it validates the material on the way out.
            // The bakes are fully opaque, so opacity comes from the base colour's alpha.
            if (spec.Transparent)
            {
                Color tint = material.GetColor(k_BaseColor);
                tint.a = spec.Opacity;
                material.SetColor(k_BaseColor, tint);
            }

            HDMaterial.SetSurfaceType(material, spec.Transparent);

            // Opaque materials still need the validation pass to pick up the mask and normal
            // keywords, which setting textures alone leaves off.
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);

            return baseMap != null;
        }

        private static Texture2D Load(Spec spec, string map)
        {
            return AssetDatabase.LoadAssetAtPath<Texture2D>(
                $"{spec.TextureFolder}/{spec.TextureSet}_{map}.png");
        }

        /// <summary>One material: where it lives, which texture set feeds it, and how it renders.</summary>
        private readonly struct Spec
        {
            public Spec(string materialPath, string textureFolder, string textureSet,
                bool transparent, float triplanarWorldScale = 0f, float opacity = 1f)
            {
                Opacity = opacity;
                MaterialPath = materialPath;
                TextureFolder = textureFolder;
                TextureSet = textureSet;
                Transparent = transparent;
                TriplanarWorldScale = triplanarWorldScale;
            }

            public string MaterialPath { get; }

            public string TextureFolder { get; }

            public string TextureSet { get; }

            public bool Transparent { get; }

            /// <summary>World-space tile size for triplanar sampling; 0 keeps the mesh UVs.</summary>
            public float TriplanarWorldScale { get; }

            /// <summary>
            /// Base-colour alpha. A transparent surface whose alpha is 1 renders solid, and the
            /// baked maps carry no alpha of their own, so glass has to state its opacity here.
            /// </summary>
            public float Opacity { get; }
        }

        private static readonly int k_BaseColorMap = Shader.PropertyToID("_BaseColorMap");
        private static readonly int k_MaskMap = Shader.PropertyToID("_MaskMap");
        private static readonly int k_NormalMap = Shader.PropertyToID("_NormalMap");
        private static readonly int k_Smoothness = Shader.PropertyToID("_Smoothness");
        private static readonly int k_BaseColor = Shader.PropertyToID("_BaseColor");
        private static readonly int k_UVBase = Shader.PropertyToID("_UVBase");
        private static readonly int k_UVDetail = Shader.PropertyToID("_UVDetail");
        private static readonly int k_TexWorldScale = Shader.PropertyToID("_TexWorldScale");

        /// <summary>HDRP's UVBaseMapping enum: UV0..UV3 are 0..3, Planar 4, Triplanar 5.</summary>
        private const float k_TriplanarMapping = 5f;
    }
}

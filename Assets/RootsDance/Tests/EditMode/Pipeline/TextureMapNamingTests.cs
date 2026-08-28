using NUnit.Framework;
using RootsDance.Editor.Pipeline;

namespace RootsDance.Tests.EditMode.Pipeline
{
    public class TextureMapNamingTests
    {
        [TestCase("Helmet_BaseMap.png", "Helmet", TextureMapKind.BaseMap)]
        [TestCase("Helmet_Normal.png", "Helmet", TextureMapKind.Normal)]
        [TestCase("Helmet_Mask.png", "Helmet", TextureMapKind.Mask)]
        [TestCase("Helmet_Emission.png", "Helmet", TextureMapKind.Emission)]
        [TestCase("Helmet_Height.png", "Helmet", TextureMapKind.Height)]
        [TestCase("TerrainAshDry_Mask.png", "TerrainAshDry", TextureMapKind.Mask)]
        [TestCase("HelmetShell_Normal.tga", "HelmetShell", TextureMapKind.Normal)]
        [TestCase("Assets/RootsDance/Textures/Props/HelmetVisor_Mask.png", "HelmetVisor", TextureMapKind.Mask)]
        public void TryParse_ConventionalName_ReturnsSetAndKind(
            string fileName, string expectedSet, TextureMapKind expectedKind)
        {
            Assert.IsTrue(TextureMapNaming.TryParse(fileName, out string set, out TextureMapKind kind));
            Assert.AreEqual(expectedSet, set);
            Assert.AreEqual(expectedKind, kind);
        }

        [TestCase(null)]
        [TestCase("")]
        [TestCase("helmet_body_basecolor.png")]   // lowercase, and two underscores
        [TestCase("T_Helmet_BaseMap.png")]        // type prefix is banned by guideline 02
        [TestCase("Helmet.png")]                  // no map suffix
        [TestCase("Helmet_Diffuse.png")]          // not an HDRP Lit slot name
        [TestCase("Helmet_basemap.png")]          // wrong case on the map
        [TestCase("_BaseMap.png")]                // no texture set
        [TestCase("Helmet_.png")]                 // empty map
        [TestCase("Helmet_Metallic.png")]         // folded into Mask.R by HDRP Lit
        [TestCase("Helmet_Occlusion.png")]        // folded into Mask.G by HDRP Lit
        [TestCase("Helmet_Specular.png")]         // HDRP Lit has no separate specular map slot
        [TestCase("Helmet_MetallicSmoothness.png")] // the URP-era packed name
        [TestCase("Helmet_MaskMap.png")]          // Painter's export name, not the project's
        public void TryParse_NonConformingName_ReturnsFalse(string fileName)
        {
            Assert.IsFalse(TextureMapNaming.TryParse(fileName, out _, out _));
        }

        [TestCase(TextureMapKind.BaseMap, true)]
        [TestCase(TextureMapKind.Emission, true)]
        [TestCase(TextureMapKind.Normal, false)]
        [TestCase(TextureMapKind.Mask, false)]
        [TestCase(TextureMapKind.Height, false)]
        public void IsColorMap_DataMapsAreLinear(TextureMapKind kind, bool expected)
        {
            Assert.AreEqual(expected, TextureMapNaming.IsColorMap(kind));
        }

        [Test]
        public void AlphaIsTransparency_MaskAlphaIsSmoothnessNotOpacity()
        {
            // HDRP Lit reads smoothness from the mask map's alpha. Marking it as
            // transparency would let Unity's alpha dilation rewrite those values.
            Assert.IsFalse(TextureMapNaming.AlphaIsTransparency(TextureMapKind.Mask));
            Assert.IsTrue(TextureMapNaming.AlphaIsTransparency(TextureMapKind.BaseMap));
        }
    }
}

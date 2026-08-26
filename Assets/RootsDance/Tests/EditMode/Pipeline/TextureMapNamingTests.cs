using NUnit.Framework;
using RootsDance.Editor.Pipeline;

namespace RootsDance.Tests.EditMode.Pipeline
{
    public class TextureMapNamingTests
    {
        [TestCase("Helmet_BaseMap.png", "Helmet", TextureMapKind.BaseMap)]
        [TestCase("HelmetShell_Normal.png", "HelmetShell", TextureMapKind.Normal)]
        [TestCase("HelmetVisor_Metallic.png", "HelmetVisor", TextureMapKind.Metallic)]
        [TestCase("Crate_Occlusion.png", "Crate", TextureMapKind.Occlusion)]
        [TestCase("Sign01_Emission.tga", "Sign01", TextureMapKind.Emission)]
        [TestCase("Assets/RootsDance/Textures/Props/Helmet_Height.png", "Helmet", TextureMapKind.Height)]
        [TestCase("TerrainAshDry_Mask.png", "TerrainAshDry", TextureMapKind.Mask)]
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
        [TestCase("Helmet_Diffuse.png")]          // not a URP Lit slot name
        [TestCase("Helmet_basemap.png")]          // wrong case on the map
        [TestCase("_BaseMap.png")]                // no texture set
        [TestCase("Helmet_.png")]                 // empty map
        public void TryParse_NonConformingName_ReturnsFalse(string fileName)
        {
            Assert.IsFalse(TextureMapNaming.TryParse(fileName, out _, out _));
        }

        [TestCase(TextureMapKind.BaseMap, true)]
        [TestCase(TextureMapKind.Emission, true)]
        [TestCase(TextureMapKind.Normal, false)]
        [TestCase(TextureMapKind.Metallic, false)]
        [TestCase(TextureMapKind.Occlusion, false)]
        [TestCase(TextureMapKind.Height, false)]
        [TestCase(TextureMapKind.Mask, false)]
        public void IsColorMap_DataMapsAreLinear(TextureMapKind kind, bool expected)
        {
            Assert.AreEqual(expected, TextureMapNaming.IsColorMap(kind));
        }

        [Test]
        public void AlphaIsTransparency_MetallicAlphaIsSmoothnessNotOpacity()
        {
            // URP Lit reads smoothness from the metallic map's alpha. Marking it as
            // transparency would let Unity's alpha dilation rewrite those values.
            Assert.IsFalse(TextureMapNaming.AlphaIsTransparency(TextureMapKind.Metallic));
            Assert.IsTrue(TextureMapNaming.AlphaIsTransparency(TextureMapKind.BaseMap));
        }
    }
}

using System.IO;
using NUnit.Framework;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Tests.EditMode.Rendering
{
    public sealed class RenderPipelineGuardTests
    {
        private static readonly string[] k_AssetRoots = { "Assets/RootsDance", "Assets/_Sandbox" };

        [Test]
        public void GraphicsSettings_DefaultRenderPipeline_IsHdrpAsset()
        {
            Assert.IsInstanceOf<HDRenderPipelineAsset>(GraphicsSettings.defaultRenderPipeline);
        }

        [Test]
        public void QualitySettings_SingleDesktopLevel_UsesHdrpAsset()
        {
            CollectionAssert.AreEqual(new[] { "Desktop" }, QualitySettings.names);
            Assert.IsInstanceOf<HDRenderPipelineAsset>(QualitySettings.GetRenderPipelineAssetAt(0));
        }

        [Test]
        public void Materials_UnderProjectRoots_UseSupportedNonUrpShaders()
        {
            foreach (string guid in AssetDatabase.FindAssets("t:Material", k_AssetRoots))
            {
                string path = AssetDatabase.GUIDToAssetPath(guid);
                Material material = AssetDatabase.LoadAssetAtPath<Material>(path);
                Assert.IsNotNull(material.shader, path + " has no shader");
                Assert.IsFalse(material.shader.name.StartsWith("Universal Render Pipeline/"),
                    path + " uses a URP shader");
                Assert.AreNotEqual("Hidden/InternalErrorShader", material.shader.name, path + " uses the error shader");
                Assert.IsTrue(material.shader.isSupported, path + " shader is not supported: " + material.shader.name);
            }
        }

        [Test]
        public void HdrpSettings_LiveUnderRootsDanceSettings()
        {
            Assert.IsTrue(File.Exists("Assets/RootsDance/Settings/HDRP/HDRP_Desktop.asset"));
            Assert.IsTrue(File.Exists("Assets/RootsDance/Settings/HDRP/HDRenderPipelineGlobalSettings.asset"));
            Assert.IsFalse(Directory.Exists("Assets/HDRPDefaultResources"));
        }
    }
}

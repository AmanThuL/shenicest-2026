using System.Collections.Generic;
using System.IO;
using NUnit.Framework;

namespace RootsDance.Tests.EditMode.Rendering
{
    /// <summary>
    /// Text-level guard: no serialized asset may still reference a URP script, shader or package asset.
    /// </summary>
    public sealed class UrpResidueTests
    {
        private static readonly string[] k_Roots = { "Assets/RootsDance", "Assets/_Sandbox" };
        private static readonly string[] k_Extensions = { ".unity", ".prefab", ".mat", ".asset" };

        private static readonly Dictionary<string, string> k_UrpGuids = new Dictionary<string, string>
        {
            { "933532a4fcc9baf4fa0491de14d08ed7", "Universal Render Pipeline/Lit shader" },
            { "69c1f799e772cb6438f56c23efccb782", "Universal Render Pipeline/Terrain/Lit shader" },
            { "8d2bb70cbf9db8d4da26e15b26e74248", "Universal Render Pipeline/Simple Lit shader" },
            { "650dd9526735d5b46b79224bc6e94025", "Universal Render Pipeline/Unlit shader" },
            { "a79441f348de89743a2939f4d699eac1", "UniversalAdditionalCameraData" },
            { "474bcb49853aa07438625e644c072ee6", "UniversalAdditionalLightData" },
            { "594ea882c5a793440b60ff72d896021e", "URP package TerrainLit.mat" },
            { "bf2edee5c58d82540a51f03df9d42094", "UniversalRenderPipelineAsset" },
            { "de640fe3d0db1804a85f9fc8f5cadab6", "UniversalRendererData" },
            { "2ec995e51a6e251468d2a3fd8a686257", "UniversalRenderPipelineGlobalSettings" },
            { "d0353a89b1f911e48b9e16bdc9f2e058", "URP material AssetVersion sidecar" },
            { "31321ba15b8f8eb4c954353edc038b1d", "URP package Lit.mat (default material)" },
        };

        private static IEnumerable<string> SerializedAssets()
        {
            foreach (string root in k_Roots)
            {
                foreach (string file in Directory.EnumerateFiles(root, "*", SearchOption.AllDirectories))
                {
                    if (System.Array.IndexOf(k_Extensions, Path.GetExtension(file)) >= 0)
                    {
                        yield return file;
                    }
                }
            }
        }

        [Test]
        public void SerializedAssets_ContainNoUrpGuid()
        {
            var failures = new List<string>();
            foreach (string file in SerializedAssets())
            {
                string text = File.ReadAllText(file);
                foreach (KeyValuePair<string, string> pair in k_UrpGuids)
                {
                    if (text.Contains(pair.Key))
                    {
                        failures.Add(file + " -> " + pair.Value);
                    }
                }
            }
            Assert.IsEmpty(failures, string.Join("\n", failures));
        }

        [Test]
        public void SerializedAssets_ContainNoMissingScript()
        {
            var failures = new List<string>();
            foreach (string file in SerializedAssets())
            {
                if (File.ReadAllText(file).Contains("m_Script: {fileID: 0}"))
                {
                    failures.Add(file);
                }
            }
            Assert.IsEmpty(failures, string.Join("\n", failures));
        }
    }
}

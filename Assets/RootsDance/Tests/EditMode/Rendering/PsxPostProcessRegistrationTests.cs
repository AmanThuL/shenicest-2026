using NUnit.Framework;
using RootsDance.Editor.Rendering;
using RootsDance.Rendering;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Rendering
{
    /// <summary>
    /// Guards the two project-settings edits a custom post-process needs (guideline 07 §4): the type must be
    /// in HDRP's After Post Process order list, and its shader must be in Always Included Shaders or a build
    /// strips it. Both are written by PsxPostProcessRegistrar.Register().
    /// </summary>
    public sealed class PsxPostProcessRegistrationTests
    {
        [Test]
        public void ShaderFind_PsxShaderName_ReturnsSupportedShader()
        {
            Shader shader = Shader.Find(PsxPostProcess.k_ShaderName);
            Assert.IsTrue(shader != null, PsxPostProcess.k_ShaderName + " not found");
            Assert.IsTrue(shader.isSupported, PsxPostProcess.k_ShaderName + " is not supported");
        }

        [Test]
        public void Registrar_IsRegistered_AfterPostProcessListContainsPsxPostProcess()
        {
            Assert.IsTrue(PsxPostProcessRegistrar.IsRegistered(),
                "PsxPostProcess is not in HDRP's After Post Process list — run "
                + "RootsDance/Rendering/Register PSX Post Process");
        }

        [Test]
        public void Registrar_IsShaderAlwaysIncluded_True()
        {
            Assert.IsTrue(PsxPostProcessRegistrar.IsShaderAlwaysIncluded(),
                PsxPostProcess.k_ShaderName + " is not in Always Included Shaders — run "
                + "RootsDance/Rendering/Register PSX Post Process");
        }

        [Test]
        public void Registrar_Register_IsIdempotent()
        {
            PsxPostProcessRegistrar.Register();
            Assert.IsFalse(PsxPostProcessRegistrar.Register(), "second Register() must report no change");
            Assert.IsTrue(PsxPostProcessRegistrar.IsRegistered());
            Assert.IsTrue(PsxPostProcessRegistrar.IsShaderAlwaysIncluded());
        }
    }
}

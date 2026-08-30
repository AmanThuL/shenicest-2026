using System.Linq;
using NUnit.Framework;
using RootsDance.App;
using UnityEditor;

namespace RootsDance.Tests.EditMode.UI
{
    public class MainMenuBuildSettingsTests
    {
        [Test]
        public void SharedSceneList_MainMenuBackground_IsEnabled()
        {
            EditorBuildSettingsScene background = EditorBuildSettings.scenes.FirstOrDefault(
                scene => scene.path == ScenePaths.k_MainMenuBackground);

            Assert.That(background, Is.Not.Null);
            Assert.That(background.enabled, Is.True);
        }
    }
}

using NUnit.Framework;
using RootsDance.App;

namespace RootsDance.Tests.EditMode.App
{
    /// <summary>
    /// The one decision in <see cref="BootstrapLoader"/>: a Bootstrap that is already in, by
    /// either measure, is never requested again. Loading it twice is what put two EventSystems,
    /// two AudioListeners and two Main Cameras into a session.
    /// </summary>
    public class BootstrapLoaderTests
    {
        [Test]
        public void NeedsLoad_NothingPresent_Loads()
        {
            Assert.That(BootstrapLoader.NeedsLoad(bootstrapIsLoaded: false, bootstrapInstanceExists: false), Is.True);
        }

        [Test]
        public void NeedsLoad_SceneLoaded_DoesNot()
        {
            Assert.That(BootstrapLoader.NeedsLoad(bootstrapIsLoaded: true, bootstrapInstanceExists: false), Is.False);
        }

        [Test]
        public void NeedsLoad_InstanceExists_DoesNot()
        {
            Assert.That(BootstrapLoader.NeedsLoad(bootstrapIsLoaded: false, bootstrapInstanceExists: true), Is.False);
        }
    }
}

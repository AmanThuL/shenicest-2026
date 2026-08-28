using NUnit.Framework;
using RootsDance.Environment;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>
    /// The opening motes are authored in nits for the day's EV 12.5; at the night's EV 5 the same
    /// nits are ten stops over and every mote renders as a white disc. The scale must undo exactly
    /// the exposure difference.
    /// </summary>
    public class EmissiveExposureTests
    {
        [Test]
        public void Scale_SameExposure_IsOne()
        {
            Assert.AreEqual(1f, EmissiveExposure.Scale(12.5f, 12.5f), 1e-6f);
        }

        [Test]
        public void Scale_SevenAndAHalfStopsDarker_DividesBy181()
        {
            Assert.AreEqual(1f / 181.02f, EmissiveExposure.Scale(12.5f, 5f), 1e-5f);
        }

        [Test]
        public void Scale_OneStopBrighter_Doubles()
        {
            Assert.AreEqual(2f, EmissiveExposure.Scale(5f, 6f), 1e-6f);
        }
    }
}

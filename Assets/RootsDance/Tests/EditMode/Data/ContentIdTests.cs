using NUnit.Framework;
using RootsDance.Data;

namespace RootsDance.Tests.EditMode.Data
{
    public class ContentIdTests
    {
        [TestCase("SO-001")]
        [TestCase("FL-001")]
        [TestCase("AB-99")]
        [TestCase("ABCDEFGH-9999")]
        public void IsValid_WellFormedId_ReturnsTrue(string id)
        {
            Assert.IsTrue(ContentId.IsValid(id));
        }

        [TestCase(null)]
        [TestCase("")]
        [TestCase("so-001")]
        [TestCase("SO001")]
        [TestCase("SO-")]
        [TestCase("SO-1")]
        [TestCase("S-001")]
        [TestCase("SO-00001")]
        [TestCase("ABCDEFGHI-001")]
        public void IsValid_MalformedId_ReturnsFalse(string id)
        {
            Assert.IsFalse(ContentId.IsValid(id));
        }

        [Test]
        public void FromAssetName_HasUnderscoreSuffix_TakesPrefixBeforeUnderscore()
        {
            Assert.AreEqual("SO-001", ContentId.FromAssetName("SO-001_Soil"));
        }

        [Test]
        public void FromAssetName_NoUnderscore_UppercasesWholeName()
        {
            Assert.AreEqual("SO-001", ContentId.FromAssetName("so-001"));
        }

        [Test]
        public void FromAssetName_Empty_ReturnsEmpty()
        {
            Assert.AreEqual(string.Empty, ContentId.FromAssetName(string.Empty));
        }
    }
}

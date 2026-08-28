using NUnit.Framework;
using RootsDance.Player.Arms;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Player
{
    /// <summary>
    /// The ground-versus-standing baseline. The clips carry no overall height displacement, so this
    /// component is the only thing that knows how far down a prone body sits — getting it wrong is
    /// what makes the view sink into the floor or float above it.
    /// </summary>
    public class ArmsHeightRigTests
    {
        private GameObject m_object;
        private ArmsHeightRig m_rig;

        [SetUp]
        public void SetUp()
        {
            m_object = new GameObject("ArmsHeightRig");
            m_rig = m_object.AddComponent<ArmsHeightRig>();

            SerializedFieldSetter.Set(m_rig, "m_standingLocalY", 1.6f);
            SerializedFieldSetter.Set(m_rig, "m_playerHeight", 1.75f);
            SerializedFieldSetter.Set(m_rig, "m_groundOffset", 0.35f);
        }

        [TearDown]
        public void TearDown()
        {
            Object.DestroyImmediate(m_object);
        }

        [Test]
        public void GroundLocalY_IsStandingMinusTheHeightLost()
        {
            Assert.AreEqual(1.6f - (1.75f - 0.35f), m_rig.GroundLocalY, 1e-4f);
        }

        [Test]
        public void Resolve_Standing_ReturnsStandingBaseline()
        {
            Assert.AreEqual(1.6f, m_rig.Resolve(ArmsHeightBase.Standing), 1e-4f);
        }

        [Test]
        public void Resolve_Ground_ReturnsGroundBaseline()
        {
            Assert.AreEqual(m_rig.GroundLocalY, m_rig.Resolve(ArmsHeightBase.Ground), 1e-4f);
        }

        [Test]
        public void Begin_Ground_SnapsTheAnchorDown()
        {
            m_rig.Begin(ArmsHeightBase.Ground, 0f);

            Assert.AreEqual(m_rig.GroundLocalY, m_object.transform.localPosition.y, 1e-4f);
        }

        [Test]
        public void Begin_Standing_SnapsTheAnchorBackUp()
        {
            m_rig.Begin(ArmsHeightBase.Ground, 0f);
            m_rig.Begin(ArmsHeightBase.Standing, 0f);

            Assert.AreEqual(1.6f, m_object.transform.localPosition.y, 1e-4f);
        }

        [Test]
        public void Begin_GroundToStanding_StartsFromTheGroundBaseline()
        {
            // The transition action is authored flat; the rise belongs to the rig, and it has to
            // begin from where the crawl left the body rather than from wherever it was.
            m_rig.Begin(ArmsHeightBase.Standing, 0f);
            m_rig.Begin(ArmsHeightBase.GroundToStanding, 2f);

            Assert.AreEqual(1.6f, m_object.transform.localPosition.y, 1e-4f,
                "Begin only arms the blend; Update drives it.");
            Assert.AreEqual(m_rig.GroundLocalY, m_rig.Resolve(ArmsHeightBase.Ground), 1e-4f);
        }
    }
}

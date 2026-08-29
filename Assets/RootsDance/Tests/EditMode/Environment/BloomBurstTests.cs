using NUnit.Framework;
using RootsDance.Environment;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Environment
{
    public class BloomBurstTests
    {
        [Test]
        public void OpenAmount_BeforeItsOrder_IsShut()
        {
            Assert.AreEqual(0f, BloomBurst.OpenAmount(0.3f, 0.5f, 0.08f), 0.0001f);
        }

        [Test]
        public void OpenAmount_MatchesTheShadersOwnReveal()
        {
            // StatueBloom.hlsl computes saturate((_Growth * (1 + soft) - order) / soft). A stem
            // and the patch it stands in must open on exactly the same curve, so this is pinned.
            const float span = 0.08f;
            const float order = 0.5f;

            for (int i = 0; i <= 20; i++)
            {
                float g = i / 20f;
                float expected = Mathf.Clamp01((g * (1f + span) - order) / span);
                Assert.AreEqual(expected, BloomBurst.OpenAmount(g, order, span), 0.0001f);
            }
        }

        [Test]
        public void OpenAmount_LateFlowersStillFinish()
        {
            // The bug this test exists for: with a plain (growth - order) / span, a flower at
            // order 0.95 reached only 0.625 at full growth and never finished opening.
            Assert.AreEqual(1f, BloomBurst.OpenAmount(1f, 0.95f, 0.08f), 0.0001f);
            Assert.AreEqual(1f, BloomBurst.OpenAmount(1f, 0.999f, 0.08f), 0.0001f);
        }

        [Test]
        public void OpenAmount_WellPastItsOrder_ClampsToOne()
        {
            Assert.AreEqual(1f, BloomBurst.OpenAmount(1f, 0.1f, 0.08f), 0.0001f);
        }

        [Test]
        public void OpenAmount_WithZeroSpan_SnapsRatherThanDividingByZero()
        {
            Assert.AreEqual(0f, BloomBurst.OpenAmount(0.49f, 0.5f, 0f), 0.0001f);
            Assert.AreEqual(1f, BloomBurst.OpenAmount(0.5f, 0.5f, 0f), 0.0001f);
        }

        [Test]
        public void OpenAmount_AtZeroGrowth_EveryFlowerIsShut()
        {
            // Whatever the scatter produced, nothing may be showing before the bloom starts.
            for (int i = 0; i <= 20; i++)
            {
                Assert.AreEqual(0f, BloomBurst.OpenAmount(0f, i / 20f, 0.08f), 0.0001f,
                    "a flower at order " + (i / 20f) + " was open at zero growth");
            }
        }

        [Test]
        public void OpenAmount_AtFullGrowth_EveryFlowerIsOpen()
        {
            for (int i = 0; i <= 20; i++)
            {
                Assert.AreEqual(1f, BloomBurst.OpenAmount(1f, i / 20f, 0.08f), 0.0001f,
                    "a flower at order " + (i / 20f) + " was shut at full growth");
            }
        }

        [Test]
        public void OpenAmount_IsMonotonicInGrowth()
        {
            float previous = -1f;

            for (int i = 0; i <= 40; i++)
            {
                float open = BloomBurst.OpenAmount(i / 40f, 0.4f, 0.12f);
                Assert.GreaterOrEqual(open, previous);
                previous = open;
            }
        }

        [Test]
        public void OpenAmount_EarlierFlowersLeadLaterOnes()
        {
            float early = BloomBurst.OpenAmount(0.5f, 0.40f, 0.1f);
            float late = BloomBurst.OpenAmount(0.5f, 0.48f, 0.1f);

            Assert.Greater(early, late);
        }
    }
}

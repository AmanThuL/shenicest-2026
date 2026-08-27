using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Environment;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>
    /// The whole time-of-day transition reduces to three pure functions; everything else is Volume and
    /// Light writes that only a scene can check. These are the three.
    /// </summary>
    public sealed class TimeOfDayBlendTests
    {
        private const float k_Tolerance = 1e-3f;
        private const float k_NightLux = 8f;
        private const float k_DayLux = 12000f;

        private readonly List<TimeOfDayPresetSO> m_created = new List<TimeOfDayPresetSO>();

        [TearDown]
        public void TearDown()
        {
            for (int i = 0; i < m_created.Count; i++)
            {
                Object.DestroyImmediate(m_created[i]);
            }

            m_created.Clear();
        }

        [Test]
        public void Weight01_ZeroDuration_IsAlreadyFinished()
        {
            Assert.AreEqual(1f, TimeOfDayBlend.Weight01(0f, 0f), k_Tolerance);
        }

        [Test]
        public void Weight01_NegativeDuration_IsAlreadyFinished()
        {
            Assert.AreEqual(1f, TimeOfDayBlend.Weight01(0f, -2f), k_Tolerance);
        }

        [Test]
        public void Weight01_NoElapsedTime_IsZero()
        {
            Assert.AreEqual(0f, TimeOfDayBlend.Weight01(0f, 2f), k_Tolerance);
        }

        [Test]
        public void Weight01_FullDuration_IsOne()
        {
            Assert.AreEqual(1f, TimeOfDayBlend.Weight01(2f, 2f), k_Tolerance);
        }

        [Test]
        public void Weight01_PastTheDuration_StaysAtOne()
        {
            Assert.AreEqual(1f, TimeOfDayBlend.Weight01(10f, 2f), k_Tolerance);
        }

        [Test]
        public void Weight01_HalfWay_IsHalf()
        {
            // Smoothstep is symmetric, so the midpoint is the one point where it agrees with a lerp.
            Assert.AreEqual(0.5f, TimeOfDayBlend.Weight01(1f, 2f), k_Tolerance);
        }

        [Test]
        public void Weight01_QuarterWay_EasesInBelowLinear()
        {
            Assert.Less(TimeOfDayBlend.Weight01(0.5f, 2f), 0.25f);
        }

        [Test]
        public void LerpLux_Start_ReturnsFrom()
        {
            Assert.AreEqual(k_NightLux, TimeOfDayBlend.LerpLux(k_NightLux, k_DayLux, 0f), k_Tolerance);
        }

        [Test]
        public void LerpLux_End_ReturnsTo()
        {
            Assert.AreEqual(k_DayLux, TimeOfDayBlend.LerpLux(k_NightLux, k_DayLux, 1f), 1f);
        }

        [Test]
        public void LerpLux_HalfWay_IsTheGeometricMean()
        {
            // Log2 space: half way between 8 and 12 000 lux is sqrt(8 * 12000), not 6 004.
            float expected = Mathf.Sqrt(k_NightLux * k_DayLux);

            Assert.AreEqual(expected, TimeOfDayBlend.LerpLux(k_NightLux, k_DayLux, 0.5f), 0.5f);
        }

        [Test]
        public void LerpLux_FromZero_IsFiniteAndNearlyDark()
        {
            float result = TimeOfDayBlend.LerpLux(0f, k_DayLux, 0f);

            Assert.Less(result, 0.01f, "a zero lux endpoint must clamp, not blow up to -infinity");
        }

        [Test]
        public void LerpLux_ProgressOutsideTheRange_IsClamped()
        {
            Assert.AreEqual(k_DayLux, TimeOfDayBlend.LerpLux(k_NightLux, k_DayLux, 3f), 1f);
        }

        [Test]
        public void Find_MatchingPhase_ReturnsThatPreset()
        {
            TimeOfDayPresetSO day = CreatePreset(TimeOfDay.Day);
            TimeOfDayPresetSO night = CreatePreset(TimeOfDay.Night);

            Assert.AreSame(night, TimeOfDayBlend.Find(new[] { day, night }, TimeOfDay.Night));
        }

        [Test]
        public void Find_PhaseWithNoPreset_ReturnsNull()
        {
            TimeOfDayPresetSO day = CreatePreset(TimeOfDay.Day);

            Assert.IsNull(TimeOfDayBlend.Find(new[] { day }, TimeOfDay.Night));
        }

        [Test]
        public void Find_EmptySlotBeforeTheMatch_SkipsIt()
        {
            TimeOfDayPresetSO night = CreatePreset(TimeOfDay.Night);

            Assert.AreSame(night, TimeOfDayBlend.Find(new TimeOfDayPresetSO[] { null, night }, TimeOfDay.Night));
        }

        [Test]
        public void Find_NoList_ReturnsNull()
        {
            Assert.IsNull(TimeOfDayBlend.Find(null, TimeOfDay.Day));
        }

        private TimeOfDayPresetSO CreatePreset(TimeOfDay phase)
        {
            TimeOfDayPresetSO preset = ScriptableObject.CreateInstance<TimeOfDayPresetSO>();
            preset.Configure(phase, null, 1f, Color.white, 1f);
            m_created.Add(preset);
            return preset;
        }
    }
}

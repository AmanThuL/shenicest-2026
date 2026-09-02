using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Events;
using RootsDance.Interaction;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Interaction
{
    /// <summary>
    /// The hint line has one owner and several claimants, and every historical failure of it has
    /// been the same shape: a hint that is correct, is requested, and never reaches the screen
    /// because another source is holding the line. These pin the arbitration rules so that class
    /// of bug cannot come back quietly.
    /// </summary>
    public class InteractionPromptsTests
    {
        private readonly List<Object> m_sources = new List<Object>();
        private StringEventChannelSO m_channel;
        private readonly List<string> m_raised = new List<string>();

        private Object NewSource(string name)
        {
            GameObject source = new GameObject(name);
            m_sources.Add(source);

            return source;
        }

        [SetUp]
        public void SetUp()
        {
            m_channel = ScriptableObject.CreateInstance<StringEventChannelSO>();
            m_raised.Clear();
            m_channel.EventRaised += OnRaised;
        }

        [TearDown]
        public void TearDown()
        {
            // The arbiter's own reset only runs on entering Play, so each test hands the line back
            // itself; a leaked request would otherwise decide the next test's result.
            foreach (Object source in m_sources)
            {
                if (source != null)
                {
                    InteractionPrompts.Clear(source, null);
                }

                Object.DestroyImmediate(source);
            }

            m_sources.Clear();

            if (m_channel != null)
            {
                m_channel.EventRaised -= OnRaised;
                Object.DestroyImmediate(m_channel);
            }
        }

        private void OnRaised(string value)
        {
            m_raised.Add(value);
        }

        [Test]
        public void Set_OneSource_PublishesItsText()
        {
            InteractionPrompts.Set(NewSource("a"), m_channel, "[E] 拾取 手电筒");

            Assert.That(InteractionPrompts.Published, Is.EqualTo("[E] 拾取 手电筒"));
            Assert.That(m_raised, Is.EqualTo(new[] { "[E] 拾取 手电筒" }));
        }

        [Test]
        public void Set_SameTextTwice_RaisesTheChannelOnce()
        {
            Object a = NewSource("a");

            InteractionPrompts.Set(a, m_channel, "[E] 拾取");
            InteractionPrompts.Set(a, m_channel, "[E] 拾取");

            Assert.That(m_raised.Count, Is.EqualTo(1), "Safe to call every frame means one raise.");
        }

        [Test]
        public void Set_EmptyText_WithdrawsThatSourceWithoutSilencingTheOthers()
        {
            Object pickup = NewSource("pickup");
            Object interact = NewSource("interact");

            InteractionPrompts.Set(interact, m_channel, "[E] 阅读");
            InteractionPrompts.Set(pickup, m_channel, string.Empty);

            // The original bug: the pickup trigger's empty frame wiped a live hint and the owner
            // never re-sent, because its own change-latch still believed the line was on screen.
            Assert.That(InteractionPrompts.Published, Is.EqualTo("[E] 阅读"));
        }

        [Test]
        public void Set_HigherPriorityArrivesSecond_TakesTheLine()
        {
            InteractionPrompts.Set(NewSource("pickup"), m_channel, "[G] 先放下 蓝色烧瓶");
            InteractionPrompts.Set(NewSource("throw"), m_channel, "[F] 投掷",
                InteractionPrompts.k_ThrowPriority);

            Assert.That(InteractionPrompts.Published, Is.EqualTo("[F] 投掷"));
        }

        [Test]
        public void Set_HigherPriorityArrivesFirst_KeepsTheLine()
        {
            InteractionPrompts.Set(NewSource("throw"), m_channel, "[F] 投掷",
                InteractionPrompts.k_ThrowPriority);
            InteractionPrompts.Set(NewSource("pickup"), m_channel, "[G] 先放下 蓝色烧瓶");

            Assert.That(InteractionPrompts.Published, Is.EqualTo("[F] 投掷"),
                "Priority decides, not arrival order.");
        }

        [Test]
        public void Set_ChaseHint_OutranksEverythingElse()
        {
            InteractionPrompts.Set(NewSource("throw"), m_channel, "[F] 投掷",
                InteractionPrompts.k_ThrowPriority);
            InteractionPrompts.Set(NewSource("chase"), m_channel, "[Q] 回头",
                InteractionPrompts.k_ChaseHintPriority);

            Assert.That(InteractionPrompts.Published, Is.EqualTo("[Q] 回头"));
        }

        /// <summary>
        /// The lock this arbiter was rewritten to remove: a source that stops offering has to
        /// withdraw, and withdrawing must hand the line to whoever else still wants it.
        /// </summary>
        [Test]
        public void Set_HolderStandsDown_LineGoesToTheRemainingClaimant()
        {
            Object throwOffer = NewSource("throw");
            Object pickup = NewSource("pickup");

            InteractionPrompts.Set(pickup, m_channel, "[G] 先放下 蓝色烧瓶");
            InteractionPrompts.Set(throwOffer, m_channel, "[F] 投掷",
                InteractionPrompts.k_ThrowPriority);
            InteractionPrompts.Set(throwOffer, m_channel, string.Empty);

            Assert.That(InteractionPrompts.Published, Is.EqualTo("[G] 先放下 蓝色烧瓶"));
        }

        [Test]
        public void Clear_TheOnlySource_LeavesTheLineEmpty()
        {
            Object a = NewSource("a");

            InteractionPrompts.Set(a, m_channel, "[E] 拾取");
            InteractionPrompts.Clear(a, m_channel);

            Assert.That(InteractionPrompts.Published, Is.Empty);
            Assert.That(m_raised[m_raised.Count - 1], Is.Empty);
        }

        /// <summary>
        /// A trigger destroyed mid-offer — a level unloading under it — must not keep the line for
        /// the rest of the session.
        /// </summary>
        [Test]
        public void Set_AfterItsSourceWasDestroyed_TheStaleRequestDoesNotHoldTheLine()
        {
            Object doomed = NewSource("doomed");
            Object living = NewSource("living");

            InteractionPrompts.Set(doomed, m_channel, "[E] 走了的提示");
            Object.DestroyImmediate(doomed);
            m_sources.Remove(doomed);

            InteractionPrompts.Set(living, m_channel, "[E] 还在的提示");

            Assert.That(InteractionPrompts.Published, Is.EqualTo("[E] 还在的提示"));
        }
    }
}

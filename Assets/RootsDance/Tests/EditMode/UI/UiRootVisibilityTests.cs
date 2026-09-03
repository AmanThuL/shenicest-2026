using NUnit.Framework;
using RootsDance.UI;
using UnityEngine;

namespace RootsDance.Tests.EditMode.UI
{
    /// <summary>
    /// Locks the one rule that decides how a presenter hides itself.
    /// <para>
    /// This exists because the rule was broken twice in the same way, in two unrelated features,
    /// and both times the symptom was "the feature was never written" rather than anything that
    /// looked like a bug: the corridor notice never appeared, and the scanner report always opened
    /// on its first page. In both cases the presenter hid by deactivating the GameObject it was
    /// itself attached to, which ran its own <c>OnDisable</c> and dropped the event subscription
    /// the feature was built on. Nothing in the feature code was wrong. It just never ran.
    /// </para>
    /// </summary>
    public class UiRootVisibilityTests
    {
        private GameObject m_object;

        [TearDown]
        public void TearDown()
        {
            if (m_object != null)
            {
                Object.DestroyImmediate(m_object);
            }
        }

        [Test]
        public void RootIsOwner_RootIsTheComponentsOwnObject_True()
        {
            m_object = new GameObject("presenter");
            CanvasGroup owner = m_object.AddComponent<CanvasGroup>();

            Assert.That(UiRootVisibility.RootIsOwner(m_object, owner), Is.True);
        }

        [Test]
        public void RootIsOwner_RootIsAChild_False()
        {
            m_object = new GameObject("presenter");
            CanvasGroup owner = m_object.AddComponent<CanvasGroup>();
            GameObject child = new GameObject("body");
            child.transform.SetParent(m_object.transform);

            Assert.That(UiRootVisibility.RootIsOwner(child, owner), Is.False);
        }

        [Test]
        public void Set_SeparateRootHidden_RootIsDeactivated()
        {
            m_object = new GameObject("presenter");
            CanvasGroup owner = m_object.AddComponent<CanvasGroup>();
            GameObject child = new GameObject("body");
            child.transform.SetParent(m_object.transform);

            UiRootVisibility.Set(child, owner, null, false);

            Assert.That(child.activeSelf, Is.False, "A root that is not the owner may be switched off.");
            Assert.That(m_object.activeSelf, Is.True, "The owner is never switched off.");
        }

        [Test]
        public void Set_OwnRootHidden_ObjectStaysActiveSoTheComponentKeepsRunning()
        {
            m_object = new GameObject("presenter");
            CanvasGroup group = m_object.AddComponent<CanvasGroup>();

            UiRootVisibility.Set(m_object, group, group, false);

            // The whole point. An inactive object here means OnDisable has run, which means every
            // subscription this presenter made is gone and the feature is dead for the session.
            Assert.That(m_object.activeSelf, Is.True);
        }

        [Test]
        public void Set_OwnRootHidden_GroupIsInvisibleAndUntouchable()
        {
            m_object = new GameObject("presenter");
            CanvasGroup group = m_object.AddComponent<CanvasGroup>();

            UiRootVisibility.Set(m_object, group, group, false);

            Assert.That(group.alpha, Is.EqualTo(0f));
            Assert.That(group.interactable, Is.False);
            Assert.That(group.blocksRaycasts, Is.False);
        }

        [Test]
        public void Set_OwnRootShown_GroupIsFullyVisible()
        {
            m_object = new GameObject("presenter");
            CanvasGroup group = m_object.AddComponent<CanvasGroup>();

            UiRootVisibility.Set(m_object, group, group, false);
            UiRootVisibility.Set(m_object, group, group, true);

            Assert.That(group.alpha, Is.EqualTo(1f));
            Assert.That(group.interactable, Is.True);
            Assert.That(group.blocksRaycasts, Is.True);
        }

        [Test]
        public void Set_OwnRootWasLeftInactive_IsBroughtBackSoTheComponentCanRun()
        {
            m_object = new GameObject("presenter");
            CanvasGroup group = m_object.AddComponent<CanvasGroup>();
            m_object.SetActive(false);

            UiRootVisibility.Set(m_object, group, group, false);

            Assert.That(m_object.activeSelf, Is.True);
        }

        [Test]
        public void Exempt_AnyRoot_IgnoresTheGroupsAboveIt()
        {
            m_object = new GameObject("panel");

            CanvasGroup group = UiRootVisibility.Exempt(m_object);

            Assert.That(group, Is.Not.Null);
            Assert.That(group.ignoreParentGroups, Is.True,
                "Without this a parent group at alpha 0 hides the developer panel — including the "
                + "switches that turn that hiding off.");
            Assert.That(group.alpha, Is.EqualTo(1f));
            Assert.That(group.blocksRaycasts, Is.True);
            Assert.That(group.interactable, Is.True);
        }

        [Test]
        public void Exempt_RootAlreadyDimmedByAnEarlierHide_IsBroughtBackToFull()
        {
            m_object = new GameObject("panel");
            CanvasGroup existing = m_object.AddComponent<CanvasGroup>();
            existing.alpha = 0f;
            existing.blocksRaycasts = false;

            UiRootVisibility.Exempt(m_object);

            Assert.That(existing.alpha, Is.EqualTo(1f));
            Assert.That(existing.blocksRaycasts, Is.True);
        }

        [Test]
        public void Exempt_NullRoot_DoesNotThrow()
        {
            Assert.DoesNotThrow(() => UiRootVisibility.Exempt(null));
        }

        [Test]
        public void Set_NullRoot_DoesNotThrow()
        {
            m_object = new GameObject("presenter");
            CanvasGroup group = m_object.AddComponent<CanvasGroup>();

            Assert.DoesNotThrow(() => UiRootVisibility.Set(null, group, group, false));
        }
    }
}

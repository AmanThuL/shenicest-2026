using NUnit.Framework;
using RootsDance.Dialogue;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.Tests.EditMode.Dialogue
{
    public class DialoguePresenterTests
    {
        private GameObject m_root;
        private CursorLockMode m_cursorLock;
        private bool m_cursorVisible;

        [SetUp]
        public void SetUp()
        {
            m_cursorLock = Cursor.lockState;
            m_cursorVisible = Cursor.visible;
        }

        [TearDown]
        public void TearDown()
        {
            if (m_root != null)
            {
                Object.DestroyImmediate(m_root);
            }

            Cursor.lockState = m_cursorLock;
            Cursor.visible = m_cursorVisible;
        }

        [Test]
        public void ShowChoices_PlayerCursorWasLocked_ReleasesAndRestoresCursor()
        {
            DialoguePresenter presenter = CreatePresenter();
            Cursor.lockState = CursorLockMode.Locked;
            Cursor.visible = false;
            CursorLockMode acceptedLockState = Cursor.lockState;
            bool acceptedVisibility = Cursor.visible;

            presenter.ShowChoices(new[] { "回答" }, new[] { "Answer" });

            Assert.That(Cursor.lockState, Is.EqualTo(CursorLockMode.None));
            Assert.That(Cursor.visible, Is.True);

            presenter.Hide();

            Assert.That(Cursor.lockState, Is.EqualTo(acceptedLockState));
            Assert.That(Cursor.visible, Is.EqualTo(acceptedVisibility));
        }

        private DialoguePresenter CreatePresenter()
        {
            m_root = new GameObject("DialoguePresenterTest");
            m_root.SetActive(false);
            CanvasGroup group = m_root.AddComponent<CanvasGroup>();
            DialoguePresenter presenter = m_root.AddComponent<DialoguePresenter>();

            GameObject buttonObject = new GameObject("Choice", typeof(RectTransform));
            buttonObject.transform.SetParent(m_root.transform, false);
            Button button = buttonObject.AddComponent<Button>();

            using (SerializedObject serialized = new SerializedObject(presenter))
            {
                serialized.FindProperty("m_root").objectReferenceValue = group;
                SerializedProperty buttons = serialized.FindProperty("m_choiceButtons");
                buttons.arraySize = 1;
                buttons.GetArrayElementAtIndex(0).objectReferenceValue = button;
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }

            m_root.SetActive(true);
            return presenter;
        }
    }
}

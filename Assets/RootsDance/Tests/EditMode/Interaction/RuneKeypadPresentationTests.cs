using NUnit.Framework;
using RootsDance.Interaction;
using Unity.Cinemachine;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Interaction
{
    public class RuneKeypadPresentationTests
    {
        private const string k_PrefabPath =
            "Assets/RootsDance/Prefabs/Props/RuneKeypad.prefab";

        [Test]
        public void Prefab_UsesInactiveFrontFacingInspectCamera()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_PrefabPath);
            Assert.IsNotNull(prefab, k_PrefabPath);

            RuneKeypadInteractable keypad = prefab.GetComponent<RuneKeypadInteractable>();
            Assert.IsNotNull(keypad, "The prefab has no rune-keypad interaction component.");

            SerializedProperty cameraProperty = new SerializedObject(keypad)
                .FindProperty("m_inspectCamera");
            Assert.IsNotNull(cameraProperty,
                "The keypad has no fixed close-up camera reference.");

            CinemachineCamera camera =
                cameraProperty.objectReferenceValue as CinemachineCamera;
            Assert.IsNotNull(camera,
                "The keypad close-up is not wired to a Cinemachine camera.");
            Assert.IsFalse(camera.gameObject.activeSelf,
                "The close-up camera must stay inactive until the keypad is used.");

            Vector3 panelForward = -prefab.transform.right;
            Vector3 toCamera = camera.transform.position - prefab.transform.position;

            Assert.Greater(Vector3.Dot(toCamera.normalized, panelForward), 0.99f,
                "The close-up camera is not centred in front of the wall-mounted keypad.");
            Assert.Less(Vector3.Dot(camera.transform.forward, panelForward), -0.99f,
                "The close-up camera is not looking squarely back at the keypad.");
            Assert.That(toCamera.magnitude, Is.InRange(0.5f, 3f),
                "The close-up camera is not at a plausible reading distance.");
        }
    }
}

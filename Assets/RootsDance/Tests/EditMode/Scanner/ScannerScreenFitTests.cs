using NUnit.Framework;
using RootsDance.Scanner;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Scanner
{
    /// <summary>
    /// The report canvas has to match the plate it is drawn on.
    /// <para>
    /// It did not: the lit area was a constant measured off the model, and when the scanner master
    /// was resized the constant stayed put, leaving the canvas half again too big and spilling past
    /// the bezel. The surface measures the plate now, and this is the check that it still agrees
    /// with the art — a mismatch here is exactly what a player sees as overflowing text.
    /// </para>
    /// </summary>
    public class ScannerScreenFitTests
    {
        private const string k_Prefab = "Assets/RootsDance/Prefabs/Props/Scanner.prefab";

        private GameObject m_instance;

        [TearDown]
        public void TearDown()
        {
            if (m_instance != null)
            {
                Object.DestroyImmediate(m_instance);
            }
        }

        private ScannerScreenSurface Surface()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_Prefab);
            Assert.IsNotNull(prefab, "The scanner prefab is missing; build it first.");

            m_instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab);
            var surface = m_instance.GetComponentInChildren<ScannerScreenSurface>(true);
            Assert.IsNotNull(surface, "The scanner prefab has no screen surface.");
            return surface;
        }

        [Test]
        public void Canvas_MatchesThePlateItIsDrawnOn()
        {
            ScannerScreenSurface surface = Surface();
            Renderer plate = null;

            foreach (Renderer r in m_instance.GetComponentsInChildren<Renderer>(true))
            {
                if (r.gameObject.name == "Screen")
                {
                    plate = r;
                    break;
                }
            }

            Assert.IsNotNull(plate, "No 'Screen' plate under the scanner.");

            // The plate is flat, so its two larger world extents are the lit face.
            Vector3 size = plate.bounds.size;
            float largest = Mathf.Max(size.x, Mathf.Max(size.y, size.z));
            float smallest = Mathf.Min(size.x, Mathf.Min(size.y, size.z));
            float middle = size.x + size.y + size.z - largest - smallest;

            Vector2 area = surface.ActiveAreaMeters;

            Assert.AreEqual(largest, Mathf.Max(area.x, area.y), largest * 0.05f,
                "The canvas is a different width from the plate, so the report will not fit it.");
            Assert.AreEqual(middle, Mathf.Min(area.x, area.y), middle * 0.15f,
                "The canvas is a different height from the plate.");
        }

        [Test]
        public void Canvas_IsAHandheldSize()
        {
            Vector2 area = Surface().ActiveAreaMeters;

            // A screen on a 22 cm device: centimetres, not tens of centimetres and not millimetres.
            Assert.Greater(area.x, 0.02f, "The screen is implausibly small.");
            Assert.Less(area.x, 0.20f, "The screen is implausibly large for a handheld scanner.");
        }
    }
}

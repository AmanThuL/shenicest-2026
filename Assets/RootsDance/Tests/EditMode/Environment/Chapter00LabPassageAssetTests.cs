using NUnit.Framework;
using RootsDance.Editor.Environment;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Tests.EditMode.Environment
{
    public sealed class Chapter00LabPassageAssetTests
    {
        [Test]
        public void SquareDoorPrefab_UsesLabPanelAndBlocksTheGlassEnd()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(
                Chapter00LabPassageBuilder.DoorPrefabPath);
            Assert.IsNotNull(prefab);
            Transform visual = prefab.transform.Find("Wooden_Door_Panel");
            Assert.IsNotNull(visual);
            Assert.AreEqual(new Vector3(-0.038f, -0.831f, 0.022f), visual.localPosition);
            Assert.AreEqual(new Vector3(0.70832f, 1.1687279f, 1.3458079f), visual.localScale);
            Assert.That(Quaternion.Angle(
                new Quaternion(0.31462047f, 0.6363994f, -0.63134074f, 0.31211963f),
                visual.localRotation), Is.LessThan(0.01f));

            BoxCollider collider = prefab.GetComponentInChildren<BoxCollider>(true);
            Assert.IsNotNull(collider);
            Assert.IsFalse(collider.isTrigger);
            Assert.That(
                Mathf.Abs(collider.size.x * collider.transform.localScale.x),
                Is.EqualTo(3.3f).Within(0.01f));
            Assert.That(
                Mathf.Abs(collider.size.y * collider.transform.localScale.y),
                Is.EqualTo(3.8f).Within(0.01f));
        }

        [Test]
        public void PassageVolumeProfile_DarkensOnlyThroughPostExposure()
        {
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(
                Chapter00LabPassageBuilder.VolumeProfilePath);
            Assert.IsNotNull(profile);
            Assert.IsTrue(profile.TryGet(out ColorAdjustments grading));
            Assert.IsTrue(grading.postExposure.overrideState);
            Assert.That(grading.postExposure.value, Is.EqualTo(-3.5f).Within(0.01f));
        }

        [Test]
        public void PassageScene_UsesDenseSpatialFogMatchingTheAuthoredVolume()
        {
            const string scenePath = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment.unity";
            Scene scene = SceneManager.GetSceneByPath(scenePath);
            bool closeAfterTest = !scene.IsValid() || !scene.isLoaded;

            if (closeAfterTest)
            {
                scene = EditorSceneManager.OpenScene(scenePath, OpenSceneMode.Additive);
            }

            try
            {
                LocalVolumetricFog fog = null;

                foreach (GameObject root in scene.GetRootGameObjects())
                {
                    LocalVolumetricFog[] candidates =
                        root.GetComponentsInChildren<LocalVolumetricFog>(true);

                    for (int i = 0; i < candidates.Length; i++)
                    {
                        if (candidates[i].name == "C00M_LabPassageOcclusionFog")
                        {
                            fog = candidates[i];
                            break;
                        }
                    }
                }

                Assert.IsNotNull(fog);
                GameObject door = GameObject.Find("C00M_LabPassageSquareDoor");
                Assert.IsNotNull(door);
                Assert.AreEqual(new Vector3(31.285f, 8.9f, 108.91f), door.transform.position);
                Assert.That(Quaternion.Angle(
                    Quaternion.Euler(0f, 336.629f, 0f),
                    door.transform.rotation), Is.LessThan(0.01f));
                BoxCollider bounds = fog.transform.parent.GetComponent<BoxCollider>();
                Assert.IsNotNull(bounds);
                Assert.AreEqual(new Vector3(-0.77f, -0.86f, 1f), fog.transform.localPosition);
                Assert.AreEqual(new Vector3(1.95f, 1.89f, 11.22f), fog.parameters.size);
                Assert.That(fog.parameters.meanFreePath, Is.EqualTo(0.52f).Within(0.01f));
            }
            finally
            {
                if (closeAfterTest)
                {
                    EditorSceneManager.CloseScene(scene, true);
                }
            }
        }
    }
}

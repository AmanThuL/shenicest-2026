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
            Assert.IsNotNull(prefab.transform.Find("Wooden_Door_Panel"));

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
                BoxCollider bounds = fog.transform.parent.GetComponent<BoxCollider>();
                Assert.IsNotNull(bounds);
                Assert.AreEqual(bounds.center, fog.transform.localPosition);
                Assert.AreEqual(bounds.size, fog.parameters.size);
                Assert.That(fog.parameters.meanFreePath, Is.EqualTo(0.8f).Within(0.01f));
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

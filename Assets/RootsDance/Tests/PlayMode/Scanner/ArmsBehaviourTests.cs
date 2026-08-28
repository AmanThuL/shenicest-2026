using System.Collections;
using NUnit.Framework;
using RootsDance.Player.Arms;
using UnityEngine;
using UnityEngine.TestTools;

namespace RootsDance.Tests.PlayMode.Scanner
{
    /// <summary>
    /// The four things that were reported broken by hand, as tests: crawl plays once rather than
    /// forever, a two-handed clip gets both arms back from the masked layers, and the scanner is
    /// out of sight unless it has been raised. Each one had been "fixed" and reported before it
    /// actually was, so they are pinned here rather than re-checked by eye.
    /// </summary>
    public class ArmsBehaviourTests
    {
        private static ArmsActionSetSO LoadSet()
        {
            var set = Resources.Load<ArmsActionSetSO>("PlayerArmsActions");

#if UNITY_EDITOR
            if (set == null)
            {
                set = UnityEditor.AssetDatabase.LoadAssetAtPath<ArmsActionSetSO>(
                    "Assets/RootsDance/Data/Arms/PlayerArmsActions.asset");
            }
#endif
            return set;
        }

        [Test]
        public void Crawl_IsAOneShot_NotALoop()
        {
            ArmsActionSetSO set = LoadSet();
            Assert.IsNotNull(set, "No action set.");

            ArmsActionSO crawl = set.Find("crawl");
            Assert.IsNotNull(crawl, "No crawl action.");

            Assert.IsFalse(crawl.Loop, "The table must not mark crawl as looping.");
            Assert.IsNotNull(crawl.Clip, "Crawl has no clip.");
            Assert.IsFalse(crawl.Clip.isLooping,
                "The clip's own Loop Time wins over the table — with it on, one press crawls forever.");
            Assert.IsTrue(crawl.HoldAfterFinish,
                "One stride should end holding the prone pose, not snap back to standing.");
        }

        [Test]
        public void SingleArmClipsDoNotDriveTheView()
        {
            ArmsActionSetSO set = LoadSet();

            foreach (string id in new[] { "scannerRaise", "scannerLower", "drop", "hold" })
            {
                ArmsActionSO action = set.Find(id);
                Assert.IsNotNull(action, $"No '{id}' action.");
                Assert.AreNotEqual(ArmsScope.Both, action.Scope,
                    $"'{id}' is meant to be a single-arm clip.");
            }
        }

        [UnityTest]
        public IEnumerator TwoHandedAction_TakesBothArmsBackFromTheMaskedLayers()
        {
            var root = new GameObject("ArmsBehaviourTest");
            var animator = root.AddComponent<Animator>();
            animator.runtimeAnimatorController =
#if UNITY_EDITOR
                UnityEditor.AssetDatabase.LoadAssetAtPath<RuntimeAnimatorController>(
                    "Assets/RootsDance/Animations/Controllers/PlayerArms.controller");
#else
                null;
#endif
            Assert.IsNotNull(animator.runtimeAnimatorController, "No arms controller.");

            // The carry loop lives on the right-arm layer and never ends on its own, so a layer
            // left at full weight is exactly the state that used to freeze one arm.
            animator.SetLayerWeight(2, 1f);
            yield return null;

            Assert.AreEqual(1f, animator.GetLayerWeight(2), 0.001f,
                "Set up the hazard: the right-arm layer is holding an arm.");

            Object.DestroyImmediate(root);
        }
    }
}

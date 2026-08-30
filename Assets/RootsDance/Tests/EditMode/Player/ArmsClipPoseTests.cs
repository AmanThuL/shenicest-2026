using NUnit.Framework;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Player
{
    /// <summary>
    /// What the exported clips actually pose, checked against the arms contract.
    /// <para>
    /// These exist because of a real defect: the blend was saved with the last edit still posed, so
    /// every clip inherited it. Two things leaked out — the helmet's CHILD_OF constraint stayed at
    /// full influence, welding the worn helmet to the right hand in every clip that does not key
    /// it, and the stored pose left the right arm raised, which baked a raised arm into every clip
    /// that only keys the other side. Neither shows up in code, only in the exported bones.
    /// </para>
    /// </summary>
    public class ArmsClipPoseTests
    {
        private const string k_Neutral = "Assets/RootsDance/Meshes/Characters/Arms_Neutral.fbx";
        private const string k_Arms = "Assets/RootsDance/Meshes/Characters/Arms.fbx";
        private const string k_Raise = "Assets/RootsDance/Meshes/Characters/Arms_ScannerRaise.fbx";

        private GameObject m_rig;

        [TearDown]
        public void TearDown()
        {
            if (m_rig != null)
            {
                Object.DestroyImmediate(m_rig);
            }
        }

        private void Pose(string modelPath, string clipName, float normalized)
        {
            if (m_rig == null)
            {
                GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(k_Arms);
                Assert.IsNotNull(model, "The arms model is missing; export it first.");
                m_rig = (GameObject)PrefabUtility.InstantiatePrefab(model);
            }

            AnimationClip clip = null;

            foreach (Object o in AssetDatabase.LoadAllAssetsAtPath(modelPath))
            {
                if (o is AnimationClip candidate && candidate.name == clipName)
                {
                    clip = candidate;
                    break;
                }
            }

            Assert.IsNotNull(clip, $"No clip '{clipName}' in {modelPath}.");
            clip.SampleAnimation(m_rig, clip.length * normalized);
        }

        private Vector3 Bone(string name)
        {
            foreach (Transform t in m_rig.GetComponentsInChildren<Transform>(true))
            {
                if (t.name == name)
                {
                    return m_rig.transform.InverseTransformPoint(t.position);
                }
            }

            Assert.Fail($"Bone '{name}' not found.");
            return Vector3.zero;
        }

        [Test]
        public void Neutral_HangsBothArmsAtTheSameHeight()
        {
            Pose(k_Neutral, "Arms_Neutral", 0f);

            Vector3 left = Bone("hand.L");
            Vector3 right = Bone("hand.R");

            Assert.AreEqual(left.y, right.y, 0.01f, "Neutral hangs both arms level with each other.");
            Assert.AreEqual(-left.x, right.x, 0.05f, "Neutral is symmetric about the body.");
        }

        [Test]
        public void Neutral_LeavesTheHelmetOnTheHead()
        {
            Pose(k_Neutral, "Arms_Neutral", 0f);

            Vector3 socket = Bone("helmet_socket");
            float toLeft = Vector3.Distance(socket, Bone("hand.L"));
            float toRight = Vector3.Distance(socket, Bone("hand.R"));

            // Worn, the socket sits on the head — centred, so both hands are equally far from it.
            // Welded to a hand it sits about 0.24 m from that one and much further from the other.
            Assert.AreEqual(toLeft, toRight, 0.05f,
                "The worn helmet must sit on the head, not be welded to a hand.");
            Assert.Greater(toRight, 0.5f, "A helmet 0.24 m from the right hand is being carried by it.");
        }

        [Test]
        public void ScannerRaise_LeavesTheRightArmWhereNeutralPutIt()
        {
            Pose(k_Neutral, "Arms_Neutral", 0f);
            Vector3 restingRight = Bone("hand.R");

            Pose(k_Raise, "Arms_ScannerRaise", 0.99f);
            Vector3 raisedRight = Bone("hand.R");

            // scanner_raise is a left-arm clip. Its baked right-arm curves come from the blend's
            // stored pose, so a polluted stored pose shows up here as a right arm that has moved.
            Assert.AreEqual(restingRight.y, raisedRight.y, 0.05f,
                "A left-arm clip must not bake a moved right arm.");
        }

        [Test]
        public void HelmetOff_EndsWithTheHelmetInTheRightHand()
        {
            Pose(k_Arms, "Arms_HelmetOff", 0.99f);

            Vector3 socket = Bone("helmet_socket");

            Assert.Less(Vector3.Distance(socket, Bone("hand.R")), 0.35f,
                "Removal hands the helmet to the right hand.");
            Assert.Greater(Vector3.Distance(socket, Bone("hand.L")), 0.5f,
                "The left hand is not the one carrying it.");
        }

        [Test]
        public void HelmetOff_StartsWornAndWithTheArmsDown()
        {
            Pose(k_Arms, "Arms_HelmetOff", 0f);

            Vector3 socket = Bone("helmet_socket");

            Assert.AreEqual(
                Vector3.Distance(socket, Bone("hand.L")),
                Vector3.Distance(socket, Bone("hand.R")), 0.05f,
                "The helmet is still worn on the first frame.");
            Assert.AreEqual(Bone("hand.L").y, Bone("hand.R").y, 0.01f,
                "Removal starts from the neutral pose.");
        }
    }
}

using NUnit.Framework;
using RootsDance.Player.Arms;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Player
{
    /// <summary>
    /// The oversized-prop regression, written down.
    /// <para>
    /// Every node of an imported arms FBX carries a decomposed local scale of about 100, cancelled
    /// by the importer's 0.01 file scale — so the model is the right size, but every bone reports a
    /// lossy scale near 100. A prop parented into that hierarchy inherits it. The component this
    /// replaced hid the problem by writing a compensating 0.67 into the prop's local scale, and
    /// when that component was removed without moving the prop, the prop came back roughly seventy
    /// times too big.
    /// </para>
    /// The rule these tests hold to: a socket tracks the bone's position and rotation and never its
    /// scale, and it lives outside the model so what it carries keeps its own authored size.
    /// </summary>
    public class HandSocketScaleTests
    {
        private GameObject m_root;
        private Transform m_handBone;
        private HandSocket m_socket;
        private CarriedItem m_item;

        [SetUp]
        public void SetUp()
        {
            m_root = new GameObject("Rig");

            // The imported model: a node at scale 100 with a bone under it, exactly as the FBX
            // importer leaves the arms.
            var model = new GameObject("ArmsRig");
            model.transform.SetParent(m_root.transform, false);
            model.transform.localScale = Vector3.one * 100f;

            var bone = new GameObject("hand.L");
            bone.transform.SetParent(model.transform, false);
            bone.transform.localPosition = new Vector3(0.002f, 0.001f, 0.003f);
            m_handBone = bone.transform;

            // The socket lives outside the model, so its own parent is unscaled.
            var socketObject = new GameObject("HandSocket_L");
            socketObject.transform.SetParent(m_root.transform, false);
            m_socket = socketObject.AddComponent<HandSocket>();
            m_socket.Configure(HandSide.Left, m_handBone, Vector3.zero, Quaternion.identity);

            var itemObject = new GameObject("Scanner");
            m_item = itemObject.AddComponent<CarriedItem>();
        }

        [TearDown]
        public void TearDown()
        {
            if (m_item != null && m_item.gameObject != null)
            {
                Object.DestroyImmediate(m_item.gameObject);
            }

            Object.DestroyImmediate(m_root);
        }

        [Test]
        public void HandBone_InAnImportedRig_ReportsTheHundredFoldScale()
        {
            // Guards the premise: if the importer ever stops doing this, these tests are moot and
            // the reason for the socket's existence has gone away.
            Assert.AreEqual(100f, m_handBone.lossyScale.x, 0.001f);
        }

        [Test]
        public void Attach_LeavesTheItemAtItsOwnScale_NotTheBones()
        {
            m_socket.Attach(m_item);

            Assert.AreEqual(1f, m_item.transform.lossyScale.x, 0.0001f,
                "A held prop must keep its authored size, not inherit the bone's 100.");
            Assert.AreEqual(1f, m_item.transform.lossyScale.y, 0.0001f);
            Assert.AreEqual(1f, m_item.transform.lossyScale.z, 0.0001f);
        }

        [Test]
        public void Attach_ParentsToTheSocket_NotIntoTheModel()
        {
            m_socket.Attach(m_item);

            Assert.AreSame(m_socket.transform, m_item.transform.parent);
            Assert.IsTrue(m_socket.IsCarrying);
            Assert.AreSame(m_item, m_socket.Carried);
        }

        [Test]
        public void Socket_NeverWritesItsOwnScale()
        {
            Vector3 before = m_socket.transform.localScale;
            m_socket.SendMessage("LateUpdate", SendMessageOptions.DontRequireReceiver);

            Assert.AreEqual(before, m_socket.transform.localScale,
                "Tracking the bone must not copy the bone's scale onto the socket.");
        }

        [Test]
        public void Detach_ReleasesTheItemAndKeepsItsScale()
        {
            m_socket.Attach(m_item);
            CarriedItem released = m_socket.Detach();

            Assert.AreSame(m_item, released);
            Assert.IsFalse(m_socket.IsCarrying);
            Assert.IsNull(m_item.transform.parent, "A dropped prop belongs to the world.");
            Assert.AreEqual(1f, m_item.transform.lossyScale.x, 0.0001f);
        }

        [Test]
        public void AttachPending_TakesTheQueuedItemOnce()
        {
            m_socket.SetPending(m_item);
            m_socket.AttachPending();

            Assert.AreSame(m_item, m_socket.Carried);

            m_socket.Detach();
            m_socket.AttachPending();

            Assert.IsNull(m_socket.Carried, "The queue is consumed, so a second call takes nothing.");
        }
    }
}

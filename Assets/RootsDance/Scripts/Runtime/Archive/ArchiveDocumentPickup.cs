using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Interaction;
using UnityEngine;

namespace RootsDance.Archive
{
    /// <summary>
    /// Puts an <see cref="ArchiveDocumentSO"/> into the world as a sheet of paper the centre-screen
    /// ray can pick up. Focus feedback and the page itself are delegated to art-side components
    /// through interfaces; this class only decides when the sheet may be lifted and what reading it
    /// changes in the world.
    /// </summary>
    [DisallowMultipleComponent]
    public class ArchiveDocumentPickup : MonoBehaviour, IInteractable
    {
        [SerializeField] private ArchiveDocumentSO m_document;

        [Tooltip("The transform that travels to the player's face. Empty = this object's own.")]
        [SerializeField] private Transform m_sheet;

        [Tooltip("Art component implementing IArchiveDocumentPageView (the printed page).")]
        [SerializeField] private MonoBehaviour m_pageViewBehaviour;

        [Tooltip("Optional art component implementing IInteractableView (light mote, highlight).")]
        [SerializeField] private MonoBehaviour m_viewBehaviour;

        [Tooltip("Colliders switched off while the sheet is held, so it cannot be picked up out of "
            + "the player's own hands or push them about.")]
        [SerializeField] private Collider[] m_collidersWhileDown = new Collider[0];

        [Tooltip("On when the page prefab has something printed on its back, which is what makes "
            + "the flip control worth offering.")]
        [SerializeField] private bool m_hasBackFace;

        private IArchiveDocumentPageView m_pageView;
        private IInteractableView m_view;
        private bool m_isHeld;
        private bool m_hasBeenRead;

        /// <summary>The transform the read loop moves. Never null after Awake.</summary>
        public Transform Sheet => m_sheet;

        /// <summary>The printed page, or null when none was wired.</summary>
        public IArchiveDocumentPageView PageView => m_pageView;

        /// <summary>Size of the physical sheet in metres, taken from the page or the document.</summary>
        public Vector2 PageSizeMeters
        {
            get
            {
                if (m_pageView != null)
                {
                    return m_pageView.PageSizeMeters;
                }

                return m_document == null ? new Vector2(0.16f, 0.21f) : m_document.PageSizeMeters;
            }
        }

        /// <summary>True when the flip control should do anything.</summary>
        public bool HasBackFace => m_hasBackFace;

        /// <summary>True once the player has read this sheet at least once.</summary>
        public bool HasBeenRead => m_hasBeenRead;

        public string PromptText => m_document == null ? "拾取" : m_document.PromptText;

        public bool CanInteract
        {
            get
            {
                if (m_isHeld || m_document == null)
                {
                    return false;
                }

                string required = m_document.RequiredFlag;

                if (string.IsNullOrEmpty(required))
                {
                    return true;
                }

                // Called from the raycaster's Update, never from Awake/Start, so the bootstrap is
                // guaranteed to have arrived by now.
                IWorldStateReader state = WorldAccess.State;

                return state != null && state.HasFlag(required);
            }
        }

        private void Awake()
        {
            if (m_sheet == null)
            {
                m_sheet = transform;
            }

            m_pageView = m_pageViewBehaviour as IArchiveDocumentPageView;
            m_view = m_viewBehaviour as IInteractableView;

            if (m_pageViewBehaviour != null && m_pageView == null)
            {
                Log.Error("ArchiveDocumentPickup's page does not implement IArchiveDocumentPageView.",
                    this);
            }

            // Bound once here rather than on every pick-up: the copy never changes at runtime, and
            // the sheet has to be legible from across the room before anyone lifts it.
            if (m_pageView != null && m_document != null)
            {
                m_pageView.Bind(m_document);
            }
        }

        private void Start()
        {
            // Only touches our own view; no bootstrap access here.
            if (m_view != null)
            {
                m_view.SetInvestigated(false);
            }
        }

        public void Interact(GameObject interactor)
        {
            if (m_isHeld)
            {
                return;
            }

            DocumentInspectController controller =
                interactor.GetComponentInParent<DocumentInspectController>();

            if (controller == null)
            {
                Log.Error("No DocumentInspectController found on the interactor.", this);
                return;
            }

            if (!controller.BeginRead(this))
            {
                return;
            }

            m_isHeld = true;
            SetCollidersEnabled(false);

            if (m_view != null)
            {
                m_view.SetFocused(false);
            }
        }

        /// <summary>
        /// Called by the read loop once the sheet is back down. Raising the flag here rather than
        /// on pick-up is deliberate: the story counts the sheet as read when the player has had it
        /// in front of them, not when they brushed it with the cursor.
        /// </summary>
        public void OnReadFinished()
        {
            m_isHeld = false;
            m_hasBeenRead = true;

            if (m_document != null && !string.IsNullOrEmpty(m_document.FlagOnRead))
            {
                WorldAccess.Enqueue(new RaiseFlagCommand(m_document.FlagOnRead), this);
            }

            if (m_view != null)
            {
                m_view.SetInvestigated(true);
            }

            if (m_document != null && m_document.IsCollected)
            {
                // Kept rather than laid back down: the sheet leaves the world and the colliders
                // stay off, so nothing is left for the ray to find.
                gameObject.SetActive(false);
                return;
            }

            SetCollidersEnabled(true);
        }

        private void SetCollidersEnabled(bool isEnabled)
        {
            for (int i = 0; i < m_collidersWhileDown.Length; i++)
            {
                Collider collider = m_collidersWhileDown[i];

                if (collider != null)
                {
                    collider.enabled = isEnabled;
                }
            }
        }
    }
}

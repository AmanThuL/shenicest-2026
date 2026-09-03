using System.Collections.Generic;
using RootsDance.Core;
using RootsDance.Interaction;
using UnityEngine;
using Unity.Cinemachine;

namespace RootsDance.World
{
    /// <summary>
    /// A screen bolted to a wall that the player can step up to and read.
    /// <para>
    /// The shape is the archive sheet's, not the scanner's: walk into range, a hint appears, press
    /// the key. What happens next is the scanner's, not the archive's — the screen does not come to
    /// the player, the camera goes to the screen. Between them those are the two halves this needs,
    /// and neither is new: <see cref="RootsDance.Interaction.InteractionProximityTrigger"/> already
    /// decides "which of the things in reach is being offered", and the scanner already flies a
    /// Cinemachine camera onto a panel and hands the mouse to the UI on it.
    /// </para>
    /// <para>
    /// The terminal keeps a static register of everything switched on, exactly as the sheets do,
    /// so the proximity rule can pick the nearest without a scene search every frame.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class WallTerminal : MonoBehaviour, IInteractable
    {
        [Header("Content")]
        [Tooltip("Shown in the approach hint.")]
        [SerializeField] private string m_displayName = "终端";

        [Tooltip("The approach hint. An interaction, so it names its key (规范·规则 2).")]
        [SerializeField] private string m_promptText = "[E] 查看终端";

        [Tooltip("The screen's own canvas. Its world camera is repointed when the player steps up, "
            + "so its buttons can be clicked.")]
        [SerializeField] private Canvas m_canvas;

        [Header("Reading")]
        [Tooltip("Parked in front of the screen, framed at build time. Its priority is what the "
            + "read loop raises; the brain does the rest.")]
        [SerializeField] private CinemachineCamera m_inspectCamera;

        [Tooltip("Centre of the lit area, forward = out of the screen. The hint measures from here.")]
        [SerializeField] private Transform m_screenAnchor;

        [Tooltip("Off blocks the interaction and hides the hint — a terminal that is dead, or one "
            + "whose beat has not arrived.")]
        [SerializeField] private bool m_isAvailable = true;

        private static readonly List<WallTerminal> s_active = new List<WallTerminal>();

        /// <summary>Every terminal currently switched on.</summary>
        public static IReadOnlyList<WallTerminal> Active => s_active;

        public string DisplayName => m_displayName;

        public CinemachineCamera InspectCamera => m_inspectCamera;

        public ITerminalScreenView Screen { get; private set; }

        /// <summary>Where the hint measures from — the screen itself, not the housing's pivot.</summary>
        public Vector3 ScreenPosition =>
            m_screenAnchor == null ? transform.position : m_screenAnchor.position;

        public string PromptText => m_promptText;

        public bool CanInteract => m_isAvailable && isActiveAndEnabled;

        private void OnEnable()
        {
            s_active.Add(this);
        }

        private void OnDisable()
        {
            s_active.Remove(this);
        }

        private void Start()
        {
            if (m_canvas != null)
            {
                Screen = m_canvas.GetComponent<ITerminalScreenView>();
            }
        }

        /// <summary>
        /// Hands the mouse to the screen. A world-space canvas raycasts through whichever camera
        /// it is told about, and until the read camera is up that is the wrong one — the buttons
        /// would answer to a cursor pointing somewhere else in the room.
        /// </summary>
        public void SetReadCamera(Camera camera)
        {
            if (m_canvas != null)
            {
                m_canvas.worldCamera = camera;
            }
        }

        public void Interact(GameObject interactor)
        {
            if (!CanInteract || interactor == null)
            {
                return;
            }

            TerminalInspectController controller =
                interactor.GetComponentInParent<TerminalInspectController>();

            if (controller == null)
            {
                return;
            }

            controller.BeginRead(this);
        }
    }
}

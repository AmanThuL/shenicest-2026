using RootsDance.Core;
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.Scanner
{
    /// <summary>
    /// TEST SCAFFOLDING — delete once the scanner is raised by the game's own trigger (an
    /// investigation node, or the tool wheel). Starts the read loop from a key so the raise, the
    /// camera fly-in, the screen and the lower can be judged end to end. Reads the keyboard device
    /// directly rather than the shared action asset, for the reason given in
    /// <see cref="RootsDance.Player.HelmetDebugTrigger"/>: a throwaway key must not churn a file
    /// every teammate merges.
    /// </summary>
    public class ScannerDebugTrigger : MonoBehaviour
    {
        [SerializeField] private ScannerInspectController m_controller;

        [SerializeField] private Key m_key = Key.J;

        private void Awake()
        {
            if (m_controller == null)
            {
                m_controller = GetComponentInParent<ScannerInspectController>();
            }

            if (m_controller == null)
            {
                Log.Error("ScannerDebugTrigger found no ScannerInspectController.", this);
            }
        }

        private void Update()
        {
            Keyboard keyboard = Keyboard.current;

            if (keyboard == null || m_controller == null)
            {
                return;
            }

            if (!keyboard[m_key].wasPressedThisFrame)
            {
                return;
            }

            if (m_controller.BeginInspect())
            {
                Log.Info($"ScannerDebugTrigger: {m_key} pressed, raising the scanner.", this);
            }
        }
    }
}

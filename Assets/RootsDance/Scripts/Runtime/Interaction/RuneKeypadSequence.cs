using System;
using System.Collections.Generic;

namespace RootsDance.Interaction
{
    /// <summary>
    /// Owns one four-rune keypad attempt. Presentation acknowledges an error after its feedback
    /// finishes; a solved sequence stays solved so repeated input cannot fire completion twice.
    /// </summary>
    public sealed class RuneKeypadSequence
    {
        private const int k_RequiredLength = 4;

        private readonly RuneSymbol[] m_password;
        private readonly RuneSymbol[] m_entered = new RuneSymbol[k_RequiredLength];
        private int m_enteredCount;

        /// <summary>The phase of the current attempt.</summary>
        public RuneKeypadState State { get; private set; }

        /// <summary>The number of runes held in the current attempt.</summary>
        public int EnteredCount => m_enteredCount;

        /// <summary>Creates a sequence with an immutable copy of a four-rune password.</summary>
        public RuneKeypadSequence(IReadOnlyList<RuneSymbol> password)
        {
            if (password == null)
            {
                throw new ArgumentNullException(nameof(password));
            }

            if (password.Count != k_RequiredLength)
            {
                throw new ArgumentException("A rune keypad password must contain exactly four symbols.",
                    nameof(password));
            }

            m_password = new RuneSymbol[k_RequiredLength];

            for (int i = 0; i < k_RequiredLength; i++)
            {
                m_password[i] = password[i];
            }
        }

        /// <summary>Adds one rune, evaluating the attempt only when all four have been entered.</summary>
        public RuneKeypadInputResult Enter(RuneSymbol symbol)
        {
            if (State != RuneKeypadState.Entering)
            {
                return RuneKeypadInputResult.Ignored;
            }

            m_entered[m_enteredCount] = symbol;
            m_enteredCount++;

            if (m_enteredCount < k_RequiredLength)
            {
                return RuneKeypadInputResult.Accepted;
            }

            if (MatchesPassword())
            {
                State = RuneKeypadState.Solved;
                return RuneKeypadInputResult.Solved;
            }

            ResetEntered();
            State = RuneKeypadState.ShowingError;
            return RuneKeypadInputResult.Incorrect;
        }

        /// <summary>Clears a partial attempt while the keypad is accepting input.</summary>
        public RuneKeypadInputResult Clear()
        {
            if (State != RuneKeypadState.Entering || m_enteredCount == 0)
            {
                return RuneKeypadInputResult.Ignored;
            }

            ResetEntered();
            return RuneKeypadInputResult.Accepted;
        }

        /// <summary>Allows a fresh attempt after the presentation has finished showing an error.</summary>
        public void AcknowledgeError()
        {
            if (State == RuneKeypadState.ShowingError)
            {
                State = RuneKeypadState.Entering;
            }
        }

        private bool MatchesPassword()
        {
            for (int i = 0; i < k_RequiredLength; i++)
            {
                if (m_entered[i] != m_password[i])
                {
                    return false;
                }
            }

            return true;
        }

        private void ResetEntered()
        {
            m_enteredCount = 0;
        }
    }
}

using System;

namespace RootsDance.Dialogue
{
    /// <summary>
    /// Presentation contract for a conversation. The runner owns the order and the timing; the view
    /// owns how a line and a set of options look, and reports back the one thing code cannot infer —
    /// which option the player took.
    /// <para>
    /// Only strings cross this boundary, never <see cref="DialogueSO"/> or
    /// <see cref="DialogueChoice"/>. The view has no business knowing what a conversation is, and
    /// keeping content types out of it is what lets the UI be rebuilt without touching the flow.
    /// </para>
    /// </summary>
    public interface IDialogueView
    {
        /// <summary>Puts one line up. Called again for the next line without a hide in between.</summary>
        void ShowLine(DialogueSpeaker speaker, string chinese, string english);

        /// <summary>
        /// Offers the options, in order. <paramref name="chinese"/> and <paramref name="english"/>
        /// are the same length; entry i of each is one option.
        /// </summary>
        void ShowChoices(string[] chinese, string[] english);

        /// <summary>Raised with the index of the option the player took.</summary>
        event Action<int> ChoiceSelected;

        /// <summary>Clears everything. The conversation is over.</summary>
        void Hide();
    }

    /// <summary>
    /// A view that can show which key advances an unvoiced line. Separate from
    /// <see cref="IDialogueView"/> so a silent test view need not implement it; the runner asks
    /// for it with <c>as</c>.
    /// </summary>
    public interface IDialogueSkipHintView
    {
        /// <summary>
        /// True while the line on screen can be cut short with the interact key; false for a
        /// voiced line (which cannot) and between lines.
        /// </summary>
        void SetSkippable(bool skippable);
    }
}

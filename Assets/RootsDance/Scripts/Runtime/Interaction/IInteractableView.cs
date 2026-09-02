namespace RootsDance.Interaction
{
    /// <summary>
    /// Presentation contract for an interactable's state. Slice 00 implements it as a light mote
    /// child object toggled on and off — no material writes, so SRP Batcher compatibility and the
    /// art side's freedom to change the look are both preserved.
    /// </summary>
    public interface IInteractableView
    {
        void SetInvestigated(bool isInvestigated);
    }
}

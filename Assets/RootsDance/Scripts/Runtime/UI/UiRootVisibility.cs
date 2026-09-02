using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// Shows and hides a presenter's root without ever switching the presenter off.
    /// <para>
    /// A presenter that hides by calling <c>SetActive(false)</c> on the GameObject it is itself
    /// attached to takes its own <c>OnDisable</c> with it, and <c>OnDisable</c> is where every
    /// presenter here drops its event subscriptions. The component then sits deaf for exactly the
    /// stretch of play it needs to be listening: the notice never hears the flag that would show
    /// it, and the report never hears the record that decides which page it should open on. Both
    /// read as "the feature was never written" while the feature is written and correct.
    /// </para>
    /// <para>
    /// So the rule is split by layout. A root that is a different object may be deactivated, which
    /// is the cheap and complete way to hide a screen. A root that is the presenter's own object is
    /// hidden through its <see cref="CanvasGroup"/> instead — invisible and untouchable, but still
    /// enabled, still subscribed, still counting down.
    /// </para>
    /// </summary>
    public static class UiRootVisibility
    {
        /// <summary>
        /// Takes <paramref name="root"/> out of every <see cref="CanvasGroup"/> above it, so no
        /// ancestor's alpha or raycast state can reach it, and leaves it fully visible.
        /// <para>
        /// For the one screen that must never be hidden by a game-facing display option: the
        /// developer panel that sets those options. It is parented wherever the bootstrap had a
        /// Canvas, which puts it under a root recording mode hides — and a parent group at alpha 0
        /// takes everything below it down, raycasts included, leaving no way to switch the option
        /// back off.
        /// </para>
        /// </summary>
        public static CanvasGroup Exempt(GameObject root)
        {
            if (root == null)
            {
                return null;
            }

            CanvasGroup group = root.GetComponent<CanvasGroup>();

            if (group == null)
            {
                group = root.AddComponent<CanvasGroup>();
            }

            group.ignoreParentGroups = true;
            group.alpha = 1f;
            group.blocksRaycasts = true;
            group.interactable = true;

            return group;
        }

        /// <summary>
        /// True when hiding <paramref name="root"/> would disable <paramref name="owner"/> along
        /// with it, and the CanvasGroup path has to be taken instead.
        /// </summary>
        public static bool RootIsOwner(GameObject root, Component owner)
        {
            return root != null && owner != null && root == owner.gameObject;
        }

        /// <summary>
        /// Puts <paramref name="root"/> in front of the player or takes it away, choosing the way
        /// that leaves <paramref name="owner"/> enabled. <paramref name="group"/> is only consulted
        /// on the self-root path; pass the group the presenter already resolved.
        /// </summary>
        public static void Set(GameObject root, Component owner, CanvasGroup group, bool visible)
        {
            if (root == null)
            {
                return;
            }

            if (!RootIsOwner(root, owner))
            {
                root.SetActive(visible);
                return;
            }

            // Never SetActive(false) here — see the type summary. The object stays active and the
            // group carries the whole of "is it on screen".
            if (!root.activeSelf)
            {
                root.SetActive(true);
            }

            if (group == null)
            {
                return;
            }

            group.alpha = visible ? 1f : 0f;
            group.interactable = visible;
            group.blocksRaycasts = visible;
        }
    }
}

using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Investigation
{
    /// <summary>
    /// The single entry point for "the player investigated something". Lives on the player root.
    /// It never writes the world state directly — it queues commands, so the report update lands in
    /// the same one place per frame as every other change.
    /// </summary>
    public class InvestigationService : MonoBehaviour
    {
        [Header("Broadcasts on")]
        [Tooltip("The result block shown right after the tool animation.")]
        [SerializeField] private StringEventChannelSO m_resultShown;

        [Tooltip("Inner monologue lines.")]
        [SerializeField] private StringEventChannelSO m_monologueRequested;

        [Tooltip("Short refusals such as 不可采样 / 不可识别.")]
        [SerializeField] private StringEventChannelSO m_noticeRequested;

        /// <summary>Records a target and shows its result. Safe to call twice: the report is idempotent.</summary>
        public void Submit(InvestigationTargetSO target)
        {
            if (target == null)
            {
                Log.Error("InvestigationService.Submit received a null target.", this);
                return;
            }

            WorldAccess.Enqueue(new AddReportEntryCommand(target.ToReportEntry()), this);
            WorldAccess.Enqueue(new RaiseFlagCommand(WorldFlags.k_FirstInvestigationDone), this);

            if (!string.IsNullOrEmpty(target.FlagOnRecorded))
            {
                WorldAccess.Enqueue(new RaiseFlagCommand(target.FlagOnRecorded), this);
            }

            Raise(m_resultShown, target.ResultBody);

            string[] monologue = target.MonologueLines;

            for (int i = 0; i < monologue.Length; i++)
            {
                Raise(m_monologueRequested, monologue[i]);
            }
        }

        /// <summary>Shows 不可采样 / 不可识别 without touching the world state.</summary>
        public void Refuse(string text)
        {
            Raise(m_noticeRequested, text);
        }

        private void Raise(StringEventChannelSO channel, string text)
        {
            if (channel == null || string.IsNullOrEmpty(text))
            {
                return;
            }

            channel.RaiseEvent(text);
        }
    }
}

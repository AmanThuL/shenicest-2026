using System.Collections.Generic;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// The one owner of the interaction hint line. Every offer in the game — interactables,
    /// scanning, picking up, harvesting, throwing — states what it would like the HUD to say, and
    /// this decides what actually goes out.
    /// <para>
    /// It exists because the sources share a single channel. Each used to raise it directly behind
    /// its own "only send when the text changed" latch, and that is unsound the moment there is
    /// more than one of them: the pickup trigger sends an empty string, blanking the hint the
    /// interactable driver had just put up, and the driver then never re-sends because its latch
    /// still says the text is on screen. The hint disappears for good.
    /// </para>
    /// <para>
    /// Resolution is by <b>declared priority, never by who got there first</b>. An earlier version
    /// let the current holder keep the line while it still wanted it, which reads as flicker-free
    /// and is in fact a lock: the pickup trigger takes the line with "put the flask down", stands
    /// down at the rune wall without withdrawing its request, and the throw hint — the one the
    /// player needs to get through the door — can never take the line back. A source that wants to
    /// stand down must say so by requesting an empty string.
    /// </para>
    /// </summary>
    public static class InteractionPrompts
    {
        /// <summary>Ranks a throw offer above a pickup offer, which is the one real conflict.</summary>
        public const int k_ThrowPriority = 10;

        /// <summary>
        /// The chase's look-back hint. Above everything: it stays up for the whole run, because it
        /// is the one control that shows the player where the pursuer is.
        /// </summary>
        public const int k_ChaseHintPriority = 20;

        /// <summary>Every other offer. Ties resolve to whoever registered first, which is stable.</summary>
        public const int k_DefaultPriority = 0;

        private struct Request
        {
            public Object Source;
            public int Priority;
            public string Text;
        }

        private static readonly List<Request> s_requests = new List<Request>();

        private static string s_published = string.Empty;

        /// <summary>What the HUD is currently being told to show. Empty means nothing is offered.</summary>
        public static string Published => s_published;

        /// <summary>
        /// States what <paramref name="source"/> would have the HUD say — an empty string meaning
        /// "I have nothing to offer, do not count me". Raises <paramref name="channel"/> only when
        /// the resolved line actually changes, so this is safe to call every frame.
        /// </summary>
        public static void Set(Object source, StringEventChannelSO channel, string text,
            int priority = k_DefaultPriority)
        {
            if (source == null)
            {
                return;
            }

            int index = IndexOf(source);

            if (string.IsNullOrEmpty(text))
            {
                if (index >= 0)
                {
                    s_requests.RemoveAt(index);
                }
            }
            else if (index >= 0)
            {
                Request existing = s_requests[index];
                existing.Priority = priority;
                existing.Text = text;
                s_requests[index] = existing;
            }
            else
            {
                s_requests.Add(new Request { Source = source, Priority = priority, Text = text });
            }

            Resolve(channel);
        }

        /// <summary>Drops a source entirely — call from OnDisable so a dead trigger cannot hold the line.</summary>
        public static void Clear(Object source, StringEventChannelSO channel)
        {
            int index = IndexOf(source);

            if (index < 0)
            {
                return;
            }

            s_requests.RemoveAt(index);
            Resolve(channel);
        }

        private static int IndexOf(Object source)
        {
            for (int i = 0; i < s_requests.Count; i++)
            {
                if (ReferenceEquals(s_requests[i].Source, source))
                {
                    return i;
                }
            }

            return -1;
        }

        /// <summary>Highest priority wins; ties go to the earliest registered, which never flickers.</summary>
        private static void Resolve(StringEventChannelSO channel)
        {
            string winner = string.Empty;
            int best = int.MinValue;

            for (int i = 0; i < s_requests.Count; i++)
            {
                Request request = s_requests[i];

                // A destroyed source leaves a stale entry behind; drop it rather than publish it.
                if (request.Source == null)
                {
                    s_requests.RemoveAt(i);
                    i--;
                    continue;
                }

                if (request.Priority <= best)
                {
                    continue;
                }

                best = request.Priority;
                winner = request.Text;
            }

            if (winner == s_published)
            {
                return;
            }

            s_published = winner;

            if (channel != null)
            {
                channel.RaiseEvent(winner);
            }
        }

        /// <summary>
        /// Statics outlive a Play session in the Editor, so stale requests from the last run would
        /// otherwise suppress the first real hint of the next one.
        /// </summary>
        [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
        private static void ResetOnLoad()
        {
            s_requests.Clear();
            s_published = string.Empty;
        }
    }
}

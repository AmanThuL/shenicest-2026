using System.Collections.Generic;

namespace RootsDance.Core
{
    /// <summary>
    /// Registry of live <see cref="IDeferredContent"/>. Content registers itself when it starts and
    /// unregisters when destroyed; the scene loader only ever reads the aggregate, so it never needs
    /// to know which scenes stream what.
    /// </summary>
    public static class DeferredContent
    {
        private static readonly List<IDeferredContent> s_active = new List<IDeferredContent>();

        public static IReadOnlyList<IDeferredContent> Active => s_active;

        public static bool AllComplete
        {
            get
            {
                for (int i = 0; i < s_active.Count; i++)
                {
                    if (!s_active[i].IsComplete)
                    {
                        return false;
                    }
                }

                return true;
            }
        }

        /// <summary>Mean progress across active content; 1 when nothing is active.</summary>
        public static float Progress
        {
            get
            {
                if (s_active.Count == 0)
                {
                    return 1f;
                }

                float sum = 0f;

                for (int i = 0; i < s_active.Count; i++)
                {
                    sum += s_active[i].Progress;
                }

                return sum / s_active.Count;
            }
        }

        public static void Register(IDeferredContent content)
        {
            if (content != null && !s_active.Contains(content))
            {
                s_active.Add(content);
            }
        }

        public static void Unregister(IDeferredContent content)
        {
            s_active.Remove(content);
        }

        public static void SetCovered(bool covered)
        {
            for (int i = 0; i < s_active.Count; i++)
            {
                s_active[i].SetCovered(covered);
            }
        }
    }
}

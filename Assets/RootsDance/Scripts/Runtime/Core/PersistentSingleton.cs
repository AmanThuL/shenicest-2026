using UnityEngine;

namespace RootsDance.Core
{
    /// <summary>
    /// First instance wins and survives scene loads; later duplicates destroy themselves.
    /// Only <see cref="RootsDance.App.GameBootstrap"/> uses this shape (see guideline 03).
    /// </summary>
    public abstract class PersistentSingleton<T> : MonoBehaviour where T : Component
    {
        private static T s_instance;

        public static T Instance
        {
            get
            {
                if (s_instance == null)
                {
                    // Once, at first access; never per frame.
                    s_instance = FindFirstObjectByType<T>();
                }

                return s_instance;
            }
        }

        protected virtual void Awake()
        {
            if (s_instance == null)
            {
                s_instance = this as T;
                DontDestroyOnLoad(gameObject);
            }
            else if (s_instance != this)
            {
                Destroy(gameObject);
            }
        }
    }
}

using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Core
{
    /// <summary>
    /// First instance wins and survives scene loads; later duplicates destroy themselves.
    /// Only <see cref="RootsDance.App.GameBootstrap"/> uses this shape (see guideline 03).
    /// <para>
    /// <see cref="Instance"/> is set by <see cref="Awake"/> and by nothing else. It used to fall
    /// back to a scene search, which handed callers the singleton object one frame before its own
    /// Awake had built anything on it — a non-null reference whose every service was still null.
    /// That is what the "bootstrap has not arrived yet" null checks all over the codebase are for,
    /// and the search defeated every one of them at once.
    /// </para>
    /// </summary>
    public abstract class PersistentSingleton<T> : MonoBehaviour where T : Component
    {
        private static T s_instance;
        private static Scene s_homeScene;

        /// <summary>The live instance, or null until its Awake has run.</summary>
        public static T Instance
        {
            get { return s_instance; }
        }

        /// <summary>
        /// The scene the live instance arrived in, before <see cref="Object.DontDestroyOnLoad"/>
        /// moved it out. A duplicate compares its own scene against this to tell "the same scene
        /// loaded twice" from "two of us authored into one scene".
        /// </summary>
        protected static Scene HomeScene => s_homeScene;

        /// <summary>
        /// Drops the cached instance for a fresh play session. Play mode is entered without a
        /// domain reload (see <see cref="RootsDance.App.PlaySessionReset"/>), so this static
        /// otherwise carries the previous session's object into the next one.
        /// </summary>
        public static void ResetInstance()
        {
            s_instance = null;
            s_homeScene = default;
        }

        protected virtual void Awake()
        {
            if (s_instance == null)
            {
                s_instance = this as T;
                s_homeScene = gameObject.scene;
                DontDestroyOnLoad(gameObject);
                return;
            }

            if (s_instance == this)
            {
                return;
            }

            // Destroy only lands at the end of the frame. Until then a duplicate keeps ticking
            // Update/LateUpdate against services its own Awake deliberately never built, so it is
            // switched off here rather than left running for the rest of the frame.
            Log.Warning($"A second {typeof(T).Name} arrived in scene '{gameObject.scene.name}'; "
                + "destroying it. The scene holding it is being loaded twice.", this);
            gameObject.SetActive(false);
            Destroy(gameObject);
        }
    }
}

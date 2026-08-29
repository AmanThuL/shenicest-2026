using RootsDance.Events;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// The event-channel assets builders wire themselves to, and the one place that creates a
    /// missing one. A channel asset holds no data — it is an identity — so creating it from a
    /// builder is safe and idempotent, and it keeps a builder from failing on a fresh clone where
    /// nobody has made the asset by hand yet.
    /// </summary>
    public static class EventChannelAssets
    {
        public const string k_Folder = "Assets/RootsDance/Data/Events";

        /// <summary>The bootstrap's flag channel; everything that reacts to the story listens here.</summary>
        public const string k_FlagRaised = k_Folder + "/FlagRaised.asset";

        /// <summary>Standing line on the helmet visor. See <c>HelmetNoticePresenter</c>.</summary>
        public const string k_HelmetNotice = k_Folder + "/HelmetNotice.asset";

        /// <summary>Refusals and alarms on the helmet visor, over the notice.</summary>
        public const string k_HelmetWarning = k_Folder + "/HelmetWarning.asset";

        public const string k_ConversationStarted = k_Folder + "/ConversationStarted.asset";

        public const string k_ConversationEnded = k_Folder + "/ConversationEnded.asset";

        /// <summary>Loads a channel, creating it if this is the first builder to ask for it.</summary>
        public static T Ensure<T>(string path) where T : ScriptableObject
        {
            T channel = AssetDatabase.LoadAssetAtPath<T>(path);

            if (channel != null)
            {
                return channel;
            }

            channel = ScriptableObject.CreateInstance<T>();
            AssetDatabase.CreateAsset(channel, path);
            AssetDatabase.SaveAssets();

            Debug.Log($"[Events] Created {path}.");

            return channel;
        }

        /// <summary>The helmet visor's two channels, in the order the presenter serializes them.</summary>
        public static void EnsureHelmetChannels(out StringEventChannelSO notice,
            out StringEventChannelSO warning)
        {
            notice = Ensure<StringEventChannelSO>(k_HelmetNotice);
            warning = Ensure<StringEventChannelSO>(k_HelmetWarning);
        }
    }
}

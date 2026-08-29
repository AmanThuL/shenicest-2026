using RootsDance.Rendering;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Editor.DevPlay
{
    /// <summary>
    /// A toggle that makes Play mode cheap to render, without touching a single shared asset.
    /// <para>
    /// The obvious way to do this would be a second HDRP quality asset. It is the wrong way here:
    /// switching the pipeline asset rebuilds it and recompiles shader variants, which costs back
    /// the time the toggle is supposed to save, and the two assets then drift apart in every
    /// setting nobody remembered to mirror. Instead this pushes one global
    /// <see cref="Volume"/> at maximum priority over whatever the level already has, for the
    /// duration of the session. Nothing on disk changes, and quitting Play undoes all of it.
    /// </para>
    /// <para>
    /// What it turns off is what the profiling of chapter 00 points at: volumetric fog, ambient
    /// occlusion, the PSX pass, and most of the shadow distance. It deliberately does not disable
    /// any scene objects — which props are dressing and which are the puzzle is a content question,
    /// and getting it wrong makes the flow untestable. Use the Flow level
    /// (<see cref="DevFlowLevelBuilder"/>) when the dressing is what you want gone.
    /// </para>
    /// Menu: RootsDance &gt; Dev &gt; Cheap Rendering (checked when on).
    /// </summary>
    [InitializeOnLoad]
    public static class DevCheapRendering
    {
        private const string k_MenuPath = "RootsDance/Dev/Cheap Rendering";
        private const string k_PrefKey = "RootsDance.Dev.CheapRendering";
        private const string k_HostName = "[Dev] Cheap Rendering";

        /// <summary>Far enough to see the route, near enough to cost almost nothing.</summary>
        private const float k_ShadowDistance = 40f;

        static DevCheapRendering()
        {
            EditorApplication.playModeStateChanged += OnPlayModeChanged;
        }

        private static bool Enabled
        {
            get { return EditorPrefs.GetBool(k_PrefKey, false); }
            set { EditorPrefs.SetBool(k_PrefKey, value); }
        }

        [MenuItem(k_MenuPath)]
        private static void Toggle()
        {
            Enabled = !Enabled;

            if (EditorApplication.isPlaying)
            {
                // Mid-session, so the difference can be seen without restarting.
                if (Enabled)
                {
                    Apply();
                }
                else
                {
                    Remove();
                }
            }
        }

        [MenuItem(k_MenuPath, validate = true)]
        private static bool ToggleValidate()
        {
            Menu.SetChecked(k_MenuPath, Enabled);
            return true;
        }

        private static void OnPlayModeChanged(PlayModeStateChange change)
        {
            if (change == PlayModeStateChange.EnteredPlayMode && Enabled)
            {
                Apply();
            }
        }

        private static void Apply()
        {
            if (GameObject.Find(k_HostName) != null)
            {
                return;
            }

            GameObject host = new GameObject(k_HostName);
            Object.DontDestroyOnLoad(host);

            Volume volume = host.AddComponent<Volume>();
            volume.isGlobal = true;

            // Above every authored volume in the project; the highest one in Main is 20.
            volume.priority = 10000f;

            VolumeProfile profile = ScriptableObject.CreateInstance<VolumeProfile>();
            profile.name = "DevCheapRendering";
            volume.sharedProfile = profile;

            // Volumetric fog: the most expensive thing still switched on in HDRP_Desktop. The fog
            // itself stays — without it the route reads completely differently and the test stops
            // resembling the game.
            Fog fog = profile.Add<Fog>();
            fog.enableVolumetricFog.overrideState = true;
            fog.enableVolumetricFog.value = false;

            // ScreenSpaceAmbientOcclusion, not AmbientOcclusion: the latter is the pre-2022 name
            // and is now an empty deprecated shell. Intensity 0 makes the effect report itself
            // inactive, so the pass is skipped rather than run with no result.
            ScreenSpaceAmbientOcclusion occlusion = profile.Add<ScreenSpaceAmbientOcclusion>();
            occlusion.intensity.overrideState = true;
            occlusion.intensity.value = 0f;

            HDShadowSettings shadows = profile.Add<HDShadowSettings>();
            shadows.maxShadowDistance.overrideState = true;
            shadows.maxShadowDistance.value = k_ShadowDistance;
            shadows.cascadeShadowSplitCount.overrideState = true;
            shadows.cascadeShadowSplitCount.value = 1;

            PsxPostProcess psx = profile.Add<PsxPostProcess>();
            psx.intensity.overrideState = true;
            psx.intensity.value = 0f;

            Debug.Log("[Dev] Cheap rendering is on: volumetric fog, ambient occlusion and the PSX "
                + $"pass are off, shadows stop at {k_ShadowDistance} m. Turn it off in "
                + $"{k_MenuPath}.", host);
        }

        private static void Remove()
        {
            GameObject host = GameObject.Find(k_HostName);

            if (host != null)
            {
                Object.Destroy(host);
            }
        }
    }
}

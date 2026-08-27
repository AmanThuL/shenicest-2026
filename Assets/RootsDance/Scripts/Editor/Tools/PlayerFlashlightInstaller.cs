using System.IO;
using RootsDance.Editor.Terrain;
using RootsDance.Events;
using RootsDance.Player;
using UnityEditor;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Installs the first-person flashlight: the <c>Player/Flashlight</c> input action, the Spot light on
    /// <c>Head/Flashlight</c> in Player.prefab, and the FlashlightController on the prefab root wired to that
    /// light and to the TimeOfDayChanged channel. Idempotent — every step is an "ensure", so a re-run never
    /// duplicates the action, the child or the component. Menu: RootsDance > Player > Install Flashlight.
    /// </summary>
    public static class PlayerFlashlightInstaller
    {
        private const string k_LogPrefix = "PlayerFlashlightInstaller";

        // ---- asset paths ---------------------------------------------------------------------------------

        private const string k_InputAssetPath = "Assets/RootsDance/Input/RootsDance.inputactions";
        private const string k_PlayerPrefabPath = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_EventsFolder = "Assets/RootsDance/Data/Events";
        private const string k_TimeOfDayChangedPath = k_EventsFolder + "/TimeOfDayChanged.asset";

        // ---- input action (design doc §3) ----------------------------------------------------------------
        // The group names must match the asset's existing control schemes, or the binding is invisible to the
        // scheme it belongs to; Interact uses exactly these two.

        private const string k_MapName = "Player";
        private const string k_ActionName = "Flashlight";
        private const string k_ExpectedControlType = "Button";
        private const string k_KeyboardBinding = "<Keyboard>/f";
        private const string k_KeyboardGroup = "Keyboard&Mouse";
        private const string k_GamepadBinding = "<Gamepad>/dpad/up";
        private const string k_GamepadGroup = "Gamepad";

        // ---- prefab (design doc §3) ----------------------------------------------------------------------

        private const string k_HeadName = "Head";
        private const string k_FlashlightName = "Flashlight";

        /// <summary>Outer cone in degrees — wide enough to walk by, narrow enough to read as a beam.</summary>
        private const float k_SpotAngle = 45f;

        /// <summary>Inner cone in degrees; everything between the two angles is the soft falloff.</summary>
        private const float k_InnerSpotAngle = 25f;

        private const float k_Range = 30f;

        /// <summary>Spot lights are authored in lumen (guideline 07 §5.1: 1 000–3 000 lm for a practical).</summary>
        private const float k_IntensityLumen = 2000f;

        /// <summary>Neutral-white LED torch, in kelvin.</summary>
        private const float k_ColorTemperatureKelvin = 5000f;

        /// <summary>HDRP light Volumetrics Multiplier: 1, so the cone shows in the fog without blowing out.</summary>
        private const float k_VolumetricMultiplier = 1f;

        /// <summary>Volumetric Shadow Dimmer 0 skips the shadow-map sample inside the fog (§5.8).</summary>
        private const float k_VolumetricShadowDimmer = 0f;

        /// <summary>Named shadow tier, never a hand-typed resolution (guideline 07 §5.6).</summary>
        private const int k_ShadowResolutionLevel = (int)ScalableSettingLevelParameter.Level.Medium;

        [MenuItem("RootsDance/Player/Install Flashlight")]
        public static void InstallFromMenu()
        {
            Install();
        }

        /// <summary>
        /// Batch entry point:
        /// <c>-executeMethod RootsDance.Editor.Tools.PlayerFlashlightInstaller.InstallFromCommandLine</c>.
        /// Throws so the Editor exits with code 1 when anything fails.
        /// </summary>
        public static void InstallFromCommandLine()
        {
            if (!Install())
            {
                throw new System.InvalidOperationException($"{k_LogPrefix}: install failed — see the log above.");
            }
        }

        /// <summary>Runs the input, prefab and wiring steps. Returns false after logging on failure.</summary>
        /// <returns>True when the action, the light and the controller are all in place.</returns>
        public static bool Install()
        {
            if (!EnsureFlashlightAction())
            {
                return false;
            }

            EnsureChannel();
            TimeOfDayEventChannelSO channel =
                AssetDatabase.LoadAssetAtPath<TimeOfDayEventChannelSO>(k_TimeOfDayChangedPath);

            if (channel == null)
            {
                Debug.LogError($"{k_LogPrefix}: could not load '{k_TimeOfDayChangedPath}'; the controller would "
                    + "be left unwired.");
                return false;
            }

            return EnsurePlayerPrefab(channel);
        }

        // ---- input ----------------------------------------------------------------------------------------

        /// <summary>
        /// Adds <c>Player/Flashlight</c> through the InputActionAsset API and writes the asset's own JSON back
        /// to the file. The .inputactions file is never hand-edited: the API is what keeps the ids, the schema
        /// and the control-scheme groups consistent.
        /// </summary>
        private static bool EnsureFlashlightAction()
        {
            if (EditorApplication.isPlayingOrWillChangePlaymode)
            {
                Debug.LogError($"{k_LogPrefix}: leave Play mode first — action maps are enabled while playing "
                    + "and the Input System refuses to change an enabled asset.");
                return false;
            }

            InputActionAsset asset = AssetDatabase.LoadAssetAtPath<InputActionAsset>(k_InputAssetPath);

            if (asset == null)
            {
                Debug.LogError($"{k_LogPrefix}: '{k_InputAssetPath}' not found.");
                return false;
            }

            InputActionMap map = asset.FindActionMap(k_MapName);

            if (map == null)
            {
                Debug.LogError($"{k_LogPrefix}: '{k_InputAssetPath}' has no '{k_MapName}' action map.");
                return false;
            }

            if (map.FindAction(k_ActionName) != null)
            {
                return true;
            }

            // The project-wide asset is enabled even in Edit mode (the Editor keeps InputSystem.actions live
            // for Editor input), and the setup API throws while any of its maps is enabled. Disable, edit,
            // and restore — the Editor re-enables the asset itself on the next domain reload anyway.
            bool wasEnabled = asset.enabled;
            asset.Disable();

            try
            {
                InputAction action = map.AddAction(k_ActionName, InputActionType.Button,
                    expectedControlLayout: k_ExpectedControlType);
                action.AddBinding(k_KeyboardBinding, groups: k_KeyboardGroup);
                action.AddBinding(k_GamepadBinding, groups: k_GamepadGroup);
            }
            finally
            {
                if (wasEnabled)
                {
                    asset.Enable();
                }
            }

            File.WriteAllText(k_InputAssetPath, asset.ToJson());
            AssetDatabase.ImportAsset(k_InputAssetPath, ImportAssetOptions.ForceUpdate);
            Debug.Log($"{k_LogPrefix}: added '{k_MapName}/{k_ActionName}' with {k_KeyboardBinding} and "
                + $"{k_GamepadBinding} to {k_InputAssetPath}.");
            return true;
        }

        // ---- assets ---------------------------------------------------------------------------------------

        /// <summary>
        /// Find-or-create the TimeOfDayChanged channel. TimeOfDayBuilder and BootstrapSceneBuilder ensure the
        /// same asset; whichever runs first wins and the others are no-ops.
        /// </summary>
        private static void EnsureChannel()
        {
            if (AssetDatabase.LoadAssetAtPath<TimeOfDayEventChannelSO>(k_TimeOfDayChangedPath) != null)
            {
                return;
            }

            TerrainSceneUtility.EnsureFolder(k_EventsFolder);
            TimeOfDayEventChannelSO channel = ScriptableObject.CreateInstance<TimeOfDayEventChannelSO>();
            AssetDatabase.CreateAsset(channel, k_TimeOfDayChangedPath);
            AssetDatabase.SaveAssets();
            Debug.Log($"{k_LogPrefix}: created the event channel asset {k_TimeOfDayChangedPath}.");
        }

        // ---- prefab ---------------------------------------------------------------------------------------

        private static bool EnsurePlayerPrefab(TimeOfDayEventChannelSO channel)
        {
            if (!File.Exists(k_PlayerPrefabPath))
            {
                Debug.LogError($"{k_LogPrefix}: '{k_PlayerPrefabPath}' does not exist.");
                return false;
            }

            GameObject contents = PrefabUtility.LoadPrefabContents(k_PlayerPrefabPath);

            try
            {
                Transform head = contents.transform.Find(k_HeadName);

                if (head == null)
                {
                    Debug.LogError($"{k_LogPrefix}: Player.prefab has no '{k_HeadName}' child to parent the "
                        + "flashlight to.");
                    return false;
                }

                Light light = EnsureFlashlight(head);
                FlashlightController controller = contents.GetComponent<FlashlightController>();

                if (controller == null)
                {
                    controller = contents.AddComponent<FlashlightController>();
                }

                SerializedObject serialized = new SerializedObject(controller);
                serialized.FindProperty("m_light").objectReferenceValue = light;
                serialized.FindProperty("m_timeOfDayChanged").objectReferenceValue = channel;
                serialized.ApplyModifiedProperties();

                bool saved;
                PrefabUtility.SaveAsPrefabAsset(contents, k_PlayerPrefabPath, out saved);

                if (!saved)
                {
                    Debug.LogError($"{k_LogPrefix}: SaveAsPrefabAsset failed for '{k_PlayerPrefabPath}'.");
                    return false;
                }

                AssetDatabase.SaveAssets();
                Debug.Log($"{k_LogPrefix}: '{k_HeadName}/{k_FlashlightName}' spot ({k_IntensityLumen} lm, "
                    + $"{k_SpotAngle}° cone, {k_Range} m) and FlashlightController are wired on "
                    + $"{k_PlayerPrefabPath}.");
                return true;
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(contents);
            }
        }

        private static Light EnsureFlashlight(Transform head)
        {
            Transform child = head.Find(k_FlashlightName);

            if (child == null)
            {
                GameObject created = new GameObject(k_FlashlightName);
                created.transform.SetParent(head, false);
                child = created.transform;
            }

            // Zero offset from the transform the Cinemachine first-person camera hard-locks to: the cone is
            // exactly the view direction, so the beam never parallaxes against what the player is looking at.
            child.localPosition = Vector3.zero;
            child.localRotation = Quaternion.identity;
            child.localScale = Vector3.one;

            Light light = child.GetComponent<Light>();

            if (light == null)
            {
                light = child.gameObject.AddComponent<Light>();
            }

            HDAdditionalLightData data = child.GetComponent<HDAdditionalLightData>();

            if (data == null)
            {
                data = child.gameObject.AddComponent<HDAdditionalLightData>();
            }

            // Type first: HDRP validates the unit against the light type, and Lumen is only legal once this
            // is a punctual light (guideline 07 §5.1).
            light.type = LightType.Spot;
            light.spotAngle = k_SpotAngle;
            light.innerSpotAngle = k_InnerSpotAngle;
            light.range = k_Range;

            // Light.intensity always holds the light type's NATIVE unit — candela for a spot; lightUnit is only
            // the Inspector's display unit. Writing 2000 straight into intensity would author 2000 cd (≈ 950 lm
            // with the reflector, ≈ 25 000 lm without), so convert exactly like HDRP's own light inspector does.
            // The reflector is pinned first because it is part of the lumen → candela solid angle.
            light.enableSpotReflector = true;
            light.lightUnit = LightUnit.Lumen;
            light.intensity = LightUnitUtils.ConvertIntensity(
                light, k_IntensityLumen, LightUnit.Lumen, LightUnit.Candela);
            light.color = Color.white;
            light.useColorTemperature = true;
            light.colorTemperature = k_ColorTemperatureKelvin;

            // The controller reads this authored intensity as "full brightness" in Awake and switches the
            // component off itself, so the prefab may ship with the Light enabled.
            light.enabled = true;

            data.EnableShadows(true); // LightShadows.Soft
            data.SetShadowResolutionOverride(false); // use the HDRP asset's tiers, not a hand-typed number
            data.SetShadowResolutionLevel(k_ShadowResolutionLevel);

            // affectsVolumetric first: volumetricDimmer and volumetricShadowDimmer read back as 0 while it
            // is off, so setting them before it would be a silent no-op on a light that had it disabled.
            data.affectsVolumetric = true;
            data.volumetricDimmer = k_VolumetricMultiplier;
            data.volumetricShadowDimmer = k_VolumetricShadowDimmer;
            return light;
        }
    }
}

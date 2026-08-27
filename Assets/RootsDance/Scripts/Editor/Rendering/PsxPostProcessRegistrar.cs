using RootsDance.Rendering;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Rendering
{
    /// <summary>
    /// Registers <see cref="PsxPostProcess"/> with HDRP. Two project-settings edits are needed and neither has
    /// a public API in HDRP 17.3 (CustomPostProcessOrdersSettings is internal), so both go through
    /// SerializedObject on the settings assets — the same data the Project Settings window writes:
    /// 1. the type's AssemblyQualifiedName in HDRP Global Settings > Custom Post Process Orders >
    ///    After Post Process;
    /// 2. the shader in Graphics > Always Included Shaders, otherwise players strip it (nothing in
    ///    a scene references it).
    /// Idempotent; guideline 07 rule 13: commit the two settings files as their own
    /// chore(rendering) commit. Every SerializedObject this type opens is short-lived and disposed via
    /// <c>using</c> — SerializedObject wraps a native handle that is not freed until Dispose or finalization.
    /// </summary>
    public static class PsxPostProcessRegistrar
    {
        public const string k_GlobalSettingsPath =
            "Assets/RootsDance/Settings/HDRP/HDRenderPipelineGlobalSettings.asset";
        public const string k_GraphicsSettingsPath = "ProjectSettings/GraphicsSettings.asset";

        private const string k_LogPrefix = "PsxPostProcessRegistrar";
        private const string k_SettingsListProperty = "m_Settings.m_SettingsList.m_List";
        private const string k_OrdersTypeSuffix = ".CustomPostProcessOrdersSettings";
        private const string k_AfterPostProcessListProperty =
            "m_AfterPostProcessCustomPostProcesses.m_CustomPostProcessTypesAsString";
        private const string k_AlwaysIncludedShadersProperty = "m_AlwaysIncludedShaders";

        [MenuItem("RootsDance/Rendering/Register PSX Post Process")]
        public static void RegisterFromMenu()
        {
            bool changed = Register();
            Debug.Log($"{k_LogPrefix}: {(changed ? "registered" : "already registered")} "
                + $"({typeof(PsxPostProcess).FullName}, {PsxPostProcess.k_ShaderName}).");
        }

        /// <summary>Batch entry point:
        /// <c>-executeMethod RootsDance.Editor.Rendering.PsxPostProcessRegistrar.RegisterFromCommandLine</c>.
        /// </summary>
        public static void RegisterFromCommandLine()
        {
            Register();

            if (!IsRegistered() || !IsShaderAlwaysIncluded())
            {
                throw new System.InvalidOperationException(
                    $"{k_LogPrefix}: registration did not stick — see the log above.");
            }
        }

        /// <summary>Performs both edits if missing. Returns true when any asset changed
        /// (they are then saved).</summary>
        public static bool Register()
        {
            bool changedOrders = AddToAfterPostProcessList();
            bool changedShaders = AddShaderToAlwaysIncluded();

            if (changedOrders || changedShaders)
            {
                AssetDatabase.SaveAssets();
            }

            return changedOrders || changedShaders;
        }

        public static bool IsRegistered()
        {
            using (SerializedObject settings = LoadGlobalSettings())
            {
                if (settings == null)
                {
                    return false;
                }

                SerializedProperty list = FindAfterPostProcessList(settings);
                return list != null && IndexOfString(list, typeof(PsxPostProcess).AssemblyQualifiedName) >= 0;
            }
        }

        public static bool IsShaderAlwaysIncluded()
        {
            Shader shader = Shader.Find(PsxPostProcess.k_ShaderName);

            if (shader == null)
            {
                return false;
            }

            using (SerializedObject graphics = LoadGraphicsSettings())
            {
                if (graphics == null)
                {
                    return false;
                }

                SerializedProperty list = FindAlwaysIncludedShaders(graphics);
                return list != null && IndexOfObject(list, shader) >= 0;
            }
        }

        private static bool AddToAfterPostProcessList()
        {
            using (SerializedObject settings = LoadGlobalSettings())
            {
                if (settings == null)
                {
                    return false;
                }

                SerializedProperty list = FindAfterPostProcessList(settings);

                if (list == null)
                {
                    Debug.LogError($"{k_LogPrefix}: could not find the Custom Post Process Orders block in "
                        + $"{k_GlobalSettingsPath}.");
                    return false;
                }

                string typeName = typeof(PsxPostProcess).AssemblyQualifiedName;

                if (IndexOfString(list, typeName) >= 0)
                {
                    return false;
                }

                list.InsertArrayElementAtIndex(list.arraySize);
                list.GetArrayElementAtIndex(list.arraySize - 1).stringValue = typeName;
                settings.ApplyModifiedPropertiesWithoutUndo();
                EditorUtility.SetDirty(settings.targetObject);
                return true;
            }
        }

        private static bool AddShaderToAlwaysIncluded()
        {
            Shader shader = Shader.Find(PsxPostProcess.k_ShaderName);

            if (shader == null)
            {
                Debug.LogError($"{k_LogPrefix}: shader '{PsxPostProcess.k_ShaderName}' not found; "
                    + "nothing added to Always Included Shaders.");
                return false;
            }

            using (SerializedObject graphics = LoadGraphicsSettings())
            {
                if (graphics == null)
                {
                    return false;
                }

                SerializedProperty list = FindAlwaysIncludedShaders(graphics);

                if (list == null)
                {
                    Debug.LogError($"{k_LogPrefix}: could not read {k_AlwaysIncludedShadersProperty} from "
                        + $"{k_GraphicsSettingsPath}.");
                    return false;
                }

                if (IndexOfObject(list, shader) >= 0)
                {
                    return false;
                }

                list.InsertArrayElementAtIndex(list.arraySize);
                list.GetArrayElementAtIndex(list.arraySize - 1).objectReferenceValue = shader;
                graphics.ApplyModifiedPropertiesWithoutUndo();
                EditorUtility.SetDirty(graphics.targetObject);
                return true;
            }
        }

        /// <summary>Opens the HDRP Global Settings asset as a SerializedObject the caller must dispose.</summary>
        private static SerializedObject LoadGlobalSettings()
        {
            Object asset = AssetDatabase.LoadMainAssetAtPath(k_GlobalSettingsPath);

            if (asset == null)
            {
                Debug.LogError($"{k_LogPrefix}: {k_GlobalSettingsPath} not found.");
                return null;
            }

            return new SerializedObject(asset);
        }

        /// <summary>Opens the Graphics Settings asset as a SerializedObject the caller must dispose.</summary>
        private static SerializedObject LoadGraphicsSettings()
        {
            Object[] assets = AssetDatabase.LoadAllAssetsAtPath(k_GraphicsSettingsPath);

            if (assets == null || assets.Length == 0 || assets[0] == null)
            {
                Debug.LogError($"{k_LogPrefix}: {k_GraphicsSettingsPath} could not be loaded.");
                return null;
            }

            return new SerializedObject(assets[0]);
        }

        private static SerializedProperty FindAfterPostProcessList(SerializedObject settings)
        {
            SerializedProperty entries = settings.FindProperty(k_SettingsListProperty);

            if (entries == null || !entries.isArray)
            {
                return null;
            }

            for (int i = 0; i < entries.arraySize; i++)
            {
                SerializedProperty entry = entries.GetArrayElementAtIndex(i);

                if (entry.propertyType != SerializedPropertyType.ManagedReference)
                {
                    continue;
                }

                if (!entry.managedReferenceFullTypename.EndsWith(k_OrdersTypeSuffix))
                {
                    continue;
                }

                return entry.FindPropertyRelative(k_AfterPostProcessListProperty);
            }

            return null;
        }

        private static SerializedProperty FindAlwaysIncludedShaders(SerializedObject graphics)
        {
            SerializedProperty list = graphics.FindProperty(k_AlwaysIncludedShadersProperty);
            return list != null && list.isArray ? list : null;
        }

        private static int IndexOfString(SerializedProperty list, string value)
        {
            for (int i = 0; i < list.arraySize; i++)
            {
                if (list.GetArrayElementAtIndex(i).stringValue == value)
                {
                    return i;
                }
            }

            return -1;
        }

        private static int IndexOfObject(SerializedProperty list, Object value)
        {
            for (int i = 0; i < list.arraySize; i++)
            {
                if (list.GetArrayElementAtIndex(i).objectReferenceValue == value)
                {
                    return i;
                }
            }

            return -1;
        }
    }
}

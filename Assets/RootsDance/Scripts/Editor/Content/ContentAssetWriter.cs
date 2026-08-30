using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Content
{
    /// <summary>
    /// The small amount of plumbing every content builder needs: create an asset only if it is
    /// missing, and reach the private serialized fields of the result.
    /// <para>
    /// Private fields are written through <see cref="SerializedObject"/> rather than by making them
    /// public. The rule that Inspector data is <c>[SerializeField] private</c> exists so that
    /// nothing can write these at runtime; a builder is Editor code authoring content once, and
    /// SerializedObject is the sanctioned way in — the same route
    /// <c>ScannerReportContentBuilder</c> already takes.
    /// </para>
    /// </summary>
    public static class ContentAssetWriter
    {
        /// <summary>
        /// Loads the asset at <paramref name="path"/>, or creates it. <paramref name="created"/>
        /// says which happened, so a builder can leave existing content strictly alone.
        /// </summary>
        public static T Ensure<T>(string path, out bool created) where T : ScriptableObject
        {
            T existing = AssetDatabase.LoadAssetAtPath<T>(path);

            if (existing != null)
            {
                created = false;
                return existing;
            }

            T asset = ScriptableObject.CreateInstance<T>();
            AssetDatabase.CreateAsset(asset, path);
            created = true;

            return asset;
        }

        /// <summary>Sets a string field by its serialized name.</summary>
        public static void SetString(SerializedObject serialized, string field, string value)
        {
            SerializedProperty property = serialized.FindProperty(field);

            if (property == null)
            {
                Debug.LogError($"[Content] No serialized field '{field}' on {serialized.targetObject}.");
                return;
            }

            property.stringValue = value;
        }

        public static void SetBool(SerializedObject serialized, string field, bool value)
        {
            SerializedProperty property = serialized.FindProperty(field);

            if (property != null)
            {
                property.boolValue = value;
            }
        }

        public static void SetFloat(SerializedObject serialized, string field, float value)
        {
            SerializedProperty property = serialized.FindProperty(field);

            if (property != null)
            {
                property.floatValue = value;
            }
        }

        public static void SetEnum(SerializedObject serialized, string field, int value)
        {
            SerializedProperty property = serialized.FindProperty(field);

            if (property != null)
            {
                property.enumValueIndex = value;
            }
        }

        public static void SetObject(SerializedObject serialized, string field, Object value)
        {
            SerializedProperty property = serialized.FindProperty(field);

            if (property != null)
            {
                property.objectReferenceValue = value;
            }
        }

        /// <summary>Rewrites a string array field to exactly these entries.</summary>
        public static void SetStringArray(SerializedObject serialized, string field, string[] values)
        {
            SerializedProperty property = serialized.FindProperty(field);

            if (property == null)
            {
                return;
            }

            property.arraySize = values.Length;

            for (int i = 0; i < values.Length; i++)
            {
                property.GetArrayElementAtIndex(i).stringValue = values[i];
            }
        }
    }
}

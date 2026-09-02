using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Player
{
    /// <summary>
    /// Writes a `[SerializeField] private` field on a component under test. Inspector data stays
    /// private per guideline 01, so a test sets it the way the Inspector does rather than through a
    /// public setter that exists only for tests.
    /// </summary>
    public static class SerializedFieldSetter
    {
        public static void Set(Object target, string fieldName, float value)
        {
            SerializedObject so = new SerializedObject(target);
            SerializedProperty property = so.FindProperty(fieldName);

            Debug.Assert(property != null, $"No serialized field '{fieldName}' on {target}.");
            property.floatValue = value;
            so.ApplyModifiedPropertiesWithoutUndo();
        }

        /// <summary>Sets a serialized reference field, for wiring a component up in a test.</summary>
        public static void Set(Object target, string fieldName, Object value)
        {
            SerializedObject so = new SerializedObject(target);
            SerializedProperty property = so.FindProperty(fieldName);

            Debug.Assert(property != null, $"No serialized field '{fieldName}' on {target}.");
            property.objectReferenceValue = value;
            so.ApplyModifiedPropertiesWithoutUndo();
        }

        /// <summary>Reads a serialized reference field, for asserting a prefab shipped wired up.</summary>
        public static Object Get(Object target, string fieldName)
        {
            SerializedObject so = new SerializedObject(target);
            SerializedProperty property = so.FindProperty(fieldName);

            Debug.Assert(property != null, $"No serialized field '{fieldName}' on {target}.");
            return property.objectReferenceValue;
        }
    }
}

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
    }
}

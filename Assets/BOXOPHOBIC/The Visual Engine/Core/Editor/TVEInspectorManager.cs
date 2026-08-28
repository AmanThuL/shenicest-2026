//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;

namespace TheVisualEngine
{
    [DisallowMultipleComponent]
    [CustomEditor(typeof(TVEManager))]
    public class TVEInspectorManager : Editor
    {
        TVEManager targetScript;

        Color bannerColor;
        string bannerLabel;
        string bannerVersion;

        void OnEnable()
        {
            targetScript = (TVEManager)target;

            bannerColor = new Color(0.9f, 0.7f, 0.4f);
            bannerLabel = "The Visual Engine";
            bannerVersion = bannerVersion = TVEUtils.GetAssetVersionStr();
        }

        public override void OnInspectorGUI()
        {
            StyledGUI.DrawInspectorBanner(bannerColor, bannerLabel, bannerVersion);

            GUILayout.Space(5);
            DrawInspector();
        }

        void DrawInspector()
        {
            serializedObject.Update();

            SerializedProperty property = serializedObject.GetIterator();
            bool enterChildren = true;
            bool showCategory = true;

            while (property.NextVisible(enterChildren))
            {
                enterChildren = false;

                //var displayName = property.displayName;
                var internalName = property.name;

                // Skip script field
                if (internalName == "m_Script")
                    continue;

                if (internalName.Contains("Category"))
                {
                    EditorGUILayout.PropertyField(property, true);

                    // Read bool/int toggle value
                    showCategory = property.boolValue;

                    continue;
                }

                if (showCategory)
                {
                    EditorGUILayout.PropertyField(property, true);
                }
            }

            serializedObject.ApplyModifiedProperties();
        }
    }
}



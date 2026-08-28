//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using Boxophobic.Utility;

namespace TheVisualEngine
{
    public class DebugGUI : ShaderGUI
    {
        GUIStyle styleButton;

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
        {
            var material0 = materialEditor.target as Material;

            DrawDynamicInspector(material0, materialEditor, props);
        }

        void DrawDynamicInspector(Material material, MaterialEditor materialEditor, MaterialProperty[] props)
        {
            styleButton = new GUIStyle(GUI.skin.GetStyle("Button"))
            {
                alignment = TextAnchor.MiddleLeft,
            };

            var customPropsList = new List<MaterialProperty>();

            for (int i = 0; i < props.Length; i++)
            {
                var property = props[i];

                if (BoxoUtils.IsShaderGUIPropertyHidden(property))
                {
                    continue;
                }

                if (property.name == "unity_Lightmaps")
                    continue;

                if (property.name == "unity_LightmapsInd")
                    continue;

                if (property.name == "unity_ShadowMasks")
                    continue;

                if (property.name.Contains("_Banner"))
                    continue;

                customPropsList.Add(property);
            }

            //Draw Custom GUI
            for (int i = 0; i < customPropsList.Count; i++)
            {
                var property = customPropsList[i];

                GUILayout.BeginHorizontal();

                materialEditor.ShaderProperty(property, property.displayName + " (" + property.name + ")");

                GUILayout.Space(2);

                //GUILayout.TextField(prop.name, GUILayout.Width(50));

                if (GUILayout.Button("C", styleButton, GUILayout.Width(20)))
                {
                    GUIUtility.systemCopyBuffer = property.name;
                }

                if (GUILayout.Button("T", styleButton, GUILayout.Width(20)))
                {
                    if (BoxoUtils.IsShaderGUIPropertyTexture(property))
                    {
                        GUIUtility.systemCopyBuffer = "Material COPY_TEX " + property.name + " XXX";
                    }

                    if (BoxoUtils.IsShaderGUIPropertyFloat(property))
                    {
                        GUIUtility.systemCopyBuffer = "Material COPY_FLOAT " + property.name + " XXX";
                    }

                    if (BoxoUtils.IsShaderGUIPropertyVector(property))
                    {
                        GUIUtility.systemCopyBuffer = "Material COPY_VECTOR " + property.name + " XXX";
                    }
                }

                GUILayout.EndHorizontal();
            }

            GUILayout.Space(20);
        }
    }
}


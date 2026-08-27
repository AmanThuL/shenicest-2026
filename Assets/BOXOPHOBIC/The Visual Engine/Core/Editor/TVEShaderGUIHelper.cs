//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using Boxophobic.Utility;

namespace TheVisualEngine
{
    public class HelperGUI : ShaderGUI
    {
        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
        {
            var material0 = materialEditor.target as Material;
            var materials = materialEditor.targets;

            DrawDynamicInspector(material0, materialEditor, props);
        }

        void DrawDynamicInspector(Material material, MaterialEditor materialEditor, MaterialProperty[] props)
        {
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
                var prop = customPropsList[i];

                materialEditor.ShaderProperty(prop, prop.displayName);

            }

            GUILayout.Space(20);

            TheVisualEngine.TVEUtils.DrawPoweredBy();
        }
    }
}


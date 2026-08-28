using RootsDance.UI;
using TMPro;
using UnityEditor;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Creates the world-space text material and fits it to every diegetic screen prefab.
    /// See <see cref="WorldSpaceTextMaterial"/> for why those screens need one at all.
    /// </summary>
    public static class WorldSpaceTextBuilder
    {
        private const string k_MaterialPath = "Assets/RootsDance/Materials/UI/FusionPixel WorldSpace.mat";
        private const string k_ShaderName = "RootsDance/UI/WorldSpaceText";

        private static readonly string[] k_Screens =
        {
            "Assets/RootsDance/Prefabs/UI/ScannerReportScreen.prefab",
        };

        [MenuItem("RootsDance/UI/Fit World Space Text")]
        public static void Build()
        {
            Material material = EnsureMaterial();

            if (material == null)
            {
                return;
            }

            foreach (string path in k_Screens)
            {
                GameObject contents = PrefabUtility.LoadPrefabContents(path);

                try
                {
                    var canvas = contents.GetComponent<Canvas>();

                    if (canvas == null)
                    {
                        Debug.LogError("WorldSpaceTextBuilder: no Canvas on " + path);
                        continue;
                    }

                    var fitter = contents.GetComponent<WorldSpaceTextMaterial>();

                    if (fitter == null)
                    {
                        fitter = contents.AddComponent<WorldSpaceTextMaterial>();
                    }

                    var serialized = new SerializedObject(fitter);
                    serialized.FindProperty("m_textMaterial").objectReferenceValue = material;
                    serialized.ApplyModifiedPropertiesWithoutUndo();

                    // Bake it into the prefab as well, so the Editor shows what the game shows.
                    foreach (TMP_Text label in contents.GetComponentsInChildren<TMP_Text>(true))
                    {
                        label.fontSharedMaterial = material;
                    }

                    PrefabUtility.SaveAsPrefabAsset(contents, path);
                    Debug.Log("WorldSpaceTextBuilder: fitted " + path);
                }
                finally
                {
                    PrefabUtility.UnloadPrefabContents(contents);
                }
            }

            AssetDatabase.SaveAssets();
        }

        private static Material EnsureMaterial()
        {
            Shader shader = Shader.Find(k_ShaderName);

            if (shader == null)
            {
                Debug.LogError("WorldSpaceTextBuilder: shader " + k_ShaderName + " not found.");
                return null;
            }

            TMP_FontAsset font = ElectronicUIKitBuilder.EnsureFont();

            if (font == null)
            {
                Debug.LogError("WorldSpaceTextBuilder: the kit font is missing.");
                return null;
            }

            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_MaterialPath);

            if (material == null)
            {
                System.IO.Directory.CreateDirectory(System.IO.Path.GetDirectoryName(k_MaterialPath));
                AssetDatabase.Refresh();
                material = new Material(shader);
                AssetDatabase.CreateAsset(material, k_MaterialPath);
            }

            material.shader = shader;

            // The atlas is the font's own; pointing at anything else renders the wrong glyphs.
            material.SetTexture("_MainTex", font.material.GetTexture(ShaderUtilities.ID_MainTex));
            EditorUtility.SetDirty(material);

            return material;
        }
    }
}

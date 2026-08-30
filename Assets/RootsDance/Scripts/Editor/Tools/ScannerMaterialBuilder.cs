using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// The six HDRP materials the scanner FBX asks for by name. The prop arrives from Maya through
    /// Blender with material slots called Scanner_1001 … Scanner_1006 and a Substance-style set of
    /// separate maps; the texture packer turned those into the project's BaseMap plus channel-packed
    /// Mask pairs, and this builds the materials that consume them.
    /// <para>
    /// Idempotent, and deliberately non-destructive: an existing material keeps whatever a human
    /// tuned on it and only has its texture slots rewired. Materials are what the model importer
    /// remaps onto the mesh through Tools/unity/model_import_profiles.json, so their paths are part
    /// of that contract and must not be renamed casually — and their file names have to stay equal
    /// to the FBX's material slot names, which is how the importer finds them at all.
    /// </para>
    /// <para>
    /// The texture sets keep the project's own naming (<c>Scanner1001_BaseMap</c>): the texture
    /// convention allows exactly one underscore, for the map suffix, so the set name cannot carry
    /// the one the material name needs.
    /// </para>
    /// Menu: RootsDance > Build Scanner Materials.
    /// </summary>
    public static class ScannerMaterialBuilder
    {
        private const string k_MaterialFolder = "Assets/RootsDance/Materials";
        private const string k_TextureFolder = "Assets/RootsDance/Textures/Props";
        private const string k_Shader = "HDRP/Lit";
        private const string k_Model = "Assets/RootsDance/Meshes/Props/Scanner.fbx";

        private static readonly string[] k_Sets =
        {
            "1001", "1002", "1003", "1004", "1005", "1006"
        };

        [MenuItem("RootsDance/Build Scanner Materials")]
        public static void Build()
        {
            Shader shader = Shader.Find(k_Shader);

            if (shader == null)
            {
                Debug.LogError($"ScannerMaterialBuilder: shader '{k_Shader}' not found. Is the "
                    + "project still on HDRP?");
                return;
            }

            int built = 0;

            for (int i = 0; i < k_Sets.Length; i++)
            {
                if (BuildOne(shader, k_Sets[i]))
                {
                    built++;
                }
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            // The model importer's remap table can only bind a material that already exists, and on
            // a first import these did not. Forcing the reimport here is what actually puts them on
            // the mesh; without it the prop renders in the missing-shader magenta, because the
            // fallback is a Standard-shader material and HDRP cannot draw one.
            AssetDatabase.ImportAsset(k_Model, ImportAssetOptions.ForceUpdate);

            Debug.Log($"ScannerMaterialBuilder: {built} of {k_Sets.Length} materials written to "
                + $"{k_MaterialFolder}, and {k_Model} reimported so the remap binds them.");
        }

        private static bool BuildOne(Shader shader, string set)
        {
            // Named exactly like the FBX's material slot. The model importer resolves
            // materials by name (BasedOnMaterialName, searched Everywhere), so a material
            // called Scanner1001 would leave the slot empty and the prop untextured.
            string path = $"{k_MaterialFolder}/Scanner_{set}.mat";
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material == null)
            {
                material = new Material(shader);
                Directory.CreateDirectory(k_MaterialFolder);
                AssetDatabase.CreateAsset(material, path);
            }

            Texture2D baseMap = Load(set, "BaseMap");
            Texture2D mask = Load(set, "Mask");

            if (baseMap == null)
            {
                Debug.LogWarning($"ScannerMaterialBuilder: no BaseMap for set {set}; the material "
                    + "was created but left untextured.");
            }

            material.SetTexture(k_BaseColorMap, baseMap);
            material.SetTexture(k_MaskMap, mask);

            // Without the packed mask there is no smoothness channel to read, so the material falls
            // back to a constant. 0.35 reads as a used field instrument rather than a showroom one.
            if (mask == null)
            {
                material.SetFloat(k_Smoothness, 0.35f);
            }

            // HDRP keeps its keywords in sync through this call; setting textures alone leaves
            // _MASKMAP off and the mask silently unused.
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);

            return baseMap != null;
        }

        private static Texture2D Load(string set, string map)
        {
            return AssetDatabase.LoadAssetAtPath<Texture2D>($"{k_TextureFolder}/Scanner{set}_{map}.png");
        }

        private static readonly int k_BaseColorMap = Shader.PropertyToID("_BaseColorMap");
        private static readonly int k_MaskMap = Shader.PropertyToID("_MaskMap");
        private static readonly int k_Smoothness = Shader.PropertyToID("_Smoothness");
    }
}

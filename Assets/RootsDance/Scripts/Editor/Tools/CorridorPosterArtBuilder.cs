using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Prints a different Briggs Botanical Gardens poster on each sheet under
    /// <c>LabCorridorPosters</c>, so the four runes hang on four pieces of art rather than four
    /// copies of one.
    /// </summary>
    /// <remarks>
    /// <para>
    /// The sheet, its folds and its UVs are the ones the model came with: this only builds one
    /// material per poster off the model's own <c>BandPoster.mat</c> and swaps the base colour map,
    /// so the crease normal and mask maps keep doing their work on the new print.
    /// </para>
    /// <para>
    /// Sheets are found and ordered exactly as CorridorPostersBuilder finds them, and the art is
    /// indexed by the same rune order, so a poster's print and its mark cannot drift apart. Only
    /// the printed sheets are re-dressed - the photogrammetry noticeboard is not a sheet and is
    /// left alone.
    /// </para>
    /// <para>
    /// Idempotent: re-running it rewrites the same four materials and re-assigns the same sheets.
    /// The base maps themselves come from Tools/textures/make_corridor_posters.py.
    /// </para>
    /// Menu: RootsDance > Build Corridor Poster Art.
    /// </remarks>
    public static class CorridorPosterArtBuilder
    {
        private const string k_Scene = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_2.unity";

        /// <summary>The model's own material, and the source of everything but the base map.</summary>
        private const string k_SheetMaterial = "Assets/RootsDance/Materials/Environment/BandPoster.mat";

        private const string k_MaterialDir = "Assets/RootsDance/Materials/Environment";
        private const string k_TextureDir = "Assets/RootsDance/Textures/Environment";

        /// <summary>
        /// One poster per rune, in CorridorPostersBuilder's rune order: the sheet that takes Fehu
        /// prints Ferns, Raidho prints Flowering Plants, and so on. The runes carry no meaning of
        /// their own, so the pairing is only ever this - a fixed order, kept so a rebuild does not
        /// shuffle the wall.
        /// </summary>
        private static readonly string[] k_Art = { "Ferns", "FloweringPlants", "Fungal", "Lichens" };

        private static readonly int k_BaseColorMapId = Shader.PropertyToID("_BaseColorMap");
        private static readonly int k_MainTexId = Shader.PropertyToID("_MainTex");

        [MenuItem("RootsDance/Build Corridor Poster Art")]
        public static void Build()
        {
            Material[] materials = BuildMaterials();

            if (materials == null)
            {
                return;
            }

            Scene scene = EditorSceneManager.OpenScene(k_Scene, OpenSceneMode.Single);
            GameObject group = CorridorPostersBuilder.Find(scene, CorridorPostersBuilder.k_GroupName);

            if (group == null)
            {
                Debug.LogError("CorridorPosterArtBuilder: no "
                    + $"'{CorridorPostersBuilder.k_GroupName}' in {k_Scene}. The posters are hung "
                    + "by hand; this tool only re-prints what is already under that group node.");
                return;
            }

            List<Transform> sheets = CorridorPostersBuilder.Sheets(group.transform);

            if (sheets.Count == 0)
            {
                Debug.LogError($"CorridorPosterArtBuilder: '{CorridorPostersBuilder.k_GroupName}' "
                    + "has no sheet-like child to print.");
                return;
            }

            Material sheetMaterial = AssetDatabase.LoadAssetAtPath<Material>(k_SheetMaterial);

            for (int i = 0; i < sheets.Count; i++)
            {
                Print(sheets[i], k_Art[i % k_Art.Length], materials[i % k_Art.Length], sheetMaterial);
            }

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            AssetDatabase.SaveAssets();

            Debug.Log($"CorridorPosterArtBuilder: printed {sheets.Count} posters under "
                + $"'{CorridorPostersBuilder.k_GroupName}'.");
        }

        /// <summary>
        /// One material per poster, each a copy of the sheet's own material carrying that poster's
        /// base map. Copying rather than authoring keeps the crease maps, smoothness and every
        /// other value the model shipped with.
        /// </summary>
        private static Material[] BuildMaterials()
        {
            Material sheet = AssetDatabase.LoadAssetAtPath<Material>(k_SheetMaterial);

            if (sheet == null)
            {
                Debug.LogError($"CorridorPosterArtBuilder: no sheet material at {k_SheetMaterial}; "
                    + "the printed materials are copies of it and cannot be built without it.");
                return null;
            }

            Material[] materials = new Material[k_Art.Length];

            for (int i = 0; i < k_Art.Length; i++)
            {
                string texturePath = Path.Combine(k_TextureDir, $"BriggsPoster_{k_Art[i]}_BaseMap.png");
                Texture2D baseMap = AssetDatabase.LoadAssetAtPath<Texture2D>(texturePath);

                if (baseMap == null)
                {
                    Debug.LogError($"CorridorPosterArtBuilder: no base map at {texturePath}. Run "
                        + "Tools/textures/make_corridor_posters.py.");
                    return null;
                }

                string path = Path.Combine(k_MaterialDir, $"BriggsPoster_{k_Art[i]}.mat");
                Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

                if (material == null)
                {
                    material = new Material(sheet);
                    Directory.CreateDirectory(k_MaterialDir);
                    AssetDatabase.CreateAsset(material, path);
                }

                material.SetTexture(k_BaseColorMapId, baseMap);
                material.SetTexture(k_MainTexId, baseMap);
                EditorUtility.SetDirty(material);
                materials[i] = material;
            }

            return materials;
        }

        /// <summary>Hands one sheet its own printed material.</summary>
        private static void Print(Transform poster, string art, Material material, Material sheetMaterial)
        {
            // The same filter CorridorPostersBuilder measures and hangs the rune on, so the print
            // lands on the object the mark lands on and never on the mark itself.
            MeshFilter filter = poster.GetComponentInChildren<MeshFilter>();
            MeshRenderer renderer = filter.GetComponent<MeshRenderer>();

            if (renderer == null)
            {
                Debug.LogWarning($"CorridorPosterArtBuilder: '{poster.name}' has a mesh but no "
                    + "renderer on it; left unprinted.");
                return;
            }

            // The model splits the sheet from its pushpin and hands both submeshes the same
            // material, and the pin's UVs sit in the base map's blank margin. Swapping every slot
            // that carries the sheet's material keeps that arrangement intact - swapping only the
            // first would re-print the pin and leave the paper as it was.
            Material[] slots = renderer.sharedMaterials;
            int swapped = 0;

            for (int i = 0; i < slots.Length; i++)
            {
                if (slots[i] == sheetMaterial || slots[i] == material)
                {
                    slots[i] = material;
                    swapped++;
                }
            }

            if (swapped == 0)
            {
                Debug.LogWarning($"CorridorPosterArtBuilder: no slot on '{poster.name}' carries "
                    + $"{k_SheetMaterial}; left unprinted.");
                return;
            }

            renderer.sharedMaterials = slots;

            // The sheets are model instances, so the swap is an override on the instance and has to
            // be recorded as one - a script assignment is not picked up otherwise.
            PrefabUtility.RecordPrefabInstancePropertyModifications(renderer);

            Debug.Log($"[{poster.name}] printed {art} on {swapped} of {slots.Length} slots.");
        }
    }
}

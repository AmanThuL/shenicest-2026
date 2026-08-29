using System.Collections.Generic;
using System.IO;
using RootsDance.Environment;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Gives every poster under <c>LabCorridorPosters</c> a single fluorescent rune, so a player
    /// who finds one mark has found one rather than a set printed on one sheet.
    /// </summary>
    /// <remarks>
    /// <para>
    /// Placement is not this tool's business. The posters are hung by hand in the scene and this
    /// only re-dresses whatever is parented under the group node, so moving, adding or removing a
    /// sheet needs no code change - run it again afterwards and the marks follow.
    /// </para>
    /// <para>
    /// Touches Main_Environment_2 and nothing else. The glow itself is entirely the shader's job:
    /// <c>RootsDance/Environment/FluorescentReveal</c> stays black until the flashlight beam falls
    /// on it, and FlashlightBeamBroadcaster feeds it the beam as shader globals at runtime.
    /// </para>
    /// <para>
    /// Idempotent: it rebuilds each overlay from scratch but leaves the materials' authored values
    /// alone, so colour and intensity tuned in the Inspector survive a rebuild.
    /// </para>
    /// Menu: RootsDance > Build Corridor Poster Runes.
    /// </remarks>
    public static class CorridorPostersBuilder
    {
        private const string k_Scene = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_2.unity";

        /// <summary>The hand-placed group node whose children are the corridor's posters.</summary>
        internal const string k_GroupName = "LabCorridorPosters";

        private const string k_Shader = "RootsDance/Environment/FluorescentReveal";
        private const string k_TunedMaterial = "Assets/RootsDance/Materials/Environment/PosterRunes.mat";
        private const string k_MaterialDir = "Assets/RootsDance/Materials/Environment";
        private const string k_MaskDir = "Assets/RootsDance/Textures/Environment";

        private const string k_OverlayName = "RuneGlow";

        /// <summary>One rune per poster. The mask and the material are both named after the rune.</summary>
        internal static readonly string[] k_Runes = { "Fehu", "Raidho", "Thurisaz", "Mannaz" };

        /// <summary>
        /// How sheet-like a child has to be before it counts as a poster: its thinnest side over
        /// its longest. A printed sheet is far under this; a photogrammetry chunk that stands on
        /// its own base is not, and gets left alone.
        /// </summary>
        private const float k_SheetRatio = 0.25f;

        /// <summary>The rune's width as a fraction of the poster's, and its aspect (square).</summary>
        private const float k_RuneWidthFraction = 0.38f;
        private const float k_RuneAspect = 1f;

        /// <summary>Rune centre as a fraction of the poster's size, measured from its centre.</summary>
        private const float k_RuneOffsetY = -0.16f;

        /// <summary>How far a hand-daubed mark strays from that nominal spot on the sheet.</summary>
        private const float k_MarkSlide = 0.07f;
        private const float k_MarkRoll = 9f;

        /// <summary>Metres the overlay floats in front of the poster face, to beat z-fighting.</summary>
        private const float k_Gap = 0.003f;

        /// <summary>Fixed so the same posters always take the same marks on a rebuild.</summary>
        private const int k_Seed = 20260829;

        private static readonly int k_RuneMaskId = Shader.PropertyToID("_RuneMask");

        [MenuItem("RootsDance/Build Corridor Poster Runes")]
        public static void Build()
        {
            Material[] materials = BuildMaterials();

            if (materials == null)
            {
                return;
            }

            Scene scene = EditorSceneManager.OpenScene(k_Scene, OpenSceneMode.Single);
            GameObject group = Find(scene, k_GroupName);

            if (group == null)
            {
                Debug.LogError($"CorridorPostersBuilder: no '{k_GroupName}' in {k_Scene}. The "
                    + "posters are hung by hand; this tool only marks what is already under that "
                    + "group node.");
                return;
            }

            List<Transform> sheets = Sheets(group.transform);

            if (sheets.Count == 0)
            {
                Debug.LogError($"CorridorPostersBuilder: '{k_GroupName}' has no sheet-like child "
                    + "to mark.");
                return;
            }

            System.Random rng = new System.Random(k_Seed);

            for (int i = 0; i < sheets.Count; i++)
            {
                // One rune each, in order. With more sheets than runes the sequence repeats, which
                // is the only honest thing four glyphs can do across five walls.
                string rune = k_Runes[i % k_Runes.Length];
                Mark(sheets[i], rune, materials[i % k_Runes.Length], rng);
            }

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            AssetDatabase.SaveAssets();

            Debug.Log($"CorridorPostersBuilder: marked {sheets.Count} posters under "
                + $"'{k_GroupName}', one rune each.");
        }

        /// <summary>
        /// One additive material per rune, each carrying that rune's own mask. Values tuned on the
        /// old shared material are copied over so colour and intensity survive the split.
        /// </summary>
        private static Material[] BuildMaterials()
        {
            Shader shader = Shader.Find(k_Shader);

            if (shader == null)
            {
                Debug.LogError($"CorridorPostersBuilder: shader '{k_Shader}' not found. It has to "
                    + "compile before the materials can be built.");
                return null;
            }

            Material tuned = AssetDatabase.LoadAssetAtPath<Material>(k_TunedMaterial);
            Material[] materials = new Material[k_Runes.Length];

            for (int i = 0; i < k_Runes.Length; i++)
            {
                string path = Path.Combine(k_MaterialDir, $"PosterRune_{k_Runes[i]}.mat");
                Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

                if (material == null)
                {
                    material = tuned == null ? new Material(shader) : new Material(tuned);
                    material.shader = shader;
                    Directory.CreateDirectory(k_MaterialDir);
                    AssetDatabase.CreateAsset(material, path);
                }

                string maskPath = Path.Combine(k_MaskDir, $"PosterRune_{k_Runes[i]}_Mask.png");
                Texture2D mask = AssetDatabase.LoadAssetAtPath<Texture2D>(maskPath);

                if (mask == null)
                {
                    Debug.LogWarning($"CorridorPostersBuilder: no mask at {maskPath}; "
                        + $"PosterRune_{k_Runes[i]} will show nothing. Run "
                        + "Tools/textures/make_poster_runes.py.");
                }

                material.SetTexture(k_RuneMaskId, mask);
                EditorUtility.SetDirty(material);
                materials[i] = material;
            }

            return materials;
        }

        /// <summary>
        /// The printed sheets under the group node, in a stable order. Measuring which children
        /// are sheets rather than matching their names keeps a renamed or duplicated poster
        /// working, and keeps the marks off anything that is not a flat print.
        /// </summary>
        internal static List<Transform> Sheets(Transform group)
        {
            List<Transform> sheets = new List<Transform>();

            foreach (Transform child in group)
            {
                MeshFilter filter = child.GetComponentInChildren<MeshFilter>();

                if (filter == null || filter.sharedMesh == null)
                {
                    continue;
                }

                Vector3 extents = filter.sharedMesh.bounds.extents;
                float thin = Mathf.Min(extents.x, Mathf.Min(extents.y, extents.z));
                float wide = Mathf.Max(extents.x, Mathf.Max(extents.y, extents.z));

                if (wide <= 0f || thin / wide > k_SheetRatio)
                {
                    Debug.Log($"CorridorPostersBuilder: '{child.name}' is not a flat sheet "
                        + $"({filter.sharedMesh.bounds.size:F2}); left unmarked.");
                    continue;
                }

                sheets.Add(child);
            }

            // Hierarchy order is what the scene shows, but it is not stable across a duplicate, so
            // sort by name to keep a given poster on a given rune between rebuilds.
            sheets.Sort((a, b) => string.CompareOrdinal(a.name, b.name));

            return sheets;
        }

        /// <summary>Lays one rune over one poster's printed face.</summary>
        private static void Mark(Transform poster, string rune, Material material, System.Random rng)
        {
            MeshFilter filter = poster.GetComponentInChildren<MeshFilter>();
            Transform face = filter.transform;
            Bounds local = filter.sharedMesh.bounds;

            int normalAxis = ThinnestAxis(local.extents);
            int widthAxis = (normalAxis + 1) % 3;
            int heightAxis = (normalAxis + 2) % 3;

            // Which in-plane axis is "up" is not something the extents can answer - a portrait
            // sheet and a landscape one disagree. The poster hangs upright, so ask the world.
            if (Verticality(face, widthAxis) > Verticality(face, heightAxis))
            {
                (widthAxis, heightAxis) = (heightAxis, widthAxis);
            }

            // Nothing in a mesh says which side of a sheet is its front. The overlay that is
            // already there does, so the side the artist printed on is inherited rather than
            // guessed; a poster that has never been marked falls back to the mesh's +normal.
            Transform existing = face.Find(k_OverlayName);
            float faceSign = 1f;

            if (existing != null)
            {
                float offset = existing.localPosition[normalAxis] - local.center[normalAxis];
                faceSign = offset < 0f ? -1f : 1f;
                Object.DestroyImmediate(existing.gameObject);
            }

            GameObject overlay = GameObject.CreatePrimitive(PrimitiveType.Quad);
            overlay.name = k_OverlayName;
            Object.DestroyImmediate(overlay.GetComponent<Collider>());
            overlay.GetComponent<MeshRenderer>().sharedMaterial = material;
            overlay.AddComponent<FluorescentRevealMarks>();
            overlay.transform.SetParent(face, false);

            Vector3 normal = Axis(normalAxis) * faceSign;
            Vector3 up = Axis(heightAxis);
            Vector3 across = Axis(widthAxis);

            // Unity's Quad primitive faces its own -Z, so the sheet's outward normal has to be the
            // quad's backward axis; aiming LookRotation at it draws the rune mirrored.
            float roll = (float)(rng.NextDouble() * 2.0 - 1.0) * k_MarkRoll;
            overlay.transform.localRotation = Quaternion.AngleAxis(roll, normal)
                * Quaternion.LookRotation(-normal, up);

            float width = 2f * local.extents[widthAxis] * k_RuneWidthFraction;
            overlay.transform.localScale = new Vector3(width, width / k_RuneAspect, 1f);

            // A mark daubed on by hand does not land in the same spot on every sheet.
            float slideX = (float)(rng.NextDouble() * 2.0 - 1.0) * k_MarkSlide;
            float slideY = (float)(rng.NextDouble() * 2.0 - 1.0) * k_MarkSlide;

            Vector3 position = local.center;
            position += normal * (local.extents[normalAxis] + k_Gap);
            position += up * (2f * local.extents[heightAxis] * k_RuneOffsetY + slideY);
            position += across * slideX;
            overlay.transform.localPosition = position;

            // The overlay is dressing, not geometry: never baked or occlusion-culled as if it were
            // part of the poster.
            GameObjectUtility.SetStaticEditorFlags(overlay, 0);

            Debug.Log($"[{poster.name}] marked {rune}, roll {roll:F1} deg, face sign {faceSign:F0}.");
        }

        /// <summary>How closely one of a transform's local axes lines up with world up, 0..1.</summary>
        private static float Verticality(Transform transform, int axis)
        {
            return Mathf.Abs(transform.TransformDirection(Axis(axis)).normalized.y);
        }

        private static int ThinnestAxis(Vector3 extents)
        {
            if (extents.x <= extents.y && extents.x <= extents.z)
            {
                return 0;
            }

            return extents.y <= extents.z ? 1 : 2;
        }

        private static Vector3 Axis(int index)
        {
            return index == 0 ? Vector3.right : index == 1 ? Vector3.up : Vector3.forward;
        }

        internal static GameObject Find(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == name)
                {
                    return root;
                }
            }

            return null;
        }
    }
}

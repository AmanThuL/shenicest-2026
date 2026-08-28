using System.IO;
using RootsDance.Environment;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Lays the fluorescent runes over the band poster in Main_Environment_2: builds the material,
    /// fits a quad to the poster's face and wires the reveal component.
    /// </summary>
    /// <remarks>
    /// <para>
    /// Touches Main_Environment_2 and nothing else. Unlike <see cref="TempPlaceEnvironment2"/> it
    /// never opens Main_Environment, because it has no terrain to sample — the runes are placed
    /// against the poster's own bounds, which is a purely local measurement. Main_Environment is a
    /// shared scene and this tool has no business being open in it.
    /// </para>
    /// <para>
    /// Idempotent: running it again rebuilds the overlay from scratch but leaves the material's
    /// authored values alone, so colour and intensity tuned in the Inspector survive a rebuild.
    /// </para>
    /// Menu: RootsDance > Build Poster Runes.
    /// </remarks>
    public static class FluorescentRunesBuilder
    {
        private const string k_Scene = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_2.unity";
        private const string k_PosterName = "BandPoster";
        private const string k_OverlayName = "RuneGlow";

        private const string k_Shader = "RootsDance/Environment/FluorescentReveal";
        private const string k_MaterialPath = "Assets/RootsDance/Materials/Environment/PosterRunes.mat";
        private const string k_MaskPath = "Assets/RootsDance/Textures/Environment/PosterRunes_Mask.png";

        /// <summary>Rune band width as a fraction of the poster's own width.</summary>
        private const float k_BandWidthFraction = 0.74f;

        /// <summary>Aspect of the mask, four glyphs across one band. Keep in sync with the PNG.</summary>
        private const float k_BandAspect = 4f;

        /// <summary>Band centre as a fraction of the poster's height, measured from its centre.</summary>
        private const float k_BandOffsetFraction = -0.28f;

        /// <summary>
        /// Which end of the sheet's normal axis carries the print. Nothing in a mesh says which
        /// side of a sheet is its front, so this is authored: flip it to -1 if the marks come out
        /// on the back of the poster.
        /// </summary>
        private const float k_FaceSign = 1f;

        /// <summary>Metres the overlay floats in front of the poster face, to beat z-fighting.</summary>
        private const float k_Gap = 0.003f;

        private static readonly int k_RuneMaskId = Shader.PropertyToID("_RuneMask");

        [MenuItem("RootsDance/Build Poster Runes")]
        public static void Build()
        {
            Material material = BuildMaterial();

            if (material == null)
            {
                return;
            }

            Scene scene = EditorSceneManager.OpenScene(k_Scene, OpenSceneMode.Single);
            GameObject poster = Find(scene, k_PosterName);

            if (poster == null)
            {
                Debug.LogError($"FluorescentRunesBuilder: no '{k_PosterName}' in {k_Scene}. Run "
                    + "RootsDance > Place Environment 2 Props first.");
                return;
            }

            MeshRenderer face = poster.GetComponentInChildren<MeshRenderer>();

            if (face == null)
            {
                Debug.LogError($"FluorescentRunesBuilder: '{k_PosterName}' has no MeshRenderer.");
                return;
            }

            GameObject overlay = Rebuild(face.transform, material);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            AssetDatabase.SaveAssets();

            Bounds bounds = overlay.GetComponent<Renderer>().bounds;
            Debug.Log($"FluorescentRunesBuilder: {k_OverlayName} size {bounds.size:F3} at "
                + $"{overlay.transform.position:F3}.");
        }

        /// <summary>
        /// Creates the material if it is missing and rewires its mask, leaving every authored value
        /// on an existing one untouched.
        /// </summary>
        private static Material BuildMaterial()
        {
            Shader shader = Shader.Find(k_Shader);

            if (shader == null)
            {
                Debug.LogError($"FluorescentRunesBuilder: shader '{k_Shader}' not found. It has to "
                    + "compile before the material can be built.");
                return null;
            }

            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_MaterialPath);

            if (material == null)
            {
                material = new Material(shader);
                Directory.CreateDirectory(Path.GetDirectoryName(k_MaterialPath));
                AssetDatabase.CreateAsset(material, k_MaterialPath);
            }

            Texture2D mask = AssetDatabase.LoadAssetAtPath<Texture2D>(k_MaskPath);

            if (mask == null)
            {
                Debug.LogWarning($"FluorescentRunesBuilder: no mask at {k_MaskPath}; the material "
                    + "was built but will show nothing. Run Tools/textures/make_poster_runes.py.");
            }

            material.SetTexture(k_RuneMaskId, mask);
            EditorUtility.SetDirty(material);

            return material;
        }

        /// <summary>
        /// Fits a quad to the poster's printed face. Which local axis that is comes from the mesh:
        /// the poster is a sheet, so its thinnest local extent is its normal, and the other two
        /// axes are its width and height. Measuring rather than assuming keeps the tool working if
        /// the model is re-exported on different axes.
        /// </summary>
        private static GameObject Rebuild(Transform face, Material material)
        {
            Transform existing = face.Find(k_OverlayName);

            if (existing != null)
            {
                Object.DestroyImmediate(existing.gameObject);
            }

            Bounds local = face.GetComponent<MeshFilter>().sharedMesh.bounds;
            int normalAxis = ThinnestAxis(local.extents);
            int widthAxis = (normalAxis + 1) % 3;
            int heightAxis = (normalAxis + 2) % 3;

            // Which of the two in-plane axes is "up" is not something the extents can answer — a
            // portrait sheet and a landscape one disagree. The poster hangs upright in the world,
            // so ask the world: the more vertical of the two axes is the sheet's height.
            if (Verticality(face, widthAxis) > Verticality(face, heightAxis))
            {
                (widthAxis, heightAxis) = (heightAxis, widthAxis);
            }

            GameObject overlay = GameObject.CreatePrimitive(PrimitiveType.Quad);
            overlay.name = k_OverlayName;
            Object.DestroyImmediate(overlay.GetComponent<Collider>());
            overlay.GetComponent<MeshRenderer>().sharedMaterial = material;
            overlay.AddComponent<FluorescentRevealMarks>();

            overlay.transform.SetParent(face, false);

            // Unity's Quad primitive faces its own -Z, so the sheet's outward normal has to be
            // the quad's *backward* axis. Aiming LookRotation at the normal instead puts the
            // quad's back towards the viewer, which draws the whole band mirrored.
            Vector3 normal = Axis(normalAxis) * k_FaceSign;
            Vector3 up = Axis(heightAxis);
            overlay.transform.localRotation = Quaternion.LookRotation(-normal, up);

            float width = 2f * local.extents[widthAxis] * k_BandWidthFraction;
            float height = width / k_BandAspect;
            overlay.transform.localScale = new Vector3(width, height, 1f);

            Vector3 position = local.center;
            position += normal * (local.extents[normalAxis] + k_Gap);
            position += up * (2f * local.extents[heightAxis] * k_BandOffsetFraction);
            overlay.transform.localPosition = position;

            // The overlay is dressing, not geometry: it must never be baked or occlusion-culled as
            // if it were part of the poster.
            GameObjectUtility.SetStaticEditorFlags(overlay, 0);

            return overlay;
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

        private static GameObject Find(Scene scene, string name)
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

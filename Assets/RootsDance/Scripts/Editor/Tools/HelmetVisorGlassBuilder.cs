using RootsDance.Player;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Moves the visor's glass out of the HUD and onto the helmet.
    /// <para>
    /// The smudges are grime on glass — the visor shader keys them to the opening's own edge,
    /// "where the glass meets the seal". But they were drawn by a full-screen Image on a
    /// <see cref="RenderMode.ScreenSpaceOverlay"/> canvas, which is locked to the screen, not to
    /// the helmet. Turn the head and the fingerprints slide across the faceplate; play the helmet
    /// removal and they stay behind. Grime belongs to the glass, and the glass belongs to the
    /// model.
    /// </para>
    /// <para>
    /// The helmet is real geometry — <c>Helmet_Placeholder</c> on a <c>helmet_socket</c> inside the
    /// arms rig — but it has an opening rather than a pane, so there was nothing to smear. This
    /// hangs a world-space pane in that opening, parented to the socket, so it moves with the
    /// helmet for free and is lit and depth-sorted with it.
    /// </para>
    /// <para>
    /// The readouts stay on the screen-space HUD: they are an overlay projected onto the inside of
    /// the visor, not something painted on the glass, and they are laid out against the opening by
    /// <c>HelmetHudBuilder</c>. Only the glass moves here.
    /// </para>
    /// </summary>
    public static class HelmetVisorGlassBuilder
    {
        private const string k_LogPrefix = "HelmetVisorGlassBuilder";
        private const string k_GlassName = "VisorGlassWorld";
        private const string k_SocketName = "helmet_socket";
        private const string k_UiMaterialPath = "Assets/RootsDance/Materials/HelmetVisor.mat";
        private const string k_GlassMaterialPath = "Assets/RootsDance/Materials/HelmetVisorGlass.mat";

        /// <summary>
        /// How far in front of the eye the pane sits, in metres. Inside the helmet, closer than
        /// anything the player can walk into, and far enough not to clip the near plane.
        /// </summary>
        private const float k_DistanceMetres = 0.12f;

        /// <summary>Canvas units across the pane. Matches the HUD so the shader's UVs agree.</summary>
        private static readonly Vector2 k_Reference = new Vector2(1920f, 1080f);

        [MenuItem("RootsDance/Helmet/Move Visor Glass Onto The Helmet")]
        public static void Build()
        {
            FirstPersonController player = Object.FindFirstObjectByType<FirstPersonController>();

            if (player == null)
            {
                Debug.LogError($"[{k_LogPrefix}] No player in the open scene. Open a level's "
                    + "Gameplay scene and run this again.");
                return;
            }

            Transform socket = FindDeep(player.transform, k_SocketName);

            if (socket == null)
            {
                Debug.LogError($"[{k_LogPrefix}] No '{k_SocketName}' under the player. The helmet "
                    + "comes in with the arms rig (Arms.fbx); this needs that rig in the scene.");
                return;
            }

            Material glassMaterial = EnsureGlassMaterial();

            if (glassMaterial == null)
            {
                return;
            }

            BuildPane(socket, glassMaterial, player);
            SilenceScreenSpaceSmudge();

            EditorSceneManager.MarkSceneDirty(SceneManager.GetActiveScene());

            Debug.Log($"[{k_LogPrefix}] The glass now hangs on '{socket.name}' and moves with the "
                + "helmet; the HUD's copy of the smudge is switched off. The scene is NOT saved.",
                socket);
        }

        /// <summary>
        /// The pane: a world-space canvas on the socket, so the existing visor shader — a uGUI
        /// shader — keeps working unchanged while the geometry rides the helmet.
        /// </summary>
        private static void BuildPane(Transform socket, Material material, FirstPersonController player)
        {
            Transform existing = socket.Find(k_GlassName);
            GameObject pane = existing != null ? existing.gameObject : null;

            if (pane == null)
            {
                pane = new GameObject(k_GlassName, typeof(RectTransform), typeof(Canvas));
                pane.transform.SetParent(socket, false);
            }

            Canvas canvas = pane.GetComponent<Canvas>();
            canvas.renderMode = RenderMode.WorldSpace;

            RectTransform rect = (RectTransform)pane.transform;
            rect.sizeDelta = k_Reference;

            // Sized so the pane covers the camera's frustum at its distance: the glass has to fill
            // the view whatever the field of view is, or the player sees round the edge of it.
            Camera camera = Camera.main;
            float fov = camera == null ? 60f : camera.fieldOfView;
            float aspect = camera == null ? 16f / 9f : camera.aspect;
            float height = 2f * k_DistanceMetres * Mathf.Tan(fov * 0.5f * Mathf.Deg2Rad);
            float width = height * aspect;

            // A little proud of the frustum, so no gap opens at the corners as the head turns.
            const float k_Overscan = 1.15f;
            rect.localScale = Vector3.one * (width * k_Overscan / k_Reference.x);

            // Squared to the eye rather than to the socket's own axes: the socket is a rig bone and
            // carries whatever orientation the animator left it in.
            Transform eye = player.transform.Find("Head") ?? player.transform;
            rect.position = eye.position + eye.forward * k_DistanceMetres;
            rect.rotation = Quaternion.LookRotation(eye.forward, eye.up);

            Image image = pane.GetComponent<Image>();

            if (image == null)
            {
                image = pane.AddComponent<Image>();
            }

            image.material = material;
            image.raycastTarget = false;
        }

        /// <summary>The glass's own material, so the HUD's copy can be tuned separately.</summary>
        private static Material EnsureGlassMaterial()
        {
            Material source = AssetDatabase.LoadAssetAtPath<Material>(k_UiMaterialPath);

            if (source == null)
            {
                Debug.LogError($"[{k_LogPrefix}] {k_UiMaterialPath} is missing; run the helmet HUD "
                    + "builder first so the visor material exists.");
                return null;
            }

            Material glass = AssetDatabase.LoadAssetAtPath<Material>(k_GlassMaterialPath);

            if (glass == null)
            {
                glass = new Material(source);
                AssetDatabase.CreateAsset(glass, k_GlassMaterialPath);
            }

            EditorUtility.SetDirty(glass);

            return glass;
        }

        /// <summary>
        /// Turns the smudge off on the HUD's visor material, so it is drawn once — on the glass
        /// that moves — rather than twice with one copy stuck to the screen.
        /// <para>
        /// The strength is zeroed rather than the texture cleared: the HUD builder re-assigns that
        /// texture whenever the slot is empty, so clearing it would come back on the next rebuild.
        /// </para>
        /// </summary>
        private static void SilenceScreenSpaceSmudge()
        {
            Material ui = AssetDatabase.LoadAssetAtPath<Material>(k_UiMaterialPath);

            if (ui == null || !ui.HasProperty("_SmudgeStrength"))
            {
                return;
            }

            ui.SetFloat("_SmudgeStrength", 0f);
            EditorUtility.SetDirty(ui);
        }

        private static Transform FindDeep(Transform root, string name)
        {
            if (root.name == name)
            {
                return root;
            }

            for (int i = 0; i < root.childCount; i++)
            {
                Transform found = FindDeep(root.GetChild(i), name);

                if (found != null)
                {
                    return found;
                }
            }

            return null;
        }
    }
}

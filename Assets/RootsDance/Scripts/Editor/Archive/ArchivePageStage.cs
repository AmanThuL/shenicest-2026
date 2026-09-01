using System;
using RootsDance.Archive;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Editor.Archive
{
    /// <summary>
    /// Renders one archive sheet head-on, off-screen, and hands back the pixels. The preview tool
    /// and the render test both go through here, so what a person looks at and what CI asserts on
    /// are the same picture.
    /// <para>
    /// Two settings here are the whole reason an earlier version of this produced a blank white
    /// page and sent everyone hunting for a shader bug that was not there:
    /// </para>
    /// <list type="bullet">
    /// <item><description><b>The clear colour has to be set on HDRP's camera data.</b> HDRP ignores
    /// <see cref="Camera.backgroundColor"/>; left alone it draws its default sky, which both hides
    /// the sheet against a bright background and lights it with sky ambient.</description></item>
    /// <item><description><b>The target is floating point and post-processing is off, so the
    /// readback is raw linear radiance</b> — nothing is exposed, tonemapped or clipped. That is
    /// what makes the render test meaningful: comparing two regions of an 8-bit picture is
    /// worthless the moment the exposure is off enough to drive both of them to white, which is
    /// how a perfectly good page was twice mistaken for one that was not drawing. Callers that
    /// want something to look at run the result through <see cref="Normalize"/>.</description></item>
    /// </list>
    /// <para>
    /// The sheet is drawn entirely by an unlit canvas, so the key light here does not fall on it
    /// directly — <c>ArchivePaperLighting</c> samples that light and tints the page with it, and
    /// that component runs in the Editor too, so this render exercises the same path the game does.
    /// </para>
    /// </summary>
    public static class ArchivePageStage
    {
        /// <summary>What a render is for.</summary>
        public enum RenderMode
        {
            /// <summary>The sheet as it ships: the composed page, folded, lit and dusted.</summary>
            Finished = 0,

            /// <summary>
            /// The page's layers laid out flat, with no fold, no lighting and no dust, framed
            /// exactly to the sheet. This is what gets baked into the composed page texture, and
            /// all three of those are left out because the finished sheet applies them over it —
            /// baking any of them in would apply it twice.
            /// </summary>
            ComposeFlat = 1
        }

        /// <summary>
        /// Irradiance that makes a head-on Lambert surface return its own albedo: outgoing radiance
        /// is <c>albedo · E / π</c>, so an E of π gives radiance equal to albedo. Exact only because
        /// the readback is floating point and nothing clips on the way out.
        /// </summary>
        private const float k_AlbedoLux = Mathf.PI;

        private static readonly Color k_Backdrop = new Color(0.10f, 0.10f, 0.09f);

        /// <summary>
        /// Renders <paramref name="document"/> on the shared page prefab. The caller owns the
        /// returned texture and must destroy it. Returns null after logging when the prefab or the
        /// page component is missing.
        /// </summary>
        public static Texture2D Render(ArchiveDocumentSO document, int width, int height)
        {
            return Render(document, width, height, RenderMode.Finished, null);
        }

        /// <summary>Renders in the given mode; see <see cref="RenderMode"/>.</summary>
        public static Texture2D Render(ArchiveDocumentSO document, int width, int height,
            RenderMode mode)
        {
            return Render(document, width, height, mode, null);
        }

        /// <summary>
        /// Renders the sheet, giving <paramref name="prepare"/> the live instance first. That hook
        /// is what lets a test render the same page twice with one layer switched off and compare
        /// the two — the only controlled way to prove a layer is doing anything, when the paper
        /// underneath it is stained differently everywhere.
        /// </summary>
        public static Texture2D Render(ArchiveDocumentSO document, int width, int height,
            System.Action<GameObject> prepare)
        {
            return Render(document, width, height, RenderMode.Finished, prepare);
        }

        public static Texture2D Render(ArchiveDocumentSO document, int width, int height,
            RenderMode mode, System.Action<GameObject> prepare)
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(
                ArchiveDocumentPrefabBuilder.k_PrefabPath);

            if (prefab == null)
            {
                Debug.LogError($"[ArchivePageStage] {ArchiveDocumentPrefabBuilder.k_PrefabPath} "
                    + "is missing; build it first.");
                return null;
            }

            GameObject instance = UnityEngine.Object.Instantiate(prefab);
            GameObject cameraObject = new GameObject("ArchiveStageCamera");
            GameObject lightObject = new GameObject("ArchiveStageLight");
            RenderTexture target = new RenderTexture(width, height, 24, RenderTextureFormat.ARGBHalf);
            Texture2D readback = new Texture2D(width, height, TextureFormat.RGBAHalf, false);

            try
            {
                ArchiveDocumentPageView page = instance.GetComponentInChildren<ArchiveDocumentPageView>();

                if (page == null)
                {
                    Debug.LogError("[ArchivePageStage] The page prefab has no page view on it.");
                    UnityEngine.Object.DestroyImmediate(readback);
                    return null;
                }

                page.Bind(document);
                ClearDust(page);

                if (mode == RenderMode.ComposeFlat)
                {
                    page.ShowLayersForComposing();
                }

                if (prepare != null)
                {
                    prepare(instance);
                }

                Transform sheet = page.transform;
                SetUpLight(lightObject, sheet, instance, mode);
                Camera camera = SetUpCamera(cameraObject, page, target, width, height, mode);

                Canvas.ForceUpdateCanvases();
                camera.Render();

                RenderTexture previous = RenderTexture.active;
                RenderTexture.active = target;
                readback.ReadPixels(new Rect(0f, 0f, width, height), 0, 0);
                readback.Apply(false, false);
                RenderTexture.active = previous;

                return readback;
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(cameraObject);
                UnityEngine.Object.DestroyImmediate(lightObject);
                UnityEngine.Object.DestroyImmediate(instance);
                target.Release();
                UnityEngine.Object.DestroyImmediate(target);
            }
        }

        /// <summary>The backdrop the sheet is rendered against, for callers testing what is off it.</summary>
        public static Color Backdrop => k_Backdrop;

        /// <summary>
        /// Turns a linear radiance render into something a person can look at: scaled so the
        /// brightest thing on the sheet sits just under white, then encoded to sRGB. Self-
        /// calibrating on purpose — the alternative is a hand-tuned exposure constant that goes
        /// wrong every time the recipe or the light changes.
        /// </summary>
        public static Texture2D Normalize(Texture2D linear)
        {
            Color[] pixels = linear.GetPixels();
            float peak = 0f;

            for (int i = 0; i < pixels.Length; i++)
            {
                peak = Mathf.Max(peak, Luma(pixels[i]));
            }

            float scale = peak > 1e-4f ? 0.94f / peak : 1f;

            for (int i = 0; i < pixels.Length; i++)
            {
                Color c = pixels[i] * scale;
                pixels[i] = new Color(ToSrgb(c.r), ToSrgb(c.g), ToSrgb(c.b), 1f);
            }

            Texture2D output = new Texture2D(linear.width, linear.height, TextureFormat.RGBA32, false);
            output.SetPixels(pixels);
            output.Apply(false, false);

            return output;
        }

        /// <summary>
        /// Encodes a linear render to sRGB without rescaling it. Used for the composed page, whose
        /// colours have to come back exactly as authored — unlike a preview, which is normalised.
        /// </summary>
        public static Texture2D ToSrgb(Texture2D linear)
        {
            Color[] pixels = linear.GetPixels();

            for (int i = 0; i < pixels.Length; i++)
            {
                Color c = pixels[i];
                pixels[i] = new Color(ToSrgb(c.r), ToSrgb(c.g), ToSrgb(c.b), Mathf.Clamp01(c.a));
            }

            Texture2D output = new Texture2D(linear.width, linear.height, TextureFormat.RGBA32, false);
            output.SetPixels(pixels);
            output.Apply(false, false);

            return output;
        }

        /// <summary>Rec. 709 luminance, for comparing how bright two regions are.</summary>
        public static float Luma(Color color)
        {
            return color.r * 0.2126f + color.g * 0.7152f + color.b * 0.0722f;
        }

        private static float ToSrgb(float value)
        {
            float v = Mathf.Clamp01(value);

            return v <= 0.0031308f ? v * 12.92f : 1.055f * Mathf.Pow(v, 1f / 2.4f) - 0.055f;
        }

        private static Camera SetUpCamera(GameObject holder, ArchiveDocumentPageView page,
            RenderTexture target, int width, int height, RenderMode mode)
        {
            Transform sheet = page.transform;
            Vector2 size = page.PageSizeMeters;

            Camera camera = holder.AddComponent<Camera>();
            camera.orthographic = true;
            camera.aspect = (float)width / height;
            // Composing frames the sheet exactly: the texture's UVs have to line up with the
            // page's, or the fold field and the page it displaces would be off by the margin.
            float margin = mode == RenderMode.ComposeFlat ? 1f : 1.06f;
            camera.orthographicSize = Mathf.Max(size.y, size.x / camera.aspect) * 0.5f * margin;
            camera.targetTexture = target;

            // A canvas is read from behind its forward axis, not in front of it: the default camera
            // looks *along* +Z at a canvas sitting at the origin. Standing on the other side gives a
            // mirror image of the page.
            camera.transform.SetPositionAndRotation(sheet.position - sheet.forward * 0.5f,
                Quaternion.LookRotation(sheet.forward, sheet.up));

            HDAdditionalCameraData data = holder.AddComponent<HDAdditionalCameraData>();
            data.clearColorMode = HDAdditionalCameraData.ClearColorMode.Color;

            // Composing clears to nothing so the sheet's torn silhouette survives into the alpha.
            data.backgroundColorHDR = mode == RenderMode.ComposeFlat
                ? new Color(0f, 0f, 0f, 0f)
                : k_Backdrop;
            data.volumeLayerMask = 0;

            // Off, so the readback is radiance rather than an exposed and tonemapped picture. The
            // point of the preview is the colours the page was authored with.
            data.customRenderingSettings = true;
            FrameSettings settings = data.renderingPathCustomFrameSettings;
            settings.SetEnabled(FrameSettingsField.Postprocess, false);
            settings.SetEnabled(FrameSettingsField.ExposureControl, false);
            data.renderingPathCustomFrameSettings = settings;

            FrameSettingsOverrideMask mask = data.renderingPathCustomFrameSettingsOverrideMask;
            mask.mask[(uint)FrameSettingsField.Postprocess] = true;
            mask.mask[(uint)FrameSettingsField.ExposureControl] = true;
            data.renderingPathCustomFrameSettingsOverrideMask = mask;

            return camera;
        }

        private static void SetUpLight(GameObject holder, Transform sheet, GameObject instance,
            RenderMode mode)
        {
            Light light = holder.AddComponent<Light>();
            light.type = LightType.Directional;
            light.color = Color.white;
            light.intensity = k_AlbedoLux;
            light.shadows = LightShadows.None;

            // Straight down the sheet's normal, so N·L is 1 and the paper returns its own albedo.
            holder.transform.rotation = Quaternion.LookRotation(sheet.forward, sheet.up);

            // The sheet is unlit, so the light does not reach it by falling on it — it reaches it
            // through the component that samples the room and tints the page. Handing the key light
            // over is what a level does too; without it the page sits at its darkness floor and the
            // preview shows a correctly-rendered sheet in an unlit room.
            ArchivePaperLighting lighting = instance.GetComponentInChildren<ArchivePaperLighting>();

            if (lighting == null)
            {
                return;
            }

            if (mode == RenderMode.ComposeFlat)
            {
                // The composed page holds the colours as authored; the finished sheet is what gets
                // lit. Leaving this on would bake one room's light into every room's sheet.
                lighting.enabled = false;
                return;
            }

            SerializedObject serialized = new SerializedObject(lighting);
            serialized.FindProperty("m_keyLight").objectReferenceValue = light;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            // Outside play mode the component is inert, because tinting a sheet writes material
            // instances and text colours into the scene the sheet belongs to. This instance belongs
            // to nobody — it is created here and destroyed at the end of the render — so it is one
            // of the few that may run.
            lighting.PreviewOutsidePlayMode = true;

            // The component samples on a throttle; a still has one frame, so ask for it now.
            lighting.enabled = false;
            lighting.enabled = true;
        }

        /// <summary>
        /// Drives the dust straight to nothing, in the one frame a still gets.
        /// <see cref="ArchiveDocumentPageView.BeginReading"/> wipes it over several frames, and an
        /// Editor render has no frames for that to wait for.
        /// </summary>
        private static void ClearDust(ArchiveDocumentPageView page)
        {
            SerializedObject serialized = new SerializedObject(page);
            SerializedProperty overlay = serialized.FindProperty("m_dustOverlay");
            UnityEngine.UI.Graphic graphic = overlay.objectReferenceValue as UnityEngine.UI.Graphic;

            if (graphic == null)
            {
                return;
            }

            Color color = graphic.color;
            color.a = 0f;
            graphic.color = color;
        }

        /// <summary>Every authored document under <c>Data/Archive/</c>.</summary>
        public static ArchiveDocumentSO[] LoadDocuments()
        {
            string[] guids = AssetDatabase.FindAssets("t:ArchiveDocumentSO",
                new[] { "Assets/RootsDance/Data/Archive" });
            ArchiveDocumentSO[] documents = new ArchiveDocumentSO[guids.Length];

            for (int i = 0; i < guids.Length; i++)
            {
                documents[i] = AssetDatabase.LoadAssetAtPath<ArchiveDocumentSO>(
                    AssetDatabase.GUIDToAssetPath(guids[i]));
            }

            Array.Sort(documents, (a, b) => string.CompareOrdinal(a.Id, b.Id));

            return documents;
        }
    }
}

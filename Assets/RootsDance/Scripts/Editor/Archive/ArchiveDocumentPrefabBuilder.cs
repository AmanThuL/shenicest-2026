using System.Collections.Generic;
using System.IO;
using RootsDance.Archive;
using TMPro;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;
using Block = RootsDance.Archive.ArchivePageLayout.Block;

namespace RootsDance.Editor.Archive
{
    /// <summary>
    /// Builds the one prefab every sheet in the archive is an instance of.
    /// <para>
    /// The whole sheet — paper and collage together — is one world-space canvas, and every layer of
    /// it is unlit. That is a deliberate retreat from something that did not work: the paper was
    /// first built as an <c>HDRP/Lit</c> quad standing behind the canvas, so it would catch the
    /// flashlight and show its fibre. It composited wrong, and not subtly. A lit surface writes
    /// scene radiance into the frame buffer — thousands, once HDRP's pre-exposure is applied —
    /// while a canvas graphic writes the 0-to-1 colour it was authored with. Blending the second
    /// over the first turns every wash, stamp and photograph into a dark smear: measured, the
    /// washes came out <em>darkening</em> the body of the page by 44% instead of lightening it.
    /// There is no value of the ink shader's <c>_PaperLight</c> that fixes that, because the gap is
    /// a pipeline pre-exposure factor a plain uGUI shader cannot read, and it may not include an
    /// HDRP header (guideline 07 §9.4).
    /// </para>
    /// <para>
    /// Keeping every layer in one space makes paper and ink agree by construction, and it is what
    /// HDRP supports anyway — it shades a canvas Unlit and nothing changes that. The response to
    /// the room is not lost: <see cref="ArchivePaperLighting"/> samples the light arriving at the
    /// sheet and tints the whole canvas with it, paper included, so the page dims and warms
    /// together. What is given up is per-pixel lighting on the paper — no normal-mapped fibre
    /// catching the torch. The normal and mask maps are still baked, for whoever later wants to
    /// build the sheet as a lit prop with the writing baked into its base map.
    /// </para>
    /// <para>
    /// A generated asset — every build re-applies the recipe to the same path, so the GUID survives
    /// and instances already placed in scenes pick the new layout up. Tune this file and the
    /// numbers in <see cref="ArchivePageLayout"/>, never the .prefab.
    /// </para>
    /// </summary>
    public static class ArchiveDocumentPrefabBuilder
    {
        private const string k_LogPrefix = "ArchiveDocumentPrefabBuilder";
        private const string k_PrefabFolder = "Assets/RootsDance/Prefabs/Props";
        private const string k_MaterialFolder = "Assets/RootsDance/Materials/Props";
        public const string k_PrefabPath = k_PrefabFolder + "/ArchiveDocument.prefab";
        public const string k_InkMaterialPath = k_MaterialFolder + "/ArchiveInk.mat";
        public const string k_PaperMaterialPath = k_MaterialFolder + "/ArchivePaper.mat";
        private const string k_InkShader = "RootsDance/UI/ArchiveInk";
        private const string k_PaperShader = "RootsDance/UI/ArchivePaper";

        /// <summary>Physical width of the sheet the prefab is built at; a loose A5-ish page.</summary>
        private const float k_PageWidthMeters = 0.16f;

        private const float k_PageThicknessMeters = 0.0015f;

        // Ink taken off the reference sheets: the heading is the archive's green, the researcher's
        // own hand is a warmer near-black, and everything the archive added later is grey.
        private static readonly Color k_HeadingInk = new Color(0.153f, 0.267f, 0.180f);
        private static readonly Color k_SubtitleInk = new Color(0.310f, 0.353f, 0.286f);
        private static readonly Color k_BodyInk = new Color(0.180f, 0.169f, 0.145f);
        private static readonly Color k_ArchiveInk = new Color(0.361f, 0.337f, 0.290f);
        private static readonly Color k_SignatureInk = new Color(0.290f, 0.259f, 0.212f);
        private static readonly Color k_BrownInk = new Color(0.353f, 0.216f, 0.129f);
        private static readonly Color k_StampInk = new Color(0.392f, 0.365f, 0.322f, 0.75f);
        private static readonly Color k_NotePaper = new Color(0.937f, 0.906f, 0.812f);
        private static readonly Color k_PhotoBlack = new Color(0.071f, 0.075f, 0.071f);
        private static readonly Color k_PhotoCard = new Color(0.871f, 0.839f, 0.761f);
        private static readonly Color k_EdgeStampInk = new Color(0.180f, 0.184f, 0.180f, 0.7f);

        /// <summary>Everything the page is printed with, so the builder passes one thing around.</summary>
        private sealed class Furniture
        {
            public Texture2D Paper;
            public Texture2D Dust;
            public Texture2D Wash;
            public Texture2D Pin;
            public Texture2D Tape;
            public Texture2D Stamp;
            public Texture2D Clip;
            public Texture2D Corner;
            public Material Ink;
            public Material PaperMaterial;
            public TMP_FontAsset HandFont;
            public TMP_FontAsset ArchiveFont;
        }

        /// <summary>
        /// The whole feature's content in one press, in the order the pieces depend on each other:
        /// the paper, the sheets, the hand they are written in (its atlas holds exactly their
        /// characters), the prefab that prints them, and finally each page composed into one image
        /// — which needs the prefab, because composing means rendering it.
        /// </summary>
        [MenuItem("RootsDance/Archive/Build All")]
        public static void BuildAll()
        {
            ArchivePaperTextureBaker.BakeAll();
            ArchiveDocumentLibrary.CreateAll();
            ArchiveFontBuilder.EnsureFontAsset();
            BuildMenu();

            // Last, and it needs the prefab: composing a page means rendering the prefab's layers.
            ArchivePageComposer.ComposeAll();
        }

        [MenuItem("RootsDance/Archive/Build Document Prefab")]
        public static void BuildMenu()
        {
            GameObject prefab = EnsurePrefab();

            if (prefab != null)
            {
                Debug.Log($"[{k_LogPrefix}] Built {k_PrefabPath}.", prefab);
            }
        }

        /// <summary>
        /// Rebuilds the page prefab and its two materials, baking the textures first when they are
        /// missing. Returns null after logging on failure.
        /// </summary>
        public static GameObject EnsurePrefab()
        {
            EnsureFolder(k_PrefabFolder);
            EnsureFolder(k_MaterialFolder);

            Material inkMaterial = EnsureInkMaterial();
            Material paperMaterial = EnsurePaperMaterial();

            if (inkMaterial == null || paperMaterial == null)
            {
                return null;
            }

            TMP_FontAsset archiveFont = TMP_Settings.defaultFontAsset;

            // The researcher's own hand. Falls back to the pixel font and then to Latin-only, and
            // says so — a page of tofu is worth a line in the console rather than being noticed in
            // a screenshot later.
            TMP_FontAsset handFont = AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(
                ArchiveFontBuilder.k_FontAssetPath);

            if (handFont == null)
            {
                handFont = ArchiveFontBuilder.EnsureFontAsset();
            }

            if (handFont == null)
            {
                handFont = FindFont("FusionPixel");
                Debug.LogWarning($"[{k_LogPrefix}] The handwriting font is missing; falling back "
                    + $"to {(handFont == null ? "a Latin-only font" : handFont.name)}.");
            }

            if (handFont == null)
            {
                handFont = archiveFont;
            }

            Furniture furniture = new Furniture
            {
                Paper = ArchivePaperTextureBaker.LoadPaperBase(),
                Dust = ArchivePaperTextureBaker.LoadDust(),
                Wash = ArchivePaperTextureBaker.LoadWash(),
                Pin = ArchivePaperTextureBaker.LoadPin(),
                Tape = ArchivePaperTextureBaker.LoadTape(),
                Stamp = ArchivePaperTextureBaker.LoadStamp(),
                Clip = ArchivePaperTextureBaker.LoadClip(),
                Corner = ArchivePaperTextureBaker.LoadCorner(),
                Ink = inkMaterial,
                PaperMaterial = paperMaterial,
                HandFont = handFont,
                ArchiveFont = archiveFont
            };

            GameObject root = new GameObject("ArchiveDocument");
            RectTransform sheet = BuildSheet(root.transform, furniture,
                out ArchiveDocumentPageView pageView);

            float pageHeightMeters = k_PageWidthMeters * ArchivePageLayout.k_Height
                / ArchivePageLayout.k_Width;

            BoxCollider box = root.AddComponent<BoxCollider>();
            box.size = new Vector3(k_PageWidthMeters, pageHeightMeters, k_PageThicknessMeters);

            ArchiveDocumentPickup pickup = root.AddComponent<ArchiveDocumentPickup>();
            SerializedObject serialized = new SerializedObject(pickup);
            serialized.FindProperty("m_sheet").objectReferenceValue = sheet;
            serialized.FindProperty("m_pageViewBehaviour").objectReferenceValue = pageView;
            SerializedProperty colliders = serialized.FindProperty("m_collidersWhileDown");
            colliders.arraySize = 1;
            colliders.GetArrayElementAtIndex(0).objectReferenceValue = box;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            GameObject prefab = PrefabUtility.SaveAsPrefabAsset(root, k_PrefabPath);
            Object.DestroyImmediate(root);
            AssetDatabase.SaveAssets();

            return prefab;
        }

        /// <summary>
        /// The sheet: a lit paper quad, the collage of ink standing just in front of it, and the
        /// dust over the lot. Draw order inside the canvas is hierarchy order.
        /// </summary>
        private static RectTransform BuildSheet(Transform parent, Furniture furniture,
            out ArchiveDocumentPageView pageView)
        {
            GameObject sheetObject = new GameObject("Sheet", typeof(RectTransform));
            RectTransform sheet = (RectTransform)sheetObject.transform;
            sheet.SetParent(parent, false);
            sheet.sizeDelta = new Vector2(ArchivePageLayout.k_Width, ArchivePageLayout.k_Height);
            sheet.localScale = Vector3.one * ArchivePageLayout.MetresPerUnit(k_PageWidthMeters);

            Canvas canvas = sheetObject.AddComponent<Canvas>();
            canvas.renderMode = RenderMode.WorldSpace;
            sheetObject.AddComponent<CanvasScaler>().dynamicPixelsPerUnit = 3f;

            // No GraphicRaycaster: the page is never clicked. It is picked up by the world ray and
            // driven by the keyboard and mouse from there.

            List<Graphic> inkGraphics = new List<Graphic>();
            List<TextMeshProUGUI> texts = new List<TextMeshProUGUI>();
            List<ArchivePageBlock> blocks = new List<ArchivePageBlock>();

            // Everything the composed page is baked from hangs off one group, so the page can put
            // it all down at once and show the flattened image instead.
            //
            // Stretched to the sheet, unlike the anchor groups inside it: the paper fills its
            // parent, and a zero-size parent stretches it to nothing. Blocks positioned by Place()
            // do not care either way — they anchor to this rect's top-left corner, which is the
            // sheet's top-left corner however the group is sized.
            RectTransform layers = CreateGroup(sheet, "Layers");
            Stretch(layers);

            // The paper goes down first, then the washes, then everything written on them: draw
            // order inside a canvas is hierarchy order.
            RawImage paper = CreateRaw(layers, "Paper", furniture.Paper, Color.white, furniture.Ink);
            Stretch(paper.rectTransform);

            RectTransform washLayer = CreateGroup(layers, "Washes");
            RectTransform inkLayer = CreateGroup(layers, "Ink");

            RectTransform diagramRect = AddDiagram(inkLayer, furniture, inkGraphics);
            RectTransform photoRect = AddPhoto(inkLayer, furniture, inkGraphics);
            RectTransform signatureRect = AddText(inkLayer, "Signature", furniture.HandFont, 24f,
                k_SignatureInk, TextAlignmentOptions.Midline, texts,
                out TextMeshProUGUI signature);
            RectTransform stampRect = AddImage(inkLayer, "RoundStamp", furniture.Stamp, Color.white,
                furniture.Ink, inkGraphics);
            RectTransform pinRect = AddImage(inkLayer, "Pin", furniture.Pin, Color.white,
                furniture.Ink, inkGraphics);
            RectTransform edgeStampRect = AddImage(inkLayer, "EdgeStamp", furniture.Stamp,
                k_EdgeStampInk, furniture.Ink, inkGraphics);
            RectTransform foldRect = AddImage(inkLayer, "CornerFold", furniture.Corner, Color.white,
                furniture.Ink, inkGraphics);

            RectTransform titleRect = AddText(inkLayer, "Title", furniture.HandFont, 72f,
                k_HeadingInk, TextAlignmentOptions.MidlineLeft, texts, out TextMeshProUGUI title);
            title.fontStyle = FontStyles.Bold;

            RectTransform subtitleRect = AddText(inkLayer, "Subtitle", furniture.HandFont, 36f,
                k_SubtitleInk, TextAlignmentOptions.MidlineLeft, texts, out TextMeshProUGUI subtitle);

            RectTransform bodyRect = AddText(inkLayer, "Body", furniture.HandFont, 38f, k_BodyInk,
                TextAlignmentOptions.TopLeft, texts, out TextMeshProUGUI body);
            body.lineSpacing = 30f;

            RectTransform transcriptionRect = AddText(inkLayer, "Transcription", furniture.HandFont,
                24f, k_ArchiveInk, TextAlignmentOptions.TopLeft, texts,
                out TextMeshProUGUI transcription);
            transcription.lineSpacing = 16f;

            RectTransform noteRect = AddTapedNote(inkLayer, furniture, texts, inkGraphics,
                out TextMeshProUGUI tapedNote);

            // The one thing on the sheet nobody wrote: a date banged on with a rubber stamp keeps
            // its mechanical face while everything else is in the researcher's hand.
            RectTransform dateRect = AddText(inkLayer, "DateStamp", furniture.ArchiveFont, 34f,
                k_StampInk, TextAlignmentOptions.Midline, texts, out TextMeshProUGUI dateStamp);
            dateStamp.characterSpacing = 16f;

            RectTransform codeRect = AddText(inkLayer, "ArchiveCode", furniture.HandFont, 46f,
                k_BrownInk, TextAlignmentOptions.MidlineLeft, texts,
                out TextMeshProUGUI archiveCode);

            // Only the writing gets a wash under it; the stamps and the pin were put straight on
            // the paper, which is what makes them read as having been added later.
            blocks.Add(ArchivePageBlock.Create(Block.Pin, pinRect, null));
            blocks.Add(ArchivePageBlock.Create(Block.Photo, photoRect, null));
            blocks.Add(ArchivePageBlock.Create(Block.Signature, signatureRect, null));
            blocks.Add(ArchivePageBlock.Create(Block.RoundStamp, stampRect, null));
            blocks.Add(ArchivePageBlock.Create(Block.Title, titleRect,
                AddWash(washLayer, "TitleWash", furniture, inkGraphics)));
            blocks.Add(ArchivePageBlock.Create(Block.Subtitle, subtitleRect,
                AddWash(washLayer, "SubtitleWash", furniture, inkGraphics)));
            blocks.Add(ArchivePageBlock.Create(Block.Diagram, diagramRect, null));
            blocks.Add(ArchivePageBlock.Create(Block.Body, bodyRect,
                AddWash(washLayer, "BodyWash", furniture, inkGraphics)));
            blocks.Add(ArchivePageBlock.Create(Block.Transcription, transcriptionRect,
                AddWash(washLayer, "TranscriptionWash", furniture, inkGraphics)));
            blocks.Add(ArchivePageBlock.Create(Block.TapedNote, noteRect, null));
            blocks.Add(ArchivePageBlock.Create(Block.DateStamp, dateRect, null));
            blocks.Add(ArchivePageBlock.Create(Block.ArchiveCode, codeRect, null));
            blocks.Add(ArchivePageBlock.Create(Block.EdgeStamp, edgeStampRect, null));
            blocks.Add(ArchivePageBlock.Create(Block.CornerFold, foldRect, null));

            // The composed page, and over it the dust. Both are drawn by the fold material, so the
            // crease deforms the writing and the grime along with the paper; the dust stays a live
            // layer because it is wiped away over several frames when the sheet is raised.
            RawImage composite = CreateRaw(sheet, "Composite", null, Color.white,
                furniture.PaperMaterial);
            Stretch(composite.rectTransform);

            RawImage dustLayer = CreateRaw(sheet, "Dust", furniture.Dust,
                new Color(1f, 1f, 1f, 0.75f), furniture.PaperMaterial);
            Stretch(dustLayer.rectTransform);

            // Only what is on screen at run time is lit; the layers underneath are baked flat.
            inkGraphics.Clear();
            inkGraphics.Add(composite);
            inkGraphics.Add(dustLayer);

            pageView = sheetObject.AddComponent<ArchiveDocumentPageView>();
            SerializedObject serialized = new SerializedObject(pageView);
            Bind(serialized, "m_page", sheet);
            Bind(serialized, "m_composite", composite);
            Bind(serialized, "m_layers", layers.gameObject);
            Bind(serialized, "m_title", title);
            Bind(serialized, "m_subtitle", subtitle);
            Bind(serialized, "m_body", body);
            Bind(serialized, "m_transcription", transcription);
            Bind(serialized, "m_tapedNote", tapedNote);
            Bind(serialized, "m_dateStamp", dateStamp);
            Bind(serialized, "m_signature", signature);
            Bind(serialized, "m_archiveCode", archiveCode);
            Bind(serialized, "m_diagram", diagramRect.GetComponent<RawImage>());
            Bind(serialized, "m_dustOverlay", dustLayer);
            BindBlocks(serialized, blocks);
            serialized.ApplyModifiedPropertiesWithoutUndo();

            ArchivePaperLighting lighting = sheetObject.AddComponent<ArchivePaperLighting>();
            SerializedObject lit = new SerializedObject(lighting);
            BindArray(lit, "m_inkGraphics", inkGraphics.ToArray());
            BindArray(lit, "m_texts", texts.ToArray());
            lit.ApplyModifiedPropertiesWithoutUndo();

            return sheet;
        }

        /// <summary>
        /// The paper material: the folded sheet, lit from the relief baked into its normal map.
        /// </summary>
        private static Material EnsurePaperMaterial()
        {
            Material material = EnsureMaterial(k_PaperShader, k_PaperMaterialPath);

            if (material == null)
            {
                return null;
            }

            material.SetTexture("_FoldTex", ArchivePaperTextureBaker.LoadFoldField());
            material.SetColor("_PaperLight", Color.white);
            material.SetVector("_LightDirection", new Vector4(-0.40f, 0.55f, 0.73f, 0f));

            // How far a fold drags the writing across the page, in UV. The slope it multiplies is
            // the bend's, so this displaces the whole band of the curve rather than a hairline.
            //
            // Small on purpose. Ink on a sheet that has been folded and flattened shifts by a few
            // tenths of a millimetre — about three pixels at this page size. Ten times that does
            // not read as a stronger fold, it reads as the text being torn in half: at 17 px the
            // displacement was wider than the strokes themselves and the writing came apart.
            material.SetFloat("_WarpStrength", 0.005f);
            material.SetFloat("_CreaseDarken", 0.7f);

            // This now shades the sheet's panels, not a band around a line. A panel leaning three
            // degrees should read as a clearly different tone across its whole width — that
            // panel-to-panel difference is the main thing the eye reads as a fold.
            material.SetFloat("_ReliefStrength", 1.6f);
            material.SetFloat("_AmbientWrap", 0.55f);
            material.SetFloat("_Sheen", 0.35f);
            material.SetFloat("_Gloss", 24f);
            EditorUtility.SetDirty(material);

            return material;
        }

        private static Material EnsureMaterial(string shaderName, string path)
        {
            Shader shader = Shader.Find(shaderName);

            if (shader == null)
            {
                Debug.LogError($"[{k_LogPrefix}] '{shaderName}' was not found; is the shader under "
                    + "Assets/RootsDance/Shaders/UI/ still there?");
                return null;
            }

            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material == null)
            {
                material = new Material(shader);
                AssetDatabase.CreateAsset(material, path);
            }

            material.shader = shader;

            return material;
        }

        /// <summary>The ink material every non-text graphic on the sheet is drawn with.</summary>
        private static Material EnsureInkMaterial()
        {
            Material material = EnsureMaterial(k_InkShader, k_InkMaterialPath);

            if (material == null)
            {
                return null;
            }

            material.SetTexture("_GrainTex", ArchivePaperTextureBaker.LoadPaperBase());
            material.SetFloat("_GrainScale", 0.006f);
            material.SetFloat("_GrainStrength", 0.4f);
            material.SetFloat("_Fade", 0.18f);
            material.SetFloat("_Bleed", 0.4f);
            material.SetColor("_PaperLight", Color.white);
            EditorUtility.SetDirty(material);

            return material;
        }

        private static RectTransform AddWash(RectTransform parent, string name, Furniture furniture,
            List<Graphic> inkGraphics)
        {
            RawImage wash = CreateRaw(parent, name, furniture.Wash, Color.white, furniture.Ink);
            inkGraphics.Add(wash);

            return wash.rectTransform;
        }

        private static RectTransform AddImage(RectTransform parent, string name, Texture2D texture,
            Color color, Material ink, List<Graphic> inkGraphics)
        {
            RawImage image = CreateRaw(parent, name, texture, color, ink);
            inkGraphics.Add(image);

            return image.rectTransform;
        }

        /// <summary>The researcher's drawing, when the sheet carries one.</summary>
        private static RectTransform AddDiagram(RectTransform parent, Furniture furniture,
            List<Graphic> inkGraphics)
        {
            RawImage diagram = CreateRaw(parent, "Diagram", null, Color.white, furniture.Ink);
            inkGraphics.Add(diagram);

            return diagram.rectTransform;
        }

        /// <summary>
        /// The photograph: a dark plate with a paperclip over its top-left corner, which is what is
        /// actually holding it to the sheet.
        /// </summary>
        private static RectTransform AddPhoto(RectTransform parent, Furniture furniture,
            List<Graphic> inkGraphics)
        {
            // A Polaroid: a cream card with the exposure sunk into it and a deep border along the
            // bottom, which is the only part of a photograph anyone ever writes on.
            RawImage card = CreateRaw(parent, "Photo", null, k_PhotoCard, furniture.Ink);
            inkGraphics.Add(card);

            RawImage exposure = CreateRaw(card.rectTransform, "Exposure", null, k_PhotoBlack,
                furniture.Ink);
            inkGraphics.Add(exposure);
            InsetSides(exposure.rectTransform, 14f, 14f, 14f, 62f);

            RawImage clip = CreateRaw(card.rectTransform, "Paperclip", furniture.Clip, Color.white,
                furniture.Ink);
            inkGraphics.Add(clip);

            RectTransform clipRect = clip.rectTransform;
            clipRect.anchorMin = new Vector2(0f, 1f);
            clipRect.anchorMax = new Vector2(0f, 1f);
            clipRect.pivot = new Vector2(0.5f, 0.5f);
            clipRect.anchoredPosition = new Vector2(40f, 2f);
            clipRect.sizeDelta = new Vector2(52f, 96f);
            clipRect.localRotation = Quaternion.Euler(0f, 0f, -7f);

            return card.rectTransform;
        }

        /// <summary>
        /// The note taped over the sheet: a strip of tape, a scrap of lighter paper under it, and
        /// the writing on the scrap.
        /// </summary>
        private static RectTransform AddTapedNote(RectTransform parent, Furniture furniture,
            List<TextMeshProUGUI> texts, List<Graphic> inkGraphics, out TextMeshProUGUI note)
        {
            RawImage paper = CreateRaw(parent, "TapedNote", furniture.Wash, k_NotePaper, furniture.Ink);
            inkGraphics.Add(paper);

            RawImage tape = CreateRaw(paper.rectTransform, "Tape", furniture.Tape, Color.white,
                furniture.Ink);
            inkGraphics.Add(tape);

            RectTransform tapeRect = tape.rectTransform;
            tapeRect.anchorMin = new Vector2(0.5f, 1f);
            tapeRect.anchorMax = new Vector2(0.5f, 1f);
            tapeRect.pivot = new Vector2(0.5f, 0.5f);
            tapeRect.anchoredPosition = new Vector2(-40f, 10f);
            tapeRect.sizeDelta = new Vector2(210f, 54f);
            tapeRect.localRotation = Quaternion.Euler(0f, 0f, 4f);

            GameObject label = new GameObject("TapedNoteText", typeof(RectTransform));
            label.transform.SetParent(paper.rectTransform, false);
            note = label.AddComponent<TextMeshProUGUI>();
            note.font = furniture.HandFont;
            note.fontSize = 30f;
            note.color = k_BodyInk;
            note.alignment = TextAlignmentOptions.Midline;
            note.textWrappingMode = TextWrappingModes.Normal;
            note.raycastTarget = false;
            note.text = string.Empty;
            Inset(note.rectTransform, 34f);
            texts.Add(note);

            return paper.rectTransform;
        }

        private static RectTransform AddText(RectTransform parent, string name, TMP_FontAsset font,
            float size, Color color, TextAlignmentOptions alignment, List<TextMeshProUGUI> texts,
            out TextMeshProUGUI text)
        {
            GameObject label = new GameObject(name, typeof(RectTransform));
            label.transform.SetParent(parent, false);

            text = label.AddComponent<TextMeshProUGUI>();
            text.font = font;
            text.fontSize = size;
            text.color = color;
            text.alignment = alignment;
            text.textWrappingMode = TextWrappingModes.Normal;
            text.raycastTarget = false;
            text.text = string.Empty;
            texts.Add(text);

            return text.rectTransform;
        }

        private static RawImage CreateRaw(RectTransform parent, string name, Texture2D texture,
            Color color, Material ink)
        {
            GameObject image = new GameObject(name, typeof(RectTransform));
            image.transform.SetParent(parent, false);

            RawImage raw = image.AddComponent<RawImage>();
            raw.texture = texture;
            raw.color = color;
            raw.raycastTarget = false;

            if (ink != null)
            {
                raw.material = ink;
            }

            return raw;
        }

        private static void BindBlocks(SerializedObject serialized, List<ArchivePageBlock> blocks)
        {
            SerializedProperty array = serialized.FindProperty("m_blocks");
            array.arraySize = blocks.Count;

            for (int i = 0; i < blocks.Count; i++)
            {
                SerializedProperty element = array.GetArrayElementAtIndex(i);
                element.FindPropertyRelative("m_block").enumValueIndex = (int)blocks[i].Block;
                element.FindPropertyRelative("m_target").objectReferenceValue = blocks[i].Target;
                element.FindPropertyRelative("m_wash").objectReferenceValue = blocks[i].Wash;
            }
        }

        private static void BindArray(SerializedObject serialized, string field, Object[] values)
        {
            SerializedProperty array = serialized.FindProperty(field);
            array.arraySize = values.Length;

            for (int i = 0; i < values.Length; i++)
            {
                array.GetArrayElementAtIndex(i).objectReferenceValue = values[i];
            }
        }

        private static void Bind(SerializedObject serialized, string field, Object value)
        {
            SerializedProperty property = serialized.FindProperty(field);

            if (property == null)
            {
                Debug.LogError($"[{k_LogPrefix}] '{field}' is not a serialized field any more.");
                return;
            }

            property.objectReferenceValue = value;
        }

        /// <summary>An empty rect at the sheet's top-left, so children keep the sheet's own units.</summary>
        private static RectTransform CreateGroup(RectTransform parent, string name)
        {
            GameObject group = new GameObject(name, typeof(RectTransform));
            RectTransform rect = (RectTransform)group.transform;
            rect.SetParent(parent, false);
            rect.anchorMin = new Vector2(0f, 1f);
            rect.anchorMax = new Vector2(0f, 1f);
            rect.pivot = new Vector2(0f, 1f);
            rect.anchoredPosition = Vector2.zero;
            rect.sizeDelta = Vector2.zero;

            return rect;
        }

        private static void Stretch(RectTransform rect)
        {
            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.pivot = new Vector2(0.5f, 0.5f);
            rect.offsetMin = Vector2.zero;
            rect.offsetMax = Vector2.zero;
        }

        /// <summary>Stretches a rect over its parent with a uniform margin.</summary>
        private static void Inset(RectTransform rect, float margin)
        {
            InsetSides(rect, margin, margin, margin, margin);
        }

        /// <summary>Stretches a rect over its parent with a margin per side.</summary>
        private static void InsetSides(RectTransform rect, float left, float right, float top,
            float bottom)
        {
            Stretch(rect);
            rect.offsetMin = new Vector2(left, bottom);
            rect.offsetMax = new Vector2(-right, -top);
        }

        private static TMP_FontAsset FindFont(string nameFragment)
        {
            // Searched rather than loaded by path: the font assets are due to move into UI/Fonts/,
            // and a path constant here would break silently on the day they do.
            string[] guids = AssetDatabase.FindAssets($"t:TMP_FontAsset {nameFragment}");

            for (int i = 0; i < guids.Length; i++)
            {
                TMP_FontAsset font = AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(
                    AssetDatabase.GUIDToAssetPath(guids[i]));

                if (font != null)
                {
                    return font;
                }
            }

            return null;
        }

        private static void EnsureFolder(string folder)
        {
            if (!AssetDatabase.IsValidFolder(folder))
            {
                Directory.CreateDirectory(folder);
                AssetDatabase.Refresh();
            }
        }
    }
}

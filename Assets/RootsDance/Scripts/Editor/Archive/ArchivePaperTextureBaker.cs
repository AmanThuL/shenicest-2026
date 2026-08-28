using System.IO;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Archive
{
    /// <summary>
    /// Bakes every placeholder texture an archive sheet is made of: the aged paper as a full lit
    /// material set, the dust lying on it, and the things laid on top of it — the pale washes the
    /// writing sits on, the pin, the tape, the round ink stamp and the paperclip.
    /// <para>
    /// The paper gets base, normal and mask maps rather than one flat colour map because the paper
    /// is a **lit** surface: it is the object's face, so it has to take the flashlight, show its
    /// fibre and its fold, and be rough rather than glossy. Only the ink on top of it is drawn by
    /// the canvas, which HDRP can shade Unlit and nothing else.
    /// </para>
    /// <para>
    /// Generated assets: every bake re-applies the recipe below to the same paths, so the GUIDs
    /// survive and every sheet in every scene picks the new look up. Tune the recipe, not the PNG.
    /// They are placeholders — the art side replaces them with scanned paper, and nothing else has
    /// to change because the material reads them by path.
    /// </para>
    /// </summary>
    public static class ArchivePaperTextureBaker
    {
        private const string k_LogPrefix = "ArchivePaperTextureBaker";
        private const string k_Folder = "Assets/RootsDance/Textures/Props";

        /// <summary>
        /// The scanned sheet the paper is built on. CC0 from ambientCG — see the LICENSE beside it.
        /// <para>
        /// Everything here used to be Perlin noise, and it read as brown fog no matter how the
        /// frequencies were tuned: real paper fibre is a photographic texture with structure at
        /// every scale, and band-limited noise has none. The ageing below — the staining, the
        /// foxing, the torn edge — is still generated, but it is now laid over a real scan instead
        /// of standing in for one.
        /// </para>
        /// </summary>
        private const string k_ScanPath = "Assets/ThirdParty/Textures/AmbientCG/Paper001_Color.jpg";

        public const string k_PaperBasePath = k_Folder + "/ArchivePaper_BaseMap.png";
        public const string k_FoldPath = k_Folder + "/ArchiveFold_Mask.png";
        public const string k_WarpPath = k_Folder + "/ArchiveWarp_Mask.png";
        public const string k_DustPath = k_Folder + "/ArchiveDust_BaseMap.png";
        public const string k_WashPath = k_Folder + "/ArchiveWash_BaseMap.png";
        public const string k_PinPath = k_Folder + "/ArchivePin_BaseMap.png";
        public const string k_TapePath = k_Folder + "/ArchiveTape_BaseMap.png";
        public const string k_StampPath = k_Folder + "/ArchiveStamp_BaseMap.png";
        public const string k_ClipPath = k_Folder + "/ArchiveClip_BaseMap.png";
        public const string k_CornerPath = k_Folder + "/ArchiveCorner_BaseMap.png";

        // Large enough that the composed page (1707 x 2048) samples this down rather than up.
        // Upscaling was half of why the sheet looked mushy; the other half was the fibre being
        // painted with noise an order of magnitude too low in frequency.
        private const int k_PaperWidth = 2048;
        private const int k_PaperHeight = 2458;
        private const int k_DustSize = 512;
        private const int k_WashWidth = 512;
        private const int k_WashHeight = 256;
        private const int k_PinSize = 128;
        private const int k_TapeWidth = 256;
        private const int k_TapeHeight = 64;
        private const int k_StampSize = 256;
        private const int k_ClipWidth = 128;
        private const int k_ClipHeight = 200;
        private const int k_FoldSize = 192;

        /// <summary>Fixed so a re-bake produces the same sheet; the ageing is art, not variety.</summary>
        private const int k_Seed = 90136;

        [MenuItem("RootsDance/Archive/Bake Paper Textures")]
        public static void BakeMenu()
        {
            BakeAll();
            Debug.Log($"[{k_LogPrefix}] Baked the archive paper set into {k_Folder}.");
        }

        /// <summary>Writes every texture and re-imports, so callers can load the assets straight after.</summary>
        public static void BakeAll()
        {
            EnsureFolder();
            BakePaperSet();
            Write(k_DustPath, BakeDust());
            Write(k_WashPath, BakeWash());
            Write(k_PinPath, BakePin());
            Write(k_TapePath, BakeTape());
            Write(k_StampPath, BakeStamp());
            Write(k_ClipPath, BakeClip());
            Write(k_CornerPath, BakeCorner());
            Write(k_FoldPath, BakeFoldField());
            Write(k_WarpPath, BakeWarpField());
            AssetDatabase.Refresh();
        }

        public static Texture2D LoadPaperBase() => LoadOrBake(k_PaperBasePath);

        /// <summary>
        /// The crease field: R the fold height, GB its gradient, A the burnished shoulder. The
        /// paper shader both warps the page by the gradient and shades it by the height, so a fold
        /// moves the writing as well as darkening the sheet.
        /// </summary>
        public static Texture2D LoadFoldField() => LoadOrBake(k_FoldPath);

        /// <summary>
        /// How far the page's content is dragged sideways at each point, in RG. See
        /// <see cref="BakeWarpField"/> — this is the field that actually bends the writing.
        /// </summary>
        public static Texture2D LoadWarpField() => LoadOrBake(k_WarpPath);

        public static Texture2D LoadDust() => LoadOrBake(k_DustPath);

        /// <summary>The pale patch the writing sits on, so ink never lands straight on the grime.</summary>
        public static Texture2D LoadWash() => LoadOrBake(k_WashPath);

        public static Texture2D LoadPin() => LoadOrBake(k_PinPath);

        public static Texture2D LoadTape() => LoadOrBake(k_TapePath);

        public static Texture2D LoadStamp() => LoadOrBake(k_StampPath);

        public static Texture2D LoadClip() => LoadOrBake(k_ClipPath);

        /// <summary>The turned-up bottom corner of the sheet.</summary>
        public static Texture2D LoadCorner() => LoadOrBake(k_CornerPath);

        private static Texture2D LoadOrBake(string path)
        {
            Texture2D texture = AssetDatabase.LoadAssetAtPath<Texture2D>(path);

            if (texture == null)
            {
                BakeAll();
                texture = AssetDatabase.LoadAssetAtPath<Texture2D>(path);
            }

            return texture;
        }

        /// <summary>
        /// Cream stock, uneven fibre, damp blotches soaked in from the edges, rust-brown foxing, one
        /// carried fold, and a torn ragged silhouette — the reference sheets are not rectangles.
        /// Base, normal and mask come out of one pass so they agree with each other.
        /// </summary>
        private static void BakePaperSet()
        {
            Texture2D scan = LoadSource(k_ScanPath);

            if (scan == null)
            {
                return;
            }

            int count = k_PaperWidth * k_PaperHeight;
            Color32[] basePixels = new Color32[count];
            float[] alpha = new float[count];

            Vector2 fibreOffset = Offset(k_Seed);
            Vector2 blotchOffset = Offset(k_Seed + 17);
            Vector2 tearOffset = Offset(k_Seed + 41);

            Color stock = new Color(0.898f, 0.855f, 0.745f);
            Color stain = new Color(0.588f, 0.494f, 0.353f);
            Color foxColor = new Color(0.478f, 0.310f, 0.184f);

            for (int y = 0; y < k_PaperHeight; y++)
            {
                float v = (float)y / (k_PaperHeight - 1);

                for (int x = 0; x < k_PaperWidth; x++)
                {
                    int index = y * k_PaperWidth + x;
                    float u = (float)x / (k_PaperWidth - 1);

                    // The real sheet's fibre, tiled twice so the weave is not obviously repeated
                    // at this size. This is the texture; everything else here is ageing laid over
                    // it. Sampled point-wise rather than filtered — it is already at 2K and the
                    // page is baked at 2048, so there is nothing to filter away.
                    float fibre = scan.GetPixelBilinear(u * 2f, v * 2.4f).g;
                    float blotch = Fbm(u * 3.2f + blotchOffset.x, v * 3.2f + blotchOffset.y, 4);
                    float edge = EdgeFalloff(u, v, 0.26f);

                    // The staining is the blotch's; the border only nudges it. Letting the border
                    // term dominate turns the sheet into a picture frame with a bright middle,
                    // which is not what an old sheet looks like.
                    float soak = Mathf.Clamp01(blotch * 1.25f - 0.42f + (1f - edge) * 0.22f);

                    // The scan is near-white newsprint; the stock colour tints it to aged cream and
                    // the fibre carries the detail.
                    Color color = Color.Lerp(stock, stain, soak * 0.62f);
                    color *= 0.55f + fibre * 0.62f;

                    // Foxing: the rust-brown specks an old sheet grows where it was damp.
                    // Foxing spots have edges. Threshold them tightly or they smear into the
                    // staining and the whole sheet turns a uniform brown.
                    float specks = Fbm(u * 120f + blotchOffset.y, v * 120f + blotchOffset.x, 2);
                    float foxing = Threshold(0.80f, 0.86f, specks) * Mathf.Clamp01(soak * 1.6f);
                    color = Color.Lerp(color, foxColor, foxing * 0.62f);

                    // No creases here. They live in the fold field, because a fold has to move the
                    // writing as well as shade the paper, and only a layer applied over the whole
                    // composed page can do that (see docs/.../纸张折痕研究.md §5).

                    // Only a light handling-dirt gradient right at the border, not a vignette.
                    color *= 0.86f + 0.14f * EdgeFalloff(u, v, 0.10f);

                    // A torn edge is a hard threshold against low-frequency noise — big irregular
                    // bites with fibre standing out of them, not a soft fade to nothing.
                    float tear = Fbm(u * 4f + tearOffset.x, v * 4f + tearOffset.y, 3);
                    float bite = EdgeFalloff(u, v, 0.085f);
                    float cut = bite > tear * 0.80f ? 1f : 0f;

                    basePixels[index] = color;
                    alpha[index] = cut;
                }
            }

            for (int i = 0; i < count; i++)
            {
                Color32 pixel = basePixels[i];
                pixel.a = (byte)Mathf.RoundToInt(Mathf.Clamp01(alpha[i]) * 255f);
                basePixels[i] = pixel;
            }

            Write(k_PaperBasePath, ToTexture(basePixels, k_PaperWidth, k_PaperHeight));
            Object.DestroyImmediate(scan);
        }

        // ---- Fold geometry, derived in docs/architecture/systems/纸张折痕研究.md -------------
        //
        // A crease is three zones, not a line: a narrow crushed valley, a wide burnished shoulder
        // either side of it, and then flat paper. The two zones differ in width by about five
        // times, which is why a single Mexican-hat profile cannot describe both — it ties them to
        // one sigma, and the first version of this came out a finger wide.
        //
        // 80 g/m² paper is ~0.10 mm thick; industrial creasing data puts a crease at roughly three
        // times the material thickness, and the elastic shoulder of a hand fold at ~1.5 mm.
        // The sheet is 0.16 m across, so one millimetre is 1/160 of the width.

        /// <summary>Millimetres across the sheet, as a fraction of its width.</summary>
        private const float k_MillimetreU = 1f / 160f;

        /// <summary>Millimetres down the sheet, as a fraction of its height.</summary>
        private const float k_MillimetreV = 1f / 192f;

        /// <summary>Half-width of the crushed valley: ~0.15 mm, three times the paper's thickness.</summary>
        private const float k_ValleyMillimetres = 0.15f;

        /// <summary>Half-width of the elastic shoulder either side: ~0.75 mm.</summary>
        private const float k_ShoulderMillimetres = 0.75f;

        /// <summary>How high the shoulder rises against how deep the valley sinks.</summary>
        private const float k_ShoulderRatio = 0.35f;

        /// <summary>Furthest the crease wanders off its nominal line, in millimetres.</summary>
        private const float k_WanderMillimetres = 1.6f;

        /// <summary>How far out of square the fold ends up, end to end, in millimetres.</summary>
        private const float k_SkewMillimetres = 1.1f;

        /// <summary>
        /// How far along a fold the crease deviates from its nominal line, in millimetres.
        /// <para>
        /// A machine crease is straight because a steel rule pressed it. This sheet was folded by
        /// somebody in the field: the two edges were lined up by eye and a thumbnail was run along
        /// from wherever it started. It wanders, and it is not square with the edge of the paper.
        /// </para>
        /// </summary>
        private static float CreaseOffset(float along, int seed)
        {
            Vector2 offset = Offset(seed);
            float wander = (Fbm(along * 3.4f + offset.x, offset.y, 3) - 0.5f) * 2f;
            float skew = along - 0.5f;

            return wander * k_WanderMillimetres + skew * k_SkewMillimetres;
        }

        /// <summary>
        /// How hard the fold was pressed at this point along it, 0 to 1.
        /// <para>
        /// Two things vary along a crease. A thumb does not press evenly, so the fold is deepest
        /// where it was started and fades towards the ends; and folding across the paper's grain
        /// fractures the fibres in discrete places rather than crushing them evenly, so the crease
        /// breaks into segments with pale gaps between them. A fold of constant depth reads as a
        /// printed line however exact its cross-section is.
        /// </para>
        /// </summary>
        private static float CreasePressure(float along, int seed)
        {
            Vector2 offset = Offset(seed + 7);

            // The uneven press of a thumb run along the fold.
            float press = 0.55f + 0.45f * Fbm(along * 4.6f + offset.x, offset.y, 3);

            // Fibres tearing in patches: where this dips, the crease all but disappears.
            float tearing = Fbm(along * 13f + offset.y, offset.x, 2);
            float breaks = Mathf.Lerp(0.25f, 1f, Threshold(0.34f, 0.52f, tearing));

            // Both ends of a fold are shallower: the pressure runs out before the paper does.
            float ends = Threshold(0f, 0.06f, Mathf.Min(along, 1f - along));

            return press * breaks * Mathf.Lerp(0.35f, 1f, ends);
        }

        /// <summary>
        /// The relief of a sheet folded in three and then across: two folds down it, one across,
        /// plus the shallow crumple paper keeps once it has been carried in a pocket. None of the
        /// three is straight; see <see cref="CreaseOffset"/>.
        /// </summary>
        private static float FoldRelief(float u, float v, Vector2 crumpleOffset)
        {
            float relief =
                Crease((v - 0.415f) / k_MillimetreV - CreaseOffset(u, 311), CreasePressure(u, 311))
                + Crease((v - 0.735f) / k_MillimetreV - CreaseOffset(u, 733),
                    0.55f * CreasePressure(u, 733))
                + Crease((u - 0.520f) / k_MillimetreU - CreaseOffset(v, 521),
                    0.75f * CreasePressure(v, 521));

            // The sheet does not lie flat between its folds, but this is a long, shallow undulation
            // — not another crease. Kept low frequency so warping the page by it does not shimmer.
            float crumple = Fbm(u * 3.2f + crumpleOffset.x, v * 3.2f + crumpleOffset.y, 2);

            return relief + (crumple - 0.5f) * 0.10f;
        }

        /// <summary>
        /// One fold, as two independent Gaussians: a narrow deep valley and a wide shallow shoulder.
        /// </summary>
        /// <param name="millimetres">Distance from the fold line, in millimetres.</param>
        /// <param name="depth">Relative depth; 1 is a well-worn fold.</param>
        private static float Crease(float millimetres, float depth)
        {
            float valley = millimetres / k_ValleyMillimetres;
            float shoulder = millimetres / k_ShoulderMillimetres;

            return depth * (k_ShoulderRatio * Mathf.Exp(-shoulder * shoulder)
                - Mathf.Exp(-valley * valley));
        }

        /// <summary>
        /// The crease field the paper shader reads: R the fold height, GB the slope of the
        /// <em>bend</em>, A the burnished shoulder that catches the light.
        /// <para>
        /// GB is the gradient of a <b>blurred</b> copy of the height, and that is the whole trick.
        /// The raw gradient is useless for this: a crease's valley is a fifth of a millimetre wide
        /// and its shoulder is five times that, so the valley's slope is about twenty times the
        /// shoulder's. Any single scale either clips the valley or loses the shoulder — and the
        /// first version clipped, saturating GB to ±1 across a 2 mm plateau and zero everywhere
        /// else. That produced exactly the two things wrong with it: a hard-edged band 2 mm wide
        /// instead of a crease, and a warp that shifted a 2 mm strip bodily by seven pixels, which
        /// is a smear rather than a fold and reads as the writing not moving at all.
        /// </para>
        /// <para>
        /// Blurring first at the shoulder's own width gives a slope that varies smoothly over the
        /// whole bend, which is what actually displaces ink on folded paper — the sheet was curved
        /// over those two millimetres, not sheared along one line. The sharp dark line of the
        /// crease itself comes from R instead, where it belongs.
        /// </para>
        /// </summary>
        private static Texture2D BakeFoldField()
        {
            int width = k_PaperWidth;
            int height = k_PaperHeight;
            float[] field = new float[width * height];
            Vector2 crumpleOffset = Offset(k_Seed + 67);

            for (int y = 0; y < height; y++)
            {
                float v = (float)y / (height - 1);

                for (int x = 0; x < width; x++)
                {
                    field[y * width + x] = FoldRelief((float)x / (width - 1), v, crumpleOffset);
                }
            }

            // The shape of the sheet itself: a few panels leaning out of plane, meeting at the
            // folds. Its gradient is the panel tilts, and that is what both shades the panels and
            // shifts the writing across a fold. Kept separate from the crease bead in R, whose
            // slope is a hundred times steeper and would drown it.
            float[] bend = new float[width * height];

            for (int y = 0; y < height; y++)
            {
                float v = (float)y / (height - 1);

                for (int x = 0; x < width; x++)
                {
                    bend[y * width + x] = PanelHeight((float)x / (width - 1), v);
                }
            }

            Color32[] pixels = new Color32[field.Length];

            for (int y = 0; y < height; y++)
            {
                for (int x = 0; x < width; x++)
                {
                    int index = y * width + x;

                    float dx = (SampleField(bend, x + 1, y, width, height)
                        - SampleField(bend, x - 1, y, width, height)) * 0.5f;
                    float dy = (SampleField(bend, x, y + 1, width, height)
                        - SampleField(bend, x, y - 1, width, height)) * 0.5f;

                    // Per texel, scaled to the sheet: the shader works in UV.
                    float slopeU = dx * width * k_SlopeScale;
                    float slopeV = dy * height * k_SlopeScale;

                    pixels[index] = new Color(
                        Mathf.Clamp01(field[index] * 0.5f + 0.5f),
                        Mathf.Clamp01(slopeU * 0.5f + 0.5f),
                        Mathf.Clamp01(slopeV * 0.5f + 0.5f),
                        Mathf.Clamp01(field[index] * 2.5f));
                }
            }

            return ToTexture(pixels, width, height);
        }

        /// <summary>
        /// How the panel tilt is scaled into the texture. A panel leans by about 0.05 (three
        /// degrees), and this puts that near 0.4 — well clear of clipping, with room for the
        /// steeper roll right at a fold.
        /// </summary>
        private const float k_SlopeScale = 1f / 20f;

        /// <summary>
        /// Half-width of the curve the sheet was bent through at a fold, in millimetres. Wider than
        /// the crushed valley by design: this is the elastic region either side of it.
        /// </summary>
        private const float k_BendMillimetres = 0.9f;

        /// <summary>
        /// How far each panel of the sheet leans out of plane, as a slope (rise over run). Three
        /// or four degrees — a sheet that has been folded does not spring back flat, and the
        /// dihedral between its panels never returns to a straight angle.
        /// </summary>
        private static readonly float[] k_PanelTiltsDown = { 0.052f, -0.041f, 0.046f };
        private static readonly float[] k_PanelTiltsAcross = { -0.038f, 0.044f };

        /// <summary>
        /// How far the sheet stands out of plane here, in millimetres.
        /// <para>
        /// This is the part every earlier version of this file was missing, and the reason the fold
        /// kept reading as a line drawn on flat paper however carefully its cross-section was
        /// measured. <b>A folded sheet is not flat.</b> Opening it does not return the dihedral
        /// between its panels to a straight angle; each panel ends up leaning a few degrees out of
        /// plane, so each one catches the light differently. That panel-to-panel difference in
        /// shading — a gentle gradient over fifty millimetres, and a step where two panels meet —
        /// is the main thing the eye reads as a fold. The crease line itself is a fine detail
        /// sitting on the join.
        /// </para>
        /// <para>
        /// So the height is piecewise linear: each fold changes the slope once, and the corner is
        /// rounded over the width of the bend. Its gradient is therefore the panel tilts, which is
        /// what shades the panels and what shifts the writing across each fold.
        /// </para>
        /// </summary>
        private static float PanelHeight(float u, float v)
        {
            float acrossMillimetres = u * 160f;
            float downMillimetres = v * 192f;

            float height = k_PanelTiltsDown[0] * downMillimetres
                + (k_PanelTiltsDown[1] - k_PanelTiltsDown[0])
                    * Ramp(downMillimetres - (0.415f * 192f + CreaseOffset(u, 311)))
                + (k_PanelTiltsDown[2] - k_PanelTiltsDown[1])
                    * Ramp(downMillimetres - (0.735f * 192f + CreaseOffset(u, 733)));

            height += k_PanelTiltsAcross[0] * acrossMillimetres
                + (k_PanelTiltsAcross[1] - k_PanelTiltsAcross[0])
                    * Ramp(acrossMillimetres - (0.520f * 160f + CreaseOffset(v, 521)));

            return height;
        }

        /// <summary>
        /// How far the writing is dragged across the page here, in RG, as a fraction of the
        /// largest such drag.
        /// <para>
        /// This is a <b>third</b> field, and it has to be, because neither of the other two can
        /// bend a letter. The panel tilt is constant across a whole panel, so warping by it slides
        /// every glyph on that panel by the same amount and not one of them changes shape — which
        /// is exactly the complaint. Only a <em>gradient</em> of displacement deforms a letterform,
        /// and a flat panel has none.
        /// </para>
        /// <para>
        /// What does have one is the crease itself. There the sheet rolls through its whole
        /// dihedral within about a millimetre, so seen flat-on the paper is sharply foreshortened
        /// across that millimetre and everything printed there is squeezed. Integrated across the
        /// fold that is a smooth <b>step</b> in displacement — content on one side offset against
        /// the other, with the transition over the width of the roll. A glyph lying across it is
        /// sheared, and a line of text breaks and steps, which is what folded documents do.
        /// </para>
        /// </summary>
        private static Texture2D BakeWarpField()
        {
            int width = k_PaperWidth;
            int height = k_PaperHeight;
            Color32[] pixels = new Color32[width * height];

            for (int y = 0; y < height; y++)
            {
                float v = (float)y / (height - 1);

                for (int x = 0; x < width; x++)
                {
                    float u = (float)x / (width - 1);
                    float acrossMillimetres = u * 160f;
                    float downMillimetres = v * 192f;

                    // The two folds that run across the sheet shear it up and down.
                    float shiftV = Step(
                            downMillimetres - (0.415f * 192f + CreaseOffset(u, 311)),
                            CreasePressure(u, 311))
                        + Step(downMillimetres - (0.735f * 192f + CreaseOffset(u, 733)),
                            0.75f * CreasePressure(u, 733));

                    // The one that runs down it shears the writing left and right.
                    float shiftU = Step(
                        acrossMillimetres - (0.520f * 160f + CreaseOffset(v, 521)),
                        CreasePressure(v, 521));

                    pixels[y * width + x] = new Color(
                        Mathf.Clamp01(shiftU / k_WarpNormalise * 0.5f + 0.5f),
                        Mathf.Clamp01(shiftV / k_WarpNormalise * 0.5f + 0.5f),
                        0f,
                        1f);
                }
            }

            return ToTexture(pixels, width, height);
        }

        /// <summary>Largest total shift any point sees, so the field fits in 0..1 without clipping.</summary>
        private const float k_WarpNormalise = 1.9f;

        /// <summary>
        /// How wide the roll at a crease is, in millimetres — the distance over which the sheet
        /// turns through its dihedral, and therefore over which the writing is sheared.
        /// </summary>
        private const float k_RollMillimetres = 0.55f;

        /// <summary>
        /// A smooth step across a fold: content one side of it is offset against the other, and the
        /// change happens over the width of the roll.
        /// </summary>
        private static float Step(float millimetres, float amount)
        {
            return amount * (float)System.Math.Tanh(millimetres / k_RollMillimetres);
        }

        /// <summary>
        /// A ramp rounded over the width of a fold's bend: flat below, linear above, curved across.
        /// Integrating a step would give a hard corner; paper bends through a radius.
        /// </summary>
        private static float Ramp(float millimetres)
        {
            return 0.5f * (millimetres
                + Mathf.Sqrt(millimetres * millimetres + k_BendMillimetres * k_BendMillimetres));
        }

        private static float SampleField(float[] field, int x, int y, int width, int height)
        {
            return field[Mathf.Clamp(y, 0, height - 1) * width + Mathf.Clamp(x, 0, width - 1)];
        }

        /// <summary>
        /// The dust: a pale grey veil whose alpha is thickest in the corners and along the top edge,
        /// where a sheet lying face-up on a desk actually collects it.
        /// </summary>
        private static Texture2D BakeDust()
        {
            Color32[] pixels = new Color32[k_DustSize * k_DustSize];
            Vector2 grainOffset = Offset(k_Seed + 73);
            Vector2 driftOffset = Offset(k_Seed + 109);
            Color grime = new Color(0.706f, 0.686f, 0.639f);

            for (int y = 0; y < k_DustSize; y++)
            {
                float v = (float)y / (k_DustSize - 1);

                for (int x = 0; x < k_DustSize; x++)
                {
                    float u = (float)x / (k_DustSize - 1);

                    float grain = Fbm(u * 96f + grainOffset.x, v * 96f + grainOffset.y, 3);
                    float drift = Fbm(u * 4.5f + driftOffset.x, v * 4.5f + driftOffset.y, 4);
                    float edge = EdgeFalloff(u, v, 0.34f);

                    // v is 0 at the bottom of the texture, so the settled band is at high v.
                    float settled = Threshold(0f, 1f, v) * 0.30f;
                    float alpha = Mathf.Clamp01(
                        (drift * 0.62f + grain * 0.24f + settled) * Mathf.Lerp(1.35f, 0.72f, edge));

                    Color color = grime;
                    color.a = alpha;
                    pixels[y * k_DustSize + x] = color;
                }
            }

            return ToTexture(pixels, k_DustSize, k_DustSize);
        }

        /// <summary>
        /// The pale wash the writing sits on: an irregular soft-edged patch, lighter than the paper,
        /// with a hand-torn outline rather than a rectangle. This is the single most characteristic
        /// thing about the reference sheets — none of the writing sits straight on the dirty paper.
        /// </summary>
        private static Texture2D BakeWash()
        {
            Color32[] pixels = new Color32[k_WashWidth * k_WashHeight];
            Vector2 shapeOffset = Offset(k_Seed + 149);
            Color wash = new Color(0.945f, 0.918f, 0.831f);

            for (int y = 0; y < k_WashHeight; y++)
            {
                float v = (float)y / (k_WashHeight - 1);

                for (int x = 0; x < k_WashWidth; x++)
                {
                    float u = (float)x / (k_WashWidth - 1);

                    // A wobbly rounded blob: the distance to the edge, pushed about by noise.
                    float shape = Fbm(u * 3.2f + shapeOffset.x, v * 3.2f + shapeOffset.y, 3);
                    float edge = Mathf.Min(
                        Threshold(0f, 0.14f, Mathf.Min(u, 1f - u)),
                        Threshold(0f, 0.30f, Mathf.Min(v, 1f - v)));

                    float alpha = Mathf.Clamp01((edge - shape * 0.55f) * 2.2f) * 0.80f;

                    Color color = wash * (0.97f + shape * 0.05f);
                    color.a = alpha;
                    pixels[y * k_WashWidth + x] = color;
                }
            }

            return ToTexture(pixels, k_WashWidth, k_WashHeight);
        }

        /// <summary>
        /// The pin head: a domed red disc with a highlight up and to the left, and nothing at all
        /// outside its radius. Round, because a square pin reads as a missing texture.
        /// </summary>
        private static Texture2D BakePin()
        {
            Color32[] pixels = new Color32[k_PinSize * k_PinSize];
            Color head = new Color(0.612f, 0.212f, 0.161f);

            for (int y = 0; y < k_PinSize; y++)
            {
                for (int x = 0; x < k_PinSize; x++)
                {
                    Vector2 fromCentre = new Vector2(
                        (float)x / (k_PinSize - 1) - 0.5f, (float)y / (k_PinSize - 1) - 0.5f) * 2f;
                    float radius = fromCentre.magnitude;

                    float lit = Mathf.Clamp01(0.5f - (fromCentre.x - fromCentre.y) * 0.6f);
                    Color color = head * (0.5f + 0.9f * lit);
                    color.a = 1f - Threshold(0.80f, 0.96f, radius);

                    pixels[y * k_PinSize + x] = color;
                }
            }

            return ToTexture(pixels, k_PinSize, k_PinSize);
        }

        /// <summary>
        /// A strip of yellowed tape: translucent, torn along both short ends, with the dull sheen of
        /// something that has been on the paper for thirty years.
        /// </summary>
        private static Texture2D BakeTape()
        {
            Color32[] pixels = new Color32[k_TapeWidth * k_TapeHeight];
            Vector2 tornOffset = Offset(k_Seed + 211);
            Color tape = new Color(0.784f, 0.749f, 0.639f);

            for (int y = 0; y < k_TapeHeight; y++)
            {
                float v = (float)y / (k_TapeHeight - 1);

                for (int x = 0; x < k_TapeWidth; x++)
                {
                    float u = (float)x / (k_TapeWidth - 1);

                    float sheen = Fbm(u * 8f + tornOffset.x, v * 24f + tornOffset.y, 2);
                    Color color = tape * Mathf.Lerp(0.88f, 1.1f, sheen);

                    float torn = Fbm(v * 9f + tornOffset.y, 3.5f, 2);
                    float endDistance = Mathf.Min(u, 1f - u) / 0.09f;
                    color.a = endDistance > torn * 0.9f ? 0.7f : 0f;

                    pixels[y * k_TapeWidth + x] = color;
                }
            }

            return ToTexture(pixels, k_TapeWidth, k_TapeHeight);
        }

        /// <summary>
        /// The round ink stamp: two concentric rings round a spiral mark, printed unevenly the way a
        /// rubber stamp does — heavy on one side, missing altogether on the other.
        /// </summary>
        private static Texture2D BakeStamp()
        {
            Color32[] pixels = new Color32[k_StampSize * k_StampSize];
            Vector2 inkOffset = Offset(k_Seed + 251);
            Color ink = new Color(0.545f, 0.204f, 0.145f);

            for (int y = 0; y < k_StampSize; y++)
            {
                for (int x = 0; x < k_StampSize; x++)
                {
                    Vector2 fromCentre = new Vector2(
                        (float)x / (k_StampSize - 1) - 0.5f, (float)y / (k_StampSize - 1) - 0.5f) * 2f;
                    float radius = fromCentre.magnitude;
                    float angle = Mathf.Atan2(fromCentre.y, fromCentre.x);

                    // Two rings, and a spiral wound between them.
                    float outer = Ring(radius, 0.90f, 0.05f);
                    float inner = Ring(radius, 0.70f, 0.032f);
                    float spiral = Ring(radius - angle * 0.055f, 0.34f, 0.05f);
                    float mark = Mathf.Max(outer, Mathf.Max(inner, spiral));

                    // Uneven inking: a rubber stamp never prints evenly all the way round.
                    float patchy = Fbm(fromCentre.x * 5f + inkOffset.x, fromCentre.y * 5f + inkOffset.y, 3);
                    float alpha = Mathf.Clamp01(mark * Mathf.Clamp01((patchy - 0.18f) * 2.6f) * 1.9f);

                    Color color = ink;
                    color.a = radius > 1f ? 0f : alpha * 0.92f;
                    pixels[y * k_StampSize + x] = color;
                }
            }

            return ToTexture(pixels, k_StampSize, k_StampSize);
        }

        /// <summary>1 on the ring of the given radius, falling off over its width.</summary>
        private static float Ring(float radius, float at, float width)
        {
            return 1f - Threshold(0f, width, Mathf.Abs(radius - at));
        }

        /// <summary>
        /// The paperclip: two nested rounded loops of dull wire, seen flat from the front, with the
        /// upper bend catching a little light.
        /// </summary>
        private static Texture2D BakeClip()
        {
            Color32[] pixels = new Color32[k_ClipWidth * k_ClipHeight];
            Color wire = new Color(0.596f, 0.608f, 0.616f);

            for (int y = 0; y < k_ClipHeight; y++)
            {
                float v = (float)y / (k_ClipHeight - 1);

                for (int x = 0; x < k_ClipWidth; x++)
                {
                    float u = (float)x / (k_ClipWidth - 1);

                    // Two stadium outlines, one inside the other and shorter at the bottom.
                    float outer = Stadium(u, v, 0.5f, 0.12f, 0.86f, 0.30f, 0.045f);
                    float inner = Stadium(u, v, 0.5f, 0.24f, 0.70f, 0.16f, 0.040f);
                    float mark = Mathf.Max(outer, inner);

                    // The top bend faces up, so it is the part that catches the light.
                    Color color = wire * Mathf.Lerp(0.72f, 1.25f, Mathf.Clamp01(1f - v * 1.2f));
                    color.a = mark;
                    pixels[y * k_ClipWidth + x] = color;
                }
            }

            return ToTexture(pixels, k_ClipWidth, k_ClipHeight);
        }

        /// <summary>
        /// The outline of a stadium (a rectangle with semicircular ends), 1 on the line itself.
        /// </summary>
        private static float Stadium(float u, float v, float centreX, float top, float bottom,
            float width, float thickness)
        {
            float halfWidth = width * 0.5f;
            float dx = Mathf.Abs(u - centreX);
            float dy = v < top ? top - v : (v > bottom ? v - bottom : 0f);

            // Distance to the stadium's centre line, then to its outline.
            float distance = dy > 0f
                ? Mathf.Sqrt(dx * dx + dy * dy)
                : dx;

            return 1f - Threshold(0f, thickness, Mathf.Abs(distance - halfWidth));
        }

        /// <summary>
        /// The turned-up corner: the shadow the lifted flap throws on the sheet, and over it the
        /// paler reverse of the paper. Drawn rather than assembled out of rectangles, because a
        /// bare triangle in the corner of a page reads as a rendering bug.
        /// </summary>
        private static Texture2D BakeCorner()
        {
            Color32[] pixels = new Color32[k_FoldSize * k_FoldSize];
            Color shadow = new Color(0.376f, 0.337f, 0.275f);
            Color reverse = new Color(0.839f, 0.796f, 0.698f);

            for (int y = 0; y < k_FoldSize; y++)
            {
                float v = (float)y / (k_FoldSize - 1);

                for (int x = 0; x < k_FoldSize; x++)
                {
                    float u = (float)x / (k_FoldSize - 1);

                    // v runs up the texture, so the corner being lifted is at high u, low v.
                    bool inShadow = u > v;
                    bool inFlap = u > v + 0.07f;

                    Color color = inFlap ? reverse : shadow;
                    color.a = inFlap ? 0.96f : (inShadow ? 0.35f : 0f);

                    pixels[y * k_FoldSize + x] = color;
                }
            }

            return ToTexture(pixels, k_FoldSize, k_FoldSize);
        }

        /// <summary>
        /// Reads a source texture straight off disk. The texture pipeline imports everything
        /// non-readable, and asking the importer for readability back is undone by the reimport
        /// that request triggers, so the file is decoded here instead.
        /// </summary>
        private static Texture2D LoadSource(string path)
        {
            if (!File.Exists(path))
            {
                Debug.LogError($"[{k_LogPrefix}] {path} is missing. It is a CC0 scan from "
                    + "ambientCG; see the LICENSE beside it for where to get it again.");
                return null;
            }

            Texture2D texture = new Texture2D(2, 2, TextureFormat.RGBA32, false);

            if (texture.LoadImage(File.ReadAllBytes(path), false))
            {
                texture.wrapMode = TextureWrapMode.Repeat;

                return texture;
            }

            Debug.LogError($"[{k_LogPrefix}] {path} could not be decoded.");
            Object.DestroyImmediate(texture);

            return null;
        }

        /// <summary>
        /// A shading-language <c>smoothstep</c>: 0 below <paramref name="edge0"/>, 1 above
        /// <paramref name="edge1"/>, smoothly between.
        /// <para>
        /// <see cref="Mathf.SmoothStep"/> is <b>not</b> this. Unity's takes (from, to, t) and
        /// returns a value between <c>from</c> and <c>to</c> — so <c>Mathf.SmoothStep(0.84f, 1f, r)</c>
        /// never returns less than 0.84 whatever r is, which is how the pin came out of the first
        /// bake with a maximum alpha of 41/255 and the stamp came out invisible. Every threshold in
        /// this file goes through here.
        /// </para>
        /// </summary>
        private static float Threshold(float edge0, float edge1, float x)
        {
            float t = Mathf.Clamp01((x - edge0) / Mathf.Max(edge1 - edge0, 1e-6f));

            return t * t * (3f - 2f * t);
        }

        /// <summary>Fractal Brownian motion on Unity's Perlin, returned on 0..1.</summary>
        private static float Fbm(float x, float y, int octaves)
        {
            float sum = 0f;
            float amplitude = 1f;
            float total = 0f;

            for (int i = 0; i < octaves; i++)
            {
                sum += Mathf.PerlinNoise(x, y) * amplitude;
                total += amplitude;
                amplitude *= 0.5f;
                x *= 2.03f;
                y *= 2.01f;
            }

            return total <= 0f ? 0f : sum / total;
        }

        /// <summary>
        /// 0 hard on the border, rising to 1 once <paramref name="band"/> of the sheet is behind you.
        /// </summary>
        private static float EdgeFalloff(float u, float v, float band)
        {
            float nearest = Mathf.Min(Mathf.Min(u, 1f - u), Mathf.Min(v, 1f - v));

            return Threshold(0f, Mathf.Max(band, 1e-4f), nearest);
        }

        /// <summary>A stable per-layer offset, so the octaves of each layer do not line up.</summary>
        private static Vector2 Offset(int seed)
        {
            System.Random random = new System.Random(seed);

            return new Vector2((float)random.NextDouble() * 512f, (float)random.NextDouble() * 512f);
        }

        private static Texture2D ToTexture(Color32[] pixels, int width, int height)
        {
            Texture2D texture = new Texture2D(width, height, TextureFormat.RGBA32, false, false);
            texture.SetPixels32(pixels);
            texture.Apply(false, false);

            return texture;
        }

        private static void Write(string path, Texture2D texture)
        {
            File.WriteAllBytes(path, texture.EncodeToPNG());
            Object.DestroyImmediate(texture);
            AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceUpdate);
        }

        private static void EnsureFolder()
        {
            if (!AssetDatabase.IsValidFolder(k_Folder))
            {
                Directory.CreateDirectory(k_Folder);
                AssetDatabase.Refresh();
            }
        }
    }
}

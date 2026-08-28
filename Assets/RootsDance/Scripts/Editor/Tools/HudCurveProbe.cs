using System.IO;
using System.Text;
using CurvedUIUtility;
using UnityEditor;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Measures how much the visor actually bows, separating <em>bow</em> from <em>tilt</em>: a curve
    /// reads as curved only when a line sags away from the straight line through its own endpoints.
    /// A readout sitting in a corner can be tilted several degrees and still look perfectly flat,
    /// which is how the HUD passed review while being, visually, not curved at all.
    /// Also writes a plot to Logs/hud_curve.png so the shape can be looked at rather than imagined.
    /// </summary>
    public static class HudCurveProbe
    {
        private const string k_CurveAssetPath = "Assets/RootsDance/Data/Config/HelmetHudCurve.asset";
        private const string k_PlotPath = "Logs/hud_curve.png";

        // The canvas scaler's reference resolution. Batch mode has no real screen, so the layout is
        // reconstructed in reference units instead of read off a RectTransform.
        private static readonly Vector2 k_Canvas = new Vector2(1920f, 1080f);

        public static void Report()
        {
            var asset = AssetDatabase.LoadAssetAtPath<CurvedUISettingsObject>(k_CurveAssetPath);

            if (asset == null)
            {
                Debug.LogError("HudCurveProbe: no curve asset at " + k_CurveAssetPath);
                return;
            }

            CurvedUISettings s = asset.Settings;
            var sb = new StringBuilder("VISOR CURVE\n");
            sb.Append("  Curve=").Append(Fmt(s.Curve)).Append("  Pull=").Append(Fmt(s.Pull))
                .Append("  Scale=").Append(Fmt(s.Scale)).Append("  Offset=").AppendLine(Fmt(s.Offset));

            var plot = new Texture2D(960, 540, TextureFormat.RGB24, false);
            Fill(plot, new Color(0.04f, 0.05f, 0.06f));

            sb.AppendLine("  a horizontal line spanning the visor, at each height:");

            foreach (float y in new[] { 470f, 300f, 0f, -300f, -370f })
            {
                Measure(sb, s, plot, y, -940f, 940f, "full width  y=" + y.ToString("F0"),
                    new Color(0.2f, 0.9f, 1f));
            }

            sb.AppendLine("  each readout, over its own width:");
            ReportLabels(sb, s, plot);

            // Bow scales with the square of the span: a 520 px readout on a 1920 px canvas can
            // only ever show 3.7% of the arc's amplitude, so a small widget expresses curvature as
            // tilt and a spanning line expresses it as bow. Judging both by the same number is what
            // made a visibly flat HUD look acceptable on paper.
            sb.AppendLine("  small widgets read as tilt, spanning lines read as bow.");
            sb.AppendLine("  target: readout tilt 8-12 deg, visor top bow >= 100 px, mid bow > 0.");

            plot.Apply(false);
            Directory.CreateDirectory("Logs");
            File.WriteAllBytes(k_PlotPath, plot.EncodeToPNG());
            Object.DestroyImmediate(plot);
            sb.Append("  plot written to ").Append(k_PlotPath);

            Debug.Log(sb.ToString());
        }

        private static void ReportLabels(StringBuilder sb, CurvedUISettings s, Texture2D plot)
        {
            // The readouts are rebuilt from the same numbers HelmetHudBuilder lays them out with, so
            // the measurement does not depend on a scene being open in batch mode.
            AddLabel(sb, s, plot, "ContamReadout", new Vector2(0f, 1f), new Vector2(90f, -70f));
            AddLabel(sb, s, plot, "SystemReadout", new Vector2(1f, 1f), new Vector2(-90f, -70f));
            AddLabel(sb, s, plot, "InteractPrompt", new Vector2(0.5f, 0f), new Vector2(0f, 170f));
        }

        private static void AddLabel(StringBuilder sb, CurvedUISettings s, Texture2D plot, string name,
            Vector2 anchor, Vector2 anchoredPosition)
        {
            Vector2 size = new Vector2(520f, 140f);

            // anchorMin == anchorMax == pivot for every readout, so the centre is exact.
            Vector2 centre = (anchor - new Vector2(0.5f, 0.5f)) * k_Canvas
                + anchoredPosition + (new Vector2(0.5f, 0.5f) - anchor) * size;

            Measure(sb, s, plot, centre.y, centre.x - size.x * 0.5f, centre.x + size.x * 0.5f,
                name.PadRight(15), new Color(1f, 0.75f, 0.2f));
        }

        private static void Measure(StringBuilder sb, CurvedUISettings s, Texture2D plot, float y,
            float x0, float x1, string label, Color colour)
        {
            const int samples = 41;
            var pts = new Vector2[samples];

            for (int i = 0; i < samples; i++)
            {
                float t = i / (float)(samples - 1);
                pts[i] = Curved(new Vector2(Mathf.Lerp(x0, x1, t), y), s);
            }

            // Bow = worst deviation from the chord through the endpoints. Tilt = the chord's own
            // slope. Splitting them is the whole point: tilt is invisible, bow is not.
            Vector2 a = pts[0];
            Vector2 b = pts[samples - 1];
            float bow = 0f;

            for (int i = 1; i < samples - 1; i++)
            {
                float t = (i / (float)(samples - 1));
                float chordY = Mathf.Lerp(a.y, b.y, t);
                bow = Mathf.Max(bow, Mathf.Abs(pts[i].y - chordY));
            }

            float tilt = Mathf.Abs(b.x - a.x) < 0.01f
                ? 0f
                : Mathf.Atan2(b.y - a.y, b.x - a.x) * Mathf.Rad2Deg;

            sb.Append("    ").Append(label.PadRight(20))
                .Append(" bow ").Append(bow.ToString("F1").PadLeft(6)).Append(" px")
                .Append("   tilt ").Append(tilt.ToString("F2").PadLeft(6)).AppendLine(" deg");

            for (int i = 0; i < samples; i++)
            {
                Plot(plot, pts[i], colour);
            }
        }

        private static Vector2 Curved(Vector2 p, CurvedUISettings s)
        {
            // Mirrors CurvedUIHelper.ModifyCurvedPosition exactly; duplicated rather than reflected
            // so a vendor change shows up as a diff here instead of a silent drift.
            float xDist = 1f - (p.y / (k_Canvas.y * 0.5f)) * (p.y / (k_Canvas.y * 0.5f));
            float yDist = 1f - (p.x / (k_Canvas.x * 0.5f)) * (p.x / (k_Canvas.x * 0.5f));

            p.x -= p.x * xDist * s.Curve.x;
            p.y -= p.y * yDist * s.Curve.y;
            p.x += xDist * s.Pull.x;
            p.y += yDist * s.Pull.y;
            p.x *= s.Scale.x;
            p.y *= s.Scale.y;
            p.x += s.Offset.x * k_Canvas.x;
            p.y += s.Offset.y * k_Canvas.y;
            return p;
        }

        private static void Plot(Texture2D tex, Vector2 canvasPoint, Color colour)
        {
            int px = Mathf.RoundToInt((canvasPoint.x / k_Canvas.x + 0.5f) * tex.width);
            int py = Mathf.RoundToInt((canvasPoint.y / k_Canvas.y + 0.5f) * tex.height);

            for (int dy = -1; dy <= 1; dy++)
            {
                for (int dx = -1; dx <= 1; dx++)
                {
                    int x = px + dx;
                    int y = py + dy;

                    if (x >= 0 && x < tex.width && y >= 0 && y < tex.height)
                    {
                        tex.SetPixel(x, y, colour);
                    }
                }
            }
        }

        private static void Fill(Texture2D tex, Color colour)
        {
            var pixels = new Color[tex.width * tex.height];

            for (int i = 0; i < pixels.Length; i++)
            {
                pixels[i] = colour;
            }

            tex.SetPixels(pixels);
        }

        private static string Fmt(Vector3 v)
        {
            return "(" + v.x.ToString("F3") + "," + v.y.ToString("F3") + ")";
        }
    }
}

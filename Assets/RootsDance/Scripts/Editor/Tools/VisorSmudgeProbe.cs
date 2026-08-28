using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Renders the visor's grime term on its own and measures how much of the view it covers.
    /// "Too stained" is a judgement about coverage, and coverage is measurable: the first
    /// edge-to-edge pass replaced a mask that fell to zero by mid-glass with a flat 1, which put
    /// the fingerprint map over the entire screen at full strength and made it read as patterned
    /// glass. This prints the numbers and writes a picture so neither has to be imagined.
    /// </summary>
    public static class VisorSmudgeProbe
    {
        private const string k_SmudgePath =
            "Assets/ThirdParty/Environment/AmbientCG/Fingerprints002/Fingerprints002_1K-JPG_Color.jpg";
        private const string k_MaterialPath = "Assets/RootsDance/Materials/HelmetVisor.mat";
        private const string k_OutDir = "Logs";

        public static void Report()
        {
            // Read the JPG straight off disk: the imported texture is not CPU-readable and turning
            // that on would edit an asset just to measure it.
            if (!File.Exists(k_SmudgePath))
            {
                Debug.LogError("VisorSmudgeProbe: no smudge map at " + k_SmudgePath);
                return;
            }

            var map = new Texture2D(2, 2, TextureFormat.RGB24, false);
            map.LoadImage(File.ReadAllBytes(k_SmudgePath));

            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_MaterialPath);

            if (material == null)
            {
                Debug.LogError("VisorSmudgeProbe: no material at " + k_MaterialPath);
                return;
            }

            var sb = new StringBuilder("VISOR GRIME\n");

            // The pass that drew the complaint, kept as the comparison line.
            Measure(sb, map, "before (flat mask) ", 1.2f, 0.08f, 0.35f, -1f, null);
            Measure(sb, map, "now                ",
                material.GetFloat("_SmudgeTiling"),
                material.GetFloat("_SmudgeMean"),
                material.GetFloat("_SmudgeStrength"),
                material.GetFloat("_SmudgeCenterClear"),
                Path.Combine(k_OutDir, "visor_smudge.png"));

            Object.DestroyImmediate(map);
            Debug.Log(sb.ToString());
        }

        /// <summary>
        /// A clear radius below zero means the old flat mask, so both passes go through one path.
        /// </summary>
        private static void Measure(StringBuilder sb, Texture2D map, string label,
            float tiling, float mean, float strength, float clearRadius, string plotPath)
        {
            const int w = 480;
            const int h = 270;
            Texture2D plot = plotPath == null ? null : new Texture2D(w, h, TextureFormat.RGB24, false);

            float total = 0f;
            int faint = 0;
            int strong = 0;
            float centre = 0f;
            float edge = 0f;
            float peak = 0f;

            for (int y = 0; y < h; y++)
            {
                for (int x = 0; x < w; x++)
                {
                    float u = (x + 0.5f) / w;
                    float v = (y + 0.5f) / h;
                    float amount = Amount(map, u, v, tiling, mean, strength, clearRadius);

                    total += amount;
                    peak = Mathf.Max(peak, amount);
                    if (amount > 0.05f) { faint++; }
                    if (amount > 0.15f) { strong++; }

                    if (plot != null)
                    {
                        float shown = Mathf.Clamp01(amount * 2f);
                        plot.SetPixel(x, y, new Color(shown, shown, shown));
                    }
                }
            }

            // Two fixed samples: the middle of the view, and halfway out to the left edge.
            centre = Amount(map, 0.5f, 0.5f, tiling, mean, strength, clearRadius);
            edge = Amount(map, 0.04f, 0.5f, tiling, mean, strength, clearRadius);

            int pixels = w * h;
            sb.Append("  ").Append(label)
                .Append(" mean ").Append((total / pixels).ToString("F3"))
                .Append("   >0.05 ").Append((100f * faint / pixels).ToString("F1").PadLeft(5)).Append("%")
                .Append("   >0.15 ").Append((100f * strong / pixels).ToString("F1").PadLeft(5)).Append("%")
                .Append("   peak ").Append(peak.ToString("F3"))
                .Append("   centre ").Append(centre.ToString("F3"))
                .Append("   far edge ").AppendLine(edge.ToString("F3"));

            if (plot != null)
            {
                plot.Apply(false);
                Directory.CreateDirectory(k_OutDir);
                File.WriteAllBytes(plotPath, plot.EncodeToPNG());
                Object.DestroyImmediate(plot);
                sb.Append("  grime alone written to ").AppendLine(plotPath);
                sb.AppendLine("  incidental grime wants a low single-digit % above 0.15, and a clean centre.");
            }
        }

        private static float Amount(Texture2D map, float u, float v,
            float tiling, float mean, float strength, float clearRadius)
        {
            // Mirrors the shader's smudge term, including the 16:9 correction on the sample.
            Color c = map.GetPixelBilinear(u * tiling * 1.778f, v * tiling);
            float luma = c.r * 0.299f + c.g * 0.587f + c.b * 0.114f;
            float smudge = Mathf.Clamp01(luma / Mathf.Max(mean, 1e-3f));

            float mask;

            if (clearRadius < 0f)
            {
                mask = 1f;
            }
            else
            {
                float fx = (u - 0.5f) * 1.778f;
                float fy = v - 0.5f;
                float distance = Mathf.Sqrt(fx * fx + fy * fy);
                mask = Mathf.Clamp01((distance - clearRadius) / Mathf.Max(1.02f - clearRadius, 1e-3f));
            }

            return smudge * strength * mask * mask;
        }
    }
}

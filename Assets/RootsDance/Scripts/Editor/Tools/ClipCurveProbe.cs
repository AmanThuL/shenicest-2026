using System.Text;
using UnityEditor;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>Dumps the camera-bone curves of each arms clip, to see what actually got baked.</summary>
    public static class ClipCurveProbe
    {
        public static void Report()
        {
            var sb = new StringBuilder("CAMERA CURVES IN THE EXPORTED CLIPS\n");

            foreach (string guid in AssetDatabase.FindAssets(
                "t:Model", new[] { "Assets/RootsDance/Meshes/Characters" }))
            {
                string path = AssetDatabase.GUIDToAssetPath(guid);

                foreach (Object o in AssetDatabase.LoadAllAssetsAtPath(path))
                {
                    var clip = o as AnimationClip;

                    if (clip == null || clip.name.StartsWith("__"))
                    {
                        continue;
                    }

                    float span = 0f;
                    int found = 0;
                    string samplePath = "";

                    foreach (EditorCurveBinding b in AnimationUtility.GetCurveBindings(clip))
                    {
                        if (!b.path.EndsWith("camera"))
                        {
                            continue;
                        }

                        AnimationCurve c = AnimationUtility.GetEditorCurve(clip, b);

                        if (c == null || c.length < 2)
                        {
                            continue;
                        }

                        found++;
                        samplePath = b.path;
                        float min = float.MaxValue, max = float.MinValue;

                        foreach (Keyframe k in c.keys)
                        {
                            min = Mathf.Min(min, k.value);
                            max = Mathf.Max(max, k.value);
                        }

                        span = Mathf.Max(span, max - min);
                    }

                    sb.Append("  ").Append(clip.name.PadRight(20))
                        .Append("cameraCurves=").Append(found.ToString().PadRight(4))
                        .Append("largestRange=").Append(span.ToString("F5"))
                        .Append("  path=").AppendLine(samplePath);
                }
            }

            Debug.Log(sb.ToString());
        }
    }
}

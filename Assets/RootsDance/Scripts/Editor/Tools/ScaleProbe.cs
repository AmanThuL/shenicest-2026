using System.Text;
using UnityEditor;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Reports how every imported model lands in Unity: the importer's file scale, the node scales
    /// the FBX carries, and the resulting world size. The node scale is the number that matters —
    /// a rig whose bones all report a lossy scale near 100 makes every socket and attachment
    /// fragile, and it is the reason held props kept coming out the wrong size.
    /// </summary>
    public static class ScaleProbe
    {
        public static void Report()
        {
            var sb = new StringBuilder("MODEL SCALE PROBE\n");

            foreach (string guid in AssetDatabase.FindAssets(
                "t:Model", new[] { "Assets/RootsDance/Meshes" }))
            {
                string path = AssetDatabase.GUIDToAssetPath(guid);
                var importer = AssetImporter.GetAtPath(path) as ModelImporter;
                var model = AssetDatabase.LoadAssetAtPath<GameObject>(path);

                if (model == null)
                {
                    continue;
                }

                var instance = (GameObject)PrefabUtility.InstantiatePrefab(model);
                Bounds bounds = new Bounds();
                bool has = false;

                foreach (Renderer renderer in instance.GetComponentsInChildren<Renderer>(true))
                {
                    if (!has)
                    {
                        bounds = renderer.bounds;
                        has = true;
                    }
                    else
                    {
                        bounds.Encapsulate(renderer.bounds);
                    }
                }

                float maxNodeScale = 0f;
                float minNodeScale = float.MaxValue;

                foreach (Transform t in instance.GetComponentsInChildren<Transform>(true))
                {
                    float s = t.localScale.x;
                    maxNodeScale = Mathf.Max(maxNodeScale, s);
                    minNodeScale = Mathf.Min(minNodeScale, s);
                }

                sb.Append("  ").Append(System.IO.Path.GetFileName(path).PadRight(26))
                    .Append(" fileScale=").Append(importer == null ? 0f : importer.fileScale)
                    .Append(" globalScale=").Append(importer == null ? 0f : importer.globalScale)
                    .Append(" nodeScale=").Append(minNodeScale.ToString("F3"))
                    .Append("..").Append(maxNodeScale.ToString("F3"))
                    .Append(" worldSize=").AppendLine(has ? bounds.size.ToString("F4") : "none");

                Object.DestroyImmediate(instance);
            }

            Debug.Log(sb.ToString());
        }
    }
}

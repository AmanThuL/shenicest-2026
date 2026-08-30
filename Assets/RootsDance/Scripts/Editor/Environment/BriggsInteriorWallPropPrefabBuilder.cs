using System;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Generates the original primitive-only wall props used by Briggs Interior. Both prefabs face local +Z,
    /// have their origin at the visible centre and deliberately contain no Collider.
    /// </summary>
    public static class BriggsInteriorWallPropPrefabBuilder
    {
        public const string k_NoticeBoardPrefabPath =
            "Assets/RootsDance/Prefabs/Environment/LabArchives/LabNoticeBoard.prefab";
        public const string k_BrokenClockPrefabPath =
            "Assets/RootsDance/Prefabs/Environment/LabArchives/BrokenVintageWallClock.prefab";

        private const string k_MaterialFolder =
            "Assets/RootsDance/Materials/Environment/BriggsInterior/WallProps";
        private const string k_PrefabFolder = "Assets/RootsDance/Prefabs/Environment/LabArchives";

        /// <summary>
        /// Creates or deterministically overwrites the notice-board prefab and returns its project path.
        /// </summary>
        public static string EnsureLabNoticeBoardPrefab()
        {
            EnsureFolder(k_PrefabFolder);
            WallPropMaterials materials = EnsureMaterials();
            Scene preview = EditorSceneManager.NewPreviewScene();

            try
            {
                GameObject root = CreatePrefabRoot("LabNoticeBoard", preview);

                try
                {
                    BuildNoticeBoard(root.transform, materials);
                    SavePrefabWithoutColliders(root, k_NoticeBoardPrefabPath);
                }
                finally
                {
                    UnityEngine.Object.DestroyImmediate(root);
                }
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(preview);
            }

            AssetDatabase.SaveAssets();
            return k_NoticeBoardPrefabPath;
        }

        /// <summary>
        /// Creates or deterministically overwrites the broken wall-clock prefab and returns its project path.
        /// </summary>
        public static string EnsureBrokenVintageWallClockPrefab()
        {
            EnsureFolder(k_PrefabFolder);
            WallPropMaterials materials = EnsureMaterials();
            Scene preview = EditorSceneManager.NewPreviewScene();

            try
            {
                GameObject root = CreatePrefabRoot("BrokenVintageWallClock", preview);

                try
                {
                    BuildBrokenClock(root.transform, materials);
                    SavePrefabWithoutColliders(root, k_BrokenClockPrefabPath);
                }
                finally
                {
                    UnityEngine.Object.DestroyImmediate(root);
                }
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(preview);
            }

            AssetDatabase.SaveAssets();
            return k_BrokenClockPrefabPath;
        }

        private static void BuildNoticeBoard(Transform root, WallPropMaterials materials)
        {
            AddCube(root, "Backing", Vector3.zero, new Vector3(1.6f, 0.95f, 0.06f), materials.FrameDark);
            AddCube(root, "Cork", new Vector3(0f, 0f, 0.045f),
                new Vector3(1.44f, 0.79f, 0.025f), materials.Cork);
            AddCube(root, "Frame_Top", new Vector3(0f, 0.44f, 0.055f),
                new Vector3(1.64f, 0.07f, 0.09f), materials.FrameRust);
            AddCube(root, "Frame_Bottom", new Vector3(0f, -0.44f, 0.055f),
                new Vector3(1.64f, 0.07f, 0.09f), materials.FrameRust);
            AddCube(root, "Frame_Left", new Vector3(-0.785f, 0f, 0.055f),
                new Vector3(0.07f, 0.88f, 0.09f), materials.FrameRust);
            AddCube(root, "Frame_Right", new Vector3(0.785f, 0f, 0.055f),
                new Vector3(0.07f, 0.88f, 0.09f), materials.FrameRust);

            AddPaper(root, "Paper_FieldNotes", new Vector2(-0.48f, 0.19f),
                new Vector2(0.36f, 0.29f), -4f, materials.PaperWarm, materials.Ink, materials.PinRed);
            AddPaper(root, "Paper_SampleLog", new Vector2(-0.08f, 0.17f),
                new Vector2(0.31f, 0.34f), 2f, materials.PaperCold, materials.Ink, materials.PinBlue);
            AddPaper(root, "Paper_PlantSketch", new Vector2(0.34f, 0.16f),
                new Vector2(0.36f, 0.32f), -3f, materials.PaperWarm, materials.Ink, materials.PinRed);
            AddPaper(root, "Paper_TestResults", new Vector2(-0.32f, -0.22f),
                new Vector2(0.43f, 0.25f), 5f, materials.PaperCold, materials.Ink, materials.PinBlue);
            AddPaper(root, "Paper_RouteDiagram", new Vector2(0.27f, -0.22f),
                new Vector2(0.49f, 0.23f), -2f, materials.PaperWarm, materials.Ink, materials.PinRed);

            AddBar2D(root, "Cord_01", new Vector2(-0.48f, 0.31f), new Vector2(-0.08f, 0.31f),
                0.008f, 0.073f, materials.Cord);
            AddBar2D(root, "Cord_02", new Vector2(-0.08f, 0.31f), new Vector2(0.34f, 0.30f),
                0.008f, 0.074f, materials.Cord);
            AddBar2D(root, "Cord_03", new Vector2(0.34f, 0.30f), new Vector2(0.27f, -0.10f),
                0.008f, 0.075f, materials.Cord);
            AddBar2D(root, "Cord_04", new Vector2(-0.32f, -0.10f), new Vector2(-0.08f, 0.31f),
                0.008f, 0.076f, materials.Cord);
        }

        private static void AddPaper(
            Transform parent,
            string name,
            Vector2 position,
            Vector2 size,
            float angle,
            Material paper,
            Material ink,
            Material pin)
        {
            GameObject holder = new GameObject(name);
            holder.transform.SetParent(parent, false);
            holder.transform.SetLocalPositionAndRotation(
                new Vector3(position.x, position.y, 0.064f),
                Quaternion.Euler(0f, 0f, angle));

            AddCube(holder.transform, "Paper", Vector3.zero, new Vector3(size.x, size.y, 0.01f), paper);
            float lineWidth = size.x * 0.68f;
            AddCube(holder.transform, "Ink_Title", new Vector3(0f, size.y * 0.22f, 0.007f),
                new Vector3(lineWidth, 0.012f, 0.005f), ink);
            AddCube(holder.transform, "Ink_Line_01", new Vector3(-size.x * 0.08f, 0f, 0.007f),
                new Vector3(lineWidth * 0.82f, 0.009f, 0.005f), ink);
            AddCube(holder.transform, "Ink_Line_02", new Vector3(size.x * 0.05f, -size.y * 0.16f, 0.007f),
                new Vector3(lineWidth * 0.62f, 0.009f, 0.005f), ink);
            AddCylinder(holder.transform, "Pin", new Vector3(0f, size.y * 0.39f, 0.014f),
                new Vector3(0.028f, 0.009f, 0.028f), new Vector3(90f, 0f, 0f), pin);
        }

        private static void BuildBrokenClock(Transform root, WallPropMaterials materials)
        {
            AddCylinder(root, "Case", new Vector3(0f, 0f, 0f),
                new Vector3(0.56f, 0.035f, 0.56f), new Vector3(90f, 0f, 0f), materials.FrameDark);
            AddCylinder(root, "OxidisedRim", new Vector3(0f, 0f, 0.042f),
                new Vector3(0.51f, 0.018f, 0.51f), new Vector3(90f, 0f, 0f), materials.FrameRust);
            AddCylinder(root, "Face", new Vector3(0f, 0f, 0.064f),
                new Vector3(0.45f, 0.01f, 0.45f), new Vector3(90f, 0f, 0f), materials.ClockFace);

            for (int i = 0; i < 12; i++)
            {
                if (i == 5)
                {
                    continue;
                }

                float angle = i * 30f * Mathf.Deg2Rad;
                Vector3 position = new Vector3(Mathf.Sin(angle) * 0.18f, Mathf.Cos(angle) * 0.18f, 0.078f);
                AddCube(root, $"HourMark_{i + 1:00}", position, new Vector3(0.015f, 0.052f, 0.012f),
                    materials.Ink, new Vector3(0f, 0f, -i * 30f));
            }

            AddBar2D(root, "HourHand", Vector2.zero, new Vector2(-0.095f, 0.09f),
                0.018f, 0.088f, materials.Ink);
            AddBar2D(root, "MinuteHand_Broken", new Vector2(0.025f, -0.02f), new Vector2(0.145f, -0.115f),
                0.012f, 0.089f, materials.Ink);
            AddCylinder(root, "HandPin", new Vector3(0f, 0f, 0.094f),
                new Vector3(0.035f, 0.008f, 0.035f), new Vector3(90f, 0f, 0f), materials.FrameRust);

            Vector2 crack = new Vector2(0.095f, 0.065f);
            AddBar2D(root, "Crack_01", crack, new Vector2(0.205f, 0.16f),
                0.008f, 0.087f, materials.Crack);
            AddBar2D(root, "Crack_02", crack, new Vector2(0.22f, 0.015f),
                0.007f, 0.087f, materials.Crack);
            AddBar2D(root, "Crack_03", crack, new Vector2(0.15f, -0.12f),
                0.007f, 0.087f, materials.Crack);
            AddBar2D(root, "Crack_04", new Vector2(0.15f, -0.12f), new Vector2(0.055f, -0.205f),
                0.006f, 0.087f, materials.Crack);
            AddCube(root, "MissingRimPatch", new Vector3(0.17f, -0.19f, 0.055f),
                new Vector3(0.16f, 0.07f, 0.07f), materials.FrameDark, new Vector3(0f, 0f, -38f));
        }

        private static void AddBar2D(
            Transform parent,
            string name,
            Vector2 start,
            Vector2 end,
            float width,
            float z,
            Material material)
        {
            Vector2 delta = end - start;
            Vector2 midpoint = (start + end) * 0.5f;
            float angle = Mathf.Atan2(delta.y, delta.x) * Mathf.Rad2Deg;
            AddCube(parent, name, new Vector3(midpoint.x, midpoint.y, z),
                new Vector3(delta.magnitude, width, 0.006f), material, new Vector3(0f, 0f, angle));
        }

        private static WallPropMaterials EnsureMaterials()
        {
            EnsureFolder(k_MaterialFolder);
            return new WallPropMaterials(
                EnsureLitMaterial("WallProp_FrameDark", new Color(0.08f, 0.12f, 0.1f), 0.65f, 0.16f),
                EnsureLitMaterial("WallProp_FrameRust", new Color(0.31f, 0.17f, 0.08f), 0.48f, 0.12f),
                EnsureLitMaterial("WallProp_Cork", new Color(0.28f, 0.18f, 0.1f), 0f, 0.06f),
                EnsureLitMaterial("WallProp_PaperWarm", new Color(0.62f, 0.61f, 0.49f), 0f, 0.18f),
                EnsureLitMaterial("WallProp_PaperCold", new Color(0.47f, 0.54f, 0.5f), 0f, 0.16f),
                EnsureLitMaterial("WallProp_Ink", new Color(0.045f, 0.07f, 0.06f), 0f, 0.05f),
                EnsureLitMaterial("WallProp_PinRed", new Color(0.42f, 0.08f, 0.045f), 0.25f, 0.2f),
                EnsureLitMaterial("WallProp_PinBlue", new Color(0.08f, 0.28f, 0.3f), 0.25f, 0.2f),
                EnsureLitMaterial("WallProp_Cord", new Color(0.36f, 0.07f, 0.045f), 0f, 0.1f),
                EnsureLitMaterial("WallProp_ClockFace", new Color(0.55f, 0.56f, 0.46f), 0f, 0.14f),
                EnsureLitMaterial("WallProp_Crack", new Color(0.025f, 0.035f, 0.03f), 0f, 0.02f));
        }

        private static Material EnsureLitMaterial(
            string name,
            Color baseColor,
            float metallic,
            float smoothness)
        {
            string path = k_MaterialFolder + "/" + name + ".mat";
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);
            Shader shader = Shader.Find("HDRP/Lit");

            if (shader == null)
            {
                throw new InvalidOperationException("HDRP/Lit shader was not found for Briggs wall props.");
            }

            if (material == null)
            {
                material = new Material(shader) { name = name };
                AssetDatabase.CreateAsset(material, path);
            }
            else
            {
                material.shader = shader;
            }

            material.SetColor("_BaseColor", baseColor);
            material.SetFloat("_Metallic", metallic);
            material.SetFloat("_Smoothness", smoothness);
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static GameObject CreatePrefabRoot(string name, Scene preview)
        {
            GameObject root = new GameObject(name);
            SceneManager.MoveGameObjectToScene(root, preview);
            root.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
            root.transform.localScale = Vector3.one;
            return root;
        }

        private static void AddCube(
            Transform parent,
            string name,
            Vector3 position,
            Vector3 scale,
            Material material,
            Vector3 euler = default)
        {
            GameObject part = GameObject.CreatePrimitive(PrimitiveType.Cube);
            part.name = name;
            SceneManager.MoveGameObjectToScene(part, parent.gameObject.scene);
            part.transform.SetParent(parent, false);
            part.transform.SetLocalPositionAndRotation(position, Quaternion.Euler(euler));
            part.transform.localScale = scale;
            UnityEngine.Object.DestroyImmediate(part.GetComponent<Collider>());
            part.GetComponent<MeshRenderer>().sharedMaterial = material;
        }

        private static void AddCylinder(
            Transform parent,
            string name,
            Vector3 position,
            Vector3 scale,
            Vector3 euler,
            Material material)
        {
            GameObject part = GameObject.CreatePrimitive(PrimitiveType.Cylinder);
            part.name = name;
            SceneManager.MoveGameObjectToScene(part, parent.gameObject.scene);
            part.transform.SetParent(parent, false);
            part.transform.SetLocalPositionAndRotation(position, Quaternion.Euler(euler));
            part.transform.localScale = scale;
            UnityEngine.Object.DestroyImmediate(part.GetComponent<Collider>());
            part.GetComponent<MeshRenderer>().sharedMaterial = material;
        }

        private static void SavePrefabWithoutColliders(GameObject root, string path)
        {
            Collider[] colliders = root.GetComponentsInChildren<Collider>(true);

            if (colliders.Length != 0)
            {
                throw new InvalidOperationException("Generated Briggs wall prop unexpectedly contains a Collider.");
            }

            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                transforms[i].gameObject.isStatic = true;
            }

            bool saved;
            PrefabUtility.SaveAsPrefabAsset(root, path, out saved);

            if (!saved)
            {
                throw new InvalidOperationException("Could not save generated Briggs wall prop prefab: " + path);
            }
        }

        private static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = System.IO.Path.GetDirectoryName(path).Replace('\\', '/');
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, System.IO.Path.GetFileName(path));
        }

        private sealed class WallPropMaterials
        {
            public WallPropMaterials(
                Material frameDark,
                Material frameRust,
                Material cork,
                Material paperWarm,
                Material paperCold,
                Material ink,
                Material pinRed,
                Material pinBlue,
                Material cord,
                Material clockFace,
                Material crack)
            {
                FrameDark = frameDark;
                FrameRust = frameRust;
                Cork = cork;
                PaperWarm = paperWarm;
                PaperCold = paperCold;
                Ink = ink;
                PinRed = pinRed;
                PinBlue = pinBlue;
                Cord = cord;
                ClockFace = clockFace;
                Crack = crack;
            }

            public Material FrameDark { get; }
            public Material FrameRust { get; }
            public Material Cork { get; }
            public Material PaperWarm { get; }
            public Material PaperCold { get; }
            public Material Ink { get; }
            public Material PinRed { get; }
            public Material PinBlue { get; }
            public Material Cord { get; }
            public Material ClockFace { get; }
            public Material Crack { get; }
        }
    }
}

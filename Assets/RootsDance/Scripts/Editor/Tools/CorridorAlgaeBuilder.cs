using System.IO;
using RootsDance.Core;
using RootsDance.Interaction;
using RootsDance.Investigation;
using RootsDance.Player.Arms;
using RootsDance.Scanner;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Plants BOT-AL-017 荧光藻 at the mouth of the lab corridor and wires the beat it carries:
    /// scan it into the biological report, then scrape some into the dead torch to light it.
    /// <para>
    /// Written as a builder rather than done by hand because the patch is four authored things at
    /// once — an investigation record, a material, a prefab and a scene placement — and the three
    /// strings that tie them together have to match exactly. A typo in any of them fails silently:
    /// the scan plays, the arm animates, and nothing appears on the screen.
    /// </para>
    /// <para>
    /// No new <see cref="ScannerReportSectionSO"/> is created. <c>03_Biology</c> already has
    /// <c>FeedsFromReport</c> set, so an <see cref="InvestigationTargetSO"/> is the whole story —
    /// the same way the two vines in chapter 00 reach the screen. Note that
    /// <see cref="ScannableTarget"/> has a <c>m_revealedSection</c> field that looks like the way
    /// to do this and is read by nothing; leave it empty.
    /// </para>
    /// Re-runnable: every step reuses what is already there, so this can be run again after the
    /// mesh or the copy changes.
    /// </summary>
    public static class CorridorAlgaeBuilder
    {
        private const string k_Scene = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_2.unity";

        private const string k_Fbx = "Assets/RootsDance/Meshes/Environment/AlgaePatch.fbx";
        private const string k_Normal = "Assets/RootsDance/Textures/Environment/AlgaePatch_Normal.png";
        private const string k_Mask = "Assets/RootsDance/Textures/Environment/AlgaePatch_Mask.png";

        private const string k_Shader = "RootsDance/Environment/BioluminescentAlgae";
        private const string k_Material = "Assets/RootsDance/Materials/Environment/BioluminescentAlgae.mat";
        private const string k_Record = "Assets/RootsDance/Data/Investigation/BOT-AL-017_FluorescentAlgae.asset";
        private const string k_Prefab = "Assets/RootsDance/Prefabs/Environment/AlgaePatch.prefab";

        /// <summary>Which of the five authored patch sizes goes on the corridor wall.</summary>
        private const string k_MeshName = "Algae_Patch_C";

        private const string k_InstanceName = "AlgaePatch_Corridor";

        // Measured by raycast against the level, not read off the design doc. The passage the
        // player walks here is open to the sky and floored by Terrain_Main at Y 7.00, not by a
        // building slab — the corridor's own bounding box in 00章室外环境设计 §54 is the shell, and
        // chapter 00 only ever reaches its foot. The west wall is the one the BandPosters hang on,
        // it is NOT axis-aligned (it runs about 13° off Z), and it only becomes solid at Z 100.5;
        // south of that is the open approach. Z 100.8-101.2 is one flat panel, which is where this
        // sits: just inside the mouth, a little short of the first poster at Z 101.48.
        private static readonly Vector3 k_Position = new Vector3(28.23f, 7.35f, 101.00f);

        // The patch is authored flat with its surface normal along local +Y, so the rotation is
        // whatever maps +Y onto the measured wall normal (0.972, 0, -0.233) — that is
        // Quaternion.FromToRotation(Vector3.up, n) written out. Y 7.35 with a 1 m patch buries the
        // bottom 0.15 m in the floor, so it reads as growing out of the corner rather than stuck on.
        private static readonly Vector3 k_EulerAngles = new Vector3(346.5f, 13.5f, 270f);

        [MenuItem("RootsDance/Build Corridor Algae")]
        public static void Build()
        {
            InvestigationTargetSO record = EnsureRecord();
            Material material = EnsureMaterial();

            if (record == null || material == null)
            {
                return;
            }

            GameObject prefab = EnsurePrefab(material, record);

            if (prefab == null)
            {
                return;
            }

            PlaceInScene(prefab);
            AssetDatabase.SaveAssets();
            Debug.Log("CorridorAlgaeBuilder: done.");
        }

        /// <summary>
        /// The report entry. <c>m_flagOnRecorded</c> is the string the whole beat turns on: the
        /// scan raises it, and the harvest point refuses to offer itself until it is up — which is
        /// what makes the player scan before they collect rather than after.
        /// </summary>
        private static InvestigationTargetSO EnsureRecord()
        {
            InvestigationTargetSO record = AssetDatabase.LoadAssetAtPath<InvestigationTargetSO>(k_Record);

            if (record == null)
            {
                EnsureFolder(Path.GetDirectoryName(k_Record));
                record = ScriptableObject.CreateInstance<InvestigationTargetSO>();
                AssetDatabase.CreateAsset(record, k_Record);
            }

            SerializedObject so = new SerializedObject(record);
            so.FindProperty("m_id").stringValue = "BOT-AL-017";
            so.FindProperty("m_kind").enumValueIndex = (int)InvestigationKind.Identify;
            so.FindProperty("m_category").enumValueIndex = (int)ReportCategory.BiologicalRecord;
            so.FindProperty("m_title").stringValue = "荧光藻";
            so.FindProperty("m_promptText").stringValue = "识别";
            so.FindProperty("m_resultBody").stringValue =
                "薄片状半透明青蓝色藻类，附着于硬质表面，表层为湿润胶质薄膜，褶皱细碎。"
                + "无外部光源时仍持续发光，光强随环境湿度上升。孢子为细小微粒，随气流扩散。";

            SerializedProperty lines = so.FindProperty("m_monologueLines");
            lines.arraySize = 1;
            lines.GetArrayElementAtIndex(0).stringValue = "它自己在发光……不需要电。";

            so.FindProperty("m_flagOnRecorded").stringValue = WorldFlags.k_AlgaeScanned;
            so.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(record);

            return record;
        }

        private static Material EnsureMaterial()
        {
            Shader shader = Shader.Find(k_Shader);

            if (shader == null)
            {
                Debug.LogError($"CorridorAlgaeBuilder: shader '{k_Shader}' not found.");
                return null;
            }

            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_Material);

            if (material == null)
            {
                EnsureFolder(Path.GetDirectoryName(k_Material));
                material = new Material(shader);
                AssetDatabase.CreateAsset(material, k_Material);
            }

            material.shader = shader;
            material.SetTexture("_WrinkleNormal", AssetDatabase.LoadAssetAtPath<Texture>(k_Normal));
            material.SetTexture("_DensityMap", AssetDatabase.LoadAssetAtPath<Texture>(k_Mask));
            EditorUtility.SetDirty(material);

            return material;
        }

        /// <summary>
        /// The prop: the film, the scan and the harvest on one object. No collider — both proximity
        /// triggers measure distance to a transform, so a collider here would be a component
        /// nothing reads.
        /// </summary>
        private static GameObject EnsurePrefab(Material material, InvestigationTargetSO record)
        {
            Mesh mesh = LoadMesh();

            if (mesh == null)
            {
                return null;
            }

            EnsureFolder(Path.GetDirectoryName(k_Prefab));

            GameObject root = new GameObject("AlgaePatch");

            try
            {
                root.AddComponent<MeshFilter>().sharedMesh = mesh;
                MeshRenderer renderer = root.AddComponent<MeshRenderer>();
                renderer.sharedMaterial = material;
                renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;

                ScannableTarget scannable = root.AddComponent<ScannableTarget>();
                SerializedObject st = new SerializedObject(scannable);
                st.FindProperty("m_displayName").stringValue = "荧光藻";
                st.FindProperty("m_repeatable").boolValue = false;
                st.ApplyModifiedPropertiesWithoutUndo();

                ScannerWorldStateResult result = root.AddComponent<ScannerWorldStateResult>();
                SerializedObject sr = new SerializedObject(result);
                sr.FindProperty("m_reportTarget").objectReferenceValue = record;
                sr.ApplyModifiedPropertiesWithoutUndo();

                HarvestPoint harvest = root.AddComponent<HarvestPoint>();
                SerializedObject hp = new SerializedObject(harvest);
                hp.FindProperty("m_displayName").stringValue = "荧光藻";
                hp.FindProperty("m_requiresCarriedItem").boolValue = true;
                hp.FindProperty("m_requiredKind").enumValueIndex = (int)CarriedKind.Torch;
                hp.FindProperty("m_blockedPrompt").stringValue = "需要先拿着手电筒";
                hp.FindProperty("m_requiredFlag").stringValue = WorldFlags.k_AlgaeScanned;
                hp.FindProperty("m_flagOnHarvested").stringValue = WorldFlags.k_FlashlightPowered;
                hp.FindProperty("m_repeatable").boolValue = false;
                hp.ApplyModifiedPropertiesWithoutUndo();

                return PrefabUtility.SaveAsPrefabAsset(root, k_Prefab);
            }
            finally
            {
                Object.DestroyImmediate(root);
            }
        }

        /// <summary>
        /// The FBX carries five patch sizes as separate meshes; this picks the one the corridor
        /// uses by name rather than by index, so re-exporting in a different order cannot silently
        /// swap a 2 m patch onto a 1 m spot.
        /// </summary>
        private static Mesh LoadMesh()
        {
            Object[] all = AssetDatabase.LoadAllAssetsAtPath(k_Fbx);

            for (int i = 0; i < all.Length; i++)
            {
                if (all[i] is Mesh mesh && mesh.name == k_MeshName)
                {
                    return mesh;
                }
            }

            Debug.LogError($"CorridorAlgaeBuilder: no mesh named '{k_MeshName}' in {k_Fbx}.");

            return null;
        }

        private static void PlaceInScene(GameObject prefab)
        {
            Scene scene = EditorSceneManager.OpenScene(k_Scene, OpenSceneMode.Single);
            GameObject existing = null;

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == k_InstanceName)
                {
                    existing = root;
                    break;
                }
            }

            if (existing != null)
            {
                // Re-running must not stack a second patch on the first, and must not throw away a
                // nudge somebody made in the Editor either — so the pose is left exactly as found.
                Debug.Log($"CorridorAlgaeBuilder: '{k_InstanceName}' already in the scene at "
                    + $"{existing.transform.position:F2}; left where it is.");
                return;
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            instance.name = k_InstanceName;
            instance.transform.SetPositionAndRotation(k_Position, Quaternion.Euler(k_EulerAngles));

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            Debug.Log($"CorridorAlgaeBuilder: placed '{k_InstanceName}' at {k_Position:F2}.");
        }

        private static void EnsureFolder(string folder)
        {
            if (string.IsNullOrEmpty(folder) || AssetDatabase.IsValidFolder(folder))
            {
                return;
            }

            string parent = Path.GetDirectoryName(folder);
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, Path.GetFileName(folder));
        }
    }
}

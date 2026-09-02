using System;
using RootsDance.App;
using RootsDance.Environment;
using RootsDance.Investigation;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>Adds the Chapter 03 rainwater sink to the greenhouse interior: the faucet runs into a
    /// rectangular pool that fills the sink basin.</summary>
    public static class GreenhouseRainwaterSinkBuilder
    {
        public const string k_RootName = "GreenhouseRainwaterSink";
        public const string k_SinkName = "RainwaterCollectionSink";
        public const string k_BasinVolumeName = "BasinVolume";
        public const string k_StreamName = "RoofRunoffStream";
        public const string k_StoredWaterName = "StoredRainwater";
        public const string k_FallenLeavesName = "FallenLeaves";
        private const string k_SinkPrefabPath =
            "Assets/RootsDance/Prefabs/Environment/LabFurniture/counter_counter_sink.prefab";
        private const string k_WaterMaterialPath = "Assets/RootsDance/VFX/VFX_StatueWater.mat";
        private const string k_LeafMaterialPath =
            "Assets/RootsDance/Materials/Environment/Leaf_Dead.mat";
        private const string k_WaterTargetPath =
            "Assets/RootsDance/Data/Investigation/WT-001_ResidualWater.asset";
        private const string k_InteractableLayer = "Interactable";

        // The pool is Lit water, but a stream this thin refracts whatever is behind it, and behind it
        // is the dark inside of the basin. It gets an Unlit material so it stays water-coloured.
        private const string k_StreamMaterialPath = "Assets/RootsDance/VFX/VFX_FaucetStream.mat";
        private const string k_StreamFlowProperty = "_UnlitColorMap";

        private const float k_SinkScale = 2.4f;
        private static readonly Vector3 k_SinkPosition = new Vector3(-11.7f, 0f, 2.46f);

        // Geometry of counter_counter_sink at k_SinkPosition / k_SinkScale, measured off its mesh:
        // the basin opening spans X [-11.97, -11.12] and Z [1.90, 3.08] between floor 1.264 and rim
        // 1.670, and the faucet spout outlet is a 0.06-radius opening pointing straight down.
        private const float k_BasinFloorY = 1.264f;
        private const float k_WaterSurfaceY = 1.5f;
        private static readonly Vector3 k_BasinCenter = new Vector3(-11.545f, 0f, 2.49f);
        private static readonly Vector3 k_SpoutOutlet = new Vector3(-11.578f, 2.062f, 2.473f);

        // The stream starts a little way up inside the spout and ends a little way under the surface,
        // so neither end shows a seam.
        private static readonly Vector3 k_StreamTop = k_SpoutOutlet + new Vector3(0f, 0.013f, 0f);
        private static readonly Vector3 k_StreamBottom =
            new Vector3(k_SpoutOutlet.x, k_WaterSurfaceY - 0.03f, k_SpoutOutlet.z);
        private const float k_StreamRadius = 0.055f;

        // The pool is a box because the basin is rectangular; it is inset from the opening so its
        // corners hide inside the basin's rounded ones.
        private static readonly Vector3 k_StoredWaterCenter =
            new Vector3(k_BasinCenter.x, (k_BasinFloorY + k_WaterSurfaceY) * 0.5f, k_BasinCenter.z);
        private static readonly Vector3 k_StoredWaterSize =
            new Vector3(0.83f, k_WaterSurfaceY - k_BasinFloorY, 1.16f);

        // Dead leaves lying on the standing water. Laid out by hand rather than scattered at random
        // so the arrangement is the same every build and can be judged in the editor: each entry is
        // (x, z) inside the pool footprint, yaw in degrees, and the leaf's length in metres. They sit
        // a hair above the surface so neither the water nor the leaf z-fights the other.
        private const float k_LeafY = k_WaterSurfaceY + 0.004f;
        private static readonly Vector4[] k_Leaves =
        {
            new Vector4(-11.78f, 2.13f, 24f, 0.105f),
            new Vector4(-11.36f, 2.31f, -61f, 0.082f),
            new Vector4(-11.62f, 2.55f, 138f, 0.118f),
            new Vector4(-11.90f, 2.78f, -14f, 0.074f),
            new Vector4(-11.44f, 2.86f, 79f, 0.096f),
            new Vector4(-11.68f, 2.98f, -113f, 0.068f),
            new Vector4(-11.24f, 2.62f, 41f, 0.088f),
        };

        // The interaction trigger is the basin interior: it contains the pool and the falling stream.
        private static readonly Vector3 k_BasinVolumePosition =
            new Vector3(k_BasinCenter.x, 1.4f, k_BasinCenter.z);
        private static readonly Vector3 k_BasinVolumeSize = new Vector3(0.88f, 0.3f, 1.22f);

        [MenuItem("RootsDance/Environment/Build Greenhouse Rainwater Sink")]
        public static void Build()
        {
            ThrowIfAnyOpenSceneIsDirty();
            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                Scene scene = EditorSceneManager.OpenScene(
                    ScenePaths.k_GreenhouseInteriorEnvironment,
                    OpenSceneMode.Single);
                BuildInto(FindRoot(scene, "_Props"), scene);
                EditorSceneManager.MarkSceneDirty(scene);
                EditorSceneManager.SaveScene(scene);
                AssetDatabase.SaveAssets();
                Debug.Log("GreenhouseRainwaterSinkBuilder: built the faucet stream and stored rainwater.");
            }
            finally
            {
                if (originalSetup.Length > 0)
                {
                    EditorSceneManager.RestoreSceneManagerSetup(originalSetup);
                }
            }
        }

        /// <summary>Builds the rain collector into the authoritative Chapter 03 environment scene.</summary>
        public static void BuildInto(Transform props, Scene scene)
        {
            GameObject sinkPrefab = LoadAsset<GameObject>(k_SinkPrefabPath);
            Material waterMaterial = LoadAsset<Material>(k_WaterMaterialPath);
            Material streamMaterial = LoadAsset<Material>(k_StreamMaterialPath);
            Material leafMaterial = LoadAsset<Material>(k_LeafMaterialPath);
            InvestigationTargetSO waterTarget =
                LoadAsset<InvestigationTargetSO>(k_WaterTargetPath);
            GameObject root = new GameObject(k_RootName + "_Building");
            SceneManager.MoveGameObjectToScene(root, scene);
            root.transform.SetParent(props, false);

            try
            {
                BuildSink(root.transform, scene, sinkPrefab);
                BuildBasinVolume(root.transform, waterTarget);
                BuildStream(root.transform, streamMaterial);
                BuildStoredWater(root.transform, waterMaterial);
                BuildFallenLeaves(root.transform, leafMaterial);
            }
            catch
            {
                UnityEngine.Object.DestroyImmediate(root);
                throw;
            }

            RemoveExistingRoot(props);
            root.name = k_RootName;
        }

        public static void BuildFromCommandLine()
        {
            try
            {
                Build();
                EditorApplication.Exit(0);
            }
            catch (Exception exception)
            {
                Debug.LogException(exception);
                EditorApplication.Exit(1);
            }
        }

        private static Transform FindRoot(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == name)
                {
                    return roots[i].transform;
                }
            }

            throw new InvalidOperationException("Greenhouse scene has no root named " + name + ".");
        }

        private static void ThrowIfAnyOpenSceneIsDirty()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.isDirty)
                {
                    throw new InvalidOperationException(
                        "Rainwater build stopped because an open scene has unsaved changes: " + scene.path);
                }
            }
        }

        private static void RemoveExistingRoot(Transform props)
        {
            Transform existing = props.Find(k_RootName);

            if (existing != null)
            {
                UnityEngine.Object.DestroyImmediate(existing.gameObject);
            }
        }

        private static void BuildSink(Transform parent, Scene scene, GameObject prefab)
        {
            GameObject sink = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            sink.name = k_SinkName;
            sink.transform.SetParent(parent, false);
            sink.transform.SetPositionAndRotation(k_SinkPosition, Quaternion.Euler(0f, 90f, 0f));
            sink.transform.localScale = Vector3.one * k_SinkScale;
        }

        private static void BuildStream(Transform parent, Material water)
        {
            float length = k_StreamTop.y - k_StreamBottom.y;
            GameObject stream = GameObject.CreatePrimitive(PrimitiveType.Cylinder);
            stream.name = k_StreamName;
            stream.transform.SetParent(parent, false);
            stream.transform.position = (k_StreamTop + k_StreamBottom) * 0.5f;
            stream.transform.localScale = new Vector3(k_StreamRadius, length * 0.5f, k_StreamRadius);
            stream.GetComponent<Renderer>().sharedMaterial = water;
            UnityEngine.Object.DestroyImmediate(stream.GetComponent<Collider>());

            WaterFlow flow = stream.AddComponent<WaterFlow>();
            SerializedObject serialized = new SerializedObject(flow);
            serialized.FindProperty("m_speed").vector2Value = new Vector2(0f, -1.4f);
            SerializedProperty properties = serialized.FindProperty("m_textureProperties");
            properties.arraySize = 1;
            properties.GetArrayElementAtIndex(0).stringValue = k_StreamFlowProperty;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            // The sink is a stopped one: what is left in the basin is standing rainwater, not a
            // running tap. The stream is still built, fully set up, and switched off — turning it
            // back on is one checkbox, and rebuilding it from scratch would not be.
            stream.SetActive(false);
        }

        /// <summary>
        /// The basin interior, which is both the volume the pool and leaves sit in and the thing the
        /// player samples. The sampling interaction lives here rather than on the pool mesh because
        /// the pool is 24 cm deep and its top face is the only part in reach — a collider on the
        /// water would be a collider the player has to aim into the sink to find.
        /// </summary>
        private static void BuildBasinVolume(Transform parent, InvestigationTargetSO waterTarget)
        {
            GameObject basin = new GameObject(k_BasinVolumeName);
            basin.transform.SetParent(parent, false);
            basin.transform.position = k_BasinVolumePosition;
            basin.layer = ResolveInteractableLayer();
            BoxCollider volume = basin.AddComponent<BoxCollider>();
            volume.center = Vector3.zero;
            volume.size = k_BasinVolumeSize;
            volume.isTrigger = true;

            InvestigatableTarget investigatable = basin.AddComponent<InvestigatableTarget>();
            SerializedObject serialized = new SerializedObject(investigatable);
            serialized.FindProperty("m_target").objectReferenceValue = waterTarget;
            serialized.FindProperty("m_isInvestigable").boolValue = true;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static int ResolveInteractableLayer()
        {
            int layer = LayerMask.NameToLayer(k_InteractableLayer);

            if (layer < 0)
            {
                throw new InvalidOperationException(
                    $"The project has no '{k_InteractableLayer}' layer; the basin would never be "
                    + "offered.");
            }

            return layer;
        }

        /// <summary>
        /// Dead leaves floating on the standing water. They are what makes the basin read as
        /// stopped rather than merely turned off: still water alone looks like water that is about
        /// to be used, and litter on it does not.
        /// </summary>
        private static void BuildFallenLeaves(Transform parent, Material leafMaterial)
        {
            GameObject group = new GameObject(k_FallenLeavesName);
            group.transform.SetParent(parent, false);
            group.transform.position = new Vector3(k_BasinCenter.x, k_LeafY, k_BasinCenter.z);

            for (int i = 0; i < k_Leaves.Length; i++)
            {
                Vector4 leaf = k_Leaves[i];
                GameObject quad = GameObject.CreatePrimitive(PrimitiveType.Quad);
                quad.name = $"Leaf_{i:00}";
                quad.transform.SetParent(group.transform, false);
                quad.transform.position = new Vector3(leaf.x, k_LeafY, leaf.y);

                // Quads face +Z; lying one flat on the water is a quarter turn about X, and the
                // yaw after it is what keeps the seven from reading as a printed pattern.
                quad.transform.rotation = Quaternion.Euler(90f, leaf.z, 0f);

                // Leaves are longer than they are wide, and the long axis follows the yaw.
                quad.transform.localScale = new Vector3(leaf.w * 0.55f, leaf.w, 1f);
                quad.GetComponent<Renderer>().sharedMaterial = leafMaterial;
                UnityEngine.Object.DestroyImmediate(quad.GetComponent<Collider>());
            }
        }

        private static void BuildStoredWater(Transform parent, Material waterMaterial)
        {
            GameObject water = GameObject.CreatePrimitive(PrimitiveType.Cube);
            water.name = k_StoredWaterName;
            water.transform.SetParent(parent, false);
            water.transform.position = k_StoredWaterCenter;
            water.transform.localScale = k_StoredWaterSize;
            water.GetComponent<Renderer>().sharedMaterial = waterMaterial;
            UnityEngine.Object.DestroyImmediate(water.GetComponent<Collider>());
        }

        private static T LoadAsset<T>(string path) where T : UnityEngine.Object
        {
            T asset = AssetDatabase.LoadAssetAtPath<T>(path);

            if (asset == null)
            {
                throw new System.IO.FileNotFoundException("Rainwater dependency was not found: " + path);
            }

            return asset;
        }
    }
}

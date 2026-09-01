using System;
using RootsDance.App;
using RootsDance.Environment;
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
        private const string k_SinkPrefabPath =
            "Assets/RootsDance/Prefabs/Environment/LabFurniture/counter_counter_sink.prefab";
        private const string k_WaterMaterialPath = "Assets/RootsDance/VFX/VFX_StatueWater.mat";

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
            GameObject root = new GameObject(k_RootName + "_Building");
            SceneManager.MoveGameObjectToScene(root, scene);
            root.transform.SetParent(props, false);

            try
            {
                BuildSink(root.transform, scene, sinkPrefab);
                BuildBasinVolume(root.transform);
                BuildStream(root.transform, streamMaterial);
                BuildStoredWater(root.transform, waterMaterial);
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
        }

        private static void BuildBasinVolume(Transform parent)
        {
            GameObject basin = new GameObject(k_BasinVolumeName);
            basin.transform.SetParent(parent, false);
            basin.transform.position = k_BasinVolumePosition;
            BoxCollider volume = basin.AddComponent<BoxCollider>();
            volume.center = Vector3.zero;
            volume.size = k_BasinVolumeSize;
            volume.isTrigger = true;
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

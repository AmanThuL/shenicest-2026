using System;
using RootsDance.App;
using RootsDance.Environment;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>Adds the Chapter 03 roof runoff and collecting sink to the greenhouse interior.</summary>
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

        private static readonly Vector3 k_SinkPosition = new Vector3(-11.5f, 0f, 2.5f);
        private static readonly Vector3 k_StreamTop = new Vector3(-11.5f, 28.5f, 2.5f);
        private static readonly Vector3 k_StreamBottom = new Vector3(-11.5f, 1.62f, 2.5f);
        private static readonly Vector3 k_StoredWaterPosition = new Vector3(-11.5f, 1.58f, 2.5f);

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
                Debug.Log("GreenhouseRainwaterSinkBuilder: built roof runoff and stored rainwater.");
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
            GameObject root = new GameObject(k_RootName + "_Building");
            SceneManager.MoveGameObjectToScene(root, scene);
            root.transform.SetParent(props, false);

            try
            {
                BuildSink(root.transform, scene, sinkPrefab);
                BuildBasinVolume(root.transform);
                BuildStream(root.transform, waterMaterial);
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
            sink.transform.localScale = Vector3.one * 1.7f;
        }

        private static void BuildStream(Transform parent, Material water)
        {
            float length = k_StreamTop.y - k_StreamBottom.y;
            GameObject stream = GameObject.CreatePrimitive(PrimitiveType.Cylinder);
            stream.name = k_StreamName;
            stream.transform.SetParent(parent, false);
            stream.transform.position = (k_StreamTop + k_StreamBottom) * 0.5f;
            stream.transform.localScale = new Vector3(0.055f, length * 0.5f, 0.055f);
            stream.GetComponent<Renderer>().sharedMaterial = water;
            UnityEngine.Object.DestroyImmediate(stream.GetComponent<Collider>());

            WaterFlow flow = stream.AddComponent<WaterFlow>();
            SerializedObject serialized = new SerializedObject(flow);
            serialized.FindProperty("m_speed").vector2Value = new Vector2(0f, -1.4f);
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static void BuildBasinVolume(Transform parent)
        {
            GameObject basin = new GameObject(k_BasinVolumeName);
            basin.transform.SetParent(parent, false);
            basin.transform.position = k_StoredWaterPosition;
            BoxCollider volume = basin.AddComponent<BoxCollider>();
            volume.center = Vector3.zero;
            volume.size = new Vector3(0.65f, 0.12f, 0.8f);
            volume.isTrigger = true;
        }

        private static void BuildStoredWater(Transform parent, Material waterMaterial)
        {
            GameObject water = GameObject.CreatePrimitive(PrimitiveType.Cylinder);
            water.name = k_StoredWaterName;
            water.transform.SetParent(parent, false);
            water.transform.position = k_StoredWaterPosition;
            water.transform.localScale = new Vector3(0.42f, 0.012f, 0.52f);
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

using System;
using System.Linq;
using RootsDance.Data;
using RootsDance.Environment;
using RootsDance.Events;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>Places a black transition surface behind the lab exit, leading to the corridor entrance.</summary>
    public static class BriggsChapterHousePortalBuilder
    {
        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";
        private const string k_PrefabPath =
            "Assets/RootsDance/Prefabs/Environment/BriggsChapterHousePortal.prefab";
        private const string k_MaterialPath =
            "Assets/RootsDance/Materials/Environment/BriggsInterior/ChapterHousePortalBlack.mat";
        private const string k_PortalName = "BriggsChapterHousePortal";

        [MenuItem("RootsDance/Environment/Apply Briggs Chapter House Portal")]
        public static void Apply()
        {
            if (EditorApplication.isPlaying)
            {
                throw new InvalidOperationException("Stop Play mode before placing the portal.");
            }
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                if (SceneManager.GetSceneAt(i).isDirty)
                {
                    throw new InvalidOperationException("Save pending scene edits before placing the portal.");
                }
            }

            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();
            try
            {
                Scene scene = SceneManager.GetSceneByPath(k_GameplayPath);
                if (!scene.isLoaded)
                {
                    scene = EditorSceneManager.OpenScene(k_GameplayPath, OpenSceneMode.Additive);
                }
                PlaceInScene(scene);
                EditorSceneManager.MarkSceneDirty(scene);
                EditorSceneManager.SaveScene(scene);
            }
            finally
            {
                EditorSceneManager.RestoreSceneManagerSetup(setup);
            }
        }

        /// <summary>Also used by the door builder so rebuilding its visuals retains the transition.</summary>
        public static void PlaceInScene(Scene scene)
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(
                "Assets/RootsDance/Data/Levels/ChapterHouseInterior.asset");
            LevelEventChannelSO channel = AssetDatabase.LoadAssetAtPath<LevelEventChannelSO>(
                "Assets/RootsDance/Data/Events/LoadLevelRequested.asset");
            int triggerLayer = LayerMask.NameToLayer("TriggerVolume");
            if (level == null || channel == null || triggerLayer < 0)
            {
                throw new InvalidOperationException("The corridor level, load channel and trigger layer are required.");
            }

            Material black = EnsureBlackMaterial();
            Scene preview = EditorSceneManager.NewPreviewScene();
            GameObject prefab;
            try
            {
                var root = new GameObject(k_PortalName);
                SceneManager.MoveGameObjectToScene(root, preview);
                root.layer = triggerLayer;
                BoxCollider trigger = root.AddComponent<BoxCollider>();
                // The probe has a 0.45 m radius. Its front cannot reach this volume through the
                // closed door (back face Z 7.29); it enters only after the player crosses the doorway.
                trigger.center = new Vector3(0f, 2.25f, 0.15f);
                trigger.size = new Vector3(4.4f, 4.5f, 0.4f);
                trigger.isTrigger = true;
                root.AddComponent<LevelPortal>().Configure(channel, level);

                GameObject surface = GameObject.CreatePrimitive(PrimitiveType.Cube);
                surface.name = "BlackTransitionSurface";
                surface.transform.SetParent(root.transform, false);
                surface.transform.localPosition = new Vector3(0f, 2.25f, 0f);
                surface.transform.localScale = new Vector3(6f, 5.5f, 0.08f);
                UnityEngine.Object.DestroyImmediate(surface.GetComponent<Collider>());
                MeshRenderer renderer = surface.GetComponent<MeshRenderer>();
                renderer.sharedMaterial = black;
                renderer.shadowCastingMode = ShadowCastingMode.Off;
                renderer.receiveShadows = false;
                prefab = PrefabUtility.SaveAsPrefabAsset(root, k_PrefabPath);
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(preview);
            }

            Transform triggers = scene.GetRootGameObjects().Single(root => root.name == "_Triggers").transform;
            Transform existing = triggers.Find(k_PortalName);
            if (existing != null)
            {
                UnityEngine.Object.DestroyImmediate(existing.gameObject);
            }
            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            instance.transform.SetParent(triggers, false);
            instance.transform.position = new Vector3(0f, 0f, 7.5f);
            PrefabUtility.RecordPrefabInstancePropertyModifications(instance.transform);
        }

        internal static Material EnsureBlackMaterial()
        {
            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_MaterialPath);
            if (material == null)
            {
                Shader shader = Shader.Find("HDRP/Unlit");
                if (shader == null)
                {
                    throw new InvalidOperationException("HDRP/Unlit is required for the black portal surface.");
                }
                material = new Material(shader) { name = "ChapterHousePortalBlack" };
                AssetDatabase.CreateAsset(material, k_MaterialPath);
            }
            material.SetColor("_UnlitColor", Color.black);
            material.SetColor("_EmissiveColor", Color.black);
            // Alpha remains one. The transparent pass lets this surface opt out of atmospheric
            // fog, which would otherwise paint the black doorway green under the laboratory fog.
            HDMaterial.SetSurfaceType(material, true);
            material.SetFloat("_EnableFogOnTransparent", 0f);
            material.SetFloat("_TransparentZWrite", 1f);
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            AssetDatabase.SaveAssetIfDirty(material);
            return material;
        }
    }
}

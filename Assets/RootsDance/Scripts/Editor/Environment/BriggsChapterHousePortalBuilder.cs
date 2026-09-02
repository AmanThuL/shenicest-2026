using System;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>Removes the retired teleport while retaining the shared black material for other exits.</summary>
    public static class BriggsChapterHousePortalBuilder
    {
        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";
        private const string k_MaterialPath =
            "Assets/RootsDance/Materials/Environment/BriggsInterior/ChapterHousePortalBlack.mat";

        [MenuItem("RootsDance/Environment/Remove Legacy Briggs Chapter House Portal")]
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

        /// <summary>Migration hook retained for old callers; the connection is now physical.</summary>
        public static void PlaceInScene(Scene scene)
        {
            ChapterHouseConnectedLevelBuilder.RemoveLegacyPortal(scene);
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

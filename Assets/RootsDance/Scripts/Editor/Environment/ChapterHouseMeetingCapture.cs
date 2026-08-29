using System;
using System.IO;
using RootsDance.App;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Renders the first meeting from the player's eye without entering Play: what the walk up the
    /// catwalk looks like, and what the sprite looks like once they are standing in front of her.
    /// <para>
    /// It exists because scale is the one thing that cannot be argued about from numbers. The
    /// scenes are opened, read and closed — never saved — and the temporary camera is destroyed.
    /// </para>
    /// </summary>
    public static class ChapterHouseMeetingCapture
    {
        private const string k_OutputFolder = "Logs/Captures/ChapterHouseMeeting";
        private const int k_Width = 1280;
        private const int k_Height = 720;

        /// <summary>Where the player's eye sits above the transform of a 1.8 m capsule.</summary>
        private const float k_EyeOffset = 0.72f;

        [MenuItem("RootsDance/Environment/Capture Chapter House Meeting")]
        public static void CaptureFromMenu()
        {
            Capture();
        }

        public static void CaptureFromCommandLine()
        {
            try
            {
                Capture();
                EditorApplication.Exit(0);
            }
            catch (Exception exception)
            {
                Debug.LogException(exception);
                EditorApplication.Exit(1);
            }
        }

        public static void Capture()
        {
            Directory.CreateDirectory(k_OutputFolder);
            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();
            Scene environment = EditorSceneManager.OpenScene(
                ScenePaths.k_ChapterHouseInteriorEnvironment, OpenSceneMode.Single);
            Scene gameplay = EditorSceneManager.OpenScene(
                ScenePaths.k_ChapterHouseInteriorGameplay, OpenSceneMode.Additive);

            GameObject cameraObject = null;

            try
            {
                Vector3 spawn = Find(gameplay, "_Spawns", "PlayerSpawn").position;
                Transform sprite = Find(gameplay, "_Narrative", "FlowerSprite");
                Vector3 eye = spawn + Vector3.up * k_EyeOffset;
                Vector3 head = sprite.position + Vector3.up * SpriteHeight(sprite) * 0.8f;

                cameraObject = new GameObject("MeetingCapture");
                Camera camera = cameraObject.AddComponent<Camera>();
                camera.fieldOfView = 60f;
                camera.nearClipPlane = 0.05f;
                camera.farClipPlane = 200f;

                Shoot(camera, eye, head, k_OutputFolder + "/01_walking_up.png");

                // Standing in front of her, where the trigger fires.
                Vector3 close = sprite.position - sprite.forward * 1.8f + Vector3.up * k_EyeOffset
                    + Vector3.up * (spawn.y - sprite.position.y);
                Shoot(camera, close, head, k_OutputFolder + "/02_face_to_face.png");

                Debug.Log($"[ChapterHouseMeeting] sprite is {SpriteHeight(sprite):F2} m tall at "
                    + $"{sprite.position}, player eye at {eye}. Captures in {k_OutputFolder}.");
            }
            finally
            {
                if (cameraObject != null)
                {
                    UnityEngine.Object.DestroyImmediate(cameraObject);
                }

                EditorSceneManager.CloseScene(gameplay, true);

                if (originalSetup.Length > 0)
                {
                    EditorSceneManager.RestoreSceneManagerSetup(originalSetup);
                }
            }
        }

        private static void Shoot(Camera camera, Vector3 from, Vector3 lookAt, string path)
        {
            camera.transform.position = from;
            camera.transform.rotation = Quaternion.LookRotation((lookAt - from).normalized, Vector3.up);

            RenderTexture target = new RenderTexture(k_Width, k_Height, 24, RenderTextureFormat.ARGB32);
            RenderTexture previous = RenderTexture.active;
            Texture2D readback = new Texture2D(k_Width, k_Height, TextureFormat.RGB24, false);

            try
            {
                camera.targetTexture = target;
                camera.Render();
                RenderTexture.active = target;
                readback.ReadPixels(new Rect(0f, 0f, k_Width, k_Height), 0, 0);
                readback.Apply();
                File.WriteAllBytes(path, readback.EncodeToPNG());
            }
            finally
            {
                camera.targetTexture = null;
                RenderTexture.active = previous;
                UnityEngine.Object.DestroyImmediate(readback);
                target.Release();
                UnityEngine.Object.DestroyImmediate(target);
            }
        }

        private static float SpriteHeight(Transform sprite)
        {
            Renderer[] renderers = sprite.GetComponentsInChildren<Renderer>(true);

            if (renderers.Length == 0)
            {
                return 1f;
            }

            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds.size.y;
        }

        private static Transform Find(Scene scene, string rootName, string childName)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name != rootName)
                {
                    continue;
                }

                Transform child = roots[i].transform.Find(childName);

                if (child == null)
                {
                    throw new InvalidOperationException(rootName + " has no child " + childName);
                }

                return child;
            }

            throw new InvalidOperationException(scene.name + " has no root " + rootName);
        }
    }
}

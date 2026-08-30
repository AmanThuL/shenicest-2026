using RootsDance.Editor.Terrain;
using RootsDance.Environment;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Builds the two placeholder particle prefabs of the opening (contamination motes, anomalous spores) and
    /// their HDRP/Unlit emissive materials, textured with the CC0 Kenney soft-particle sprites under
    /// <c>Assets/ThirdParty/VFX/KenneyParticlePack/</c>. Placeholders: HDRP/Unlit ignores particle vertex
    /// colour, so the fade is size-over-lifetime; the VFX pass replaces these with proper Shader Graph particles.
    /// Materials and prefabs are generated assets: every build re-applies the recipe below to them (the same
    /// path keeps their GUIDs, so scene instances survive) — tune the recipe, not the .mat/.prefab.
    /// </summary>
    public static class OpeningVfxPrefabBuilder
    {
        private const string k_LogPrefix = "OpeningVfxPrefabBuilder";
        private const string k_PrefabFolder = "Assets/RootsDance/Prefabs/VFX";
        private const string k_MaterialFolder = "Assets/RootsDance/VFX";
        private const string k_TextureFolder = "Assets/ThirdParty/VFX/KenneyParticlePack";
        private const string k_UnlitShader = "HDRP/Unlit";
        private static readonly int k_UnlitColorId = Shader.PropertyToID("_UnlitColor");
        private static readonly int k_UnlitColorMapId = Shader.PropertyToID("_UnlitColorMap");
        private static readonly int k_EmissiveColorMapId = Shader.PropertyToID("_EmissiveColorMap");

        private sealed class Recipe
        {
            public string Name;
            /// <summary>Sprite file name inside <see cref="k_TextureFolder"/>; its alpha shapes the particle.</summary>
            public string TextureFile;
            public Color BaseColor;
            public float EmissiveNits;
            public float LifetimeMin;
            public float LifetimeMax;
            public float SizeMin;
            public float SizeMax;
            public float Speed;
            public float NoiseStrength;
            public int MaxParticles;
        }

        private static Recipe RecipeFor(OpeningVfxKind kind)
        {
            switch (kind)
            {
                case OpeningVfxKind.AnomalousSpores:
                    return new Recipe
                    {
                        Name = "AnomalousSpores", TextureFile = "circle_05.png",
                        BaseColor = new Color(0.32f, 0.43f, 0.12f, 0.62f), EmissiveNits = 1500f,
                        LifetimeMin = 10f, LifetimeMax = 18f, SizeMin = 0.08f, SizeMax = 0.16f,
                        Speed = 0.08f, NoiseStrength = 0.18f, MaxParticles = 120,
                    };
                default:
                    return new Recipe
                    {
                        Name = "ContaminationMotes", TextureFile = "circle_05.png",
                        BaseColor = new Color(0.55f, 0.45f, 0.16f, 0.65f), EmissiveNits = 1200f,
                        LifetimeMin = 8f, LifetimeMax = 14f, SizeMin = 0.05f, SizeMax = 0.12f,
                        Speed = 0.04f, NoiseStrength = 0.12f, MaxParticles = 260,
                    };
            }
        }

        public static string PrefabPath(OpeningVfxKind kind)
        {
            return $"{k_PrefabFolder}/{RecipeFor(kind).Name}.prefab";
        }

        public static string MaterialPath(OpeningVfxKind kind)
        {
            return $"{k_MaterialFolder}/VFX_{RecipeFor(kind).Name}.mat";
        }

        public static string TexturePath(OpeningVfxKind kind)
        {
            return $"{k_TextureFolder}/{RecipeFor(kind).TextureFile}";
        }

        /// <summary>
        /// Returns the prefab asset for <paramref name="kind"/>, creating material and prefab when missing and
        /// re-applying the recipe to both when they exist. Returns null after logging on failure.
        /// </summary>
        public static GameObject EnsurePrefab(OpeningVfxKind kind)
        {
            Material material = EnsureMaterial(kind);

            if (material == null)
            {
                return null;
            }

            Recipe recipe = RecipeFor(kind);
            string path = PrefabPath(kind);
            GameObject existing = AssetDatabase.LoadAssetAtPath<GameObject>(path);

            if (existing != null)
            {
                return ReapplyPrefab(existing, path, recipe, material);
            }

            TerrainSceneUtility.EnsureFolder(k_PrefabFolder);
            Scene preview = EditorSceneManager.NewPreviewScene();

            try
            {
                GameObject root = new GameObject(recipe.Name);
                SceneManager.MoveGameObjectToScene(root, preview);
                ConfigureParticles(root.AddComponent<ParticleSystem>(), recipe, material);

                bool saved;
                GameObject prefab = PrefabUtility.SaveAsPrefabAsset(root, path, out saved);

                if (!saved)
                {
                    Debug.LogError($"{k_LogPrefix}: SaveAsPrefabAsset failed for '{path}'.");
                    return null;
                }

                Debug.Log($"{k_LogPrefix}: created {path}.");
                return prefab;
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(preview);
            }
        }

        private static GameObject ReapplyPrefab(GameObject existing, string path, Recipe recipe, Material material)
        {
            GameObject contents = PrefabUtility.LoadPrefabContents(path);

            try
            {
                ParticleSystem system = contents.GetComponent<ParticleSystem>();

                if (system == null)
                {
                    system = contents.AddComponent<ParticleSystem>();
                }

                ConfigureParticles(system, recipe, material);

                // The nits above are authored for the day look's EV 12.5; the follower rescales the emissive
                // to whatever fixed exposure the Volume stack asks for, so the motes survive the night.
                if (contents.GetComponent<EmissiveExposureFollower>() == null)
                {
                    contents.AddComponent<EmissiveExposureFollower>();
                }

                bool saved;
                GameObject prefab = PrefabUtility.SaveAsPrefabAsset(contents, path, out saved);

                if (!saved)
                {
                    Debug.LogError($"{k_LogPrefix}: SaveAsPrefabAsset failed while re-applying '{path}'.");
                    return existing;
                }

                Debug.Log($"{k_LogPrefix}: re-applied the recipe to {path}.");
                return prefab;
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(contents);
            }
        }

        private static Material EnsureMaterial(OpeningVfxKind kind)
        {
            Recipe recipe = RecipeFor(kind);
            string texturePath = TexturePath(kind);
            Texture2D texture = AssetDatabase.LoadAssetAtPath<Texture2D>(texturePath);

            if (texture == null)
            {
                Debug.LogError($"{k_LogPrefix}: particle sprite '{texturePath}' not found "
                    + "(see the folder's SOURCE.md).");
                return null;
            }

            string path = MaterialPath(kind);
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);
            bool created = false;

            if (material == null)
            {
                Shader shader = Shader.Find(k_UnlitShader);

                if (shader == null)
                {
                    Debug.LogError($"{k_LogPrefix}: shader '{k_UnlitShader}' not found.");
                    return null;
                }

                TerrainSceneUtility.EnsureFolder(k_MaterialFolder);
                material = new Material(shader);
                created = true;
            }

            HDMaterial.SetSurfaceType(material, true);
            material.SetColor(k_UnlitColorId, recipe.BaseColor);
            material.SetTexture(k_UnlitColorMapId, texture);
            material.SetTexture(k_EmissiveColorMapId, texture);
            HDMaterial.SetUseEmissiveIntensity(material, true);
            HDMaterial.SetEmissiveColor(material, recipe.BaseColor);
            HDMaterial.SetEmissiveIntensity(material, recipe.EmissiveNits, EmissiveIntensityUnit.Nits);
            HDMaterial.ValidateMaterial(material);

            if (created)
            {
                AssetDatabase.CreateAsset(material, path);
                Debug.Log($"{k_LogPrefix}: created {path}.");
            }
            else
            {
                EditorUtility.SetDirty(material);
            }

            return material;
        }

        private static void ConfigureParticles(ParticleSystem system, Recipe recipe, Material material)
        {
            ParticleSystem.MainModule main = system.main;
            main.loop = true;
            main.prewarm = true;
            main.playOnAwake = true;
            main.scalingMode = ParticleSystemScalingMode.Shape;
            main.simulationSpace = ParticleSystemSimulationSpace.World;
            main.startLifetime = new ParticleSystem.MinMaxCurve(recipe.LifetimeMin, recipe.LifetimeMax);
            main.startSize = new ParticleSystem.MinMaxCurve(recipe.SizeMin, recipe.SizeMax);
            main.startSpeed = recipe.Speed;
            main.startColor = Color.white;
            main.gravityModifier = 0f;
            main.maxParticles = recipe.MaxParticles;

            ParticleSystem.EmissionModule emission = system.emission;
            emission.enabled = true;
            emission.rateOverTime = 2f;

            ParticleSystem.ShapeModule shape = system.shape;
            shape.enabled = true;
            shape.shapeType = ParticleSystemShapeType.Box;
            shape.scale = Vector3.one;
            shape.randomDirectionAmount = 1f;

            ParticleSystem.NoiseModule noise = system.noise;
            noise.enabled = true;
            noise.strength = recipe.NoiseStrength;
            noise.frequency = 0.3f;
            noise.scrollSpeed = 0.2f;
            noise.damping = true;

            ParticleSystem.SizeOverLifetimeModule sizeOverLifetime = system.sizeOverLifetime;
            sizeOverLifetime.enabled = true;
            AnimationCurve fade = new AnimationCurve(
                new Keyframe(0f, 0f), new Keyframe(0.2f, 1f), new Keyframe(0.8f, 1f), new Keyframe(1f, 0f));
            sizeOverLifetime.size = new ParticleSystem.MinMaxCurve(1f, fade);

            ParticleSystemRenderer renderer = system.GetComponent<ParticleSystemRenderer>();
            renderer.renderMode = ParticleSystemRenderMode.Billboard;
            renderer.sharedMaterial = material;
            renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
            renderer.receiveShadows = false;
        }
    }
}

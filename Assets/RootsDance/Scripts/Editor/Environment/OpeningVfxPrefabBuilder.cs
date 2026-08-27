using RootsDance.Editor.Terrain;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Builds the two placeholder particle prefabs of the opening (contamination motes, anomalous spores) and
    /// their HDRP/Unlit emissive materials. Placeholders: HDRP/Unlit ignores particle vertex colour, so the
    /// fade is size-over-lifetime; the VFX pass replaces these with proper Shader Graph particles. Materials and
    /// prefabs are create-once (see <see cref="EnsurePrefab"/>): changing a recipe here does nothing to an
    /// already-built asset — delete the generated material/prefab by hand, or use an explicit overwrite entry
    /// (not implemented here) to pick up the new values.
    /// </summary>
    public static class OpeningVfxPrefabBuilder
    {
        private const string k_LogPrefix = "OpeningVfxPrefabBuilder";
        private const string k_PrefabFolder = "Assets/RootsDance/Prefabs/VFX";
        private const string k_MaterialFolder = "Assets/RootsDance/VFX";
        private const string k_UnlitShader = "HDRP/Unlit";
        private static readonly int k_UnlitColorId = Shader.PropertyToID("_UnlitColor");

        private sealed class Recipe
        {
            public string Name;
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
                        Name = "AnomalousSpores", BaseColor = new Color(0.75f, 0.95f, 0.80f, 0.9f),
                        EmissiveNits = 3000f, LifetimeMin = 8f, LifetimeMax = 14f, SizeMin = 0.06f, SizeMax = 0.10f,
                        Speed = 0.10f, NoiseStrength = 0.25f, MaxParticles = 40,
                    };
                default:
                    return new Recipe
                    {
                        Name = "ContaminationMotes", BaseColor = new Color(0.90f, 0.85f, 0.55f, 0.85f),
                        EmissiveNits = 2000f, LifetimeMin = 6f, LifetimeMax = 10f, SizeMin = 0.04f, SizeMax = 0.08f,
                        Speed = 0.05f, NoiseStrength = 0.15f, MaxParticles = 80,
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

        /// <summary>Returns the existing prefab asset, or builds material + prefab and returns the new asset.</summary>
        public static GameObject EnsurePrefab(OpeningVfxKind kind)
        {
            string path = PrefabPath(kind);
            GameObject existing = AssetDatabase.LoadAssetAtPath<GameObject>(path);

            if (existing != null)
            {
                return existing;
            }

            Material material = EnsureMaterial(kind);

            if (material == null)
            {
                return null;
            }

            Recipe recipe = RecipeFor(kind);
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

        private static Material EnsureMaterial(OpeningVfxKind kind)
        {
            string path = MaterialPath(kind);
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material != null)
            {
                return material;
            }

            Shader shader = Shader.Find(k_UnlitShader);

            if (shader == null)
            {
                Debug.LogError($"{k_LogPrefix}: shader '{k_UnlitShader}' not found.");
                return null;
            }

            Recipe recipe = RecipeFor(kind);
            TerrainSceneUtility.EnsureFolder(k_MaterialFolder);
            material = new Material(shader);
            HDMaterial.SetSurfaceType(material, true);
            material.SetColor(k_UnlitColorId, recipe.BaseColor);
            HDMaterial.SetUseEmissiveIntensity(material, true);
            HDMaterial.SetEmissiveColor(material, recipe.BaseColor);
            HDMaterial.SetEmissiveIntensity(material, recipe.EmissiveNits, EmissiveIntensityUnit.Nits);
            HDMaterial.ValidateMaterial(material);
            AssetDatabase.CreateAsset(material, path);
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

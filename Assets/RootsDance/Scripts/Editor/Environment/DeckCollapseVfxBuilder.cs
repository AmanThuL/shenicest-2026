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
    /// Builds the two dust prefabs the deck collapse switches on, and hangs them under
    /// <c>_StairCollapse</c> in GreenhouseInterior_Environment_2 wired into
    /// <see cref="GreenhouseStairCollapse"/>'s effect slots.
    /// <list type="bullet">
    /// <item><b>DeckWarningDust</b> — the deck under strain: a thin sift of dust and grit falling from
    /// the underside of the ring, looping for as long as the warning lasts.</item>
    /// <item><b>DeckCollapseDust</b> — the deck going: a cloud bursting at deck height and rolling out
    /// along the floor as the rubble lands, one shot.</item>
    /// </list>
    /// Same recipe as the opening VFX: Kenney sprites on an HDRP/Unlit transparent material with
    /// an emissive floor so the dust reads under the scene's exposure. Sized from the rig's own
    /// mesh bounds, so it lands on the deck wherever the deck ends up.
    /// </summary>
    public static class DeckCollapseVfxBuilder
    {
        private const string k_LogPrefix = "DeckCollapseVfxBuilder";
        private const string k_PrefabFolder = "Assets/RootsDance/Prefabs/VFX";
        private const string k_MaterialFolder = "Assets/RootsDance/VFX";
        private const string k_TextureFolder = "Assets/ThirdParty/VFX/KenneyParticlePack";
        private const string k_UnlitShader = "HDRP/Unlit";
        private const string k_ScenePath =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Environment_2.unity";
        private const string k_RigRootName = "_StairCollapse";
        private const string k_WarningName = "DeckWarningDust";
        private const string k_CollapseName = "DeckCollapseDust";

        private static readonly int k_UnlitColorId = Shader.PropertyToID("_UnlitColor");
        private static readonly int k_UnlitColorMapId = Shader.PropertyToID("_UnlitColorMap");
        private static readonly int k_EmissiveColorMapId = Shader.PropertyToID("_EmissiveColorMap");

        [MenuItem("RootsDance/Environment/Build Deck Collapse VFX")]
        public static void BuildFromMenu()
        {
            Build();
        }

        /// <summary>Materials, prefabs, and the scene wiring. Idempotent.</summary>
        public static bool Build()
        {
            Material dust = EnsureMaterial("VFX_DeckDust", "smoke_01.png", new Color(0.62f, 0.56f, 0.46f, 0.55f), 900f);
            Material grit = EnsureMaterial("VFX_DeckGrit", "dirt_01.png", new Color(0.30f, 0.26f, 0.22f, 0.95f), 400f);

            if (dust == null || grit == null)
            {
                return false;
            }

            GameObject warningPrefab = EnsurePrefab(k_WarningName, root => ConfigureWarning(root, dust, grit));
            GameObject collapsePrefab = EnsurePrefab(k_CollapseName, root => ConfigureCollapse(root, dust, grit));

            if (warningPrefab == null || collapsePrefab == null)
            {
                return false;
            }

            return Wire(warningPrefab, collapsePrefab);
        }

        // ---- materials ------------------------------------------------------------------------

        private static Material EnsureMaterial(string name, string textureFile, Color color, float nits)
        {
            string texturePath = k_TextureFolder + "/" + textureFile;
            Texture2D texture = AssetDatabase.LoadAssetAtPath<Texture2D>(texturePath);

            if (texture == null)
            {
                Debug.LogError($"{k_LogPrefix}: particle sprite '{texturePath}' not found (see the folder's SOURCE.md).");
                return null;
            }

            string path = $"{k_MaterialFolder}/{name}.mat";
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
            material.SetColor(k_UnlitColorId, color);
            material.SetTexture(k_UnlitColorMapId, texture);
            material.SetTexture(k_EmissiveColorMapId, texture);
            HDMaterial.SetUseEmissiveIntensity(material, true);
            HDMaterial.SetEmissiveColor(material, new Color(color.r, color.g, color.b, 1f));
            HDMaterial.SetEmissiveIntensity(material, nits, EmissiveIntensityUnit.Nits);
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

        // ---- prefabs --------------------------------------------------------------------------

        private static GameObject EnsurePrefab(string name, System.Action<GameObject> configure)
        {
            TerrainSceneUtility.EnsureFolder(k_PrefabFolder);
            string path = $"{k_PrefabFolder}/{name}.prefab";
            GameObject root = new GameObject(name);

            try
            {
                configure(root);
                bool saved;
                GameObject prefab = PrefabUtility.SaveAsPrefabAsset(root, path, out saved);

                if (!saved || prefab == null)
                {
                    Debug.LogError($"{k_LogPrefix}: SaveAsPrefabAsset failed for '{path}'.");
                    return null;
                }

                Debug.Log($"{k_LogPrefix}: wrote {path}.");
                return prefab;
            }
            finally
            {
                Object.DestroyImmediate(root);
            }
        }

        /// <summary>Dust sifting down from the underside of the ring, plus the odd bit of grit. Loops.</summary>
        private static void ConfigureWarning(GameObject root, Material dust, Material grit)
        {
            ParticleSystem sift = Child(root, "Sift").AddComponent<ParticleSystem>();
            Configure(sift, dust, loop: true, duration: 4f, lifetime: (2.5f, 4.5f), size: (0.5f, 1.2f),
                speed: 0.15f, gravity: 0.03f, rate: 14f, burst: 0, maxParticles: 120, box: new Vector3(14f, 0.3f, 14f),
                growTo: 1.8f, alphaPeak: 0.35f, noise: 0.25f, stretch: false);

            ParticleSystem crumbs = Child(root, "Grit").AddComponent<ParticleSystem>();
            Configure(crumbs, grit, loop: true, duration: 4f, lifetime: (1.6f, 2.4f), size: (0.03f, 0.09f),
                speed: 0.2f, gravity: 1f, rate: 5f, burst: 0, maxParticles: 40, box: new Vector3(13f, 0.2f, 13f),
                growTo: 1f, alphaPeak: 1f, noise: 0f, stretch: true);
        }

        /// <summary>A cloud at deck height, then dust rolling along the floor as the rubble lands. One shot.</summary>
        private static void ConfigureCollapse(GameObject root, Material dust, Material grit)
        {
            ParticleSystem cloud = Child(root, "Cloud").AddComponent<ParticleSystem>();
            Configure(cloud, dust, loop: false, duration: 9f, lifetime: (4f, 7f), size: (2f, 4.5f),
                speed: 0.8f, gravity: -0.01f, rate: 18f, burst: 50, maxParticles: 260, box: new Vector3(14f, 1.5f, 14f),
                growTo: 2.2f, alphaPeak: 0.55f, noise: 0.5f, stretch: false);

            ParticleSystem floor = Child(root, "Floor").AddComponent<ParticleSystem>();
            Configure(floor, dust, loop: false, duration: 10f, lifetime: (3f, 6f), size: (1.5f, 3.5f),
                speed: 1.2f, gravity: 0.02f, rate: 30f, burst: 0, maxParticles: 320, box: new Vector3(18f, 0.6f, 18f),
                growTo: 2.5f, alphaPeak: 0.5f, noise: 0.35f, stretch: false);

            ParticleSystem spray = Child(root, "Grit").AddComponent<ParticleSystem>();
            Configure(spray, grit, loop: false, duration: 8f, lifetime: (1.5f, 3f), size: (0.04f, 0.12f),
                speed: 3.5f, gravity: 1.2f, rate: 40f, burst: 80, maxParticles: 400, box: new Vector3(12f, 1f, 12f),
                growTo: 1f, alphaPeak: 1f, noise: 0f, stretch: true);
        }

        private static GameObject Child(GameObject root, string name)
        {
            GameObject child = new GameObject(name);
            child.transform.SetParent(root.transform, false);
            return child;
        }

        private static void Configure(ParticleSystem system, Material material, bool loop, float duration,
            (float, float) lifetime, (float, float) size, float speed, float gravity, float rate, int burst,
            int maxParticles, Vector3 box, float growTo, float alphaPeak, float noise, bool stretch)
        {
            ParticleSystem.MainModule main = system.main;
            main.loop = loop;
            main.prewarm = loop;
            main.playOnAwake = true;
            main.duration = duration;
            main.scalingMode = ParticleSystemScalingMode.Shape;
            main.simulationSpace = ParticleSystemSimulationSpace.World;
            main.startLifetime = new ParticleSystem.MinMaxCurve(lifetime.Item1, lifetime.Item2);
            main.startSize = new ParticleSystem.MinMaxCurve(size.Item1, size.Item2);
            main.startSpeed = speed;
            main.startRotation = new ParticleSystem.MinMaxCurve(0f, Mathf.PI * 2f);
            main.startColor = Color.white;
            main.gravityModifier = gravity;
            main.maxParticles = maxParticles;

            ParticleSystem.EmissionModule emission = system.emission;
            emission.enabled = true;
            emission.rateOverTime = rate;

            if (burst > 0)
            {
                emission.SetBursts(new[] { new ParticleSystem.Burst(0f, (short)burst) });
            }

            ParticleSystem.ShapeModule shape = system.shape;
            shape.enabled = true;
            shape.shapeType = ParticleSystemShapeType.Box;
            shape.scale = box;
            shape.randomDirectionAmount = 1f;

            ParticleSystem.NoiseModule noiseModule = system.noise;
            noiseModule.enabled = noise > 0f;
            noiseModule.strength = noise;
            noiseModule.frequency = 0.25f;
            noiseModule.scrollSpeed = 0.3f;
            noiseModule.damping = true;

            ParticleSystem.SizeOverLifetimeModule sizeOverLifetime = system.sizeOverLifetime;
            sizeOverLifetime.enabled = true;
            sizeOverLifetime.size = new ParticleSystem.MinMaxCurve(1f,
                new AnimationCurve(new Keyframe(0f, 0.6f), new Keyframe(1f, growTo)));

            ParticleSystem.ColorOverLifetimeModule colorOverLifetime = system.colorOverLifetime;
            colorOverLifetime.enabled = true;
            Gradient gradient = new Gradient();
            gradient.SetKeys(
                new[] { new GradientColorKey(Color.white, 0f), new GradientColorKey(Color.white, 1f) },
                new[]
                {
                    new GradientAlphaKey(0f, 0f), new GradientAlphaKey(alphaPeak, 0.15f),
                    new GradientAlphaKey(alphaPeak, 0.6f), new GradientAlphaKey(0f, 1f)
                });
            colorOverLifetime.color = gradient;

            ParticleSystem.RotationOverLifetimeModule spin = system.rotationOverLifetime;
            spin.enabled = !stretch;
            spin.z = new ParticleSystem.MinMaxCurve(-0.3f, 0.3f);

            ParticleSystemRenderer renderer = system.GetComponent<ParticleSystemRenderer>();
            renderer.renderMode = stretch ? ParticleSystemRenderMode.Stretch : ParticleSystemRenderMode.Billboard;
            renderer.lengthScale = stretch ? 2.5f : 1f;
            renderer.sharedMaterial = material;
            renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
            renderer.receiveShadows = false;
            renderer.sortingFudge = 0f;
        }

        // ---- scene wiring ---------------------------------------------------------------------

        private static bool Wire(GameObject warningPrefab, GameObject collapsePrefab)
        {
            Scene scene = SceneManager.GetSceneByPath(k_ScenePath);

            if (!scene.IsValid() || !scene.isLoaded)
            {
                Debug.LogError($"{k_LogPrefix}: open {k_ScenePath} (additively is fine) and run again.");
                return false;
            }

            GameObject rigRoot = null;

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == k_RigRootName)
                {
                    rigRoot = root;
                    break;
                }
            }

            GreenhouseStairCollapse collapse = rigRoot != null ? rigRoot.GetComponentInChildren<GreenhouseStairCollapse>(true) : null;

            if (collapse == null)
            {
                Debug.LogError($"{k_LogPrefix}: no '{k_RigRootName}' with a GreenhouseStairCollapse in {scene.name}.");
                return false;
            }

            // Deck ring and floor, from the rig's own mesh bounds: the renderers may be inactive.
            Bounds bounds = MeshBounds(rigRoot);
            Vector3 deckTop = new Vector3(bounds.center.x, bounds.max.y - 0.2f, bounds.center.z);
            Vector3 floor = new Vector3(bounds.center.x, bounds.min.y + 0.3f, bounds.center.z);

            GameObject warning = EnsureInstance(rigRoot.transform, warningPrefab, k_WarningName);
            warning.transform.SetPositionAndRotation(deckTop - Vector3.up * 0.4f, Quaternion.identity);
            warning.SetActive(false);

            GameObject collapseFx = EnsureInstance(rigRoot.transform, collapsePrefab, k_CollapseName);
            collapseFx.transform.SetPositionAndRotation(deckTop, Quaternion.identity);
            Transform floorSystem = collapseFx.transform.Find("Floor");

            if (floorSystem != null)
            {
                floorSystem.position = floor;
            }

            collapseFx.SetActive(false);

            using (SerializedObject serialized = new SerializedObject(collapse))
            {
                SetSingle(serialized.FindProperty("m_warningEffects"), warning);
                SetSingle(serialized.FindProperty("m_collapseEffects"), collapseFx);
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            Debug.Log($"{k_LogPrefix}: wired {k_WarningName} at {warning.transform.position:F1} and "
                + $"{k_CollapseName} at {collapseFx.transform.position:F1} (floor {floor:F1}) into {scene.name}.");
            return true;
        }

        private static GameObject EnsureInstance(Transform parent, GameObject prefab, string name)
        {
            Transform existing = parent.Find(name);

            if (existing != null)
            {
                Object.DestroyImmediate(existing.gameObject);
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, parent.gameObject.scene);
            instance.name = name;
            instance.transform.SetParent(parent, true);
            return instance;
        }

        private static void SetSingle(SerializedProperty array, GameObject value)
        {
            array.arraySize = 1;
            array.GetArrayElementAtIndex(0).objectReferenceValue = value;
        }

        private static Bounds MeshBounds(GameObject root)
        {
            MeshFilter[] filters = root.GetComponentsInChildren<MeshFilter>(true);
            bool any = false;
            Bounds bounds = new Bounds(root.transform.position, Vector3.zero);

            foreach (MeshFilter filter in filters)
            {
                if (filter.sharedMesh == null || filter.name.StartsWith("Deck"))
                {
                    continue;
                }

                Bounds local = filter.sharedMesh.bounds;
                Vector3[] corners =
                {
                    local.min, local.max,
                    new Vector3(local.min.x, local.min.y, local.max.z), new Vector3(local.min.x, local.max.y, local.min.z),
                    new Vector3(local.max.x, local.min.y, local.min.z), new Vector3(local.min.x, local.max.y, local.max.z),
                    new Vector3(local.max.x, local.min.y, local.max.z), new Vector3(local.max.x, local.max.y, local.min.z)
                };

                foreach (Vector3 corner in corners)
                {
                    Vector3 world = filter.transform.TransformPoint(corner);

                    if (!any)
                    {
                        bounds = new Bounds(world, Vector3.zero);
                        any = true;
                    }
                    else
                    {
                        bounds.Encapsulate(world);
                    }
                }
            }

            return bounds;
        }
    }
}

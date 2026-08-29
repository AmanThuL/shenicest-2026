using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;
using RootsDance.Environment;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Builds <c>Main_Environment_Statue</c>: an additive content part holding the StMuerte statue
    /// and the water that pours from its right arm, across both palms, and through the left hand's
    /// finger gaps down to the ground.
    /// <para>
    /// The statue FBX is exported in place from <c>GAIA1_v8.blend</c> with the same profile family
    /// as <c>Briggs_Greenhouse.fbx</c> (import scale 0.6045, axis conversion baked), so the
    /// instance sits at the world origin and lines up with the greenhouse exactly as in Blender.
    /// Anchor points below are Blender world coordinates mapped through
    /// <c>(x, y, z) → (0.6045·x, 0.6045·z, 0.6045·y)</c> — verified against the imported bounds.
    /// </para>
    /// <para>
    /// The water is deliberately not a simulation (see <see cref="WaterFlow"/> for the project's
    /// stance): each leg is a cross-ribbon mesh whose streak texture scrolls, and every "impact"
    /// is just the next emitter placed and timed at the landing point. Splashes are Shuriken with
    /// HDRP/Unlit + Kenney sprites; HDRP/Unlit ignores particle vertex colour, so fades are
    /// size-over-lifetime, same as <c>OpeningVfxPrefabBuilder</c>.
    /// </para>
    /// Menu: RootsDance > Build Statue Environment Scene. Idempotent: rebuilds the root in place.
    /// </summary>
    public static class StatueEnvironmentBuilder
    {
        private const string k_LogPrefix = "StatueEnvironmentBuilder";

        private const string k_ScenePath = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_Statue.unity";
        private const string k_StatueFbx = "Assets/RootsDance/Meshes/Environment/GAIA1/Sculpture/StMuerte.fbx";
        private const string k_LevelAsset = "Assets/RootsDance/Data/Levels/Main.asset";

        private const string k_MeshFolder = "Assets/RootsDance/Meshes/Environment/GAIA1/Sculpture/Generated";
        private const string k_MaterialFolder = "Assets/RootsDance/VFX";

        /// <summary>Lives beside the materials: the Textures/ pipeline owns only material map sets.</summary>
        private const string k_StreakTexture = k_MaterialFolder + "/WaterStreaks.png";

        /// <summary>Tileable ripple normal map, stretched along V so the scroll reads as flow.</summary>
        private const string k_FlowNormalTexture = k_MaterialFolder + "/WaterFlowNormal.png";
        private const string k_WaterMaterial = k_MaterialFolder + "/VFX_StatueWater.mat";
        private const string k_SplashMaterial = k_MaterialFolder + "/VFX_StatueWaterSplash.mat";
        private const string k_MistMaterial = k_MaterialFolder + "/VFX_StatueWaterMist.mat";

        private const string k_SplashSprite = "Assets/ThirdParty/VFX/KenneyParticlePack/circle_05.png";
        private const string k_MistSprite = "Assets/ThirdParty/VFX/KenneyParticlePack/light_01.png";

        private const string k_RootName = "Statue";
        private const string k_UnlitShader = "HDRP/Unlit";

        private static readonly int k_UnlitColorId = Shader.PropertyToID("_UnlitColor");
        private static readonly int k_UnlitColorMapId = Shader.PropertyToID("_UnlitColorMap");
        private static readonly int k_SortPriorityId = Shader.PropertyToID("_TransparentSortPriority");
        private static readonly int k_DoubleSidedId = Shader.PropertyToID("_DoubleSidedEnable");
        private static readonly int k_BaseColorId = Shader.PropertyToID("_BaseColor");
        private static readonly int k_BaseColorMapId = Shader.PropertyToID("_BaseColorMap");
        private static readonly int k_NormalMapId = Shader.PropertyToID("_NormalMap");
        private static readonly int k_NormalScaleId = Shader.PropertyToID("_NormalScale");
        private static readonly int k_SmoothnessId = Shader.PropertyToID("_Smoothness");
        private static readonly int k_MetallicId = Shader.PropertyToID("_Metallic");
        private static readonly int k_RefractionModelId = Shader.PropertyToID("_RefractionModel");
        private static readonly int k_IorId = Shader.PropertyToID("_Ior");

        /// <summary>UV tiles per metre of stream length; wrap mode keeps long falls seamless.</summary>
        private const float k_UvTilesPerMeter = 0.35f;

        // Water path anchors. Right forearm bones → right palm → off the right fingertips onto the
        // left hand's fingers → three finger gaps → greenhouse floor (Blender z 7.78 → Unity
        // y 4.70). Surface heights and gap positions come from collider raycasts against the
        // imported statue, not from the rig; nudge in the scene later rather than re-deriving.
        private static readonly Vector3[] k_ArmToRightPalm =
        {
            new Vector3(27.55f, 17.62f, 65.90f),
            new Vector3(27.05f, 17.32f, 66.30f),
            new Vector3(26.85f, 17.16f, 66.62f),
            new Vector3(26.68f, 17.06f, 66.97f),
        };

        private static readonly Vector3[] k_RightPalmToLeftPalm =
        {
            new Vector3(26.68f, 17.06f, 66.97f),
            new Vector3(26.50f, 16.98f, 67.08f),
            new Vector3(26.40f, 16.86f, 67.18f),
            new Vector3(26.25f, 16.62f, 67.15f),
        };

        private static readonly Vector3[] k_FingerGaps =
        {
            new Vector3(25.85f, 16.55f, 67.35f),
            new Vector3(26.00f, 16.52f, 67.30f),
            new Vector3(26.20f, 16.50f, 67.25f),
        };

        private const float k_GroundY = 4.72f;

        // The greenhouse FBX instance in Main_Environment sits under "ResearchFacility_GaiaV7",
        // not at the world origin. The statue shares the same baked Blender frame, so its root
        // copies that node's transform verbatim; every anchor above is local to this frame.
        private static readonly Vector3 k_RootPosition = new Vector3(0.9278145f, 5.5960455f, 61.911377f);
        private static readonly Quaternion k_RootRotation = new Quaternion(0f, -0.21196891f, 0f, 0.97727644f);

        private static readonly Vector3 k_RightPalmSplash = new Vector3(26.68f, 17.08f, 66.97f);
        private static readonly Vector3 k_LeftPalmSplash = new Vector3(26.25f, 16.66f, 67.15f);
        private static readonly Vector3 k_GroundSplash = new Vector3(26.02f, 4.75f, 67.45f);

        [MenuItem("RootsDance/Build Statue Environment Scene")]
        public static void Run()
        {
            GameObject statuePrefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_StatueFbx);

            if (statuePrefab == null)
            {
                Debug.LogError($"{k_LogPrefix}: statue FBX missing at {k_StatueFbx}; export it first.");
                return;
            }

            Texture2D streaks = EnsureStreakTexture();
            Texture2D flowNormal = EnsureFlowNormalTexture();
            Material water = EnsureWaterMaterial(streaks, flowNormal);
            Material splash = EnsureParticleMaterial(
                k_SplashMaterial, k_SplashSprite, new Color(0.85f, 0.93f, 1f, 0.5f), 1);
            Material mist = EnsureParticleMaterial(
                k_MistMaterial, k_MistSprite, new Color(0.8f, 0.9f, 1f, 0.12f), -1);

            if (water == null || splash == null || mist == null)
            {
                return;
            }

            Scene scene = OpenOrCreateScene();
            GameObject root = RebuildRoot(scene);

            GameObject statue = (GameObject)PrefabUtility.InstantiatePrefab(statuePrefab, scene);
            statue.transform.SetParent(root.transform, false);
            statue.transform.localPosition = Vector3.zero;
            statue.transform.localRotation = Quaternion.identity;

            GameObject waterRoot = new GameObject("StatueWater");
            SceneManager.MoveGameObjectToScene(waterRoot, scene);
            waterRoot.transform.SetParent(root.transform, false);

            EnsureFolder(k_MeshFolder);

            BuildStream(waterRoot, "Stream_ArmToRightPalm", k_ArmToRightPalm, 0.18f, 0.26f,
                new Vector2(0f, -0.6f), water, root.transform);
            BuildStream(waterRoot, "Stream_RightPalmToLeftPalm", k_RightPalmToLeftPalm, 0.22f, 0.3f,
                new Vector2(0f, -0.7f), water, root.transform);

            for (int i = 0; i < k_FingerGaps.Length; i++)
            {
                BuildStream(waterRoot, $"Stream_FingerFall_{i}", FallPath(k_FingerGaps[i]), 0.12f, 0.32f,
                    new Vector2(0f, -1.6f), water, null);
            }

            BuildSplash(waterRoot, "Splash_RightPalm", k_RightPalmSplash, splash,
                radius: 0.12f, rate: 20f, speed: 0.9f, sizeMin: 0.04f, sizeMax: 0.12f, life: 0.55f);
            BuildSplash(waterRoot, "Splash_LeftPalm", k_LeftPalmSplash, splash,
                radius: 0.15f, rate: 25f, speed: 1.1f, sizeMin: 0.05f, sizeMax: 0.15f, life: 0.6f);
            BuildSplash(waterRoot, "Splash_Ground", k_GroundSplash, splash,
                radius: 0.45f, rate: 60f, speed: 2.6f, sizeMin: 0.08f, sizeMax: 0.28f, life: 0.8f);
            BuildMist(waterRoot, "Mist_Ground", k_GroundSplash + new Vector3(0f, 0.4f, 0f), mist);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            RegisterScene();
            AssetDatabase.SaveAssets();

            Debug.Log($"{k_LogPrefix}: built and saved {k_ScenePath}.");
        }

        // -------------------------------------------------------------------------------- scene

        private static Scene OpenOrCreateScene()
        {
            Scene scene = SceneManager.GetSceneByPath(k_ScenePath);

            if (scene.isLoaded)
            {
                return scene;
            }

            if (File.Exists(k_ScenePath))
            {
                return EditorSceneManager.OpenScene(k_ScenePath, OpenSceneMode.Additive);
            }

            scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Additive);
            EditorSceneManager.SaveScene(scene, k_ScenePath);
            return scene;
        }

        private static GameObject RebuildRoot(Scene scene)
        {
            foreach (GameObject rootObject in scene.GetRootGameObjects())
            {
                if (rootObject.name == k_RootName)
                {
                    Object.DestroyImmediate(rootObject);
                }
            }

            GameObject root = new GameObject(k_RootName);
            SceneManager.MoveGameObjectToScene(root, scene);
            root.transform.SetPositionAndRotation(k_RootPosition, k_RootRotation);
            return root;
        }

        /// <summary>Adds the scene to the build list and to the Main level's additive parts.</summary>
        private static void RegisterScene()
        {
            List<EditorBuildSettingsScene> scenes = new List<EditorBuildSettingsScene>(EditorBuildSettings.scenes);
            bool listed = scenes.Exists(s => s.path == k_ScenePath);

            if (!listed)
            {
                scenes.Add(new EditorBuildSettingsScene(k_ScenePath, true));
                EditorBuildSettings.scenes = scenes.ToArray();
            }

            Object level = AssetDatabase.LoadMainAssetAtPath(k_LevelAsset);

            if (level == null)
            {
                Debug.LogWarning($"{k_LogPrefix}: level asset missing at {k_LevelAsset}; scene not registered.");
                return;
            }

            SerializedObject serialized = new SerializedObject(level);
            SerializedProperty paths = serialized.FindProperty("m_scenePaths");

            for (int i = 0; i < paths.arraySize; i++)
            {
                if (paths.GetArrayElementAtIndex(i).stringValue == k_ScenePath)
                {
                    return;
                }
            }

            paths.InsertArrayElementAtIndex(paths.arraySize);
            paths.GetArrayElementAtIndex(paths.arraySize - 1).stringValue = k_ScenePath;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(level);
        }

        // ------------------------------------------------------------------------------ streams

        private static Vector3[] FallPath(Vector3 gap)
        {
            return new[]
            {
                gap,
                gap + new Vector3(0f, -0.6f, 0.05f),
                new Vector3(gap.x, (gap.y + k_GroundY) * 0.5f, gap.z + 0.1f),
                new Vector3(gap.x, k_GroundY, gap.z + 0.16f),
            };
        }

        private static void BuildStream(
            GameObject parent, string name, Vector3[] waypoints, float startWidth, float endWidth,
            Vector2 scrollSpeed, Material material, Transform conformTo)
        {
            Mesh mesh = BuildRibbonMesh(waypoints, startWidth, endWidth, conformTo);
            string meshPath = $"{k_MeshFolder}/{name}.asset";
            AssetDatabase.DeleteAsset(meshPath);
            AssetDatabase.CreateAsset(mesh, meshPath);

            GameObject stream = new GameObject(name);
            stream.transform.SetParent(parent.transform, false);

            MeshFilter filter = stream.AddComponent<MeshFilter>();
            filter.sharedMesh = mesh;

            MeshRenderer renderer = stream.AddComponent<MeshRenderer>();
            renderer.sharedMaterial = material;
            renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;

            WaterFlow flow = stream.AddComponent<WaterFlow>();
            SerializedObject serialized = new SerializedObject(flow);
            serialized.FindProperty("m_renderer").objectReferenceValue = renderer;
            SerializedProperty properties = serialized.FindProperty("m_textureProperties");
            properties.arraySize = 2;
            properties.GetArrayElementAtIndex(0).stringValue = "_NormalMap";
            properties.GetArrayElementAtIndex(1).stringValue = "_BaseColorMap";
            serialized.FindProperty("m_speed").vector2Value = scrollSpeed;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        /// <summary>
        /// Two perpendicular ribbons along a Catmull-Rom curve through the waypoints, so the
        /// stream has a silhouette from every side without billboarding. V runs with the flow.
        /// </summary>
        private static Mesh BuildRibbonMesh(
            Vector3[] waypoints, float startWidth, float endWidth, Transform conformTo)
        {
            const int samplesPerSegment = 10;
            List<Vector3> centers = new List<Vector3>();

            for (int i = 0; i < waypoints.Length - 1; i++)
            {
                Vector3 p0 = waypoints[Mathf.Max(i - 1, 0)];
                Vector3 p1 = waypoints[i];
                Vector3 p2 = waypoints[i + 1];
                Vector3 p3 = waypoints[Mathf.Min(i + 2, waypoints.Length - 1)];
                int last = i == waypoints.Length - 2 ? samplesPerSegment : samplesPerSegment - 1;

                for (int s = 0; s <= last; s++)
                {
                    centers.Add(CatmullRom(p0, p1, p2, p3, (float)s / samplesPerSegment));
                }
            }

            if (conformTo != null)
            {
                ConformToSurface(centers, conformTo, startWidth, endWidth);
            }

            int count = centers.Count;
            Vector3[] vertices = new Vector3[count * 4];
            Vector2[] uvs = new Vector2[count * 4];
            float arc = 0f;

            for (int i = 0; i < count; i++)
            {
                if (i > 0)
                {
                    arc += Vector3.Distance(centers[i], centers[i - 1]);
                }

                Vector3 tangent = i < count - 1
                    ? (centers[i + 1] - centers[i]).normalized
                    : (centers[i] - centers[i - 1]).normalized;

                Vector3 side = Vector3.Cross(tangent, Vector3.up);
                side = side.sqrMagnitude < 1e-4f ? Vector3.right : side.normalized;
                Vector3 across = Vector3.Cross(tangent, side).normalized;

                float t = count > 1 ? (float)i / (count - 1) : 0f;

                // Pinched at the source so the stream reads as seeping out of the geometry
                // instead of a pipe hanging in the air.
                float emerge = Mathf.Lerp(0.2f, 1f, Mathf.SmoothStep(0f, 1f, Mathf.Clamp01(t / 0.12f)));
                float half = Mathf.Lerp(startWidth, endWidth, t) * 0.5f * emerge;
                float v = arc * k_UvTilesPerMeter;

                vertices[i * 4 + 0] = centers[i] - side * half;
                vertices[i * 4 + 1] = centers[i] + side * half;
                vertices[i * 4 + 2] = centers[i] - across * half;
                vertices[i * 4 + 3] = centers[i] + across * half;
                uvs[i * 4 + 0] = new Vector2(0f, v);
                uvs[i * 4 + 1] = new Vector2(1f, v);
                uvs[i * 4 + 2] = new Vector2(0f, v);
                uvs[i * 4 + 3] = new Vector2(1f, v);
            }

            int[] triangles = new int[(count - 1) * 12];
            int index = 0;

            for (int i = 0; i < count - 1; i++)
            {
                int a = i * 4;
                int b = (i + 1) * 4;
                index = AddQuad(triangles, index, a + 0, a + 1, b + 0, b + 1);
                index = AddQuad(triangles, index, a + 2, a + 3, b + 2, b + 3);
            }

            Mesh mesh = new Mesh();
            mesh.name = "WaterStream";
            mesh.vertices = vertices;
            mesh.uv = uvs;
            mesh.triangles = triangles;
            mesh.RecalculateNormals();
            mesh.RecalculateBounds();
            return mesh;
        }

        /// <summary>
        /// Lifts every sample that sank into the statue back above its surface. The anchors are
        /// straight-line guesses between raycast points; between them the robe's folds and the
        /// bone forearm bulge higher than the interpolation, which is what clips. Centers are in
        /// the statue root's local frame; the root is yaw-only, so "down" matches in both frames.
        /// </summary>
        private static void ConformToSurface(
            List<Vector3> centers, Transform frame, float startWidth, float endWidth)
        {
            Physics.SyncTransforms();

            int count = centers.Count;
            float[] lifted = new float[count];

            for (int i = 0; i < count; i++)
            {
                float t = count > 1 ? (float)i / (count - 1) : 0f;
                float clearance = Mathf.Lerp(startWidth, endWidth, t) * 0.5f + 0.02f;
                Vector3 world = frame.TransformPoint(centers[i]);
                Vector3 origin = world + Vector3.up * 1.5f;
                lifted[i] = centers[i].y;

                if (Physics.Raycast(origin, Vector3.down, out RaycastHit hit, 3f))
                {
                    float surface = frame.InverseTransformPoint(hit.point).y;

                    if (lifted[i] < surface + clearance)
                    {
                        lifted[i] = surface + clearance;
                    }
                }
            }

            // One smoothing pass so the lifted path rolls over folds instead of stair-stepping,
            // then a re-clamp so smoothing cannot push a point back under the surface it left.
            for (int i = 1; i < count - 1; i++)
            {
                float smoothed = (lifted[i - 1] + lifted[i] * 2f + lifted[i + 1]) * 0.25f;
                Vector3 c = centers[i];
                c.y = Mathf.Max(smoothed, lifted[i]);
                centers[i] = c;
            }

            Vector3 first = centers[0];
            first.y = lifted[0];
            centers[0] = first;

            Vector3 last = centers[count - 1];
            last.y = lifted[count - 1];
            centers[count - 1] = last;
        }

        private static int AddQuad(int[] triangles, int index, int a0, int a1, int b0, int b1)
        {
            triangles[index++] = a0;
            triangles[index++] = b0;
            triangles[index++] = a1;
            triangles[index++] = a1;
            triangles[index++] = b0;
            triangles[index++] = b1;
            return index;
        }

        private static Vector3 CatmullRom(Vector3 p0, Vector3 p1, Vector3 p2, Vector3 p3, float t)
        {
            float t2 = t * t;
            float t3 = t2 * t;
            return 0.5f * ((2f * p1)
                + (-p0 + p2) * t
                + (2f * p0 - 5f * p1 + 4f * p2 - p3) * t2
                + (-p0 + 3f * p1 - 3f * p2 + p3) * t3);
        }

        // ---------------------------------------------------------------------------- particles

        private static void BuildSplash(
            GameObject parent, string name, Vector3 position, Material material,
            float radius, float rate, float speed, float sizeMin, float sizeMax, float life)
        {
            ParticleSystem system = NewParticleObject(parent, name, position, material);

            ParticleSystem.MainModule main = system.main;
            main.loop = true;
            main.playOnAwake = true;
            main.simulationSpace = ParticleSystemSimulationSpace.World;
            main.startLifetime = new ParticleSystem.MinMaxCurve(life * 0.7f, life);
            main.startSize = new ParticleSystem.MinMaxCurve(sizeMin, sizeMax);
            main.startSpeed = new ParticleSystem.MinMaxCurve(speed * 0.5f, speed);
            main.startColor = Color.white;
            main.gravityModifier = 1.1f;
            main.maxParticles = 200;

            ParticleSystem.EmissionModule emission = system.emission;
            emission.rateOverTime = rate;

            ParticleSystem.ShapeModule shape = system.shape;
            shape.shapeType = ParticleSystemShapeType.Cone;
            shape.angle = 35f;
            shape.radius = radius;
            shape.rotation = new Vector3(-90f, 0f, 0f);

            ApplyFade(system);
        }

        private static void BuildMist(GameObject parent, string name, Vector3 position, Material material)
        {
            ParticleSystem system = NewParticleObject(parent, name, position, material);

            ParticleSystem.MainModule main = system.main;
            main.loop = true;
            main.playOnAwake = true;
            main.simulationSpace = ParticleSystemSimulationSpace.World;
            main.startLifetime = new ParticleSystem.MinMaxCurve(1.8f, 3f);
            main.startSize = new ParticleSystem.MinMaxCurve(0.9f, 2.2f);
            main.startSpeed = new ParticleSystem.MinMaxCurve(0.15f, 0.4f);
            main.startColor = Color.white;
            main.gravityModifier = -0.02f;
            main.maxParticles = 60;

            ParticleSystem.EmissionModule emission = system.emission;
            emission.rateOverTime = 7f;

            ParticleSystem.ShapeModule shape = system.shape;
            shape.shapeType = ParticleSystemShapeType.Hemisphere;
            shape.radius = 0.7f;

            ApplyFade(system);
        }

        private static ParticleSystem NewParticleObject(
            GameObject parent, string name, Vector3 position, Material material)
        {
            GameObject holder = new GameObject(name);
            holder.transform.SetParent(parent.transform, false);
            holder.transform.localPosition = position;

            ParticleSystem system = holder.AddComponent<ParticleSystem>();
            ParticleSystemRenderer renderer = holder.GetComponent<ParticleSystemRenderer>();
            renderer.renderMode = ParticleSystemRenderMode.Billboard;
            renderer.sharedMaterial = material;
            renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
            renderer.receiveShadows = false;
            return system;
        }

        /// <summary>HDRP/Unlit ignores particle vertex colour, so the fade is size, not alpha.</summary>
        private static void ApplyFade(ParticleSystem system)
        {
            ParticleSystem.SizeOverLifetimeModule sizeOverLifetime = system.sizeOverLifetime;
            sizeOverLifetime.enabled = true;
            AnimationCurve fade = new AnimationCurve(
                new Keyframe(0f, 0.4f), new Keyframe(0.15f, 1f), new Keyframe(0.75f, 0.9f), new Keyframe(1f, 0f));
            sizeOverLifetime.size = new ParticleSystem.MinMaxCurve(1f, fade);
        }

        // ---------------------------------------------------------------------- materials/tex

        /// <summary>
        /// HDRP/Lit transparent with a scrolling ripple normal map: specular glints, fresnel edges
        /// and smooth reflections come from Lit itself — the "surface shader turned sideways" look
        /// with the depth-based parts (deep-water tint, shore foam) deliberately absent, because
        /// those assume a horizontal plane. The streak map keeps the silhouette broken up.
        /// </summary>
        private static Material EnsureWaterMaterial(Texture2D streaks, Texture2D flowNormal)
        {
            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_WaterMaterial);
            Shader lit = Shader.Find("HDRP/Lit");

            if (lit == null)
            {
                Debug.LogError($"{k_LogPrefix}: shader 'HDRP/Lit' not found.");
                return null;
            }

            if (material == null)
            {
                material = new Material(lit);
                AssetDatabase.CreateAsset(material, k_WaterMaterial);
            }
            else if (material.shader != lit)
            {
                material.shader = lit;
            }

            HDMaterial.SetSurfaceType(material, true);
            material.SetColor(k_BaseColorId, new Color(0.55f, 0.72f, 0.85f, 0.55f));
            material.SetTexture(k_BaseColorMapId, streaks);
            material.SetTexture(k_NormalMapId, flowNormal);
            material.SetFloat(k_NormalScaleId, 1.6f);
            material.SetFloat(k_SmoothnessId, 0.92f);
            material.SetFloat(k_MetallicId, 0f);
            material.SetFloat(k_DoubleSidedId, 1f);
            material.SetFloat(k_SortPriorityId, 0f);

            // Clear water over a white statue has no contrast of its own: what sells it is the
            // background bending through the sheet. Thin refraction (model 3, the flashlight-lens
            // precedent) plus the scrolling normal is what makes the flow read.
            material.SetFloat(k_RefractionModelId, 3f);
            material.SetFloat(k_IorId, 1.33f);
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureParticleMaterial(string path, string spritePath, Color color, int sortPriority)
        {
            Texture2D sprite = AssetDatabase.LoadAssetAtPath<Texture2D>(spritePath);

            if (sprite == null)
            {
                Debug.LogError($"{k_LogPrefix}: particle sprite missing at {spritePath}.");
                return null;
            }

            Material material = LoadOrCreateMaterial(path);

            if (material == null)
            {
                return null;
            }

            HDMaterial.SetSurfaceType(material, true);
            material.SetColor(k_UnlitColorId, color);
            material.SetTexture(k_UnlitColorMapId, sprite);
            material.SetFloat(k_SortPriorityId, sortPriority);
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material LoadOrCreateMaterial(string path)
        {
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

            material = new Material(shader);
            AssetDatabase.CreateAsset(material, path);
            return material;
        }

        /// <summary>
        /// A tiling column-streak alpha texture, generated once so the effect needs no downloads.
        /// Columns get a smoothed random intensity; a second wrapped noise varies them lengthwise.
        /// </summary>
        private static Texture2D EnsureStreakTexture()
        {
            Texture2D existing = AssetDatabase.LoadAssetAtPath<Texture2D>(k_StreakTexture);

            if (existing != null)
            {
                return existing;
            }

            EnsureFolder(k_MaterialFolder);

            const int width = 128;
            const int height = 512;
            const int lattice = 16;
            System.Random random = new System.Random(20260829);
            float[] columnSeed = new float[width / lattice];
            float[] phaseSeed = new float[width / lattice];

            for (int i = 0; i < columnSeed.Length; i++)
            {
                columnSeed[i] = (float)random.NextDouble();
                phaseSeed[i] = (float)random.NextDouble() * Mathf.PI * 2f;
            }

            Texture2D texture = new Texture2D(width, height, TextureFormat.RGBA32, false);
            Color32[] pixels = new Color32[width * height];

            for (int x = 0; x < width; x++)
            {
                float cell = (float)x / lattice;
                int i0 = Mathf.FloorToInt(cell) % columnSeed.Length;
                int i1 = (i0 + 1) % columnSeed.Length;
                float ft = Mathf.SmoothStep(0f, 1f, cell - Mathf.Floor(cell));
                float column = Mathf.Lerp(columnSeed[i0], columnSeed[i1], ft);
                float phase = Mathf.Lerp(phaseSeed[i0], phaseSeed[i1], ft);

                for (int y = 0; y < height; y++)
                {
                    float wave = 0.62f + 0.38f * Mathf.Sin(y * (Mathf.PI * 2f * 3f / height) + phase);
                    // Floor keeps the sheet legible; streaks modulate on top rather than cutting
                    // holes, which read as broken geometry at a distance.
                    float alpha = 0.45f + 0.55f * Mathf.Pow(Mathf.Clamp01(column * wave), 1.4f);
                    byte a = (byte)(alpha * 255f);
                    pixels[y * width + x] = new Color32(255, 255, 255, a);
                }
            }

            texture.SetPixels32(pixels);
            texture.Apply();
            File.WriteAllBytes(k_StreakTexture, texture.EncodeToPNG());
            Object.DestroyImmediate(texture);
            AssetDatabase.ImportAsset(k_StreakTexture, ImportAssetOptions.ForceUpdate);
            return AssetDatabase.LoadAssetAtPath<Texture2D>(k_StreakTexture);
        }

        /// <summary>
        /// Tileable water-ripple normal map from octaves of periodic value noise, stretched 4:1
        /// along V so scrolling it lengthwise reads as flow rather than boiling.
        /// </summary>
        private static Texture2D EnsureFlowNormalTexture()
        {
            Texture2D existing = AssetDatabase.LoadAssetAtPath<Texture2D>(k_FlowNormalTexture);

            if (existing != null)
            {
                return existing;
            }

            EnsureFolder(k_MaterialFolder);

            const int size = 256;
            const int cells = 8;
            System.Random random = new System.Random(20260830);
            float[,] lattice = new float[cells, cells];

            for (int y = 0; y < cells; y++)
            {
                for (int x = 0; x < cells; x++)
                {
                    lattice[x, y] = (float)random.NextDouble();
                }
            }

            float[,] height = new float[size, size];

            for (int y = 0; y < size; y++)
            {
                for (int x = 0; x < size; x++)
                {
                    float value = 0f;
                    float amplitude = 1f;
                    float total = 0f;

                    for (int octave = 0; octave < 3; octave++)
                    {
                        int frequency = 1 << octave;
                        // V is sampled at a quarter of the U frequency: elongated ripples.
                        float u = (float)x / size * cells * frequency;
                        float v = (float)y / size * cells * frequency * 0.25f;
                        value += SampleLattice(lattice, cells, u, v) * amplitude;
                        total += amplitude;
                        amplitude *= 0.5f;
                    }

                    height[x, y] = value / total;
                }
            }

            const float strength = 4f;
            Texture2D texture = new Texture2D(size, size, TextureFormat.RGBA32, false);
            Color32[] pixels = new Color32[size * size];

            for (int y = 0; y < size; y++)
            {
                for (int x = 0; x < size; x++)
                {
                    float dx = (height[(x + 1) % size, y] - height[(x + size - 1) % size, y]) * strength;
                    float dy = (height[x, (y + 1) % size] - height[x, (y + size - 1) % size]) * strength;
                    Vector3 normal = new Vector3(-dx, -dy, 1f).normalized;
                    pixels[y * size + x] = new Color32(
                        (byte)((normal.x * 0.5f + 0.5f) * 255f),
                        (byte)((normal.y * 0.5f + 0.5f) * 255f),
                        (byte)((normal.z * 0.5f + 0.5f) * 255f),
                        255);
                }
            }

            texture.SetPixels32(pixels);
            texture.Apply();
            File.WriteAllBytes(k_FlowNormalTexture, texture.EncodeToPNG());
            Object.DestroyImmediate(texture);
            AssetDatabase.ImportAsset(k_FlowNormalTexture, ImportAssetOptions.ForceUpdate);

            TextureImporter importer = (TextureImporter)AssetImporter.GetAtPath(k_FlowNormalTexture);
            importer.textureType = TextureImporterType.NormalMap;
            importer.SaveAndReimport();

            return AssetDatabase.LoadAssetAtPath<Texture2D>(k_FlowNormalTexture);
        }

        private static float SampleLattice(float[,] lattice, int cells, float u, float v)
        {
            int x0 = Mathf.FloorToInt(u);
            int y0 = Mathf.FloorToInt(v);
            float tx = Mathf.SmoothStep(0f, 1f, u - x0);
            float ty = Mathf.SmoothStep(0f, 1f, v - y0);
            int ix0 = ((x0 % cells) + cells) % cells;
            int iy0 = ((y0 % cells) + cells) % cells;
            int ix1 = (ix0 + 1) % cells;
            int iy1 = (iy0 + 1) % cells;
            float a = Mathf.Lerp(lattice[ix0, iy0], lattice[ix1, iy0], tx);
            float b = Mathf.Lerp(lattice[ix0, iy1], lattice[ix1, iy1], tx);
            return Mathf.Lerp(a, b, ty);
        }

        private static void EnsureFolder(string folder)
        {
            if (AssetDatabase.IsValidFolder(folder))
            {
                return;
            }

            string parent = Path.GetDirectoryName(folder)?.Replace('\\', '/');
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, Path.GetFileName(folder));
        }
    }
}

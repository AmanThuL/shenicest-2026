using System;
using System.Collections.Generic;
using RootsDance.App;
using RootsDance.Environment;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Puts the run-off under the statue's water: the fall lands on the stone below the fingers,
    /// the stone's top carries what it can, and the rest runs off its shoulders into the soil.
    /// <para>
    /// The stone is <c>StoneBasin.fbx</c> and its name is a lie — the mesh is a closed dome with a
    /// hollow underside, not a basin, so nothing can be held in it. That is built into the shape of
    /// this rig rather than argued with: the water is a shallow cap riding the dome, and "full" is
    /// the cap standing proud of the summit instead of a level reaching a lip. What the shot has to
    /// say — the water arrives, the stone cannot keep it, the ground takes it — survives the stone
    /// having no hollow.
    /// </para>
    /// <para>
    /// Everything is built under <c>StatueWater</c> so the ending switches it on with the fall
    /// itself: <see cref="RockPoolOverflow"/> starts on <c>OnEnable</c>, and one parent object
    /// carries the fall, the pool and the run-off together. The stone itself lives in
    /// <see cref="ScenePaths.k_GreenhouseInteriorEnvironment2"/> and is not touched — its transform
    /// is copied here as constants and a throwaway instance is used to raycast against.
    /// </para>
    /// </summary>
    public static class StonePoolOverflowBuilder
    {
        public const string k_RootName = "StonePool";
        public const string k_SurfaceName = "Pool_Surface";
        public const string k_SpillwaysName = "Spillways";

        private const string k_WaterRootPath = "_Props/Statue/StatueWater";
        private const string k_StoneFbxPath = "Assets/RootsDance/Meshes/Props/StoneBasin.fbx";
        private const string k_WaterMaterialPath = "Assets/RootsDance/VFX/VFX_StatueWater.mat";
        private const string k_SplashMaterialPath = "Assets/RootsDance/VFX/VFX_StatueWaterSplash.mat";
        private const string k_MeshFolder = "Assets/RootsDance/Meshes/Environment/GAIA1/Sculpture/Generated";

        // The stone as it is placed in GreenhouseInterior_Environment_2, copied off that scene's
        // prefab instance. Duplicated rather than read live so this builder never opens, dirties or
        // depends on the scene that owns the prop.
        private static readonly Vector3 k_StonePosition = new Vector3(-4.9990096f, 10.343271f, 134.4764f);
        private static readonly Quaternion k_StoneRotation =
            new Quaternion(0f, -0.97727644f, 0f, -0.21196896f);
        private const float k_StoneScale = 1.3190084f;
        private const string k_ProbeName = "StonePoolProbe";
        private const float k_ProbeRayHeight = 14.5f;
        private const float k_ProbeRayLength = 6f;

        // The soil sits a little under the stone's base; anything higher that a downward ray meets
        // is greenhouse, statue or planting, not ground.
        private const float k_SoilSearchBand = 0.3f;

        // Where the three finger falls hit, measured off the stream bounds in the greenhouse scene.
        // The summit search starts here so the pool forms under the water rather than at whatever
        // point of the dome happens to be highest.
        private static readonly Vector2 k_LandingPoint = new Vector2(-4.744f, 134.273f);
        private const float k_SummitSearchRadius = 0.35f;

        // Pool extent. The full radius is where the dome's shoulder starts to fall away fast; past
        // it a horizontal cap stops looking like water on a stone and starts looking like a plate.
        private const float k_FullDiameter = 0.62f;
        private const float k_EmptyDiameter = 0.13f;

        // Heights are offsets from the summit. Empty is a film a few millimetres over the top;
        // full stands proud of it, which is as close to "over the lip" as a dome gets.
        private const float k_EmptyRise = 0.004f;
        private const float k_FullRise = 0.028f;

        private const float k_FillSeconds = 14f;
        private const float k_SpillsAt = 0.9f;

        private const int k_SpillwayCount = 3;
        private const int k_SpillwaySamples = 22;
        private const float k_SpillwayStep = 0.09f;
        private const float k_SpillwayClearance = 0.012f;
        private const float k_SpillwayStartWidth = 0.11f;
        private const float k_SpillwayEndWidth = 0.2f;

        // The run-off does not end on the soil, it ends under it: the last samples sink below the
        // surface so the ribbon reads as water going into the ground rather than pooling on it.
        private const float k_SoakDepth = 0.05f;

        [MenuItem("RootsDance/Environment/Build Stone Pool Overflow")]
        public static void Build()
        {
            ThrowIfAnyOpenSceneIsDirty();
            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                Scene scene = EditorSceneManager.OpenScene(
                    ScenePaths.k_GreenhouseInteriorEnvironment, OpenSceneMode.Single);
                BuildInto(scene);
                EditorSceneManager.MarkSceneDirty(scene);
                EditorSceneManager.SaveScene(scene);
                AssetDatabase.SaveAssets();
                Debug.Log("StonePoolOverflowBuilder: built the stone pool and its run-off.");
            }
            finally
            {
                if (originalSetup.Length > 0)
                {
                    EditorSceneManager.RestoreSceneManagerSetup(originalSetup);
                }
            }
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

        /// <summary>Builds the rig into an already-open greenhouse environment scene.</summary>
        public static void BuildInto(Scene scene)
        {
            Transform waterRoot = FindWaterRoot(scene);
            Material water = LoadAsset<Material>(k_WaterMaterialPath);
            Material splash = LoadAsset<Material>(k_SplashMaterialPath);
            GameObject stonePrefab = LoadAsset<GameObject>(k_StoneFbxPath);

            GameObject probe = InstantiateStoneProbe(stonePrefab, scene);
            GameObject root = new GameObject(k_RootName + "_Building");
            SceneManager.MoveGameObjectToScene(root, scene);
            root.transform.SetParent(waterRoot, false);

            try
            {
                Vector3 summit = FindSummit();
                NeutraliseParentTransform(root.transform, summit);

                float shoulderDrop = MeasureShoulderDrop(summit);
                Transform surface = BuildSurface(root.transform, water, shoulderDrop);
                GameObject spillways = BuildSpillways(root.transform, summit, water, splash);
                AddOverflow(root, surface, spillways);
            }
            catch
            {
                UnityEngine.Object.DestroyImmediate(root);
                throw;
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(probe);
            }

            RemoveExistingRoot(waterRoot);
            root.name = k_RootName;
        }

        /// <summary>
        /// Puts the rig into world axes and world metres. It hangs off the statue, and the statue
        /// is an imported FBX carrying both a yaw and an import scale; without this every height,
        /// width and traced path below would come out turned and shrunk by whatever that node
        /// happens to be. Undoing it here is what lets the rest of the builder speak in metres.
        /// </summary>
        private static void NeutraliseParentTransform(Transform root, Vector3 summit)
        {
            Vector3 parentScale = root.parent == null ? Vector3.one : root.parent.lossyScale;
            float scale = (parentScale.x + parentScale.y + parentScale.z) / 3f;

            if (Mathf.Abs(scale) < 1e-4f)
            {
                throw new InvalidOperationException(
                    "The statue node this rig hangs off is scaled to nothing; the pool cannot be sized.");
            }

            root.localScale = Vector3.one / scale;
            root.rotation = Quaternion.identity;
            root.position = summit;
        }

        // ------------------------------------------------------------------------------ the stone

        /// <summary>
        /// A throwaway copy of the stone with a collider on it, so every height below comes from
        /// the mesh the player sees instead of numbers typed in from a measuring session. The stone
        /// in the scene carries no collider and belongs to another scene; this one is destroyed
        /// before the build ends.
        /// </summary>
        private static GameObject InstantiateStoneProbe(GameObject prefab, Scene scene)
        {
            GameObject probe = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            probe.name = k_ProbeName;
            probe.transform.SetPositionAndRotation(k_StonePosition, k_StoneRotation);
            probe.transform.localScale = Vector3.one * k_StoneScale;

            MeshFilter filter = probe.GetComponentInChildren<MeshFilter>();

            if (filter == null || filter.sharedMesh == null)
            {
                UnityEngine.Object.DestroyImmediate(probe);
                throw new InvalidOperationException("StoneBasin.fbx has no mesh to measure against.");
            }

            MeshCollider collider = filter.gameObject.AddComponent<MeshCollider>();
            collider.sharedMesh = filter.sharedMesh;
            Physics.SyncTransforms();
            return probe;
        }

        /// <summary>
        /// The highest point of the dome under the falling water. Searched rather than assumed,
        /// because the stone is a scanned rock: its top is off-centre and nudging the prop in the
        /// scene moves it again.
        /// </summary>
        private static Vector3 FindSummit()
        {
            Vector3 best = Vector3.zero;
            bool found = false;

            for (float x = -k_SummitSearchRadius; x <= k_SummitSearchRadius; x += 0.03f)
            {
                for (float z = -k_SummitSearchRadius; z <= k_SummitSearchRadius; z += 0.03f)
                {
                    if (x * x + z * z > k_SummitSearchRadius * k_SummitSearchRadius)
                    {
                        continue;
                    }

                    Vector2 point = k_LandingPoint + new Vector2(x, z);

                    if (TrySampleStone(point, out float y) && (!found || y > best.y))
                    {
                        best = new Vector3(point.x, y, point.y);
                        found = true;
                    }
                }
            }

            if (!found)
            {
                throw new InvalidOperationException(
                    "No stone under the statue's fall; the prop moved, so this rig has to be re-aimed.");
            }

            return best;
        }

        /// <summary>
        /// How far the dome falls away between its summit and the pool's rim. The water cap is
        /// built that deep, so at full width its edge meets the stone instead of hanging over it.
        /// </summary>
        private static float MeasureShoulderDrop(Vector3 summit)
        {
            float radius = k_FullDiameter * 0.5f;
            float drop = 0f;
            int samples = 0;

            for (int i = 0; i < 16; i++)
            {
                float angle = i * Mathf.PI * 2f / 16f;
                Vector2 point = new Vector2(
                    summit.x + Mathf.Cos(angle) * radius,
                    summit.z + Mathf.Sin(angle) * radius);

                if (TrySampleStone(point, out float y))
                {
                    drop += summit.y - y;
                    samples++;
                }
            }

            return samples == 0 ? 0.1f : Mathf.Max(drop / samples, 0.01f);
        }

        private static bool TrySampleStone(Vector2 point, out float y)
        {
            y = float.NegativeInfinity;
            RaycastHit[] hits = Physics.RaycastAll(
                new Vector3(point.x, k_ProbeRayHeight, point.y), Vector3.down, k_ProbeRayLength);

            for (int i = 0; i < hits.Length; i++)
            {
                if (hits[i].transform.root.name == k_ProbeName && hits[i].point.y > y)
                {
                    y = hits[i].point.y;
                }
            }

            return !float.IsNegativeInfinity(y);
        }

        /// <summary>
        /// The ground the run-off soaks into: the highest surface under the stone's own base, so a
        /// ray that also clips the statue, a planter or the greenhouse roof does not become "soil".
        /// </summary>
        private static float SampleSoil(Vector2 point)
        {
            RaycastHit[] hits = Physics.RaycastAll(
                new Vector3(point.x, k_ProbeRayHeight, point.y), Vector3.down, k_ProbeRayLength);
            float best = float.NegativeInfinity;
            float ceiling = k_StonePosition.y + k_SoilSearchBand;

            for (int i = 0; i < hits.Length; i++)
            {
                if (hits[i].transform.root.name == k_ProbeName || hits[i].point.y > ceiling)
                {
                    continue;
                }

                if (hits[i].point.y > best)
                {
                    best = hits[i].point.y;
                }
            }

            return float.IsNegativeInfinity(best) ? k_StonePosition.y : best;
        }

        // ------------------------------------------------------------------------------- the pool

        private static Transform BuildSurface(Transform parent, Material water, float shoulderDrop)
        {
            Mesh mesh = BuildCapMesh(shoulderDrop);
            Mesh saved = SaveMesh(mesh, "StonePool_Surface");

            GameObject surface = new GameObject(k_SurfaceName);
            surface.transform.SetParent(parent, false);
            surface.transform.localPosition = new Vector3(0f, k_EmptyRise, 0f);
            surface.transform.localScale = new Vector3(k_EmptyDiameter, 1f, k_EmptyDiameter);
            surface.AddComponent<MeshFilter>().sharedMesh = saved;

            MeshRenderer renderer = surface.AddComponent<MeshRenderer>();
            renderer.sharedMaterial = water;
            renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;

            AddFlow(surface, new Vector2(0.03f, 0.05f));
            return surface.transform;
        }

        /// <summary>
        /// A shallow cap of unit diameter, dished to <paramref name="depth"/> at its rim. The dish
        /// is what lets one mesh serve every fill level: the component scales it in X and Z only,
        /// so a small pool sinks its rim into the stone and shows just the crown, and the full one
        /// meets the shoulder the depth was measured against.
        /// </summary>
        private static Mesh BuildCapMesh(float depth)
        {
            const int k_Rings = 8;
            const int k_Segments = 32;

            List<Vector3> vertices = new List<Vector3> { Vector3.zero };
            List<Vector2> uvs = new List<Vector2> { new Vector2(0.5f, 0.5f) };
            List<int> triangles = new List<int>();

            for (int ring = 1; ring <= k_Rings; ring++)
            {
                float t = (float)ring / k_Rings;
                float radius = 0.5f * t;

                for (int segment = 0; segment < k_Segments; segment++)
                {
                    float angle = segment * Mathf.PI * 2f / k_Segments;
                    float x = Mathf.Cos(angle) * radius;
                    float z = Mathf.Sin(angle) * radius;
                    vertices.Add(new Vector3(x, -depth * t * t, z));
                    uvs.Add(new Vector2(x + 0.5f, z + 0.5f));
                }
            }

            for (int segment = 0; segment < k_Segments; segment++)
            {
                int next = (segment + 1) % k_Segments;
                triangles.Add(0);
                triangles.Add(1 + next);
                triangles.Add(1 + segment);
            }

            for (int ring = 1; ring < k_Rings; ring++)
            {
                int inner = 1 + (ring - 1) * k_Segments;
                int outer = 1 + ring * k_Segments;

                for (int segment = 0; segment < k_Segments; segment++)
                {
                    int next = (segment + 1) % k_Segments;
                    triangles.Add(inner + segment);
                    triangles.Add(inner + next);
                    triangles.Add(outer + segment);
                    triangles.Add(outer + segment);
                    triangles.Add(inner + next);
                    triangles.Add(outer + next);
                }
            }

            Mesh mesh = new Mesh();
            mesh.name = "StonePoolCap";
            mesh.SetVertices(vertices);
            mesh.SetUVs(0, uvs);
            mesh.SetTriangles(triangles, 0);
            mesh.RecalculateNormals();
            mesh.RecalculateBounds();
            return mesh;
        }

        // -------------------------------------------------------------------------- the run-off

        /// <summary>
        /// Three ribbons off the rim, each aimed down a saddle of the dome rather than at an angle
        /// picked here: water leaves a rock where the rock is lowest, and on a scanned boulder that
        /// is somewhere different on every side.
        /// </summary>
        private static GameObject BuildSpillways(
            Transform parent, Vector3 summit, Material water, Material splash)
        {
            GameObject group = new GameObject(k_SpillwaysName);
            group.transform.SetParent(parent, false);
            group.transform.localPosition = Vector3.zero;

            float[] angles = FindSpillAngles(summit);

            for (int i = 0; i < angles.Length; i++)
            {
                List<Vector3> path = TracePath(summit, angles[i]);

                if (path.Count < 3)
                {
                    continue;
                }

                BuildRibbon(group.transform, $"Spill_{i}", path, water);
                BuildSplash(group.transform, $"Splash_Runoff_{i}", path[path.Count - 1], splash);
            }

            group.SetActive(false);
            return group;
        }

        /// <summary>The three lowest points around the rim, kept apart so the run-off does not all
        /// leave down one side of the stone.</summary>
        private static float[] FindSpillAngles(Vector3 summit)
        {
            const int k_Probes = 36;
            float radius = k_FullDiameter * 0.5f + 0.06f;
            float[] heights = new float[k_Probes];

            for (int i = 0; i < k_Probes; i++)
            {
                float angle = i * Mathf.PI * 2f / k_Probes;
                Vector2 point = new Vector2(
                    summit.x + Mathf.Cos(angle) * radius,
                    summit.z + Mathf.Sin(angle) * radius);
                heights[i] = TrySampleStone(point, out float y) ? y : float.NegativeInfinity;
            }

            List<float> chosen = new List<float>();
            bool[] taken = new bool[k_Probes];

            while (chosen.Count < k_SpillwayCount)
            {
                int best = -1;

                for (int i = 0; i < k_Probes; i++)
                {
                    if (taken[i] || float.IsNegativeInfinity(heights[i]))
                    {
                        continue;
                    }

                    if (best < 0 || heights[i] < heights[best])
                    {
                        best = i;
                    }
                }

                if (best < 0)
                {
                    break;
                }

                chosen.Add(best * Mathf.PI * 2f / k_Probes);

                // A sixth of the rim on either side is spoken for, so the ribbons spread instead
                // of crowding the single lowest saddle — and three of them still fit.
                for (int offset = -k_Probes / 6; offset <= k_Probes / 6; offset++)
                {
                    taken[((best + offset) % k_Probes + k_Probes) % k_Probes] = true;
                }
            }

            return chosen.ToArray();
        }

        /// <summary>
        /// Walks outward from the rim, riding the stone while there is stone under the path and
        /// falling to the soil once there is not, then sinking below it.
        /// </summary>
        private static List<Vector3> TracePath(Vector3 summit, float angle)
        {
            Vector2 direction = new Vector2(Mathf.Cos(angle), Mathf.Sin(angle));
            Vector2 start = new Vector2(summit.x, summit.z) + direction * (k_FullDiameter * 0.5f - 0.03f);
            List<Vector3> path = new List<Vector3>();
            int onSoil = 0;

            for (int i = 0; i < k_SpillwaySamples; i++)
            {
                Vector2 point = start + direction * (i * k_SpillwayStep);
                float soil = SampleSoil(point);

                if (onSoil == 0 && TrySampleStone(point, out float stone) && stone > soil + 0.02f)
                {
                    path.Add(new Vector3(point.x, stone + k_SpillwayClearance, point.y));
                    continue;
                }

                onSoil++;

                // Two samples on the soil read as the run-off reaching the ground; the third goes
                // under it, which is where the water is meant to end up.
                if (onSoil >= 3)
                {
                    path.Add(new Vector3(point.x, soil - k_SoakDepth, point.y));
                    break;
                }

                path.Add(new Vector3(point.x, soil + k_SpillwayClearance, point.y));
            }

            return path;
        }

        private static void BuildRibbon(Transform parent, string name, List<Vector3> path, Material water)
        {
            Mesh mesh = BuildRibbonMesh(path);
            Mesh saved = SaveMesh(mesh, "StonePool_" + name);

            GameObject ribbon = new GameObject(name);
            ribbon.transform.SetParent(parent, false);
            ribbon.transform.rotation = Quaternion.identity;
            ribbon.transform.position = path[0];
            ribbon.AddComponent<MeshFilter>().sharedMesh = saved;

            MeshRenderer renderer = ribbon.AddComponent<MeshRenderer>();
            renderer.sharedMaterial = water;
            renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;

            AddFlow(ribbon, new Vector2(0f, -0.9f));
        }

        /// <summary>
        /// A flat strip laid along the path and widened as it goes, because run-off spreads. Built
        /// in the ribbon object's local space, which is the scene's frame with the statue's yaw
        /// taken off it.
        /// </summary>
        private static Mesh BuildRibbonMesh(List<Vector3> path)
        {
            int count = path.Count;
            Vector3[] vertices = new Vector3[count * 2];
            Vector2[] uvs = new Vector2[count * 2];
            int[] triangles = new int[(count - 1) * 6];
            Vector3 origin = path[0];

            for (int i = 0; i < count; i++)
            {
                Vector3 forward = i == 0
                    ? path[1] - path[0]
                    : path[i] - path[i - 1];
                forward.y = 0f;

                if (forward.sqrMagnitude < 1e-6f)
                {
                    forward = Vector3.forward;
                }

                Vector3 side = Vector3.Cross(Vector3.up, forward.normalized);
                float t = count > 1 ? (float)i / (count - 1) : 0f;
                float half = Mathf.Lerp(k_SpillwayStartWidth, k_SpillwayEndWidth, t) * 0.5f;
                Vector3 center = path[i] - origin;

                vertices[i * 2] = center - side * half;
                vertices[i * 2 + 1] = center + side * half;
                uvs[i * 2] = new Vector2(0f, t * 4f);
                uvs[i * 2 + 1] = new Vector2(1f, t * 4f);
            }

            int index = 0;

            for (int i = 0; i < count - 1; i++)
            {
                int a = i * 2;
                int b = (i + 1) * 2;
                triangles[index++] = a;
                triangles[index++] = b;
                triangles[index++] = a + 1;
                triangles[index++] = a + 1;
                triangles[index++] = b;
                triangles[index++] = b + 1;
            }

            Mesh mesh = new Mesh();
            mesh.name = "StonePoolSpill";
            mesh.vertices = vertices;
            mesh.uv = uvs;
            mesh.triangles = triangles;
            mesh.RecalculateNormals();
            mesh.RecalculateBounds();
            return mesh;
        }

        private static void BuildSplash(Transform parent, string name, Vector3 position, Material material)
        {
            GameObject splash = new GameObject(name);
            splash.transform.SetParent(parent, false);
            splash.transform.position = position;

            ParticleSystem system = splash.AddComponent<ParticleSystem>();
            ParticleSystem.MainModule main = system.main;
            main.startLifetime = 0.5f;
            main.startSpeed = 0.7f;
            main.startSize = new ParticleSystem.MinMaxCurve(0.03f, 0.09f);
            main.startColor = new Color(0.85f, 0.93f, 1f, 0.45f);
            main.gravityModifier = 1.1f;
            main.maxParticles = 60;
            main.playOnAwake = true;

            ParticleSystem.EmissionModule emission = system.emission;
            emission.rateOverTime = 18f;

            ParticleSystem.ShapeModule shape = system.shape;
            shape.shapeType = ParticleSystemShapeType.Circle;
            shape.radius = 0.09f;

            ParticleSystemRenderer renderer = splash.GetComponent<ParticleSystemRenderer>();
            renderer.sharedMaterial = material;
            renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
        }

        // ------------------------------------------------------------------------------- wiring

        private static void AddOverflow(GameObject root, Transform surface, GameObject spillways)
        {
            RockPoolOverflow overflow = root.AddComponent<RockPoolOverflow>();
            SerializedObject serialized = new SerializedObject(overflow);
            serialized.FindProperty("m_surface").objectReferenceValue = surface;
            serialized.FindProperty("m_surfaceRenderer").objectReferenceValue =
                surface.GetComponent<Renderer>();
            serialized.FindProperty("m_emptyHeight").floatValue = k_EmptyRise;
            serialized.FindProperty("m_fullHeight").floatValue = k_FullRise;
            serialized.FindProperty("m_emptyWidth").floatValue = k_EmptyDiameter;
            serialized.FindProperty("m_fullWidth").floatValue = k_FullDiameter;
            serialized.FindProperty("m_fillSeconds").floatValue = k_FillSeconds;
            serialized.FindProperty("m_spillsAt").floatValue = k_SpillsAt;

            SerializedProperty spillwayList = serialized.FindProperty("m_spillways");
            spillwayList.arraySize = 1;
            spillwayList.GetArrayElementAtIndex(0).objectReferenceValue = spillways;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static void AddFlow(GameObject target, Vector2 speed)
        {
            WaterFlow flow = target.AddComponent<WaterFlow>();
            SerializedObject serialized = new SerializedObject(flow);
            serialized.FindProperty("m_speed").vector2Value = speed;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        // ------------------------------------------------------------------------------- helpers

        private static Transform FindWaterRoot(Scene scene)
        {
            string[] parts = k_WaterRootPath.Split('/');
            GameObject[] roots = scene.GetRootGameObjects();
            Transform current = null;

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == parts[0])
                {
                    current = roots[i].transform;
                    break;
                }
            }

            for (int i = 1; current != null && i < parts.Length; i++)
            {
                current = current.Find(parts[i]);
            }

            if (current == null)
            {
                throw new InvalidOperationException(
                    "The greenhouse environment scene has no " + k_WaterRootPath + " to hang the pool on.");
            }

            return current;
        }

        private static void RemoveExistingRoot(Transform parent)
        {
            Transform existing = parent.Find(k_RootName);

            if (existing != null)
            {
                UnityEngine.Object.DestroyImmediate(existing.gameObject);
            }
        }

        private static Mesh SaveMesh(Mesh mesh, string name)
        {
            string path = $"{k_MeshFolder}/{name}.asset";
            AssetDatabase.DeleteAsset(path);
            AssetDatabase.CreateAsset(mesh, path);
            return AssetDatabase.LoadAssetAtPath<Mesh>(path);
        }

        private static void ThrowIfAnyOpenSceneIsDirty()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.isDirty)
                {
                    throw new InvalidOperationException(
                        "Stone pool build stopped because an open scene has unsaved changes: " + scene.path);
                }
            }
        }

        private static T LoadAsset<T>(string path) where T : UnityEngine.Object
        {
            T asset = AssetDatabase.LoadAssetAtPath<T>(path);

            if (asset == null)
            {
                throw new System.IO.FileNotFoundException("Stone pool dependency was not found: " + path);
            }

            return asset;
        }
    }
}

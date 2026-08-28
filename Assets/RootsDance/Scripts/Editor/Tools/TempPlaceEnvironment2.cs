using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Temporary one-off: imports the new props and places them in Main_Environment_2.
    /// <para>
    /// Main_Environment_2 is an additive *content* part: it is loaded on top of Main_Environment
    /// (terrain, lighting) and Main_Gameplay, so it must carry neither a camera nor a light of its
    /// own, and the props must be snapped to the terrain that lives in the other scene. Both are
    /// this tool's job — it opens Main_Environment purely to read the terrain and never saves it.
    /// </para>
    /// <para>
    /// The models arrive from Blender with the Z-up conversion left on the FBX root
    /// (<c>rotation (90, 0, 0)</c>), so an authored yaw is applied <em>on top of</em> that rotation.
    /// Assigning a plain <c>Quaternion.Euler(0, yaw, 0)</c> would drop the conversion and tip the
    /// prop onto its nose.
    /// </para>
    /// Menu: RootsDance > Place Environment 2 Props.
    /// </summary>
    public static class TempPlaceEnvironment2
    {
        private const string k_Environment = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment.unity";
        private const string k_Scene = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_2.unity";
        private const string k_Car = "Assets/RootsDance/Meshes/Environment/CarRustyOpenDoor.fbx";
        private const string k_Flashlight = "Assets/RootsDance/Meshes/Props/Flashlight.fbx";
        private const string k_Poster = "Assets/RootsDance/Meshes/Environment/BandPoster.fbx";
        private const string k_ScanPoster = "Assets/RootsDance/Meshes/Environment/SHA2017Poster.obj";

        /// <summary>
        /// Which way the poster's printed face looks after the FBX axis conversion. The Maya
        /// source hangs it in the XY plane with the pushpins protruding towards -Z, so this is the
        /// yaw that turns that face back towards the player spawn at (0, -10).
        /// </summary>
        private const float k_PosterYaw = 20f;

        /// <summary>Objects the default new-scene template ships that an additive part must not keep.</summary>
        private static readonly string[] k_TemplateObjects = { "Main Camera", "Directional Light" };

        [MenuItem("RootsDance/Place Environment 2 Props")]
        public static void Run()
        {
            AssetDatabase.Refresh();

            PropMaterialBuilder.Build();

            AssetDatabase.ImportAsset(k_Car, ImportAssetOptions.ForceUpdate);
            AssetDatabase.ImportAsset(k_Flashlight, ImportAssetOptions.ForceUpdate);
            AssetDatabase.ImportAsset(k_Poster, ImportAssetOptions.ForceUpdate);
            AssetDatabase.ImportAsset(k_ScanPoster, ImportAssetOptions.ForceUpdate);
            AssetDatabase.Refresh();

            // Main_Environment only supplies the terrain to sample against; it is never saved.
            EditorSceneManager.OpenScene(k_Environment, OpenSceneMode.Single);
            Scene scene = EditorSceneManager.OpenScene(k_Scene, OpenSceneMode.Additive);

            Terrain terrain = Object.FindFirstObjectByType<Terrain>();

            if (terrain == null)
            {
                Debug.LogError("TempPlaceEnvironment2: no Terrain in Main_Environment; cannot snap.");
                return;
            }

            StripTemplateObjects(scene);

            // The player spawns at (0, ~3, -10) looking down +Z. The torch lies just in front of
            // the spawn where it reads as a pickup; the wreck sits further up the path on the one
            // patch that is both clear of vegetation and flat enough for a 4 m body (the ridge
            // around (7, 4) is inside a thicket and hides it completely).
            Place(scene, terrain, k_Car, "CarRustyOpenDoor", new Vector2(8f, 26f), 35f, 0.15f);
            Place(scene, terrain, k_Flashlight, "Flashlight", new Vector2(0.8f, -7.5f), -25f, 0f);

            // The poster is a flat sheet, so it is the one prop that must stay upright: laying it
            // along the slope would tip a hanging print onto its face. It stands just left of the
            // spawn, turned back towards it, with its bottom edge on the ground.
            Place(scene, terrain, k_Poster, "BandPoster", new Vector2(-2.2f, -6.5f), k_PosterYaw, 0f,
                alignToSlope: false);

            // The SHA2017 scan is not a sheet but a 3.7 x 2.4 x 2.4 m photogrammetry chunk that
            // stands on its own base, so it beds into the slope like the wreck does. It sits off
            // the path to the left, turned towards it.
            Place(scene, terrain, k_ScanPoster, "SHA2017Poster", new Vector2(-6.5f, 1f), 110f, 0.05f);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            AssetDatabase.SaveAssets();

            Debug.Log("TempPlaceEnvironment2: done.");
        }

        /// <summary>Drops the camera and light the "new scene" template left behind.</summary>
        private static void StripTemplateObjects(Scene scene)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                for (int i = 0; i < k_TemplateObjects.Length; i++)
                {
                    if (root.name != k_TemplateObjects[i])
                    {
                        continue;
                    }

                    Debug.Log($"TempPlaceEnvironment2: removed '{root.name}' — an additive part "
                        + "must not add a second camera or light.");
                    Object.DestroyImmediate(root);
                    break;
                }
            }
        }

        /// <param name="sink">
        /// How far the snapped body is pushed back into the ground, so a wide prop on uneven
        /// terrain beds in instead of showing a gap under its low corner.
        /// </param>
        /// <param name="alignToSlope">
        /// Whether the prop lies along the ground normal. A body that rests on the ground does;
        /// anything that reads as upright — a poster, a sign — must not, or it leans with the hill.
        /// </param>
        private static void Place(Scene scene, Terrain terrain, string modelPath, string name,
            Vector2 groundXZ, float yaw, float sink, bool alignToSlope = true)
        {
            GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(modelPath);

            if (model == null)
            {
                Debug.LogError($"TempPlaceEnvironment2: '{modelPath}' did not import.");
                return;
            }

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == name)
                {
                    Object.DestroyImmediate(root);
                }
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(model, scene);
            instance.name = name;

            Vector3 spot = new Vector3(groundXZ.x, 0f, groundXZ.y);

            // Lie along the slope, then yaw, then the import rotation — which is never replaced,
            // only composed onto (see the class remarks).
            Quaternion tilt = alignToSlope
                ? Quaternion.FromToRotation(Vector3.up, GroundNormal(terrain, spot))
                : Quaternion.identity;
            instance.transform.rotation = tilt * Quaternion.Euler(0f, yaw, 0f) * model.transform.rotation;
            instance.transform.position = spot;

            // Snap by measured bounds rather than by pivot: the FBX pivots are not on the footprint.
            // The mean height beds the prop into the slope; snapping to the highest point under it
            // would leave the downhill end hanging in the air.
            Bounds bounds = Measure(instance);
            float ground = MeanGroundUnder(terrain, bounds);
            instance.transform.position += new Vector3(0f, ground - sink - bounds.min.y, 0f);

            bounds = Measure(instance);

            Debug.Log($"[{name}] size {bounds.size:F3} at {instance.transform.position:F3} "
                + $"(ground {ground:F2}, bounds.min.y {bounds.min.y:F3})");
        }

        /// <summary>The terrain's surface normal at a world point, for laying a prop along a slope.</summary>
        private static Vector3 GroundNormal(Terrain terrain, Vector3 world)
        {
            Vector3 local = world - terrain.transform.position;
            Vector3 size = terrain.terrainData.size;

            return terrain.terrainData.GetInterpolatedNormal(local.x / size.x, local.z / size.z);
        }

        /// <summary>
        /// The mean terrain height under a prop's footprint. Sampling only the pivot tips anything
        /// wide enough to matter into, or out of, the slope it stands on.
        /// </summary>
        private static float MeanGroundUnder(Terrain terrain, Bounds bounds)
        {
            const int k_Steps = 4;
            float total = 0f;
            int count = 0;

            for (int ix = 0; ix <= k_Steps; ix++)
            {
                for (int iz = 0; iz <= k_Steps; iz++)
                {
                    Vector3 point = new Vector3(
                        Mathf.Lerp(bounds.min.x, bounds.max.x, ix / (float)k_Steps),
                        0f,
                        Mathf.Lerp(bounds.min.z, bounds.max.z, iz / (float)k_Steps));

                    total += terrain.SampleHeight(point) + terrain.transform.position.y;
                    count++;
                }
            }

            return total / count;
        }

        private static Bounds Measure(GameObject instance)
        {
            Bounds bounds = new Bounds(instance.transform.position, Vector3.zero);
            bool first = true;

            foreach (Renderer renderer in instance.GetComponentsInChildren<Renderer>())
            {
                if (first)
                {
                    bounds = renderer.bounds;
                    first = false;
                }
                else
                {
                    bounds.Encapsulate(renderer.bounds);
                }
            }

            return bounds;
        }
    }
}

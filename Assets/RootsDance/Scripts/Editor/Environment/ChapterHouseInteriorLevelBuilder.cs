using System;
using System.Collections.Generic;
using System.Linq;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Editor.DevPlay;
using RootsDance.Investigation;
using Unity.Cinemachine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Builds the chapter house interior level from the imported chapel mesh: an environment scene
    /// carrying the building, its materials and its lighting, and a gameplay scene carrying the
    /// player, camera and anchors — the same two-scene shape every other level here has.
    /// <para>
    /// The mesh keeps its authored scale. It measures 20.8 m across, 29.6 m deep and 20.8 m tall,
    /// which is a real chapter house next to a 1.8 m player, so scaling it would only make the
    /// building lie about its own size. It is centred on X/Z and grounded at Y 0 instead, because
    /// the OBJ was authored around the modeller's origin, not ours.
    /// </para>
    /// Repeatable: re-running rebuilds both scenes from scratch and re-points the level asset and
    /// checkpoints, so it is the one place the layout is authored.
    /// Menu: RootsDance &gt; Build Chapter House Interior.
    /// </summary>
    public static class ChapterHouseInteriorLevelBuilder
    {
        private const string k_LevelName = "ChapterHouseInterior";
        private const string k_LevelFolder = "Assets/RootsDance/Scenes/Levels/" + k_LevelName;
        private const string k_LevelAssetPath = "Assets/RootsDance/Data/Levels/" + k_LevelName + ".asset";
        private const string k_CheckpointFolder = "Assets/RootsDance/Data/DevPlay/" + k_LevelName;
        private const string k_PlayerPrefabPath = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_ModelPath =
            "Assets/RootsDance/Meshes/Environment/ChapterHouse/ChapterHouse.obj";
        private const string k_MaterialFolder = "Assets/RootsDance/Materials/Environment/ChapterHouse";
        private const string k_TextureFolder = "Assets/RootsDance/Textures/Environment/ChapterHouse";
        private const string k_VolumeProfilePath =
            "Assets/RootsDance/Settings/VolumeProfiles/MainProfile.asset";

        private const string k_NaveAnchor = "Checkpoint_ChapterHouseNave";
        private const string k_GalleryAnchor = "Checkpoint_ChapterHouseGallery";

        /// <summary>
        /// Every material the OBJ declares, and the texture set each one wears. Base and normal
        /// names are the files in <see cref="k_TextureFolder"/>; empty means the material has no
        /// map of that kind and stays a flat surface.
        /// <para>
        /// The mapping is by hand because the authored names do not line up with the texture names
        /// on their own — the MTL spells one of them "panles_plasterwood", the roof bake is
        /// prefixed "New", and the balustrade shouts. Matching them loosely in code would paper
        /// over exactly the cases worth seeing.
        /// </para>
        /// </summary>
        private static readonly SurfaceMapping[] k_Surfaces =
        {
            new SurfaceMapping("lower_floor", "lower_floor", null),
            new SurfaceMapping("lower_columns", "lower_columns", null),
            new SurfaceMapping("lower_doors", "lower_doors", null),
            new SurfaceMapping("lower_pianochamber", "lower_pianochamber", null),
            new SurfaceMapping("panels_stonewood", "panels_stonewood", null),
            new SurfaceMapping("panles_plasterwood", "panels_plasterwood", null),
            new SurfaceMapping("upper_balustrade", "UPPER_BALUSTRADE", null),
            new SurfaceMapping("upper_gallerywood", "upper_gallerywood", null),
            new SurfaceMapping("upper_roof", "Newupper_roof", null),
            new SurfaceMapping("upper_sidecolumns", "upper_sidecolumns", null),
            new SurfaceMapping("wall_archwindows", "wall_archwindows", null),
            new SurfaceMapping("wall_balconyside", "wall_balconyside", null),
            new SurfaceMapping("wall_fourclo", "wall_fourclo", null),
            new SurfaceMapping("wall_galleryside", "wall_galleryside", null),
            new SurfaceMapping("wall_pianoside", "wall_pianoside", null),

            // The glazing. "fourclo" is the quatrefoil — the round opening the building is known
            // by here — and it takes the circular window set.
            new SurfaceMapping("Window_fourclo", "windowcircle_bw", "windowcircle_nrm"),
            new SurfaceMapping("Window_small", "windowsmall_bw", "windowsmall_nrm"),
            new SurfaceMapping("Windwo_test", "windowlarge_bw", "windowlarge_nrm"),

            // The three bakes with no surface of their own: a gradient wash the author used for
            // ambient tint, and two odds and ends.
            new SurfaceMapping("Material.001", "gradbake", null),
            new SurfaceMapping("emission", "gradbake", null),
            new SurfaceMapping("bacl", "plane", null),
        };

        private static readonly CheckpointPlacement[] k_CheckpointPlacements =
        {
            new CheckpointPlacement(k_NaveAnchor, new Vector3(0f, 1f, -11f), 0f),
            new CheckpointPlacement(k_GalleryAnchor, new Vector3(0f, 1f, 4f), 180f),
        };

        [MenuItem("RootsDance/Build Chapter House Interior")]
        public static void Build()
        {
            ThrowIfAnyOpenSceneIsDirty();

            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();
            LevelSO level = null;

            try
            {
                AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
                EnsureFolder(k_LevelFolder);
                EnsureFolder(k_CheckpointFolder);
                EnsureFolder(k_MaterialFolder);

                ConfigureModelImporter();
                ConfigureTextureImporters();
                Dictionary<string, Material> materials = EnsureMaterials();
                Bounds bounds = BuildEnvironmentScene(materials);
                BuildGameplayScene();
                level = CreateLevelAsset();
                CreateCheckpointAssets(level);
                RegisterScenesInBuildSettings();
                AssetDatabase.SaveAssets();

                Log.Info($"Built the chapter house interior: {bounds.size.x:F1} x {bounds.size.z:F1} m "
                    + $"footprint, {bounds.size.y:F1} m tall, grounded at Y 0.", level);
            }
            finally
            {
                bool hasLoadedScene = originalSetup.Any(setup => setup.isLoaded);

                if (hasLoadedScene)
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

        private static void ThrowIfAnyOpenSceneIsDirty()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.isDirty)
                {
                    throw new InvalidOperationException(
                        "ChapterHouseInterior build stopped because an open scene has unsaved changes: "
                        + scene.path);
                }
            }
        }

        // ---- Materials -------------------------------------------------------------------------

        /// <summary>
        /// The OBJ arrives with one child object per authored group, which is what the material
        /// mapping keys off. Scale stays 1 — the mesh is already in metres — and normals are
        /// imported rather than recalculated, because a chapel's flat panels and its curved vaults
        /// need different smoothing and the author already decided which is which.
        /// </summary>
        private static void ConfigureModelImporter()
        {
            ModelImporter importer = AssetImporter.GetAtPath(k_ModelPath) as ModelImporter;

            if (importer == null)
            {
                throw new System.IO.FileNotFoundException("Chapter house model missing: " + k_ModelPath);
            }

            bool changed = false;

            if (!Mathf.Approximately(importer.globalScale, 1f))
            {
                importer.globalScale = 1f;
                changed = true;
            }

            if (importer.importNormals != ModelImporterNormals.Import)
            {
                importer.importNormals = ModelImporterNormals.Import;
                changed = true;
            }

            if (!importer.isReadable)
            {
                // Left readable so the bounds pass and any later collider bake can see the mesh.
                importer.isReadable = true;
                changed = true;
            }

            if (changed)
            {
                importer.SaveAndReimport();
            }
        }

        /// <summary>
        /// Normal maps have to be marked as such at import or HDRP reads them as colour. The rest
        /// of the set is left alone: they are baked colour, which is what the default importer
        /// already assumes.
        /// </summary>
        private static void ConfigureTextureImporters()
        {
            for (int i = 0; i < k_Surfaces.Length; i++)
            {
                string normalName = k_Surfaces[i].NormalTexture;

                if (string.IsNullOrEmpty(normalName))
                {
                    continue;
                }

                string path = $"{k_TextureFolder}/{normalName}.png";
                TextureImporter importer = AssetImporter.GetAtPath(path) as TextureImporter;

                if (importer == null)
                {
                    throw new System.IO.FileNotFoundException("Chapter house texture missing: " + path);
                }

                if (importer.textureType == TextureImporterType.NormalMap)
                {
                    continue;
                }

                importer.textureType = TextureImporterType.NormalMap;
                importer.SaveAndReimport();
            }
        }

        /// <summary>
        /// The materials, keyed by every name a renderer might be found under: the authored
        /// material name and the texture name. Both are needed — the MTL writes the plaster panels
        /// as "panles_plasterwood" while the mesh object spells them "panels_plasterwood", and
        /// whichever of the two a given importer surfaces, the surface still has to be found.
        /// </summary>
        private static Dictionary<string, Material> EnsureMaterials()
        {
            Dictionary<string, Material> byKey =
                new Dictionary<string, Material>(k_Surfaces.Length * 2, StringComparer.Ordinal);

            for (int i = 0; i < k_Surfaces.Length; i++)
            {
                SurfaceMapping surface = k_Surfaces[i];
                Material material = EnsureMaterial(surface);
                byKey[Normalize(surface.MaterialName)] = material;

                string textureKey = Normalize(surface.BaseTexture);

                if (!string.IsNullOrEmpty(textureKey) && !byKey.ContainsKey(textureKey))
                {
                    byKey[textureKey] = material;
                }
            }

            return byKey;
        }

        /// <summary>
        /// Lower-cased letters and digits only. Authored names differ by case, underscores,
        /// hyphens and Blender's ".003" suffixes, none of which mean anything here.
        /// </summary>
        private static string Normalize(string name)
        {
            if (string.IsNullOrEmpty(name))
            {
                return string.Empty;
            }

            System.Text.StringBuilder builder = new System.Text.StringBuilder(name.Length);

            for (int i = 0; i < name.Length; i++)
            {
                char character = name[i];

                if (char.IsLetterOrDigit(character))
                {
                    builder.Append(char.ToLowerInvariant(character));
                }
            }

            return builder.ToString();
        }

        private static Material EnsureMaterial(SurfaceMapping surface)
        {
            string path = $"{k_MaterialFolder}/ChapterHouse_{surface.MaterialName}.mat";
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);
            bool isNew = material == null;

            if (isNew)
            {
                Shader lit = Shader.Find("HDRP/Lit");

                if (lit == null)
                {
                    throw new InvalidOperationException("HDRP/Lit shader was not found.");
                }

                material = new Material(lit);
            }

            material.SetTexture("_BaseColorMap", LoadTexture(surface.BaseTexture));
            material.SetColor("_BaseColor", Color.white);

            // The bakes carry all the shading the author intended; a specular response on top of
            // them would read as a second, wrong light.
            material.SetFloat("_Smoothness", 0.08f);
            material.SetFloat("_Metallic", 0f);

            if (!string.IsNullOrEmpty(surface.NormalTexture))
            {
                material.SetTexture("_NormalMap", LoadTexture(surface.NormalTexture));
                material.SetFloat("_NormalScale", 1f);
                material.EnableKeyword("_NORMALMAP");
            }

            // Chapel walls, glazing and balustrades are all single-sided planes in this mesh — the
            // whole building disappears from the inside without this, which is the only side the
            // level is ever seen from.
            material.SetFloat("_DoubleSidedEnable", 1f);
            material.SetFloat("_DoubleSidedNormalMode", 1f);
            material.enableInstancing = true;

            HDMaterial.ValidateMaterial(material);

            if (isNew)
            {
                AssetDatabase.CreateAsset(material, path);
            }
            else
            {
                EditorUtility.SetDirty(material);
            }

            return material;
        }

        private static Texture LoadTexture(string textureName)
        {
            if (string.IsNullOrEmpty(textureName))
            {
                return null;
            }

            string path = $"{k_TextureFolder}/{textureName}.png";
            Texture texture = AssetDatabase.LoadAssetAtPath<Texture>(path);

            if (texture == null)
            {
                throw new System.IO.FileNotFoundException("Chapter house texture missing: " + path);
            }

            return texture;
        }

        // ---- Environment scene -----------------------------------------------------------------

        private static Bounds BuildEnvironmentScene(Dictionary<string, Material> materials)
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            Transform lighting = CreateRoot("_Lighting");
            Transform geometry = CreateRoot("_Geometry");
            Transform buildingRoot = CreateChild("ChapterHouseRoot", geometry);
            Transform props = CreateRoot("_Props");
            CreateRoot("_NavMesh");

            GameObject building = InstantiateModel(k_ModelPath, "ChapterHouse", buildingRoot, scene);
            Bounds bounds = GroundModel(building);
            ApplyMaterials(building, materials);
            SetStatic(building);

            CreateLighting(lighting, bounds);
            CreateWalkableFloor(geometry, bounds);
            CreateScaleReference(props);

            EditorSceneManager.SaveScene(scene, ScenePaths.k_ChapterHouseInteriorEnvironment);
            return bounds;
        }

        /// <summary>
        /// Centres the building on X/Z and sets its floor on Y 0, at the mesh's authored scale.
        /// </summary>
        private static Bounds GroundModel(GameObject building)
        {
            Bounds bounds = GetRendererBounds(building);

            if (bounds.size.y <= 0f)
            {
                throw new InvalidOperationException("The chapter house renderer bounds have no height.");
            }

            building.transform.position += new Vector3(
                -bounds.center.x,
                -bounds.min.y,
                -bounds.center.z);

            return GetRendererBounds(building);
        }

        /// <summary>
        /// Puts the built materials onto the imported mesh. A slot is identified by its own
        /// material name first and by the object it sits on second, because whether an OBJ import
        /// surfaces the authored material names at all depends on importer settings, while the
        /// object names ("lower_floor_Plane") carry the same information either way.
        /// </summary>
        private static void ApplyMaterials(GameObject building, Dictionary<string, Material> materials)
        {
            Renderer[] renderers = building.GetComponentsInChildren<Renderer>(true);
            int assignedCount = 0;
            List<string> unmapped = new List<string>();

            for (int rendererIndex = 0; rendererIndex < renderers.Length; rendererIndex++)
            {
                Renderer renderer = renderers[rendererIndex];
                Material[] assigned = renderer.sharedMaterials;
                Material byObject = Match(materials, renderer.gameObject.name);

                for (int materialIndex = 0; materialIndex < assigned.Length; materialIndex++)
                {
                    Material source = assigned[materialIndex];
                    Material replacement = source == null
                        ? byObject
                        : Match(materials, source.name) ?? byObject;

                    if (replacement != null)
                    {
                        assigned[materialIndex] = replacement;
                        assignedCount++;
                        continue;
                    }

                    string reported = source == null ? renderer.gameObject.name : source.name;

                    if (!unmapped.Contains(reported))
                    {
                        unmapped.Add(reported);
                    }
                }

                renderer.sharedMaterials = assigned;
            }

            if (assignedCount == 0)
            {
                throw new InvalidOperationException(
                    "No chapter house material slot matched the mapping; the mesh import changed.");
            }

            if (unmapped.Count > 0)
            {
                Debug.LogWarning("[ChapterHouse] These slots have no mapping and keep the import "
                    + "default: " + string.Join(", ", unmapped));
            }
        }

        /// <summary>
        /// The surface whose key the name starts with, longest key first so "windowsmall" is not
        /// stolen by a shorter "window". Null when nothing matches.
        /// </summary>
        private static Material Match(Dictionary<string, Material> materials, string name)
        {
            string normalized = Normalize(name);

            if (normalized.Length == 0)
            {
                return null;
            }

            if (materials.TryGetValue(normalized, out Material exact))
            {
                return exact;
            }

            Material best = null;
            int bestLength = 0;

            foreach (KeyValuePair<string, Material> entry in materials)
            {
                if (entry.Key.Length > bestLength && normalized.StartsWith(entry.Key, StringComparison.Ordinal))
                {
                    best = entry.Value;
                    bestLength = entry.Key.Length;
                }
            }

            return best;
        }

        /// <summary>
        /// Daylight through the glazing plus a low interior fill. A chapter house is read by its
        /// height, and height only reads when the upper walls catch light the floor does not.
        /// </summary>
        private static void CreateLighting(Transform parent, Bounds bounds)
        {
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_VolumeProfilePath);

            if (profile == null)
            {
                throw new System.IO.FileNotFoundException(
                    "The base volume profile was not found: " + k_VolumeProfilePath);
            }

            GameObject volumeObject = new GameObject("Global Volume");
            volumeObject.transform.SetParent(parent, false);
            Volume volume = volumeObject.AddComponent<Volume>();
            volume.isGlobal = true;
            volume.priority = 0f;
            volume.weight = 1f;
            volume.sharedProfile = profile;

            GameObject sunObject = new GameObject("Sun");
            sunObject.transform.SetParent(parent, false);
            sunObject.transform.rotation = Quaternion.Euler(38f, -35f, 0f);
            Light sun = sunObject.AddComponent<Light>();
            sun.type = LightType.Directional;
            sun.intensity = 10000f;
            sun.colorTemperature = 5200f;
            sun.useColorTemperature = true;
            sun.shadows = LightShadows.Soft;

            float halfDepth = bounds.size.z * 0.5f;
            float upper = bounds.size.y * 0.62f;
            float lower = bounds.size.y * 0.22f;

            CreateFillLight(parent, "ChapterHouseFill_NaveHigh", new Vector3(0f, upper, -halfDepth * 0.45f));
            CreateFillLight(parent, "ChapterHouseFill_CrossingHigh", new Vector3(0f, upper, halfDepth * 0.2f));
            CreateFillLight(parent, "ChapterHouseFill_NaveLow", new Vector3(0f, lower, -halfDepth * 0.55f));
            CreateFillLight(parent, "ChapterHouseFill_CrossingLow", new Vector3(0f, lower, halfDepth * 0.3f));
        }

        private static void CreateFillLight(Transform parent, string name, Vector3 position)
        {
            GameObject lightObject = new GameObject(name);
            lightObject.transform.SetParent(parent, false);
            lightObject.transform.localPosition = position;
            Light light = lightObject.AddComponent<Light>();
            light.type = LightType.Point;
            light.intensity = 180000f;
            light.range = 26f;
            light.color = new Color(0.86f, 0.84f, 0.78f);
            light.shadows = LightShadows.None;
        }

        /// <summary>
        /// A flat collider under the whole footprint. The mesh's own floor is a single-sided plane
        /// with no collider, and grey-boxing a level on geometry that cannot be stood on is the
        /// fastest way to make it untestable.
        /// </summary>
        private static void CreateWalkableFloor(Transform parent, Bounds bounds)
        {
            GameObject floor = new GameObject("WalkableFloor");
            floor.transform.SetParent(parent, false);
            floor.transform.position = new Vector3(0f, -0.1f, 0f);
            floor.layer = LayerMask.NameToLayer("Ground");
            floor.isStatic = true;
            BoxCollider collider = floor.AddComponent<BoxCollider>();
            collider.size = new Vector3(bounds.size.x, 0.2f, bounds.size.z);
        }

        private static void CreateScaleReference(Transform parent)
        {
            GameObject marker = new GameObject("PlayerHeightReference_1p8m");
            marker.transform.SetParent(parent, false);
            marker.transform.localPosition = new Vector3(2f, 0.9f, 0f);
            BoxCollider collider = marker.AddComponent<BoxCollider>();
            collider.size = new Vector3(0.1f, 1.8f, 0.1f);
            collider.isTrigger = true;
            marker.SetActive(false);
        }

        // ---- Gameplay scene --------------------------------------------------------------------

        private static void BuildGameplayScene()
        {
            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            Transform cameras = CreateRoot("_Cameras");
            Transform spawns = CreateRoot("_Spawns");
            CreateRoot("_Triggers");
            CreateRoot("_Interactables");
            CreateRoot("_Narrative");
            Transform anchors = CreateRoot("_Anchors");

            for (int i = 0; i < k_CheckpointPlacements.Length; i++)
            {
                CheckpointPlacement placement = k_CheckpointPlacements[i];
                GameObject anchor = new GameObject(placement.AnchorName);
                anchor.transform.SetParent(anchors, false);
                anchor.transform.SetPositionAndRotation(
                    placement.Position,
                    Quaternion.Euler(0f, placement.Yaw, 0f));
            }

            CheckpointPlacement entrance = k_CheckpointPlacements[0];
            GameObject spawnPoint = new GameObject("PlayerSpawn");
            spawnPoint.transform.SetParent(spawns, false);
            spawnPoint.transform.SetPositionAndRotation(
                entrance.Position,
                Quaternion.Euler(0f, entrance.Yaw, 0f));

            GameObject playerPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_PlayerPrefabPath);

            if (playerPrefab == null)
            {
                throw new System.IO.FileNotFoundException(
                    "Player prefab was not found: " + k_PlayerPrefabPath);
            }

            GameObject player = (GameObject)PrefabUtility.InstantiatePrefab(playerPrefab, scene);
            player.transform.SetPositionAndRotation(
                spawnPoint.transform.position, spawnPoint.transform.rotation);
            player.transform.localScale = Vector3.one;
            CreateFirstPersonCamera(cameras, player.transform);

            EditorSceneManager.SaveScene(scene, ScenePaths.k_ChapterHouseInteriorGameplay);
        }

        private static void CreateFirstPersonCamera(Transform cameras, Transform player)
        {
            Transform head = player.Find("Head");

            if (head == null)
            {
                head = player.Find("m_head");
            }

            if (head == null)
            {
                throw new InvalidOperationException("Player prefab has no Head or m_head child.");
            }

            GameObject cameraRig = new GameObject("FirstPersonCamera");
            cameraRig.transform.SetParent(cameras, false);
            CinemachineCamera camera = cameraRig.AddComponent<CinemachineCamera>();
            camera.Target.TrackingTarget = head;
            CinemachineHardLockToTarget positionControl = cameraRig.AddComponent<CinemachineHardLockToTarget>();
            positionControl.Damping = 0.05f;
            CinemachineRotateWithFollowTarget rotationControl =
                cameraRig.AddComponent<CinemachineRotateWithFollowTarget>();
            rotationControl.Damping = 0.05f;
        }

        // ---- Level and checkpoints -------------------------------------------------------------

        private static LevelSO CreateLevelAsset()
        {
            EnsureFolder("Assets/RootsDance/Data/Levels");
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_LevelAssetPath);
            bool isNew = level == null;

            if (isNew)
            {
                level = ScriptableObject.CreateInstance<LevelSO>();
            }

            SerializedObject serialized = new SerializedObject(level);
            SerializedProperty scenePaths = serialized.FindProperty("m_scenePaths");
            scenePaths.arraySize = 2;
            scenePaths.GetArrayElementAtIndex(0).stringValue =
                ScenePaths.k_ChapterHouseInteriorEnvironment;
            scenePaths.GetArrayElementAtIndex(1).stringValue =
                ScenePaths.k_ChapterHouseInteriorGameplay;
            serialized.ApplyModifiedProperties();

            if (isNew)
            {
                AssetDatabase.CreateAsset(level, k_LevelAssetPath);
            }
            else
            {
                EditorUtility.SetDirty(level);
            }

            AssetDatabase.SaveAssetIfDirty(level);
            return level;
        }

        private static void CreateCheckpointAssets(LevelSO level)
        {
            CreateCheckpoint(
                k_CheckpointFolder + "/CH-01_ChapterHouseNave.asset",
                "CH-01 Chapter house nave",
                level,
                k_CheckpointPlacements[0]);
            CreateCheckpoint(
                k_CheckpointFolder + "/CH-02_ChapterHouseGallery.asset",
                "CH-02 Chapter house gallery",
                level,
                k_CheckpointPlacements[1]);
        }

        private static void CreateCheckpoint(
            string assetPath, string label, LevelSO level, CheckpointPlacement placement)
        {
            DevCheckpointSO checkpoint = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(assetPath);
            bool isNew = checkpoint == null;

            if (isNew)
            {
                checkpoint = ScriptableObject.CreateInstance<DevCheckpointSO>();
            }

            // No story flags: the building has no place in the script yet, so this is a walk-in
            // for looking at it, not a rehearsal of a beat.
            checkpoint.Configure(
                label,
                level,
                placement.AnchorName,
                placement.Position,
                placement.Yaw,
                CheckpointTimeOfDay.LevelDefault,
                new string[0],
                new InvestigationTargetSO[0]);

            SerializedObject serialized = new SerializedObject(checkpoint);
            serialized.FindProperty("m_snapToGround").boolValue = false;
            serialized.FindProperty("m_groundClearance").floatValue = 0f;
            serialized.ApplyModifiedProperties();

            if (isNew)
            {
                AssetDatabase.CreateAsset(checkpoint, assetPath);
            }
            else
            {
                EditorUtility.SetDirty(checkpoint);
            }

            AssetDatabase.SaveAssetIfDirty(checkpoint);
        }

        private static void RegisterScenesInBuildSettings()
        {
            List<EditorBuildSettingsScene> scenes = EditorBuildSettings.scenes.ToList();
            AddSceneIfMissing(scenes, ScenePaths.k_ChapterHouseInteriorEnvironment);
            AddSceneIfMissing(scenes, ScenePaths.k_ChapterHouseInteriorGameplay);
            EditorBuildSettings.scenes = scenes.ToArray();
        }

        private static void AddSceneIfMissing(List<EditorBuildSettingsScene> scenes, string path)
        {
            int existingIndex = scenes.FindIndex(scene => scene.path == path);

            if (existingIndex >= 0)
            {
                scenes[existingIndex] = new EditorBuildSettingsScene(path, true);
                return;
            }

            scenes.Add(new EditorBuildSettingsScene(path, true));
        }

        // ---- Scene helpers ---------------------------------------------------------------------

        private static Transform CreateRoot(string name)
        {
            GameObject root = new GameObject(name);
            root.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
            root.transform.localScale = Vector3.one;
            return root.transform;
        }

        private static Transform CreateChild(string name, Transform parent)
        {
            Transform child = CreateRoot(name);
            child.SetParent(parent, false);
            return child;
        }

        private static GameObject InstantiateModel(string path, string name, Transform parent, Scene scene)
        {
            GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(path);

            if (model == null)
            {
                throw new System.IO.FileNotFoundException("Model was not imported: " + path);
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(model, scene);
            instance.name = name;
            instance.transform.SetParent(parent, false);
            instance.transform.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
            instance.transform.localScale = Vector3.one;
            return instance;
        }

        private static Bounds GetRendererBounds(GameObject root)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);

            if (renderers.Length == 0)
            {
                throw new InvalidOperationException("Model has no renderers: " + root.name);
            }

            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds;
        }

        private static void SetStatic(GameObject root)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                transforms[i].gameObject.isStatic = true;
            }
        }

        private static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = System.IO.Path.GetDirectoryName(path).Replace('\\', '/');
            string folderName = System.IO.Path.GetFileName(path);
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, folderName);
        }

        private readonly struct SurfaceMapping
        {
            public SurfaceMapping(string materialName, string baseTexture, string normalTexture)
            {
                MaterialName = materialName;
                BaseTexture = baseTexture;
                NormalTexture = normalTexture;
            }

            public string MaterialName { get; }
            public string BaseTexture { get; }
            public string NormalTexture { get; }
        }

        private struct CheckpointPlacement
        {
            public CheckpointPlacement(string anchorName, Vector3 position, float yaw)
            {
                AnchorName = anchorName;
                Position = position;
                Yaw = yaw;
            }

            public string AnchorName;
            public Vector3 Position;
            public float Yaw;
        }
    }
}

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
using UnityEditor.Animations;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Builds the chapter house interior level from the <em>dressed</em> chapel: an environment
    /// scene carrying the building, its materials, its collision and its lighting, and a gameplay
    /// scene carrying the player, camera and anchors — the same two-scene shape every other level
    /// here has.
    /// <para>
    /// The source is <c>SourceArt/Corridor/RootsDance_Corridor_Blockout.blend</c>, not the raw
    /// download. There the chapel was taken apart into its 21 pieces and re-laid as an indoor
    /// corridor: the two gable walls keep their round openings and now face each other down the
    /// hall, the cloth-like landscape sits under the floor, and a metal catwalk crosses the hall
    /// above it. That arrangement — the openings and the bridge — is the level; the untouched
    /// chapel is only the material it was cut from.
    /// </para>
    /// <para>
    /// The blockout simplified all 21 surfaces down to three flat Blender materials, so the
    /// authored bakes are put back here by <see cref="k_Parts"/>: the pieces come out of the
    /// exporter named <c>ClothLandscape_CorridorShell.NNN</c> in alphabetical order of their
    /// original names, which is what the table restores.
    /// </para>
    /// <para>
    /// The blockout re-laid the chapel at a uniform 0.662 of its authored size — measured piece by
    /// piece, spread 0.005 — which put a 0.55 m balustrade next to a 1.8 m player and made the whole
    /// building read as a model of itself. The <c>static_chapterhouse</c> import profile multiplies
    /// that back out by 1.511, so the level is 13.2 m across, 18.8 m deep and 13.1 m tall, with a
    /// 6.8 × 13.7 m hall. Correcting it at import rather than on the instance keeps the scale in the
    /// one file that owns import settings, and leaves the scene's transforms at 1.
    /// </para>
    /// <para>
    /// Past that the mesh is only centred on X/Z and grounded at Y 0, because the blend was authored
    /// around the modeller's origin, not ours.
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
            "Assets/RootsDance/Meshes/Environment/ChapterHouse/ChapterHouseCorridor.fbx";
        private const string k_MaterialFolder = "Assets/RootsDance/Materials/Environment/ChapterHouse";
        private const string k_TextureFolder = "Assets/RootsDance/Textures/Environment/ChapterHouse";
        private const string k_VolumeProfilePath =
            "Assets/RootsDance/Settings/VolumeProfiles/MainProfile.asset";

        /// <summary>
        /// The procedural mycelium filling the undercroft — the gap between the cloth landscape
        /// and the underside of the hall floor. Grown by
        /// <c>Tools/blender/generate_mycelium.py</c>, which writes its vertices in this level's
        /// own world space and clips them out of the floor slab and the catwalk.
        /// </summary>
        private const string k_MyceliumModelPath =
            "Assets/RootsDance/Meshes/Environment/ChapterHouse/MyceliumUndercroft.fbx";
        private const string k_MyceliumName = "MyceliumUndercroft";
        private const string k_MyceliumGuttationPart = "Mycelium_Guttation";
        private const string k_AnimationFolder = "Assets/RootsDance/Animations/Environment";
        private const string k_MyceliumControllerPath =
            k_AnimationFolder + "/MyceliumUndercroft.controller";

        private const string k_NaveAnchor = "Checkpoint_ChapterHouseNave";
        private const string k_GalleryAnchor = "Checkpoint_ChapterHouseBridge";

        /// <summary>The catwalk. The one piece that is not a part of the chapel.</summary>
        private const string k_BridgePart = "Bridge_Metal_Center.001";
        private const string k_BridgeSurface = "Bridge_Metal";

        /// <summary>The chapel floor the hall is walked on, and the landscape under it.</summary>
        private const string k_FloorPart = "ClothLandscape_CorridorShell.007";
        private const string k_ClothPart = "ClothLandscape_CorridorShell.011";

        /// <summary>
        /// Head clearance over a walkable surface for a spawn or an anchor. Public because the
        /// narrative wiring places things at floor level off the same anchors and has to subtract
        /// it back out; one constant beats two that drift apart.
        /// </summary>
        public const float k_EyeClearance = 1.05f;

        /// <summary>
        /// What <c>static_chapterhouse</c> imports at, and the reciprocal of the 0.662 the blockout
        /// shrank the chapel by. Held here so the build fails loudly if the profile drifts from it.
        /// </summary>
        private const float k_ImportScale = 1.511f;

        /// <summary>
        /// Every material the chapel declares, and the texture set each one wears. Base and normal
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

            // The catwalk is not part of the chapel and carries no bake, so it is the one surface
            // that has to be a described material rather than a photographed one.
            new SurfaceMapping(k_BridgeSurface, null, null, new Color(0.17f, 0.18f, 0.19f), 0.9f, 0.35f),
        };

        /// <summary>
        /// Which chapel surface each blockout piece is. The blockout renamed every piece to
        /// <c>ClothLandscape_CorridorShell.NNN</c> and flattened the materials to three, so the
        /// authored identity survives only in this order — the pieces were duplicated in
        /// alphabetical order of their original names, which is the order below. The UVs came
        /// through untouched, so putting the original bake back on a piece is all it takes.
        /// <para>
        /// If the blend is re-exported with pieces added or removed, this table is what has to be
        /// re-derived — <see cref="ApplyMaterials"/> fails loudly rather than guessing.
        /// </para>
        /// </summary>
        private static readonly (string Part, string Surface)[] k_Parts =
        {
            ("ClothLandscape_CorridorShell", "bacl"),                    // DEathbox
            ("ClothLandscape_CorridorShell.001", "Window_fourclo"),      // glass_fourclo — the round opening
            ("ClothLandscape_CorridorShell.002", "Windwo_test"),         // glass_largearch
            ("ClothLandscape_CorridorShell.003", "Window_small"),        // glass_threearches
            ("ClothLandscape_CorridorShell.004", "emission"),            // ImSPOECIAL
            ("ClothLandscape_CorridorShell.005", "lower_columns"),
            ("ClothLandscape_CorridorShell.006", "lower_doors"),
            (k_FloorPart, "lower_floor"),
            ("ClothLandscape_CorridorShell.008", "lower_pianochamber"),
            ("ClothLandscape_CorridorShell.009", "panles_plasterwood"),
            ("ClothLandscape_CorridorShell.010", "panels_stonewood"),
            (k_ClothPart, "Material.001"),                               // the_warbler — the cloth landscape
            ("ClothLandscape_CorridorShell.012", "upper_balustrade"),
            ("ClothLandscape_CorridorShell.013", "upper_gallerywood"),
            ("ClothLandscape_CorridorShell.014", "upper_roof"),
            ("ClothLandscape_CorridorShell.015", "upper_sidecolumns"),
            ("ClothLandscape_CorridorShell.016", "wall_pianoside"),      // gable wall, round opening
            ("ClothLandscape_CorridorShell.017", "wall_archwindows"),
            ("ClothLandscape_CorridorShell.018", "wall_balconyside"),
            ("ClothLandscape_CorridorShell.019", "wall_fourclo"),
            ("ClothLandscape_CorridorShell.020", "wall_galleryside"),    // gable wall, round opening
            (k_BridgePart, k_BridgeSurface),
        };

        /// <summary>
        /// Where the player starts and where Dev Play drops them. Both are derived from the built
        /// geometry — the hall floor and the catwalk — rather than typed in, because the blockout
        /// is explicitly a layout the level artist is still moving around.
        /// </summary>
        private static CheckpointPlacement[] s_checkpointPlacements;

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
        /// Makes sure the mesh on disk was imported under the settings the project asked for, and
        /// never sets them itself. They belong to the <c>static_chapterhouse</c> entry in
        /// <c>Tools/unity/model_import_profiles.json</c>, which <c>BlenderModelPostprocessor</c>
        /// applies on every import; setting them a second time here would give the project two
        /// answers to the same question.
        /// <para>
        /// That profile is a plain JSON file, and the AssetDatabase does not hash it — editing it
        /// leaves every model that is already imported sitting on its old settings until something
        /// asks for a reimport. So a mismatch is usually a stale artifact rather than a broken
        /// registration: ask for the reimport once, and only give up if the settings still do not
        /// take, which means the entry itself is wrong or missing.
        /// </para>
        /// </summary>
        private static void ConfigureModelImporter()
        {
            if (ImportedUnderProfile(LoadModelImporter()))
            {
                return;
            }

            AssetDatabase.ImportAsset(k_ModelPath, ImportAssetOptions.ForceUpdate);
            ModelImporter importer = LoadModelImporter();

            if (ImportedUnderProfile(importer))
            {
                Log.Info(
                    "Reimported the chapter house mesh to pick up the static_chapterhouse profile; "
                    + "the model import profiles are not hashed by the AssetDatabase.",
                    AssetDatabase.LoadAssetAtPath<GameObject>(k_ModelPath));
                return;
            }

            throw new InvalidOperationException(
                "The chapter house FBX did not import under the static_chapterhouse profile even "
                + "after a forced reimport (scale " + importer.globalScale + ", expected "
                + k_ImportScale + "; readable " + importer.isReadable + ", expected True; materials "
                + importer.materialImportMode + ", expected None). Check its entry in "
                + "Tools/unity/model_import_profiles.json.");
        }

        private static ModelImporter LoadModelImporter()
        {
            ModelImporter importer = AssetImporter.GetAtPath(k_ModelPath) as ModelImporter;

            if (importer == null)
            {
                throw new System.IO.FileNotFoundException("Chapter house model missing: " + k_ModelPath);
            }

            return importer;
        }

        private static bool ImportedUnderProfile(ModelImporter importer)
        {
            return Mathf.Approximately(importer.globalScale, k_ImportScale)
                && importer.isReadable
                && importer.materialImportMode == ModelImporterMaterialImportMode.None;
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
            material.SetColor("_BaseColor", surface.BaseColor);
            material.SetFloat("_Smoothness", surface.Smoothness);
            material.SetFloat("_Metallic", surface.Metallic);

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
            CreateCollision(building);
            SetStatic(building);
            CreateMycelium(building, scene);

            Bounds floor = PartBounds(building, k_FloorPart);
            s_checkpointPlacements = PlaceCheckpoints(building, floor);
            CreateLighting(lighting, bounds, floor);
            CreateScaleReference(props, floor);

            EditorSceneManager.SaveScene(scene, ScenePaths.k_ChapterHouseInteriorEnvironment);
            return bounds;
        }

        /// <summary>
        /// Places the mycelium in the undercroft and starts its breath looping.
        ///
        /// The generator already worked in this level's world space, so the instance only has to
        /// repeat whatever transform <see cref="GroundModel"/> gave the building. Copying that
        /// transform rather than writing the offset down keeps the two in register the next time
        /// the blockout is re-exported and the building is re-grounded.
        ///
        /// It is deliberately not marked static: the breath is a blend-shape animation, so these
        /// are SkinnedMeshRenderers and static batching would freeze them.
        /// </summary>
        private static void CreateMycelium(GameObject building, Scene scene)
        {
            GameObject mycelium = InstantiateModel(
                k_MyceliumModelPath, k_MyceliumName, building.transform.parent, scene);

            mycelium.transform.SetLocalPositionAndRotation(
                building.transform.localPosition, building.transform.localRotation);
            mycelium.transform.localScale = building.transform.localScale;

            Material hyphae = EnsureMyceliumMaterial(
                "Hyphae", new Color(0.84f, 0.82f, 0.74f), 0.25f);
            Material guttation = EnsureMyceliumMaterial(
                "Guttation", new Color(0.93f, 0.96f, 0.98f), 0.95f);

            Renderer[] renderers = mycelium.GetComponentsInChildren<Renderer>(true);

            if (renderers.Length == 0)
            {
                throw new InvalidOperationException(
                    "The mycelium model has no renderers: " + k_MyceliumModelPath);
            }

            for (int i = 0; i < renderers.Length; i++)
            {
                Material material = renderers[i].gameObject.name == k_MyceliumGuttationPart
                    ? guttation
                    : hyphae;
                Material[] slots = renderers[i].sharedMaterials;

                for (int slot = 0; slot < slots.Length; slot++)
                {
                    slots[slot] = material;
                }

                renderers[i].sharedMaterials = slots;
            }

            EnsureMyceliumAnimator(mycelium);
        }

        /// <summary>
        /// The mycelium carries no baked textures — it is lit geometry, so its two surfaces are
        /// described by parameters. Single-sided on purpose: every filament is a closed, capped
        /// tube, so the back faces are never seen and double-siding would only cost fill rate.
        /// </summary>
        private static Material EnsureMyceliumMaterial(string name, Color colour, float smoothness)
        {
            string path = $"{k_MaterialFolder}/Mycelium_{name}.mat";
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

            material.SetColor("_BaseColor", colour);
            material.SetFloat("_Smoothness", smoothness);
            material.SetFloat("_Metallic", 0f);
            material.enableInstancing = true;

            HDMaterial.ValidateMaterial(material);

            if (isNew)
            {
                EnsureFolder(k_MaterialFolder);
                AssetDatabase.CreateAsset(material, path);
            }
            else
            {
                EditorUtility.SetDirty(material);
            }

            return material;
        }

        /// <summary>
        /// Drives the imported breath clip. The clip is authored as one seamless 96-frame cycle
        /// and imported with loop time on, so a single default state is the whole controller.
        /// </summary>
        private static void EnsureMyceliumAnimator(GameObject mycelium)
        {
            AnimationClip clip = LoadMyceliumClip();
            EnsureFolder(k_AnimationFolder);

            AnimatorController controller =
                AssetDatabase.LoadAssetAtPath<AnimatorController>(k_MyceliumControllerPath);

            if (controller == null)
            {
                controller = AnimatorController.CreateAnimatorControllerAtPathWithClip(
                    k_MyceliumControllerPath, clip);
            }
            else
            {
                AnimatorStateMachine machine = controller.layers[0].stateMachine;

                if (machine.defaultState == null)
                {
                    machine.defaultState = machine.AddState(clip.name);
                }

                machine.defaultState.motion = clip;
                EditorUtility.SetDirty(controller);
            }

            Animator animator = mycelium.GetComponent<Animator>();

            if (animator == null)
            {
                animator = mycelium.AddComponent<Animator>();
            }

            animator.runtimeAnimatorController = controller;
            animator.applyRootMotion = false;
            // Blend-shape skinning costs the same whether or not anyone is looking, and the
            // undercroft is sealed: stop it entirely when nothing renders it.
            animator.cullingMode = AnimatorCullingMode.CullCompletely;
        }

        private static AnimationClip LoadMyceliumClip()
        {
            UnityEngine.Object[] assets = AssetDatabase.LoadAllAssetsAtPath(k_MyceliumModelPath);

            for (int i = 0; i < assets.Length; i++)
            {
                AnimationClip clip = assets[i] as AnimationClip;

                if (clip != null && !clip.name.StartsWith("__preview__", StringComparison.Ordinal))
                {
                    return clip;
                }
            }

            throw new InvalidOperationException(
                "The mycelium FBX carries no animation clip. Check that it imported under the " +
                "mycelium_breathing profile in Tools/unity/model_import_profiles.json: " +
                k_MyceliumModelPath);
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
        /// Puts the authored bakes back onto the blockout's pieces. The blockout renamed every
        /// piece and flattened its three materials, so <see cref="k_Parts"/> — and nothing else —
        /// says which piece is which surface. A piece the table does not name means the export no
        /// longer matches it, and that stops the build instead of being guessed through: a wrong
        /// guess here puts the floor bake on a wall, which reads as a texturing mistake rather
        /// than as a stale table.
        /// </summary>
        private static void ApplyMaterials(GameObject building, Dictionary<string, Material> materials)
        {
            Dictionary<string, Material> byPart =
                new Dictionary<string, Material>(k_Parts.Length, StringComparer.Ordinal);

            for (int i = 0; i < k_Parts.Length; i++)
            {
                string key = Normalize(k_Parts[i].Surface);

                if (!materials.TryGetValue(key, out Material material))
                {
                    throw new InvalidOperationException(
                        "k_Parts names a surface that k_Surfaces does not build: " + k_Parts[i].Surface);
                }

                byPart[k_Parts[i].Part] = material;
            }

            Renderer[] renderers = building.GetComponentsInChildren<Renderer>(true);
            List<string> unmapped = new List<string>();

            for (int i = 0; i < renderers.Length; i++)
            {
                Renderer renderer = renderers[i];

                if (!byPart.TryGetValue(renderer.gameObject.name, out Material material))
                {
                    unmapped.Add(renderer.gameObject.name);
                    continue;
                }

                Material[] assigned = renderer.sharedMaterials;

                for (int slot = 0; slot < assigned.Length; slot++)
                {
                    assigned[slot] = material;
                }

                renderer.sharedMaterials = assigned;
            }

            if (unmapped.Count > 0)
            {
                throw new InvalidOperationException(
                    "The chapter house export has pieces k_Parts does not name: "
                    + string.Join(", ", unmapped));
            }

            if (renderers.Length != k_Parts.Length)
            {
                throw new InvalidOperationException(
                    "The chapter house export has " + renderers.Length + " pieces; k_Parts names "
                    + k_Parts.Length + ".");
            }
        }

        /// <summary>
        /// Daylight through the glazing plus a low interior fill. A chapter house is read by its
        /// height, and height only reads when the upper walls catch light the floor does not.
        /// </summary>
        private static void CreateLighting(Transform parent, Bounds bounds, Bounds floor)
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

            // The fills hang in the hall, measured from its floor rather than from the model's
            // overall box: that box starts three metres lower, at the landscape under the building,
            // and a light placed by a fraction of it would sit below the floor it is meant to lift.
            float hallHeight = Mathf.Max(1f, bounds.max.y - floor.max.y);
            float upper = floor.max.y + hallHeight * 0.62f;
            float lower = floor.max.y + hallHeight * 0.22f;
            float x = floor.center.x;
            float depth = floor.size.z;

            CreateFillLight(parent, "ChapterHouseFill_NaveHigh",
                new Vector3(x, upper, floor.center.z - depth * 0.28f));
            CreateFillLight(parent, "ChapterHouseFill_CrossingHigh",
                new Vector3(x, upper, floor.center.z + depth * 0.28f));
            CreateFillLight(parent, "ChapterHouseFill_NaveLow",
                new Vector3(x, lower, floor.center.z - depth * 0.34f));
            CreateFillLight(parent, "ChapterHouseFill_CrossingLow",
                new Vector3(x, lower, floor.center.z + depth * 0.34f));
        }

        private static void CreateFillLight(Transform parent, string name, Vector3 position)
        {
            GameObject lightObject = new GameObject(name);
            lightObject.transform.SetParent(parent, false);
            lightObject.transform.localPosition = position;
            Light light = lightObject.AddComponent<Light>();
            light.type = LightType.Point;

            // Lumens for a 4.5 x 9 m hall, not for the 44 m greenhouse this was copied from: the
            // earlier value lit a building six times the size and blows this one out.
            light.intensity = 22000f;
            light.range = 14f;
            light.color = new Color(0.86f, 0.84f, 0.78f);
            light.shadows = LightShadows.None;
        }

        /// <summary>
        /// Collision straight off the mesh, one <see cref="MeshCollider"/> per piece. The earlier
        /// pass put a single flat box under the whole footprint, which worked only while the level
        /// was one flat chapel floor at Y 0; here the hall floor sits about three metres above the
        /// landscape it is laid over, so a box on the ground plane would drop the player through
        /// the building and stand them under it.
        /// <para>
        /// Non-convex mesh colliders collide from both faces, which matters because most of this
        /// building is single-sided planes. Only the three surfaces the player is meant to stand
        /// on go on the Ground layer — the walls still block, they just do not count as footing.
        /// </para>
        /// </summary>
        private static void CreateCollision(GameObject building)
        {
            int groundLayer = LayerMask.NameToLayer("Ground");

            if (groundLayer < 0)
            {
                throw new InvalidOperationException("The required Ground layer does not exist.");
            }

            MeshFilter[] filters = building.GetComponentsInChildren<MeshFilter>(true);

            for (int i = 0; i < filters.Length; i++)
            {
                MeshFilter filter = filters[i];

                if (filter.sharedMesh == null)
                {
                    continue;
                }

                MeshCollider collider = filter.gameObject.GetComponent<MeshCollider>();

                if (collider == null)
                {
                    collider = filter.gameObject.AddComponent<MeshCollider>();
                }

                collider.sharedMesh = filter.sharedMesh;
                collider.convex = false;

                string name = filter.gameObject.name;

                if (name == k_FloorPart || name == k_BridgePart || name == k_ClothPart)
                {
                    filter.gameObject.layer = groundLayer;
                }
            }
        }

        /// <summary>
        /// Where the player starts, and where Dev Play drops them: the south end of the hall
        /// looking down it, and the catwalk looking back. Both ride on the built geometry rather
        /// than on typed coordinates, because the blockout is a layout still being moved around and
        /// a hand-typed anchor would quietly end up inside a wall the next time it moves.
        /// </summary>
        private static CheckpointPlacement[] PlaceCheckpoints(GameObject building, Bounds floor)
        {
            Bounds bridge = PartBounds(building, k_BridgePart);

            // On the catwalk, both of them. The bridge is the route: it is the only surface that
            // crosses the hall above the cloth landscape, and the chapel floor beside it is a
            // single-sided plane the player is not meant to be walking on at all. Standing them on
            // the deck at the near end means walking forward simply crosses the bridge.
            float deck = bridge.max.y;
            float middle = bridge.center.z;

            return new[]
            {
                new CheckpointPlacement(
                    k_NaveAnchor,
                    new Vector3(
                        bridge.center.x,
                        deck + k_EyeClearance,
                        bridge.min.z + 0.5f),
                    0f),
                new CheckpointPlacement(
                    k_GalleryAnchor,
                    new Vector3(
                        bridge.center.x,
                        deck + k_EyeClearance,
                        middle),
                    180f),
            };
        }

        /// <summary>The world bounds of one named piece. Throws rather than returning an empty box.</summary>
        private static Bounds PartBounds(GameObject building, string partName)
        {
            Renderer[] renderers = building.GetComponentsInChildren<Renderer>(true);

            for (int i = 0; i < renderers.Length; i++)
            {
                if (renderers[i].gameObject.name == partName)
                {
                    return renderers[i].bounds;
                }
            }

            throw new InvalidOperationException("The chapter house export has no piece named " + partName);
        }

        private static void CreateScaleReference(Transform parent, Bounds floor)
        {
            GameObject marker = new GameObject("PlayerHeightReference_1p8m");
            marker.transform.SetParent(parent, false);
            marker.transform.position = new Vector3(
                floor.center.x + 1.5f,
                floor.max.y + 0.9f,
                floor.center.z);
            BoxCollider collider = marker.AddComponent<BoxCollider>();
            collider.size = new Vector3(0.1f, 1.8f, 0.1f);
            collider.isTrigger = true;
            marker.SetActive(false);
        }

        // ---- Gameplay scene --------------------------------------------------------------------

        private static void BuildGameplayScene()
        {
            if (s_checkpointPlacements == null)
            {
                throw new InvalidOperationException(
                    "The gameplay scene is placed off the built geometry, so the environment scene "
                    + "has to be built first.");
            }

            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            Transform cameras = CreateRoot("_Cameras");
            Transform spawns = CreateRoot("_Spawns");
            CreateRoot("_Triggers");
            CreateRoot("_Interactables");
            CreateRoot("_Narrative");
            Transform anchors = CreateRoot("_Anchors");

            for (int i = 0; i < s_checkpointPlacements.Length; i++)
            {
                CheckpointPlacement placement = s_checkpointPlacements[i];
                GameObject anchor = new GameObject(placement.AnchorName);
                anchor.transform.SetParent(anchors, false);
                anchor.transform.SetPositionAndRotation(
                    placement.Position,
                    Quaternion.Euler(0f, placement.Yaw, 0f));
            }

            CheckpointPlacement entrance = s_checkpointPlacements[0];
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
                s_checkpointPlacements[0]);
            CreateCheckpoint(
                k_CheckpointFolder + "/CH-02_ChapterHouseBridge.asset",
                "CH-02 Chapter house bridge",
                level,
                s_checkpointPlacements[1]);
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
            /// <summary>
            /// A baked surface: the texture carries all the shading, so the response on top of it
            /// stays flat — a specular highlight over a bake reads as a second, wrong light.
            /// </summary>
            public SurfaceMapping(string materialName, string baseTexture, string normalTexture)
                : this(materialName, baseTexture, normalTexture, Color.white, 0f, 0.08f)
            {
            }

            public SurfaceMapping(
                string materialName,
                string baseTexture,
                string normalTexture,
                Color baseColor,
                float metallic,
                float smoothness)
            {
                MaterialName = materialName;
                BaseTexture = baseTexture;
                NormalTexture = normalTexture;
                BaseColor = baseColor;
                Metallic = metallic;
                Smoothness = smoothness;
            }

            public string MaterialName { get; }
            public string BaseTexture { get; }
            public string NormalTexture { get; }
            public Color BaseColor { get; }
            public float Metallic { get; }
            public float Smoothness { get; }
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

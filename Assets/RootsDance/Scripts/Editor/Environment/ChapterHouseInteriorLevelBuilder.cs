using System;
using System.Collections.Generic;
using System.Linq;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Editor.DevPlay;
using RootsDance.Environment;
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

        private const string k_CorridorEntranceAnchor = "Checkpoint_CorridorEntrance";
        private const string k_FlowerSpriteEncounterAnchor = "Checkpoint_FlowerSpriteEncounter";

        /// <summary>
        /// The catwalk. The one piece that is not a part of the chapel. Public because
        /// <see cref="ChapterHouseBridgeRailingBuilder"/> rails the same piece off the same name.
        /// </summary>
        public const string k_BridgePart = "Bridge_Metal_Center.001";
        private const string k_BridgeSurface = "Bridge_Metal";

        /// <summary>The chapel floor the hall is walked on, and the landscape under it.</summary>
        private const string k_FloorPart = "ClothLandscape_CorridorShell.007";
        private const string k_ClothPart = "ClothLandscape_CorridorShell.011";

        /// <summary>Every physical door in the building, flattened into one static mesh by the same
        /// blockout pass that renamed the pieces. <see cref="SeparateDoors"/> pulls it back apart.</summary>
        private const string k_DoorsPart = "ClothLandscape_CorridorShell.006";
        private const string k_EmissionPart = "ClothLandscape_CorridorShell.004";
        private const string k_EmissionSurface = "emission";
        private const string k_ClothSurface = "Material.001";
        private const string k_EdgeEmissionTexture = "gradbake";
        private const float k_EdgeEmissionNits = 1500f;
        private const float k_ClothEmissionNits = 30000f;

        /// <summary>How close two loose islands of <see cref="k_DoorsPart"/> have to be, in world
        /// metres, to count as the same door — a leaf and its handle sit centimetres apart; two
        /// different doors are metres apart.</summary>
        private const float k_DoorClusterDistance = 0.6f;

        private const float k_DoorOpenAngle = 100f;

        /// <summary>Sized together with <see cref="k_DoorTriggerMargin"/> so the swing finishes
        /// before a sprinting player reaches the leaf: 100° at 220°/s takes 0.45 s, and the margin
        /// gives 2.45 m of approach (half margin minus the probe's 0.45 m radius) — 0.56 s at the
        /// 4.4 m/s sprint speed. A late-opening leaf swings into the player and shoves them back
        /// out of the doorway.</summary>
        private const float k_DoorDegreesPerSecond = 220f;
        private const float k_DoorTriggerMargin = 5.8f;
        private const float k_DoorTriggerHeight = 2.4f;

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
        private const float k_LayoutScale = 2f;
        private const float k_LayoutYOffset = -3.5f;

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
            new SurfaceMapping(k_ClothSurface, "plane", null, Color.white, 0f, 0.3f),
            new SurfaceMapping("emission", "gradalpha", null),
            new SurfaceMapping("bacl", null, null, new Color(0.015f, 0.02f, 0.03f), 0f, 0.08f),

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
            (k_EmissionPart, k_EmissionSurface),                          // ImSPOECIAL
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
        private static ChapterHouseRoundEntranceBuilder.Placement s_roundEntrancePlacement;

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

                // The gameplay scene above is built from an empty scene, so the bridge meeting and
                // the sprite are gone every time this runs. Writing them back here is what keeps a
                // geometry rebuild from silently deleting the only story beat in the level.
                Content.NarrativeRuntimeBuilder.ApplyChapterHouseOnly();

                // Same reason: the rebuilt gameplay scene starts with an empty _Triggers, which
                // would silently sever the level's only way onward.
                ChapterHouseGreenhousePortalBuilder.ApplyToScenes();
                ChapterHouseConnectedLevelBuilder.Build(s_roundEntrancePlacement);

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

            // Start from the deterministic opaque state used by every authored surface. The
            // emission card below is the sole transparent exception.
            HDMaterial.SetSurfaceType(material, false);
            HDMaterial.SetAlphaClipping(material, false);

            if (surface.MaterialName == k_EmissionSurface)
            {
                Texture emissionTexture = LoadTexture(k_EdgeEmissionTexture);

                // ImSPOECIAL is the thin gradient card between the floor and the cloth. In the
                // source it contributes light without hiding the landscape behind it. Additive
                // transparency reproduces that compositing: the black part of gradbake vanishes
                // and only its blue ramp remains. Treating it as opaque produced the black band
                // that cut across the Unity version.
                material.SetColor("_BaseColor", Color.black);
                material.SetTexture("_EmissiveColorMap", emissionTexture);
                HDMaterial.SetUseEmissiveIntensity(material, true);
                HDMaterial.SetEmissiveColor(material, Color.white);
                HDMaterial.SetEmissiveIntensity(
                    material,
                    k_EdgeEmissionNits,
                    EmissiveIntensityUnit.Nits);
                material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.RealtimeEmissive;
                HDMaterial.SetSurfaceType(material, true);
                material.SetFloat("_BlendMode", 1f);
                material.SetFloat("_TransparentZWrite", 0f);
                material.SetFloat("_EnableFogOnTransparent", 0f);
            }
            else if (surface.MaterialName == k_ClothSurface)
            {
                // Sketchfab's cloth appearance is baked into plane.png. The original OBJ's MTL
                // omits that assignment, which previously left the cloth wearing gradbake.png —
                // the small perimeter card's texture — and made every fold nearly black.
                Texture clothTexture = LoadTexture(surface.BaseTexture);
                material.SetTexture("_EmissiveColorMap", clothTexture);
                HDMaterial.SetUseEmissiveIntensity(material, true);
                HDMaterial.SetEmissiveColor(material, Color.white);
                HDMaterial.SetEmissiveIntensity(
                    material,
                    k_ClothEmissionNits,
                    EmissiveIntensityUnit.Nits);
                material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.RealtimeEmissive;
            }
            else
            {
                material.SetTexture("_EmissiveColorMap", null);
                HDMaterial.SetUseEmissiveIntensity(material, false);
                HDMaterial.SetEmissiveColor(material, Color.black);
            }

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
            buildingRoot.localScale = Vector3.one * k_LayoutScale;
            Transform props = CreateRoot("_Props");
            CreateRoot("_NavMesh");

            GameObject building = InstantiateModel(k_ModelPath, "ChapterHouse", buildingRoot, scene);
            Bounds bounds = GroundModel(building);
            buildingRoot.position = new Vector3(0f, k_LayoutYOffset, 0f);
            bounds = GetRendererBounds(building);
            ApplyMaterials(building, materials);
            SetStatic(building);
            Bounds legacyDoorway = SeparateDoors(building, materials);
            Bounds floor = PartBounds(building, k_FloorPart);
            Bounds cloth = PartBounds(building, k_ClothPart);
            s_roundEntrancePlacement = ChapterHouseRoundEntranceBuilder.Replace(
                building, geometry, scene, floor, legacyDoorway);
            CreateCollision(building);
            CreateMycelium(building, scene, floor, cloth);
            ChapterHouseBridgeRailingBuilder.Place(building);

            s_checkpointPlacements = PlaceCheckpoints(building, floor);
            CreateLighting(lighting, bounds, floor);
            CreateScaleReference(props, floor);

            EditorSceneManager.SaveScene(scene, ScenePaths.k_ChapterHouseInteriorEnvironment);
            return bounds;
        }

        /// <summary>
        /// Places the mycelium in the undercroft and starts its breath looping.
        ///
        /// The FBX stores the generator's Unity-world coordinates on Blender's Y/Z axes. It is
        /// rotated once on import, compensated for the two-times chapter-house layout scale, then
        /// centred over the portion of cloth visible from the catwalk. This keeps it at a true
        /// world scale of one instead of spreading it across the entire undercroft.
        ///
        /// It is deliberately not marked static: the breath is a blend-shape animation, so these
        /// are SkinnedMeshRenderers and static batching would freeze them.
        /// </summary>
        private static void CreateMycelium(
            GameObject building,
            Scene scene,
            Bounds floor,
            Bounds cloth)
        {
            GameObject mycelium = InstantiateModel(
                k_MyceliumModelPath, k_MyceliumName, building.transform.parent, scene);

            FitMyceliumToVisibleCloth(mycelium, building, floor, cloth);

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
            mycelium.SetActive(true);
        }

        private static void FitMyceliumToVisibleCloth(
            GameObject mycelium,
            GameObject building,
            Bounds floor,
            Bounds cloth)
        {
            Transform myceliumTransform = mycelium.transform;
            myceliumTransform.SetLocalPositionAndRotation(
                building.transform.localPosition,
                building.transform.localRotation * Quaternion.Euler(90f, 0f, 0f));
            myceliumTransform.localScale = building.transform.localScale / k_LayoutScale;

            // Remove per-renderer overrides left by look-development. The model asset owns both
            // meshes at identity; scaling them independently makes droplets drift off the hyphae.
            for (int i = 0; i < myceliumTransform.childCount; i++)
            {
                Transform child = myceliumTransform.GetChild(i);
                child.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
                child.localScale = Vector3.one;
            }

            Bounds myceliumBounds = GetRendererBounds(mycelium);
            Vector3 targetCentre = new Vector3(floor.center.x, cloth.center.y, cloth.center.z);
            myceliumTransform.position += targetCentre - myceliumBounds.center;
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
        private static void CreateLighting(
            Transform parent,
            Bounds bounds,
            Bounds floor)
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
        /// Pulls <see cref="k_DoorsPart"/>'s loose parts back apart into one GameObject per physical
        /// door, each pivoted on its own hinge edge with a <see cref="SwingDoor"/>, and removes the
        /// merged piece so nothing renders twice. Which door(s) actually respond to the player is a
        /// gameplay decision made elsewhere — this only makes each one independently animatable.
        /// <para>
        /// Everything here is computed in world space and only converted back to local space once a
        /// door's own transform is placed, via <c>Transform.InverseTransformPoint</c> — so it never
        /// has to know or guess the mesh's axis convention or the importer's 1.511 scale.
        /// </para>
        /// </summary>
        private static Bounds SeparateDoors(GameObject building, Dictionary<string, Material> materials)
        {
            MeshFilter mergedFilter = building.GetComponentsInChildren<MeshFilter>(true)
                .FirstOrDefault(filter => filter.gameObject.name == k_DoorsPart);

            if (mergedFilter == null || mergedFilter.sharedMesh == null)
            {
                throw new InvalidOperationException(
                    "The chapter house doors piece was not found: " + k_DoorsPart);
            }

            if (!materials.TryGetValue(Normalize("lower_doors"), out Material doorMaterial))
            {
                throw new InvalidOperationException("No material was built for the chapel doors.");
            }

            Transform mergedTransform = mergedFilter.transform;
            Mesh mergedMesh = mergedFilter.sharedMesh;
            int[] triangles = mergedMesh.triangles;
            Vector3[] localVertices = mergedMesh.vertices;
            Vector3[] worldVertices = new Vector3[localVertices.Length];

            for (int i = 0; i < localVertices.Length; i++)
            {
                worldVertices[i] = mergedTransform.TransformPoint(localVertices[i]);
            }

            List<List<int>> islands = FindTriangleIslands(triangles, localVertices.Length);
            List<List<int>> doorGroups = ClusterIslandsIntoDoors(islands, triangles, worldVertices);

            if (doorGroups.Count == 0)
            {
                throw new InvalidOperationException("The chapel doors mesh has no geometry.");
            }

            doorGroups.Sort((a, b) =>
            {
                Vector3 centerA = TriangleGroupWorldBounds(a, triangles, worldVertices).center;
                Vector3 centerB = TriangleGroupWorldBounds(b, triangles, worldVertices).center;
                int byZ = centerA.z.CompareTo(centerB.z);
                return byZ != 0 ? byZ : centerA.x.CompareTo(centerB.x);
            });

            Transform parent = mergedTransform.parent;

            if (doorGroups.Count != 4)
            {
                throw new InvalidOperationException(
                    "The chapter house entrance replacement expects four authored door groups, found "
                    + doorGroups.Count + ".");
            }

            Bounds legacyDoorway = TriangleGroupWorldBounds(doorGroups[0], triangles, worldVertices);

            // Door A was the offset rectangular entrance. It is deliberately not rebuilt: the
            // round-entrance wall covers and erases that entire bay. Keep the original B/C/D
            // letters stable so the greenhouse exit remains ChapterHouseDoor_D.
            for (int i = 1; i < doorGroups.Count; i++)
            {
                string name = "ChapterHouseDoor_" + (char)('A' + i);
                BuildDoor(name, doorGroups[i], mergedMesh, triangles, worldVertices, mergedTransform,
                    parent, doorMaterial);
            }

            UnityEngine.Object.DestroyImmediate(mergedFilter.gameObject);
            return legacyDoorway;
        }

        /// <summary>Groups triangles by shared-vertex connectivity. The importer welds coincident
        /// vertices (see the <c>static_chapterhouse</c> profile), so two triangles that touch always
        /// share a vertex index, not just a position.</summary>
        private static List<List<int>> FindTriangleIslands(int[] triangles, int vertexCount)
        {
            int[] parent = new int[vertexCount];

            for (int i = 0; i < vertexCount; i++)
            {
                parent[i] = i;
            }

            int triangleCount = triangles.Length / 3;

            for (int t = 0; t < triangleCount; t++)
            {
                int v0 = triangles[t * 3];
                int v1 = triangles[t * 3 + 1];
                int v2 = triangles[t * 3 + 2];
                Union(parent, v0, v1);
                Union(parent, v1, v2);
            }

            Dictionary<int, List<int>> byRoot = new Dictionary<int, List<int>>();

            for (int t = 0; t < triangleCount; t++)
            {
                int root = Find(parent, triangles[t * 3]);

                if (!byRoot.TryGetValue(root, out List<int> group))
                {
                    group = new List<int>();
                    byRoot[root] = group;
                }

                group.Add(t);
            }

            return byRoot.Values.ToList();
        }

        /// <summary>Merges islands whose world-space bounds sit within
        /// <see cref="k_DoorClusterDistance"/> of each other — a door leaf and its handle or hinge
        /// hardware, as separate loose islands belonging to the same physical door.</summary>
        private static List<List<int>> ClusterIslandsIntoDoors(
            List<List<int>> islands, int[] triangles, Vector3[] worldVertices)
        {
            int count = islands.Count;
            Bounds[] bounds = new Bounds[count];

            for (int i = 0; i < count; i++)
            {
                bounds[i] = TriangleGroupWorldBounds(islands[i], triangles, worldVertices);
            }

            int[] parent = new int[count];

            for (int i = 0; i < count; i++)
            {
                parent[i] = i;
            }

            for (int i = 0; i < count; i++)
            {
                for (int j = i + 1; j < count; j++)
                {
                    if (BoundsDistance(bounds[i], bounds[j]) <= k_DoorClusterDistance)
                    {
                        Union(parent, i, j);
                    }
                }
            }

            Dictionary<int, List<int>> byRoot = new Dictionary<int, List<int>>();

            for (int i = 0; i < count; i++)
            {
                int root = Find(parent, i);

                if (!byRoot.TryGetValue(root, out List<int> group))
                {
                    group = new List<int>();
                    byRoot[root] = group;
                }

                group.AddRange(islands[i]);
            }

            return byRoot.Values.ToList();
        }

        private static int Find(int[] parent, int v)
        {
            while (parent[v] != v)
            {
                parent[v] = parent[parent[v]];
                v = parent[v];
            }

            return v;
        }

        private static void Union(int[] parent, int a, int b)
        {
            int rootA = Find(parent, a);
            int rootB = Find(parent, b);

            if (rootA != rootB)
            {
                parent[rootA] = rootB;
            }
        }

        private static float BoundsDistance(Bounds a, Bounds b)
        {
            Vector3 gap = Vector3.Max(Vector3.zero, Vector3.Max(a.min - b.max, b.min - a.max));
            return gap.magnitude;
        }

        private static Bounds TriangleGroupWorldBounds(
            List<int> triangleIndices, int[] triangles, Vector3[] worldVertices)
        {
            Bounds bounds = new Bounds(worldVertices[triangles[triangleIndices[0] * 3]], Vector3.zero);

            for (int i = 0; i < triangleIndices.Count; i++)
            {
                int triangle = triangleIndices[i];

                for (int corner = 0; corner < 3; corner++)
                {
                    bounds.Encapsulate(worldVertices[triangles[triangle * 3 + corner]]);
                }
            }

            return bounds;
        }

        /// <summary>The hinge sits on the door's own thin (wall-normal) axis, at the minimum edge of
        /// its long (width) axis, at floor height — one vertical edge of the opening, same
        /// convention for every door regardless of which wall it is set into.</summary>
        private static Vector3 ComputeHinge(Bounds worldBounds)
        {
            bool thinIsX = worldBounds.size.x < worldBounds.size.z;

            return thinIsX
                ? new Vector3(worldBounds.center.x, worldBounds.min.y, worldBounds.min.z)
                : new Vector3(worldBounds.min.x, worldBounds.min.y, worldBounds.center.z);
        }

        /// <summary>
        /// Builds one door: a trigger root at the hinge point plus a leaf child that carries the
        /// extracted mesh and rotates. The root's rotation is left at world identity and the leaf's
        /// vertices are baked in the leaf's own local space via <c>InverseTransformPoint</c>, so the
        /// result is correct regardless of the merged mesh's own rotation or the model's import scale.
        /// </summary>
        private static void BuildDoor(
            string name,
            List<int> triangleIndices,
            Mesh mergedMesh,
            int[] triangles,
            Vector3[] worldVertices,
            Transform mergedTransform,
            Transform parent,
            Material material)
        {
            Vector3[] normals = mergedMesh.normals;
            Vector2[] uvs = mergedMesh.uv;
            bool hasNormals = normals != null && normals.Length == worldVertices.Length;
            bool hasUvs = uvs != null && uvs.Length == worldVertices.Length;

            Bounds worldBounds = TriangleGroupWorldBounds(triangleIndices, triangles, worldVertices);
            Vector3 hinge = ComputeHinge(worldBounds);

            GameObject root = new GameObject(name);
            root.transform.SetParent(parent, false);
            root.transform.position = hinge;
            root.transform.rotation = Quaternion.identity;
            // The player's probe only collides with TriggerVolume, so a door root left on Default
            // never sees the probe and never opens. The leaf below stays on Default: its collider
            // has to block the player's capsule, not talk to the probe.
            int triggerLayer = LayerMask.NameToLayer("TriggerVolume");
            if (triggerLayer < 0)
            {
                throw new InvalidOperationException("The required TriggerVolume layer does not exist.");
            }
            root.layer = triggerLayer;

            GameObject leaf = new GameObject(name + "_Leaf");
            leaf.transform.SetParent(root.transform, false);
            leaf.transform.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
            leaf.transform.localScale = Vector3.one;

            Dictionary<int, int> remap = new Dictionary<int, int>();
            List<Vector3> newVertices = new List<Vector3>();
            List<Vector3> newNormals = hasNormals ? new List<Vector3>() : null;
            List<Vector2> newUvs = hasUvs ? new List<Vector2>() : null;
            int[] newTriangles = new int[triangleIndices.Count * 3];

            for (int i = 0; i < triangleIndices.Count; i++)
            {
                int triangle = triangleIndices[i];

                for (int corner = 0; corner < 3; corner++)
                {
                    int originalIndex = triangles[triangle * 3 + corner];

                    if (!remap.TryGetValue(originalIndex, out int newIndex))
                    {
                        newIndex = newVertices.Count;
                        remap[originalIndex] = newIndex;
                        newVertices.Add(leaf.transform.InverseTransformPoint(worldVertices[originalIndex]));

                        if (hasNormals)
                        {
                            Vector3 worldNormal = mergedTransform.TransformDirection(normals[originalIndex]);
                            newNormals.Add(leaf.transform.InverseTransformDirection(worldNormal));
                        }

                        if (hasUvs)
                        {
                            newUvs.Add(uvs[originalIndex]);
                        }
                    }

                    newTriangles[i * 3 + corner] = newIndex;
                }
            }

            Mesh leafMesh = new Mesh { name = name + "_Mesh" };
            leafMesh.SetVertices(newVertices);

            if (hasNormals)
            {
                leafMesh.SetNormals(newNormals);
            }

            if (hasUvs)
            {
                leafMesh.SetUVs(0, newUvs);
            }

            leafMesh.SetTriangles(newTriangles, 0);

            if (!hasNormals)
            {
                leafMesh.RecalculateNormals();
            }

            leafMesh.RecalculateBounds();
            leafMesh.RecalculateTangents();

            MeshFilter filter = leaf.AddComponent<MeshFilter>();
            filter.sharedMesh = leafMesh;
            MeshRenderer renderer = leaf.AddComponent<MeshRenderer>();
            renderer.sharedMaterial = material;

            BoxCollider leafCollider = leaf.AddComponent<BoxCollider>();
            leafCollider.center = leafMesh.bounds.center;
            leafCollider.size = leafMesh.bounds.size;

            BoxCollider trigger = root.AddComponent<BoxCollider>();
            trigger.isTrigger = true;
            trigger.size = new Vector3(
                leafMesh.bounds.size.x + k_DoorTriggerMargin,
                k_DoorTriggerHeight,
                leafMesh.bounds.size.z + k_DoorTriggerMargin);
            trigger.center = new Vector3(
                leafMesh.bounds.center.x, trigger.size.y * 0.5f, leafMesh.bounds.center.z);

            SwingDoor swingDoor = root.AddComponent<SwingDoor>();
            swingDoor.Configure(leaf.transform, k_DoorOpenAngle, k_DoorDegreesPerSecond);
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
                    k_CorridorEntranceAnchor,
                    new Vector3(
                        bridge.center.x,
                        deck + k_EyeClearance,
                        bridge.min.z + 0.5f),
                    0f),
                new CheckpointPlacement(
                    k_FlowerSpriteEncounterAnchor,
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
                k_CheckpointFolder + "/02-04A_CorridorEntrance.asset",
                "02-04A Corridor entrance",
                level,
                s_checkpointPlacements[0]);
            CreateCheckpoint(
                k_CheckpointFolder + "/02-04B_FlowerSpriteEncounter.asset",
                "02-04B Flower sprite encounter",
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

            // The chapter house sits after chapter 00, so its checkpoints seed the same flags as
            // every other post-00 checkpoint (Briggs 02-01, greenhouse 03-01). An empty list here
            // rewinds the world: the helmet comes back on, the radio briefing re-arms.
            checkpoint.Configure(
                label,
                level,
                placement.AnchorName,
                placement.Position,
                placement.Yaw,
                CheckpointTimeOfDay.LevelDefault,
                new[]
                {
                    WorldFlags.k_LeftStartArea,
                    WorldFlags.k_RadioBriefingStarted,
                    WorldFlags.k_RadioBriefingFinished,
                    WorldFlags.k_HelmetRemovable,
                    WorldFlags.k_HelmetRemoved,
                    WorldFlags.k_EnteredGrassBelt,
                    WorldFlags.k_FirstInvestigationDone,
                },
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

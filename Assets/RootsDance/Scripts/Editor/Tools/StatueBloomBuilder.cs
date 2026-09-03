using System.IO;
using RootsDance.Core;
using RootsDance.Environment;
using RootsDance.Events;
using RootsDance.World;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Puts the growth that climbs the StMuerte statue into <c>Main_Environment_Statue</c>: two
    /// materials, the prefab and the one scene placement.
    /// <para>
    /// Two meshes make the bloom. <c>BloomPatches</c> is cover wrapped onto the robe and revealed
    /// by a clip; <c>BloomFlowers</c> is the field of flowers standing out of it, each opening as
    /// geometry from poses baked into its vertex data. One <see cref="GrowthDriver"/> feeds both,
    /// because a shared front that is computed twice is a front that drifts.
    /// </para>
    /// <para>
    /// Written as a builder for the same reason <see cref="CorridorAlgaeBuilder"/> is — the effect
    /// is a material, a prefab and a placement that have to agree, and a mismatch fails silently
    /// rather than loudly. It is far simpler than the algae one because the clumps were wrapped
    /// onto the robe in Blender and exported in place: the mesh already carries the statue's own
    /// world coordinates, so the placement is an identity transform under the statue's root and
    /// there is nothing to position by hand.
    /// </para>
    /// <para>
    /// Neither mesh casts shadows. Both shaders have a DepthForwardOnly and a ForwardOnly pass and
    /// no ShadowCaster — see the plan's §6.3 for why they are unlit — so asking for shadows would
    /// cost a pass that cannot run.
    /// </para>
    /// Menu: RootsDance > Build Statue Bloom. Re-runnable: every step reuses what is already there,
    /// and an existing placement is left exactly where it is.
    /// </summary>
    public static class StatueBloomBuilder
    {
        private const string k_LogPrefix = "StatueBloomBuilder";

        private const string k_ScenePath = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_Statue.unity";
        private const string k_Fbx = "Assets/RootsDance/Meshes/Environment/GAIA1/Sculpture/BloomPatches.fbx";
        private const string k_Shader = "RootsDance/Environment/StatueBloom";
        private const string k_Material = "Assets/RootsDance/Materials/Environment/StatueBloom.mat";
        private const string k_Prefab = "Assets/RootsDance/Prefabs/Environment/StatueBloom.prefab";

        private const string k_FlowerFbx =
            "Assets/RootsDance/Meshes/Environment/GAIA1/Sculpture/BloomFlowers.fbx";

        private const string k_FlowerShader = "RootsDance/Environment/StatueFlowers";

        private const string k_FlowerMaterial =
            "Assets/RootsDance/Materials/Environment/StatueFlowers.mat";

        /// <summary>The flower field's own child under the prefab root.</summary>
        private const string k_FlowerInstanceName = "Flowers";

        /// <summary>The bootstrap's FlagRaised channel — what tells the statue the ending began.</summary>
        private const string k_FlagChannel = "Assets/RootsDance/Data/Events/FlagRaised.asset";

        private const string k_GameplayScene = "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";

        /// <summary>The volume that notices the player has arrived at the statue.</summary>
        private const string k_SacredVolume = "SacredSpaceVolume";

        /// <summary>
        /// Where the water lands, from <c>StatueEnvironmentBuilder.k_GroundSplash</c> — the foot of
        /// the statue, and the one point in the scene that is unambiguously "here".
        /// </summary>
        private static readonly Vector3 k_StatueFoot = new Vector3(26.02f, 4.75f, 67.45f);

        /// <summary>
        /// Big enough that the player cannot walk past the statue without the flag, small enough
        /// that it is not raised from the far side of the terrain. The statue is 18.8 m tall.
        /// </summary>
        private static readonly Vector3 k_SacredVolumeSize = new Vector3(22f, 12f, 22f);

        /// <summary>The statue's root in the scene. The clumps go under it, so it carries them.</summary>
        private const string k_StatueRoot = "Statue";

        private const string k_InstanceName = "StatueBloom";

        /// <summary>
        /// Seconds from bare stone to fully grown. Matched to MUS_EndingBloom when the cut is
        /// timed; until then it is long enough to read as growth rather than as a switch.
        /// </summary>
        private const float k_Duration = 45f;

        [MenuItem("RootsDance/Build Statue Bloom")]
        public static void Build()
        {
            Material material = EnsureMaterial(k_Shader, k_Material);
            Material flowers = EnsureMaterial(k_FlowerShader, k_FlowerMaterial);

            if (material == null || flowers == null)
            {
                return;
            }

            GameObject prefab = EnsurePrefab(material, flowers);

            if (prefab == null)
            {
                return;
            }

            PlaceInScene(prefab);
            PlaceSacredSpaceTrigger();
            AssetDatabase.SaveAssets();
            Debug.Log($"{k_LogPrefix}: done.");
        }

        private static Material EnsureMaterial(string shaderName, string path)
        {
            Shader shader = Shader.Find(shaderName);

            if (shader == null)
            {
                Debug.LogError($"{k_LogPrefix}: shader '{shaderName}' not found.");
                return null;
            }

            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material == null)
            {
                EnsureFolder(Path.GetDirectoryName(path));
                material = new Material(shader);
                AssetDatabase.CreateAsset(material, path);
            }

            material.shader = shader;

            // Authored fully grown, so the material reads correctly in the project window and in a
            // prefab preview. GrowthDriver takes it to 0 the moment the object is switched on.
            material.SetFloat("_Growth", 1f);
            EditorUtility.SetDirty(material);

            return material;
        }

        /// <summary>
        /// Imports the flower field exactly the way the cover is imported.
        /// <para>
        /// The two meshes were exported from the same statue in the same coordinates by the same
        /// exporter, so the only thing that can put them in different places is the importer — and
        /// a freshly imported FBX arrives on Unity's defaults, not on the cover's settings. Two of
        /// those defaults move geometry:
        /// </para>
        /// <para>
        /// <c>bakeAxisConversion</c> decides whether the Blender-to-Unity axis conversion goes
        /// into the vertices or stays on the model root as a rotation. The cover bakes it; a new
        /// import does not. Hanging one under the other then leaves a 180° flip about X between
        /// them, and because the mesh origin is ~93 m from the statue, that flip throws the field
        /// 139 m away — which is what <c>BloomFlowersMeshTests</c> measures.
        /// </para>
        /// <para>
        /// <c>globalScale</c> is the GAIA1 convention: 0.6045, the number that makes the statue
        /// 18.8 m tall rather than 31. A default import stands the flowers 1.65× too large.
        /// </para>
        /// <para>
        /// Read off the cover rather than written down here, so the two cannot drift apart.
        /// </para>
        /// </summary>
        private static bool EnsureFlowerImport()
        {
            ModelImporter cover = AssetImporter.GetAtPath(k_Fbx) as ModelImporter;
            ModelImporter flowers = AssetImporter.GetAtPath(k_FlowerFbx) as ModelImporter;

            if (cover == null || flowers == null)
            {
                Debug.LogError($"{k_LogPrefix}: {k_Fbx} or {k_FlowerFbx} is not an imported model. "
                    + "Run Tools/pipeline/build_bloom_flowers.py first.");
                return false;
            }

            bool changed = flowers.bakeAxisConversion != cover.bakeAxisConversion
                || flowers.useFileScale != cover.useFileScale
                || !Mathf.Approximately(flowers.globalScale, cover.globalScale)
                || flowers.importAnimation != cover.importAnimation
                || flowers.animationType != cover.animationType
                || flowers.importVisibility != cover.importVisibility
                || flowers.importBlendShapes != cover.importBlendShapes
                || flowers.importCameras != cover.importCameras
                || flowers.importLights != cover.importLights
                || flowers.materialImportMode != cover.materialImportMode
                || flowers.importNormals != cover.importNormals
                || flowers.weldVertices != cover.weldVertices;

            if (!changed)
            {
                return true;
            }

            // Placement.
            flowers.bakeAxisConversion = cover.bakeAxisConversion;
            flowers.useFileScale = cover.useFileScale;
            flowers.globalScale = cover.globalScale;

            // The field is one static mesh. Everything here is a rig, a camera or a light the
            // exporter never wrote, and importing them costs an Animator on the model root.
            flowers.importAnimation = cover.importAnimation;
            flowers.animationType = cover.animationType;
            flowers.importVisibility = cover.importVisibility;
            flowers.importBlendShapes = cover.importBlendShapes;
            flowers.importCameras = cover.importCameras;
            flowers.importLights = cover.importLights;
            flowers.materialImportMode = cover.materialImportMode;

            // Vertex data. The pose deltas live in UV1..UV3 and the growth order in vertex colour;
            // a weld setting that disagrees with the cover's would merge them differently.
            flowers.importNormals = cover.importNormals;
            flowers.weldVertices = cover.weldVertices;

            flowers.SaveAndReimport();
            Debug.Log($"{k_LogPrefix}: reimported the flower field on the cover's settings "
                + $"(scale {cover.globalScale}, bakeAxisConversion {cover.bakeAxisConversion}).");
            return true;
        }

        private static GameObject EnsurePrefab(Material material, Material flowerMaterial)
        {
            if (!EnsureFlowerImport())
            {
                return null;
            }

            GameObject source = AssetDatabase.LoadAssetAtPath<GameObject>(k_Fbx);

            if (source == null)
            {
                Debug.LogError($"{k_LogPrefix}: {k_Fbx} not found.");
                return null;
            }

            EnsureFolder(Path.GetDirectoryName(k_Prefab));

            // Instantiate the imported model rather than hanging its mesh on a fresh GameObject.
            // The importer leaves the Blender-to-Unity axis conversion on this FBX's root as a 90°
            // rotation about X instead of baking it into the vertices, and the mesh's local origin
            // is tens of metres from the statue — so dropping that rotation does not merely tip the
            // clumps over, it throws them ~93 m away. Taking the model's own root keeps whatever
            // transform the importer decided on, for this export and for every future one.
            GameObject root = (GameObject)PrefabUtility.InstantiatePrefab(source);
            PrefabUtility.UnpackPrefabInstance(root, PrefabUnpackMode.Completely,
                InteractionMode.AutomatedAction);
            root.name = k_InstanceName;

            try
            {
                MeshRenderer renderer = root.GetComponentInChildren<MeshRenderer>();

                if (renderer == null)
                {
                    Debug.LogError($"{k_LogPrefix}: no MeshRenderer in {k_Fbx}.");
                    return null;
                }

                renderer.sharedMaterial = material;
                renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;

                MeshRenderer flowers = AttachFlowers(root, flowerMaterial);

                if (flowers == null)
                {
                    return null;
                }

                GrowthDriver driver = root.AddComponent<GrowthDriver>();
                SerializedObject so = new SerializedObject(driver);

                // One driver, both meshes. The cover and the flowers standing in it read the same
                // growth order out of their own vertex colour, so they only stay in step while
                // they are handed the same value on the same frame.
                SerializedProperty renderers = so.FindProperty("m_renderers");
                renderers.arraySize = 2;
                renderers.GetArrayElementAtIndex(0).objectReferenceValue = renderer;
                renderers.GetArrayElementAtIndex(1).objectReferenceValue = flowers;

                so.FindProperty("m_duration").floatValue = k_Duration;
                so.FindProperty("m_startAt").floatValue = 0f;

                // Parked at bare stone until the story says otherwise. GrowthCue owns the start,
                // so playing on enable would bloom the statue the moment its scene loaded — which
                // is what it did before the cue existed.
                so.FindProperty("m_playOnEnable").boolValue = false;

                // The cover at _Growth 0 clips to nothing, but a flower at growth 0 is still a
                // shut bud standing on the robe. The driver keeps the field switched off until
                // the ending starts, so the statue is bare stone until then.
                SerializedProperty hidden = so.FindProperty("m_hiddenUntilStarted");
                hidden.arraySize = 1;
                hidden.GetArrayElementAtIndex(0).objectReferenceValue = flowers;
                so.ApplyModifiedPropertiesWithoutUndo();

                if (!AttachCue(root))
                {
                    return null;
                }

                return PrefabUtility.SaveAsPrefabAsset(root, k_Prefab);
            }
            finally
            {
                Object.DestroyImmediate(root);
            }
        }


        /// <summary>
        /// Gives the statue the beat it blooms on: <see cref="WorldFlags.k_CirculationOuter"/>,
        /// the player reading the ecology correctly at the circulation console. The other two
        /// answers wake the boss; this one ends the game. <c>MusicWiring</c> already scores the
        /// same flag with MUS_EndingBloom, so the two were always going to be one beat — this is
        /// the picture half of it.
        /// </summary>
        private static bool AttachCue(GameObject root)
        {
            StringEventChannelSO channel =
                AssetDatabase.LoadAssetAtPath<StringEventChannelSO>(k_FlagChannel);

            if (channel == null)
            {
                Debug.LogError($"{k_LogPrefix}: {k_FlagChannel} not found; the statue would never "
                    + "hear the ending begin.");
                return false;
            }

            GrowthCue cue = root.AddComponent<GrowthCue>();
            SerializedObject so = new SerializedObject(cue);
            so.FindProperty("m_flagRaised").objectReferenceValue = channel;
            so.FindProperty("m_flagId").stringValue = WorldFlags.k_CirculationOuter;
            so.ApplyModifiedPropertiesWithoutUndo();
            return true;
        }

        /// <summary>
        /// Hangs the flower field under the prefab root and gives it its material.
        /// <para>
        /// Parented with <c>worldPositionStays</c> true, deliberately. Both FBXes carry the
        /// importer's axis conversion on their own root, and both were exported in the statue's
        /// own coordinates; parenting one under the other without keeping its world pose applies
        /// that conversion twice and throws the flowers off the statue exactly the way §7 of the
        /// plan records the clumps being thrown 93 m. Keeping the world pose makes the Editor
        /// compute whatever local transform expresses "leave it where the importer put it".
        /// </para>
        /// </summary>
        private static MeshRenderer AttachFlowers(GameObject root, Material material)
        {
            GameObject source = AssetDatabase.LoadAssetAtPath<GameObject>(k_FlowerFbx);

            if (source == null)
            {
                Debug.LogError($"{k_LogPrefix}: {k_FlowerFbx} not found. Run "
                    + "Tools/pipeline/build_bloom_flowers.py first.");
                return null;
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(source);
            PrefabUtility.UnpackPrefabInstance(instance, PrefabUnpackMode.Completely,
                InteractionMode.AutomatedAction);
            instance.name = k_FlowerInstanceName;
            instance.transform.SetParent(root.transform, true);

            MeshRenderer renderer = instance.GetComponentInChildren<MeshRenderer>();

            if (renderer == null)
            {
                Debug.LogError($"{k_LogPrefix}: no MeshRenderer in {k_FlowerFbx}.");
                Object.DestroyImmediate(instance);
                return null;
            }

            renderer.sharedMaterial = material;

            // Same reason the cover casts none: RootsDance/Environment/StatueFlowers has a depth
            // and a forward pass and no ShadowCaster, so asking for shadows costs a pass that
            // cannot run. Three thousand flowers is also the wrong place to start paying for one.
            renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;

            return renderer;
        }

        /// <summary>
        /// Gives MUS_SacredGaia the beat it has been waiting for: the player walking into the
        /// space the statue stands in.
        /// <para>
        /// In the gameplay scene rather than the statue's environment scene, because that is where
        /// triggers live and where <c>TriggerLayerTests</c> looks — a volume on the wrong layer
        /// raises nothing and says nothing about it.
        /// </para>
        /// </summary>
        private static void PlaceSacredSpaceTrigger()
        {
            Scene scene = SceneManager.GetSceneByPath(k_GameplayScene);

            if (!scene.IsValid() || !scene.isLoaded)
            {
                for (int i = 0; i < SceneManager.sceneCount; i++)
                {
                    if (SceneManager.GetSceneAt(i).isDirty)
                    {
                        Debug.LogError($"{k_LogPrefix}: a scene has unsaved changes. Save or "
                            + "discard them, then run this again.");
                        return;
                    }
                }

                scene = EditorSceneManager.OpenScene(k_GameplayScene, OpenSceneMode.Additive);
            }
            else if (scene.isDirty)
            {
                Debug.LogError($"{k_LogPrefix}: '{scene.name}' has unsaved changes. Save or "
                    + "discard them, then run this again.");
                return;
            }

            int layer = LayerMask.NameToLayer("TriggerVolume");

            if (layer < 0)
            {
                Debug.LogError($"{k_LogPrefix}: the TriggerVolume layer is not configured.");
                return;
            }

            StringEventChannelSO channel =
                AssetDatabase.LoadAssetAtPath<StringEventChannelSO>(k_FlagChannel);

            if (channel == null)
            {
                Debug.LogError($"{k_LogPrefix}: {k_FlagChannel} not found.");
                return;
            }

            GameObject volume = null;

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == k_SacredVolume)
                {
                    volume = root;
                    break;
                }
            }

            if (volume == null)
            {
                volume = new GameObject(k_SacredVolume);
                SceneManager.MoveGameObjectToScene(volume, scene);
            }

            volume.layer = layer;
            volume.transform.position = k_StatueFoot + new Vector3(0f, k_SacredVolumeSize.y * 0.5f, 0f);
            volume.transform.rotation = Quaternion.identity;

            BoxCollider box = volume.GetComponent<BoxCollider>();

            if (box == null)
            {
                box = volume.AddComponent<BoxCollider>();
            }

            box.isTrigger = true;
            box.center = Vector3.zero;
            box.size = k_SacredVolumeSize;

            TriggerVolume trigger = volume.GetComponent<TriggerVolume>();

            if (trigger == null)
            {
                trigger = volume.AddComponent<TriggerVolume>();
            }

            SerializedObject so = new SerializedObject(trigger);
            so.FindProperty("m_flagId").stringValue = WorldFlags.k_EnteredSacredSpace;
            so.ApplyModifiedPropertiesWithoutUndo();

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            Debug.Log($"{k_LogPrefix}: '{k_SacredVolume}' is in {scene.name}, raising "
                + $"{WorldFlags.k_EnteredSacredSpace}.");
        }

        private static void PlaceInScene(GameObject prefab)
        {
            // Use the scene if it is already open. The Main level is four additive scenes, and
            // opening this one Single would close the other three out from under whoever is
            // working in them — a builder has no business rearranging someone's setup.
            Scene scene = SceneManager.GetSceneByPath(k_ScenePath);

            if (!scene.IsValid() || !scene.isLoaded)
            {
                // Not open, so this has to open it — and Single would discard unsaved work
                // anywhere else. Refusing is the only safe answer.
                for (int i = 0; i < SceneManager.sceneCount; i++)
                {
                    Scene other = SceneManager.GetSceneAt(i);

                    if (other.isDirty)
                    {
                        Debug.LogError($"{k_LogPrefix}: '{other.name}' has unsaved changes. Save "
                            + "or discard them, then run this again.");
                        return;
                    }
                }

                scene = EditorSceneManager.OpenScene(k_ScenePath, OpenSceneMode.Single);
            }
            else if (scene.isDirty)
            {
                Debug.LogError($"{k_LogPrefix}: '{scene.name}' has unsaved changes. Save or "
                    + "discard them, then run this again.");
                return;
            }
            GameObject statue = null;

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == k_StatueRoot)
                {
                    statue = root;
                    break;
                }
            }

            if (statue == null)
            {
                Debug.LogError($"{k_LogPrefix}: no '{k_StatueRoot}' root in {k_ScenePath}. Run "
                    + "RootsDance > Build Statue Environment Scene first.");
                return;
            }

            Transform existing = statue.transform.Find(k_InstanceName);

            if (existing != null)
            {
                // Re-running must not stack a second copy. It must, however, repair a pose left by
                // an earlier build: an instance placed at identity is the 93 m bug, and telling
                // somebody it is "already there" while it sits in the sky is worse than useless.
                if (PoseMatches(existing, prefab.transform))
                {
                    Debug.Log($"{k_LogPrefix}: '{k_InstanceName}' is already under "
                        + $"'{k_StatueRoot}'; left as it is.");
                    return;
                }

                ApplyPrefabPose(existing, prefab.transform);
                EditorSceneManager.MarkSceneDirty(scene);
                EditorSceneManager.SaveScene(scene);
                Debug.Log($"{k_LogPrefix}: corrected the pose of '{k_InstanceName}' to the "
                    + "prefab's own.");
                return;
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
            instance.name = k_InstanceName;

            // The mesh carries the statue's own world coordinates, exported in place from the same
            // blend the statue came from, so the clumps land on the robe as long as the prefab's
            // own transform is left alone. Forcing identity here is exactly what put them 93 m off
            // the statue: it discards the axis conversion the importer parked on the model's root.
            instance.transform.SetParent(statue.transform, false);
            ApplyPrefabPose(instance.transform, prefab.transform);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            Debug.Log($"{k_LogPrefix}: placed '{k_InstanceName}' under '{k_StatueRoot}'.");
        }

        /// <summary>
        /// Give <paramref name="target"/> the pose the prefab itself carries. That pose is not
        /// identity: it holds the axis conversion the model importer left on the FBX root.
        /// </summary>
        private static void ApplyPrefabPose(Transform target, Transform prefabRoot)
        {
            target.localPosition = prefabRoot.localPosition;
            target.localRotation = prefabRoot.localRotation;
            target.localScale = prefabRoot.localScale;
        }

        private static bool PoseMatches(Transform target, Transform prefabRoot)
        {
            return target.localPosition == prefabRoot.localPosition
                && Quaternion.Angle(target.localRotation, prefabRoot.localRotation) < 0.01f
                && target.localScale == prefabRoot.localScale;
        }

        private static void EnsureFolder(string folder)
        {
            if (string.IsNullOrEmpty(folder) || AssetDatabase.IsValidFolder(folder))
            {
                return;
            }

            string parent = Path.GetDirectoryName(folder);
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, Path.GetFileName(folder));
        }
    }
}

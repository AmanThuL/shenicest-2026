using System;
using RootsDance.Core;
using UnityEditor;
using UnityEditor.Animations;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Editor.Content
{
    /// <summary>
    /// Turns the downloaded plant-monster FBX into the flower sprite the script calls 小花: one
    /// material, one animator that idles, and one prefab a level can drop in.
    /// <para>
    /// The mesh is authored 9.09 m tall. She is written as something the player is startled by and
    /// then talks down to, so she stands a little over half their height — <see cref="k_TargetHeight"/>
    /// against a 1.8 m player. The correction is an import scale rather than a prefab scale, so the
    /// scene keeps transforms at 1 and nothing downstream has to know she was resized.
    /// </para>
    /// <para>
    /// The FBX carries four takes — idle, walk, attack, aggro. Only idle is wired up here; the
    /// other three are imported and named so they are there when something needs them, but a
    /// controller that can only stand still is honest about what the level actually does with her.
    /// </para>
    /// Menu: RootsDance &gt; Content &gt; Build Flower Sprite.
    /// </summary>
    public static class FlowerSpriteBuilder
    {
        private const string k_ModelPath = "Assets/RootsDance/Meshes/Characters/FlowerSprite.fbx";
        private const string k_TextureFolder = "Assets/RootsDance/Textures/Characters/FlowerSprite";
        private const string k_BaseMapPath = k_TextureFolder + "/FlowerSprite_BaseMap.png";
        private const string k_NormalMapPath = k_TextureFolder + "/FlowerSprite_Normal.png";
        private const string k_MaterialFolder = "Assets/RootsDance/Materials/Characters";
        private const string k_MaterialPath = k_MaterialFolder + "/FlowerSprite.mat";
        private const string k_AnimationFolder = "Assets/RootsDance/Animations/Characters";
        private const string k_ControllerPath = k_AnimationFolder + "/FlowerSprite.controller";
        private const string k_PrefabFolder = "Assets/RootsDance/Prefabs/Characters";
        private const string k_PrefabPath = k_PrefabFolder + "/FlowerSprite.prefab";

        /// <summary>A little over half of the player's 1.8 m.</summary>
        private const float k_TargetHeight = 1.05f;

        /// <summary>
        /// What the model imports at: <see cref="k_TargetHeight"/> over the 9.094 m the FBX is
        /// authored at. The build re-measures and fails if the mesh changes under it.
        /// </summary>
        private const float k_ImportScale = 0.1155f;

        private const string k_IdleClip = "FlowerSprite_Idle";

        /// <summary>
        /// The takes in the FBX, in file order, and what each becomes. The authored names arrive as
        /// <c>metarig.001|metarig.001|idle</c>, which is neither readable in an Animator nor legal
        /// under the naming rules, so every one is renamed on import.
        /// </summary>
        private static readonly (string Take, string Clip, bool Loops)[] k_Clips =
        {
            ("agrro", "FlowerSprite_Aggro", false),
            ("attack", "FlowerSprite_Attack", false),
            ("idle", k_IdleClip, true),
            ("walk", "FlowerSprite_Walk", true),
        };

        [MenuItem("RootsDance/Content/Build Flower Sprite")]
        public static void Build()
        {
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            EnsureFolder(k_MaterialFolder);
            EnsureFolder(k_AnimationFolder);
            EnsureFolder(k_PrefabFolder);

            ConfigureTextures();
            ConfigureModel();
            Material material = EnsureMaterial();
            AnimatorController controller = EnsureController();
            GameObject prefab = EnsurePrefab(material, controller);
            AssetDatabase.SaveAssets();

            Bounds bounds = RendererBounds(prefab);
            Log.Info($"Built the flower sprite at {bounds.size.y:F2} m tall — "
                + $"{bounds.size.y / 1.8f:P0} of the player.", prefab);
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

        /// <summary>
        /// Normal maps have to be marked as such or HDRP reads them as colour. The base map is left
        /// as the importer's default, which already assumes colour.
        /// </summary>
        private static void ConfigureTextures()
        {
            TextureImporter normal = AssetImporter.GetAtPath(k_NormalMapPath) as TextureImporter;

            if (normal == null)
            {
                throw new System.IO.FileNotFoundException("Missing texture: " + k_NormalMapPath);
            }

            if (normal.textureType != TextureImporterType.NormalMap)
            {
                normal.textureType = TextureImporterType.NormalMap;
                normal.SaveAndReimport();
            }
        }

        /// <summary>
        /// Rig, scale and clip names, set here rather than in the model import profiles because the
        /// clip renaming is per-take data that <c>ModelImportProfiles</c> has no shape for.
        /// </summary>
        private static void ConfigureModel()
        {
            ModelImporter importer = AssetImporter.GetAtPath(k_ModelPath) as ModelImporter;

            if (importer == null)
            {
                throw new System.IO.FileNotFoundException("Missing model: " + k_ModelPath);
            }

            bool changed = false;

            if (!Mathf.Approximately(importer.globalScale, k_ImportScale))
            {
                importer.globalScale = k_ImportScale;
                changed = true;
            }

            if (importer.animationType != ModelImporterAnimationType.Generic)
            {
                importer.animationType = ModelImporterAnimationType.Generic;
                importer.avatarSetup = ModelImporterAvatarSetup.CreateFromThisModel;
                changed = true;
            }

            if (!importer.importAnimation)
            {
                importer.importAnimation = true;
                changed = true;
            }

            if (importer.materialImportMode != ModelImporterMaterialImportMode.None)
            {
                // The material is built here from the two shipped textures; the ones the FBX
                // declares are a Blender viewport shader and carry nothing worth importing.
                importer.materialImportMode = ModelImporterMaterialImportMode.None;
                changed = true;
            }

            ModelImporterClipAnimation[] clips = importer.defaultClipAnimations;

            for (int i = 0; i < clips.Length; i++)
            {
                for (int j = 0; j < k_Clips.Length; j++)
                {
                    if (!clips[i].takeName.EndsWith(k_Clips[j].Take, StringComparison.Ordinal))
                    {
                        continue;
                    }

                    clips[i].name = k_Clips[j].Clip;
                    clips[i].loopTime = k_Clips[j].Loops;
                }
            }

            importer.clipAnimations = clips;
            changed = true;

            if (changed)
            {
                importer.SaveAndReimport();
            }

            GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(k_ModelPath);

            if (model == null)
            {
                throw new InvalidOperationException("The flower sprite model failed to import.");
            }

            float height = RendererBounds(model).size.y;

            if (Mathf.Abs(height - k_TargetHeight) > 0.12f)
            {
                throw new InvalidOperationException(
                    $"The flower sprite imports {height:F2} m tall, not {k_TargetHeight:F2} m. The "
                    + "mesh changed under the import scale; re-derive k_ImportScale from its "
                    + "authored height.");
            }
        }

        private static Material EnsureMaterial()
        {
            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_MaterialPath);
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

            material.SetTexture("_BaseColorMap", LoadRequired<Texture>(k_BaseMapPath));
            material.SetColor("_BaseColor", Color.white);
            material.SetTexture("_NormalMap", LoadRequired<Texture>(k_NormalMapPath));
            material.SetFloat("_NormalScale", 1f);
            material.EnableKeyword("_NORMALMAP");
            material.SetFloat("_Smoothness", 0.25f);
            material.SetFloat("_Metallic", 0f);

            // Leaves and petals are single-sided planes; without this she is full of holes from
            // whichever side the player happens to walk up on.
            material.SetFloat("_DoubleSidedEnable", 1f);
            material.SetFloat("_DoubleSidedNormalMode", 1f);

            HDMaterial.ValidateMaterial(material);

            if (isNew)
            {
                AssetDatabase.CreateAsset(material, k_MaterialPath);
            }
            else
            {
                EditorUtility.SetDirty(material);
            }

            return material;
        }

        private static AnimatorController EnsureController()
        {
            AnimationClip idle = FindClip(k_IdleClip);
            AnimatorController controller =
                AssetDatabase.LoadAssetAtPath<AnimatorController>(k_ControllerPath);

            if (controller == null)
            {
                controller = AnimatorController.CreateAnimatorControllerAtPath(k_ControllerPath);
            }

            AnimatorStateMachine machine = controller.layers[0].stateMachine;
            AnimatorState state = null;

            for (int i = 0; i < machine.states.Length; i++)
            {
                if (machine.states[i].state.name == k_IdleClip)
                {
                    state = machine.states[i].state;
                }
            }

            if (state == null)
            {
                state = machine.AddState(k_IdleClip);
            }

            state.motion = idle;
            machine.defaultState = state;
            EditorUtility.SetDirty(controller);
            return controller;
        }

        private static GameObject EnsurePrefab(Material material, AnimatorController controller)
        {
            GameObject model = LoadRequired<GameObject>(k_ModelPath);
            GameObject root = (GameObject)PrefabUtility.InstantiatePrefab(model);

            try
            {
                root.name = "FlowerSprite";
                root.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
                root.transform.localScale = Vector3.one;

                Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);

                for (int i = 0; i < renderers.Length; i++)
                {
                    Material[] slots = renderers[i].sharedMaterials;

                    for (int slot = 0; slot < slots.Length; slot++)
                    {
                        slots[slot] = material;
                    }

                    renderers[i].sharedMaterials = slots;
                }

                Animator animator = root.GetComponent<Animator>();

                if (animator == null)
                {
                    animator = root.AddComponent<Animator>();
                }

                animator.runtimeAnimatorController = controller;
                animator.applyRootMotion = false;

                // She is scenery the player talks to, not something they bump into: a collider
                // would let the player shove her off a 0.92 m catwalk.
                return PrefabUtility.SaveAsPrefabAsset(root, k_PrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static AnimationClip FindClip(string clipName)
        {
            UnityEngine.Object[] assets = AssetDatabase.LoadAllAssetsAtPath(k_ModelPath);

            for (int i = 0; i < assets.Length; i++)
            {
                if (assets[i] is AnimationClip clip && clip.name == clipName)
                {
                    return clip;
                }
            }

            throw new InvalidOperationException(
                "The model has no clip named " + clipName + ". Its takes are: "
                + string.Join(", ", System.Array.ConvertAll(assets, a => a == null ? "null" : a.name)));
        }

        private static Bounds RendererBounds(GameObject root)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);

            if (renderers.Length == 0)
            {
                throw new InvalidOperationException("No renderers on " + root.name);
            }

            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds;
        }

        private static T LoadRequired<T>(string path) where T : UnityEngine.Object
        {
            T asset = AssetDatabase.LoadAssetAtPath<T>(path);

            if (asset == null)
            {
                throw new System.IO.FileNotFoundException("Required asset was not found: " + path);
            }

            return asset;
        }

        private static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = System.IO.Path.GetDirectoryName(path).Replace('\\', '/');
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, System.IO.Path.GetFileName(path));
        }
    }
}

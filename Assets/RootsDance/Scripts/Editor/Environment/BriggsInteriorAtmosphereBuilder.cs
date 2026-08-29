using System.Linq;
using RootsDance.Editor.Rendering;
using RootsDance.Rendering;
using UnityEditor;
using UnityEditor.Rendering;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Adds a non-destructive interior look on top of the hand-assembled Briggs laboratory shell.
    /// This tool never rebuilds or moves the Garage source-art hierarchy.
    /// </summary>
    public static class BriggsInteriorAtmosphereBuilder
    {
        private const string k_EnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment.unity";
        private const string k_AtmosphereRootName = "_LabAtmosphere";
        private const string k_ProfilePath =
            "Assets/RootsDance/Settings/VolumeProfiles/BriggsInteriorProfile.asset";
        private const string k_BlockerMaterialPath =
            "Assets/RootsDance/Materials/Environment/BriggsInterior/LabLightBlocker.mat";
        private const string k_FogNoisePath =
            "Assets/RootsDance/Textures/Environment/Garage/LabFogNoise.asset";

        [MenuItem("RootsDance/Environment/Apply Briggs Interior Atmosphere")]
        private static void ApplyFromMenu()
        {
            ApplyToLoadedScene();
        }

        /// <summary>
        /// Rebuilds the Briggs-only atmosphere in the loaded environment scene. The generated hierarchy and
        /// every authored profile value are replaced deterministically, so the aggregate environment builder
        /// can safely call this after props have moved.
        /// </summary>
        public static void ApplyToLoadedScene()
        {
            ValidatePsxRegistration();
            Scene environment = FindLoadedEnvironmentScene();
            Transform atmosphere = ReplaceAtmosphereRoot(environment);
            Material blockerMaterial = EnsureBlockerMaterial();
            Texture3D fogNoise = EnsureFogNoise();
            VolumeProfile profile = EnsureProfile();

            CreateLightBlockers(atmosphere, blockerMaterial, environment);
            CreateOpaqueLeakCaps(atmosphere, blockerMaterial, environment);
            CreateInteriorVolume(atmosphere, profile);
            CreateRoomFog(atmosphere, fogNoise);
            ConfigureSun(environment);
            CreateRoofShaftLights(atmosphere);
            ConfigureLabFillLights(environment);

            EditorSceneManager.SaveScene(environment);
            AssetDatabase.SaveAssets();
            Debug.Log("[BriggsInteriorAtmosphere] Restored the exact 006b2dc dark-green lighting, fog and PSX configuration.");
        }

        /// <summary>Batch entry point for the standalone atmosphere pass.</summary>
        public static void ApplyFromCommandLine()
        {
            EditorSceneManager.OpenScene(k_EnvironmentPath, OpenSceneMode.Single);
            ApplyToLoadedScene();

            if (Application.isBatchMode)
            {
                EditorApplication.Exit(0);
            }
        }

        private static Scene FindLoadedEnvironmentScene()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.path == k_EnvironmentPath)
                {
                    return scene;
                }
            }

            throw new System.InvalidOperationException(
                "Open BriggsInterior_Environment before applying its atmosphere.");
        }

        private static Transform ReplaceAtmosphereRoot(Scene scene)
        {
            GameObject existing = scene.GetRootGameObjects()
                .FirstOrDefault(root => root.name == k_AtmosphereRootName);

            if (existing != null)
            {
                Undo.DestroyObjectImmediate(existing);
            }

            GameObject created = new GameObject(k_AtmosphereRootName);
            SceneManager.MoveGameObjectToScene(created, scene);
            Undo.RegisterCreatedObjectUndo(created, "Create Briggs interior atmosphere");
            return created.transform;
        }

        private static void CreateLightBlockers(Transform parent, Material material, Scene scene)
        {
            Transform blockers = CreateChild("LightBlockers_ShadowOnly", parent);
            const float wallThickness = 0.5f;
            const float blockerHeight = 5.7f;
            const float southZ = -7.15f;
            MeshRenderer westWall = FindMeshRenderer(scene, "Briggs_Wall_West");
            MeshRenderer eastWall = FindMeshRenderer(scene, "Briggs_Wall_East");
            float westX = westWall != null ? westWall.bounds.max.x - 0.12f : -9.15f;
            float eastX = eastWall != null ? eastWall.bounds.min.x + 0.12f : 9.15f;

            CreateBlocker(
                blockers,
                "Blocker_West",
                new Vector3(westX, 2.45f, 0f),
                new Vector3(wallThickness, blockerHeight, 14.6f),
                material);
            CreateBlocker(
                blockers,
                "Blocker_East",
                new Vector3(eastX, 2.45f, 0f),
                new Vector3(wallThickness, blockerHeight, 14.6f),
                material);
            CreateBlocker(
                blockers,
                "Blocker_Roof_NorthSeam",
                new Vector3(0f, 5f, 6.5f),
                new Vector3(18.6f, 0.3f, 1.6f),
                material);
            // Keep the 3.2 m south entrance centred at X = 3 m open while sealing both corners.
            CreateBlocker(
                blockers,
                "Blocker_South_West",
                new Vector3(-4f, 2.45f, southZ),
                new Vector3(10.8f, blockerHeight, wallThickness),
                material);
            CreateBlocker(
                blockers,
                "Blocker_South_East",
                new Vector3(7f, 2.45f, southZ),
                new Vector3(4.8f, blockerHeight, wallThickness),
                material);
        }

        private static void CreateBlocker(
            Transform parent,
            string name,
            Vector3 position,
            Vector3 size,
            Material material)
        {
            GameObject blocker = GameObject.CreatePrimitive(PrimitiveType.Cube);
            blocker.name = name;
            blocker.transform.SetParent(parent, false);
            blocker.transform.localPosition = position;
            blocker.transform.localScale = size;
            blocker.isStatic = true;

            Collider collider = blocker.GetComponent<Collider>();

            if (collider != null)
            {
                Object.DestroyImmediate(collider);
            }

            MeshRenderer renderer = blocker.GetComponent<MeshRenderer>();
            renderer.sharedMaterial = material;
            renderer.shadowCastingMode = ShadowCastingMode.ShadowsOnly;
            renderer.receiveShadows = false;
            renderer.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;
        }

        private static void CreateOpaqueLeakCaps(Transform parent, Material material, Scene scene)
        {
            Transform caps = CreateChild("LightLeakCaps_Opaque", parent);
            MeshRenderer westWall = FindMeshRenderer(scene, "Briggs_Wall_West");
            MeshRenderer eastWall = FindMeshRenderer(scene, "Briggs_Wall_East");
            float northZ = 7.15f;
            float westX = westWall != null ? westWall.bounds.max.x - 0.12f : -9.05f;
            float eastX = eastWall != null ? eastWall.bounds.min.x + 0.12f : 9.05f;
            Material westMaterial = GetWallPatchMaterial(westWall, material);
            Material eastMaterial = GetWallPatchMaterial(eastWall, material);
            CreateOpaqueCap(
                caps,
                "Cap_Top_South",
                new Vector3(0f, 4.38f, -7.05f),
                new Vector3(18.7f, 1.35f, 0.4f),
                westMaterial);
            CreateOpaqueCap(
                caps,
                "Cap_Top_West",
                new Vector3(westX, 4.38f, 0f),
                new Vector3(0.4f, 1.35f, 14.5f),
                westMaterial);
            CreateOpaqueCap(
                caps,
                "Cap_Top_East",
                new Vector3(eastX, 4.38f, 0f),
                new Vector3(0.4f, 1.35f, 14.5f),
                eastMaterial);

            CreateOpaqueCap(
                caps,
                "Cap_Bottom_South",
                new Vector3(0f, 0.02f, -7.05f),
                new Vector3(18.7f, 0.12f, 0.4f),
                westMaterial);
            CreateOpaqueCap(
                caps,
                "Cap_Bottom_West",
                new Vector3(westX, 0.02f, 0f),
                new Vector3(0.4f, 0.12f, 14.5f),
                westMaterial);
            CreateOpaqueCap(
                caps,
                "Cap_Bottom_East",
                new Vector3(eastX, 0.02f, 0f),
                new Vector3(0.4f, 0.12f, 14.5f),
                eastMaterial);

            CreateOpaqueCap(
                caps,
                "Cap_Corner_NorthWest",
                new Vector3(westX, 2.45f, northZ),
                new Vector3(0.45f, 5.4f, 0.45f),
                westMaterial);
            CreateOpaqueCap(
                caps,
                "Cap_Corner_NorthEast",
                new Vector3(eastX, 2.45f, northZ),
                new Vector3(0.45f, 5.4f, 0.45f),
                eastMaterial);
            CreateOpaqueCap(
                caps,
                "Cap_Corner_SouthWest",
                new Vector3(westX, 2.45f, -7.05f),
                new Vector3(0.45f, 5.4f, 0.45f),
                westMaterial);
            CreateOpaqueCap(
                caps,
                "Cap_Corner_SouthEast",
                new Vector3(eastX, 2.45f, -7.05f),
                new Vector3(0.45f, 5.4f, 0.45f),
                eastMaterial);
        }

        private static void CreateOpaqueCap(
            Transform parent,
            string name,
            Vector3 position,
            Vector3 size,
            Material material)
        {
            GameObject cap = GameObject.CreatePrimitive(PrimitiveType.Cube);
            cap.name = name;
            cap.transform.SetParent(parent, false);
            cap.transform.localPosition = position;
            cap.transform.localScale = size;
            cap.isStatic = true;

            Collider collider = cap.GetComponent<Collider>();

            if (collider != null)
            {
                Object.DestroyImmediate(collider);
            }

            MeshRenderer renderer = cap.GetComponent<MeshRenderer>();
            renderer.sharedMaterial = material;
            renderer.shadowCastingMode = ShadowCastingMode.On;
            renderer.receiveShadows = true;
            renderer.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;
        }

        private static void CreateInteriorVolume(Transform parent, VolumeProfile profile)
        {
            GameObject volumeObject = new GameObject("Global Volume");
            volumeObject.transform.SetParent(parent, false);

            Volume volume = volumeObject.AddComponent<Volume>();
            volume.isGlobal = true;
            volume.priority = 0f;
            volume.blendDistance = 0f;
            volume.weight = 1f;
            volume.sharedProfile = profile;
        }

        private static void CreateRoomFog(Transform parent, Texture3D noise)
        {
            GameObject fogObject = new GameObject("RoomSmoke_LocalVolumetricFog");
            fogObject.transform.SetParent(parent, false);
            fogObject.transform.localPosition = new Vector3(0f, 2.35f, 0f);

            LocalVolumetricFog fog = fogObject.AddComponent<LocalVolumetricFog>();
            LocalVolumetricFogArtistParameters parameters =
                new LocalVolumetricFogArtistParameters(new Color(0.50f, 0.64f, 0.56f), 13.5f, 0f);
            parameters.blendingMode = LocalVolumetricFogBlendingMode.Additive;
            parameters.priority = 10;
            parameters.size = new Vector3(17.2f, 4.6f, 13.2f);
            parameters.scaleMode = LocalVolumetricFogScaleMode.ScaleInvariant;
            parameters.volumeMask = noise;
            parameters.textureTiling = new Vector3(1.35f, 0.8f, 1.35f);
            parameters.textureScrollingSpeed = new Vector3(0.012f, 0.003f, 0.009f);
            parameters.positiveFade = new Vector3(0.12f, 0.08f, 0.12f);
            parameters.negativeFade = new Vector3(0.12f, 0.08f, 0.12f);
            parameters.distanceFadeStart = 35f;
            parameters.distanceFadeEnd = 45f;
            parameters.falloffMode = LocalVolumetricFogFalloffMode.Exponential;
            fog.parameters = parameters;
        }

        private static VolumeProfile EnsureProfile()
        {
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_ProfilePath);

            if (profile == null)
            {
                EnsureFolder(System.IO.Path.GetDirectoryName(k_ProfilePath).Replace('\\', '/'));
                profile = VolumeProfileFactory.CreateVolumeProfileAtPath(k_ProfilePath);
            }

            Exposure exposure = GetOrAdd<Exposure>(profile);
            Set(exposure.mode, ExposureMode.Fixed);
            Set(exposure.fixedExposure, 4.5f);

            VisualEnvironment environment = GetOrAdd<VisualEnvironment>(profile);
            Set(environment.skyType, (int)SkyType.Gradient);
            Set(environment.cloudType, 0);
            Set(environment.skyAmbientMode, SkyAmbientMode.Dynamic);

            GradientSky sky = GetOrAdd<GradientSky>(profile);
            Set(sky.top, new Color(0.035f, 0.070f, 0.052f));
            Set(sky.middle, new Color(0.090f, 0.140f, 0.105f));
            Set(sky.bottom, new Color(0.015f, 0.025f, 0.020f));
            Set(sky.gradientDiffusion, 1.4f);
            Set(sky.skyIntensityMode, SkyIntensityMode.Exposure);
            Set(sky.exposure, -1.2f);
            Set(sky.multiplier, 1f);

            Fog fog = GetOrAdd<Fog>(profile);
            Set(fog.enabled, true);
            Set(fog.colorMode, FogColorMode.SkyColor);
            Set(fog.tint, Color.white);
            Set(fog.meanFreePath, 38f);
            Set(fog.baseHeight, 0f);
            Set(fog.maximumHeight, 6f);
            Set(fog.maxFogDistance, 70f);
            Set(fog.enableVolumetricFog, true);
            Set(fog.albedo, new Color(0.62f, 0.72f, 0.65f));
            Set(fog.anisotropy, 0.62f);
            Set(fog.globalLightProbeDimmer, 0.04f);
            Set(fog.depthExtent, 40f);
            Set(fog.multipleScatteringIntensity, 0.35f);
            Set(fog.denoisingMode, FogDenoisingMode.Gaussian);
            Set(fog.quality, ScalableSettingLevelParameter.LevelCount);
            fog.fogControlMode = FogControl.Manual;
            Set(fog.screenResolutionPercentage, 50f);
            Set(fog.volumeSliceCount, 128);
            Set(fog.sliceDistributionUniformity, 0.65f);

            IndirectLightingController indirect = GetOrAdd<IndirectLightingController>(profile);
            Set(indirect.indirectDiffuseLightingMultiplier, 0.25f);
            Set(indirect.reflectionLightingMultiplier, 0.38f);
            Set(indirect.reflectionProbeIntensityMultiplier, 0.45f);

            HDShadowSettings shadows = GetOrAdd<HDShadowSettings>(profile);
            Set(shadows.maxShadowDistance, 50f);
            Set(shadows.cascadeShadowSplitCount, 4);

            ScreenSpaceAmbientOcclusion ao = GetOrAdd<ScreenSpaceAmbientOcclusion>(profile);
            Set(ao.intensity, 0.9f);
            Set(ao.directLightingStrength, 0.12f);
            Set(ao.radius, 0.65f);

            ColorAdjustments color = GetOrAdd<ColorAdjustments>(profile);
            Set(color.postExposure, -0.15f);
            Set(color.contrast, 20f);
            Set(color.saturation, -20f);
            Set(color.colorFilter, new Color(0.84f, 0.94f, 0.90f));

            WhiteBalance whiteBalance = GetOrAdd<WhiteBalance>(profile);
            Set(whiteBalance.temperature, -6f);
            Set(whiteBalance.tint, -12f);

            Tonemapping tonemapping = GetOrAdd<Tonemapping>(profile);
            Set(tonemapping.mode, TonemappingMode.Neutral);

            Bloom bloom = GetOrAdd<Bloom>(profile);
            Set(bloom.threshold, 0f);
            Set(bloom.intensity, 0.08f);
            Set(bloom.scatter, 0.65f);
            bloom.highQualityFiltering = true;

            Vignette vignette = GetOrAdd<Vignette>(profile);
            Set(vignette.mode, VignetteMode.Procedural);
            Set(vignette.intensity, 0.22f);
            Set(vignette.smoothness, 0.55f);

            PsxPostProcess psx = GetOrAdd<PsxPostProcess>(profile);
            Set(psx.intensity, 1f);
            Set(psx.grainMode, false);
            Set(psx.pixelScale, 4);
            Set(psx.colorLevels, 32);
            Set(psx.ditherStrength, 0.6f);
            Set(psx.interlaceStrength, 0.1f);
            Set(psx.interlaceSize, 1);
            Set(psx.grainIntensity, 0.1f);
            Set(psx.grainSize, 3);
            Set(psx.grainRate, 10f);
            Set(psx.grainShadowBias, 0.65f);
            RemoveComponent<FilmGrain>(profile);

            EditorUtility.SetDirty(profile);
            return profile;
        }

        private static Material EnsureBlockerMaterial()
        {
            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_BlockerMaterialPath);

            if (material == null)
            {
                EnsureFolder(System.IO.Path.GetDirectoryName(k_BlockerMaterialPath).Replace('\\', '/'));
                Shader shader = Shader.Find("HDRP/Lit");

                if (shader == null)
                {
                    throw new System.InvalidOperationException("HDRP/Lit shader was not found.");
                }

                material = new Material(shader) { name = "LabLightBlocker" };
                AssetDatabase.CreateAsset(material, k_BlockerMaterialPath);
            }

            material.SetColor("_BaseColor", Color.black);
            material.SetFloat("_Smoothness", 0f);
            material.SetFloat("_DoubleSidedEnable", 1f);
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Texture3D EnsureFogNoise()
        {
            Texture3D texture = AssetDatabase.LoadAssetAtPath<Texture3D>(k_FogNoisePath);

            if (texture != null)
            {
                return texture;
            }

            const int resolution = 32;
            texture = new Texture3D(resolution, resolution, resolution, TextureFormat.RGBA32, false)
            {
                name = "LabFogNoise",
                wrapMode = TextureWrapMode.Repeat,
                filterMode = FilterMode.Bilinear,
                anisoLevel = 0,
            };
            Color[] pixels = new Color[resolution * resolution * resolution];
            int index = 0;

            for (int z = 0; z < resolution; z++)
            {
                for (int y = 0; y < resolution; y++)
                {
                    for (int x = 0; x < resolution; x++)
                    {
                        float fx = x / (float)resolution;
                        float fy = y / (float)resolution;
                        float fz = z / (float)resolution;
                        float broad = (
                            Mathf.PerlinNoise(fx * 3.1f + 7.2f, fy * 3.1f + 2.4f)
                            + Mathf.PerlinNoise(fy * 3.1f + 11.7f, fz * 3.1f + 5.3f)
                            + Mathf.PerlinNoise(fz * 3.1f + 3.8f, fx * 3.1f + 13.1f)) / 3f;
                        float detail = Mathf.PerlinNoise(
                            (fx + fz) * 8.4f + 19.1f,
                            (fy + fx) * 8.4f + 4.6f);
                        float density = Mathf.SmoothStep(0.28f, 0.78f, broad * 0.78f + detail * 0.22f);
                        pixels[index++] = new Color(density, density, density, density);
                    }
                }
            }

            texture.SetPixels(pixels);
            texture.Apply(updateMipmaps: false, makeNoLongerReadable: true);
            AssetDatabase.CreateAsset(texture, k_FogNoisePath);
            return texture;
        }

        private static void ConfigureSun(Scene scene)
        {
            Light sun = FindLight(scene, "Sun");

            if (sun == null)
            {
                throw new System.InvalidOperationException("BriggsInterior environment has no Sun light.");
            }

            HDAdditionalLightData data = sun.GetComponent<HDAdditionalLightData>();

            if (data == null)
            {
                data = sun.gameObject.AddComponent<HDAdditionalLightData>();
            }

            sun.shadows = LightShadows.Soft;
            sun.shadowBias = 0.025f;
            sun.shadowNormalBias = 0.18f;
            sun.lightUnit = LightUnit.Lux;
            sun.intensity = 18000f;
            sun.color = new Color(0.88f, 0.97f, 0.85f);
            sun.useColorTemperature = false;
            data.affectsVolumetric = true;
            // Keep the exterior sunlight on surfaces, but do not let it flatten the entire fog bank.
            data.volumetricDimmer = 0.12f;
            data.volumetricShadowDimmer = 1f;
            data.shadowDimmer = 1f;
            data.angularDiameter = 8f;
            EditorUtility.SetDirty(sun);
            EditorUtility.SetDirty(data);
        }

        private static void CreateRoofShaftLights(Transform parent)
        {
            Transform shafts = CreateChild("RoofShaftLights", parent);
            CreateRoofShaft(
                shafts,
                "RoofShaft_Main",
                new Vector3(0.1f, 4.18f, 2.5f),
                Quaternion.Euler(70f, 180f, 0f),
                1100f,
                28f,
                12f,
                3.2f);
            CreateRoofShaft(
                shafts,
                "RoofShaft_West",
                new Vector3(-5.35f, 4.18f, 3.75f),
                Quaternion.Euler(74f, 165f, 0f),
                700f,
                24f,
                10f,
                2.2f);
        }

        private static void CreateRoofShaft(
            Transform parent,
            string name,
            Vector3 position,
            Quaternion rotation,
            float lumen,
            float outerAngle,
            float innerAngle,
            float volumetricDimmer)
        {
            GameObject lightObject = new GameObject(name);
            lightObject.transform.SetParent(parent, false);
            lightObject.transform.SetLocalPositionAndRotation(position, rotation);

            Light light = lightObject.AddComponent<Light>();
            light.type = LightType.Spot;
            light.spotAngle = outerAngle;
            light.innerSpotAngle = innerAngle;
            light.range = 9f;
            light.enableSpotReflector = true;
            light.lightUnit = LightUnit.Lumen;
            light.intensity = LightUnitUtils.ConvertIntensity(light, lumen, LightUnit.Lumen, LightUnit.Candela);
            light.color = new Color(0.78f, 0.98f, 0.82f);
            // The light begins just below the ceiling shell so it can form a controllable art-directed shaft.
            light.shadows = LightShadows.None;

            HDAdditionalLightData data = lightObject.GetComponent<HDAdditionalLightData>();

            if (data == null)
            {
                data = lightObject.AddComponent<HDAdditionalLightData>();
            }

            data.EnableShadows(false);
            data.SetShadowResolutionOverride(false);
            data.SetShadowResolutionLevel((int)ScalableSettingLevelParameter.Level.Medium);
            data.affectsVolumetric = true;
            data.volumetricDimmer = volumetricDimmer;
            data.volumetricShadowDimmer = 0f;
        }

        private static void ConfigureLabFillLights(Scene scene)
        {
            ConfigureFill(FindLight(scene, "LabFill_North"), 10000f, new Color(0.56f, 0.78f, 0.67f));
            ConfigureFill(FindLight(scene, "LabFill_South"), 8000f, new Color(0.62f, 0.74f, 0.61f));
        }

        private static void ConfigureFill(Light light, float lumen, Color color)
        {
            if (light == null)
            {
                return;
            }

            light.lightUnit = LightUnit.Lumen;
            light.intensity = LightUnitUtils.ConvertIntensity(light, lumen, LightUnit.Lumen, LightUnit.Candela);
            light.color = color;
            light.range = 12f;
            light.shadows = LightShadows.None;
            HDAdditionalLightData data = light.GetComponent<HDAdditionalLightData>();

            if (data != null)
            {
                data.affectsVolumetric = false;
                EditorUtility.SetDirty(data);
            }

            EditorUtility.SetDirty(light);
        }

        private static Light FindLight(Scene scene, string name)
        {
            return scene.GetRootGameObjects()
                .SelectMany(root => root.GetComponentsInChildren<Light>(true))
                .FirstOrDefault(light => light.name == name);
        }

        private static MeshRenderer FindMeshRenderer(Scene scene, string name)
        {
            return scene.GetRootGameObjects()
                .SelectMany(root => root.GetComponentsInChildren<MeshRenderer>(true))
                .FirstOrDefault(renderer => renderer.name == name);
        }

        private static Material GetWallPatchMaterial(MeshRenderer renderer, Material fallback)
        {
            if (renderer == null)
            {
                return fallback;
            }

            Material[] materials = renderer.sharedMaterials;

            if (materials.Length > 1 && materials[1] != null)
            {
                return materials[1];
            }

            return renderer.sharedMaterial != null ? renderer.sharedMaterial : fallback;
        }

        private static Transform CreateChild(string name, Transform parent)
        {
            GameObject child = new GameObject(name);
            child.transform.SetParent(parent, false);
            return child.transform;
        }

        private static T GetOrAdd<T>(VolumeProfile profile) where T : VolumeComponent
        {
            T component;

            if (profile.TryGet(out component))
            {
                return component;
            }

            return VolumeProfileFactory.CreateVolumeComponent<T>(profile, overrides: false, saveAsset: false);
        }

        /// <summary>Removes both the profile entry and its embedded sub-asset, matching the Volume Inspector.</summary>
        private static void RemoveComponent<T>(VolumeProfile profile) where T : VolumeComponent
        {
            T component;

            if (!profile.TryGet(out component))
            {
                return;
            }

            profile.Remove<T>();
            AssetDatabase.RemoveObjectFromAsset(component);
            Object.DestroyImmediate(component, true);
        }

        private static void ValidatePsxRegistration()
        {
            if (PsxPostProcessRegistrar.IsRegistered() && PsxPostProcessRegistrar.IsShaderAlwaysIncluded())
            {
                return;
            }

            throw new System.InvalidOperationException(
                "BriggsInterior PSX requires the existing project registration. Run "
                + "RootsDance > Rendering > Register PSX Post Process before rebuilding the atmosphere.");
        }

        private static void Set<T>(VolumeParameter<T> parameter, T value)
        {
            parameter.overrideState = true;
            parameter.value = value;
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

// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;
using Boxophobic.Utility;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine.Rendering;

namespace TheVisualEngine
{
    [HelpURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.hbq3w8ae720x")]
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Visual Engine/TVE Manager")]
    [DefaultExecutionOrder(-1)]
    public class TVEManager : StyledMonoBehaviour
    {
        public static TVEManager Instance;

#if UNITY_EDITOR
        [StyledCategory("Quick Settings", true, 0, 10)]
        public bool quickCategory = true;
#endif

        [Tooltip("Controls the global wind power.")]
        [StyledRangeOptions("Motion Control", 0, 1, new string[] { "None", "Windy", "Strong" })]
        public float motionControl = 0.5f;

        [Space(10)]
        [Tooltip("Use the Seasons slider to control the element properties when the element is set to Seasons mode.")]
        [StyledRangeOptions("Season Control", 0, 4, new string[] { "Winter", "Spring", "Summer", "Autumn", "Winter" })]
        public float seasonControl = 2f;

#if UNITY_EDITOR
        [StyledSpace(10)]
        public bool quickEnd = true;

        [StyledCategory("Main Settings", true, 0, 10)]
        public bool mainCategory = true;
#endif

        [StyledMessage("Error", "Main Camera not found! Make sure you have a main camera with Main Camera tag in your scene! Particle elements updating will be skipped without it. Enter play mode to update the status!", 0, 10)]
        public bool styledCameraMessaage = false;

        [Tooltip("Sets the main camera used for scene rendering.")]
        public Camera mainCamera;

        [Tooltip("Sets the main light used as the sun in the scene.")]
        public Light mainLight;

        [Tooltip("Sets the main direction from a gameobject.")]
        public GameObject mainWind;

        [Tooltip("Sets the main settings automatically.")]
        [Space(10)]
        public bool autoAssingMainObjects = true;

#if UNITY_EDITOR
        [StyledSpace(10)]
        public bool mainEnd = true;

        [StyledCategory("Player Settings", true, 0, 10)]
        public bool playerCategory = true;
#endif

        [Tooltip("Sets the main player gameobject.")]
        public GameObject playerObject;

        [Tooltip("Sets the main player radius.")]
        public float playerRadius = 1;

#if UNITY_EDITOR
        [StyledSpace(10)]
        public bool playerEnd = true;

        [StyledCategory("Global Settings", true, 0, 10)]
        public bool globalCategory = true;
#endif

        public TVEGlobalCoatData globalCoatData = new();
        public TVEGlobalPaintData globalPaintData = new();
        public TVEGlobalAtmoData globalAtmoData = new();
        public TVEGlobalEffexData globalEffexData = new();
        public TVEGlobalGlowData globalGlowData = new();
        public TVEGlobalVertxData globalVertxData = new();
        //public TVEGlobalFlowData globalFlowData = new();

#if UNITY_EDITOR
        [StyledSpace(10)]
        public bool globalEnd = true;

        [StyledCategory("Shader Settings", true, 0, 10)]
        public bool shaderCategory = true;
#endif

        //public TVEShaderMotionData motionSettings = new();
        //[Tooltip("Use the shader Season settings when using the Season feature on materials.")]
        //public TVEShaderSeasonData seasonSettings = new();
        [Tooltip("Use the shader Meta settings to toggle the HTrace shader proxy representation support.")]
        public TVEShaderMetaGIData metaGISettings = new();

#if UNITY_EDITOR
        [StyledSpace(10)]
        public bool shaderEnd = true;

        [StyledCategory("Element Settings", true, 0, 10)]
        public bool elementCategory = true;

        [StyledMessage("Info", "Realtime Sorting is not supported for elements with GPU Instanceing enabled!", 0, 10)]
        public bool styledSortingMessaage = true;
#endif

        [Tooltip("Controls the elements visibility in scene and game view.")]
        public TVEElementsVisibility elementVisibility = TVEElementsVisibility.HiddenAtRuntime;
        [HideInInspector]
        public TVEElementsVisibility elementVisibilityOld = TVEElementsVisibility.HiddenAtRuntime;
        [Tooltip("Controls the elements sorting by element position. Always enabled in edit mode.")]
        public TVEElementsOrdering elementOrdering = TVEElementsOrdering.SortInEditMode;
        [Tooltip("Controls the elements rendering.")]
        public TVEElementRendererData elementRenderer = new();


#if !THE_VISUAL_ENGINE_DEBUG
        [System.NonSerialized]
#endif
        [Space(10)]
        public List<TVEElementBufferData> renderDataSet = new List<TVEElementBufferData>();

#if !THE_VISUAL_ENGINE_DEBUG
        [System.NonSerialized]
#endif
        public List<TVEElement> renderElements = new List<TVEElement>();

#if !THE_VISUAL_ENGINE_DEBUG
        [System.NonSerialized]
#endif
        public List<TVEInstanced> renderInstances = new List<TVEInstanced>();

#if !THE_VISUAL_ENGINE_DEBUG
        [System.NonSerialized]
#endif

        float customTime;
        Transform focusTransform;

        MaterialPropertyBlock propertyBlock;

        Matrix4x4 projectionMatrix;
        Matrix4x4 modelViewMatrix = new Matrix4x4
        (
            new Vector4(1f, 0f, 0f, 0f),
            new Vector4(0f, 0f, -1f, 0f),
            new Vector4(0f, -1f, 0f, 0f),
            new Vector4(0f, 0f, 0f, 1f)
        );

        void OnEnable()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

#if UNITY_EDITOR
            if (gameObject.GetComponent<MeshRenderer>() == null)
            {
                gameObject.AddComponent<MeshRenderer>();
                gameObject.GetComponent<MeshRenderer>().sharedMaterial = Resources.Load<Material>("Internal Arrow");
                gameObject.GetComponent<MeshRenderer>().hideFlags = HideFlags.HideInInspector;
            }

            if (gameObject.GetComponent<MeshFilter>() == null)
            {
                gameObject.AddComponent<MeshFilter>();
                gameObject.GetComponent<MeshFilter>().mesh = Resources.Load<Mesh>("Internal Mesh Arrow");
                gameObject.GetComponent<MeshFilter>().hideFlags = HideFlags.HideInInspector;
            }
#endif

            EnableManager();

            if (autoAssingMainObjects)
            {
                if (mainCamera == null)
                {
                    mainCamera = Camera.main;
                }

                if (mainWind == null)
                {
                    mainWind = gameObject;
                }

                if (mainLight == null)
                {
                    SetGlobalLightingMainLight();
                }
            }

            // Disable Arrow in play mode
            if (Application.isPlaying == true)
            {
                gameObject.GetComponent<MeshRenderer>().enabled = false;
            }
            else
            {
                gameObject.GetComponent<MeshRenderer>().enabled = true;
            }

            InitElementsRendering();

            SortElementObjects();
            SetElementsVisibility();
        }

        void OnDisable()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

            DisableManager();
        }

        void OnDestroy()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

            DisableManager();
        }

        void Update()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

            if (mainWind != null)
            {
                gameObject.transform.eulerAngles = new Vector3(0, mainWind.transform.eulerAngles.y, 0);
            }
            else
            {
                gameObject.transform.eulerAngles = new Vector3(0, gameObject.transform.eulerAngles.y, 0);
            }

            SetGlobalShaderProperties();
        }


        void LateUpdate()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

            if (mainCamera != null)
            {
                focusTransform = mainCamera.transform;
            }

#if UNITY_EDITOR
            if (!Application.isPlaying)
            {
                if (SceneView.lastActiveSceneView != null)
                {
                    focusTransform = SceneView.lastActiveSceneView.camera.transform;
                }
            }
#endif

            Shader.SetGlobalFloat("TVE_MainCameraSpeedValue", Vector3.Magnitude(focusTransform.position) * 0.2f + (focusTransform.rotation.x + focusTransform.rotation.y) * 0.5f);

            if (propertyBlock == null)
            {
                propertyBlock = new MaterialPropertyBlock();
            }

            if (elementOrdering == TVEElementsOrdering.SortAtRuntime || sortDirty)
            {
                SortElementObjects();
            }

            if (elementVisibilityOld != elementVisibility)
            {
                SetElementsVisibility();

                elementVisibilityOld = elementVisibility;
            }

            SubmitRenderBuffers();

            GL.PushMatrix();
            RenderTexture currentRenderTexture = RenderTexture.active;

            ExecuteRenderBuffers(true);
            ExecuteRenderBuffers(false);

            RenderTexture.active = currentRenderTexture;
            GL.PopMatrix();

#if UNITY_EDITOR
            if (Selection.Contains(gameObject))
            {
                //UpdateDebugData();

                if (elementOrdering == TVEElementsOrdering.SortAtRuntime)
                {
                    styledSortingMessaage = true;
                }
                else
                {
                    styledSortingMessaage = false;
                }

                if (mainCamera == null)
                {
                    styledCameraMessaage = true;
                }
                else
                {
                    styledCameraMessaage = false;
                }
            }
#endif
        }

        void EnableManager()
        {
            if (TVEManager.Instance != null && TVEManager.Instance != this)
            {
                TVEManager.Instance.gameObject.SetActive(false);
            }

            Instance = this;
            Instance.name = "The Visual Engine";

            Shader.SetGlobalFloat("TVE_ManagerActive", 1);
            Shader.SetGlobalFloat("TVE_IsEnabled", 1);
        }

        void DisableManager()
        {
            Instance = null;

            //globalVolume.DisableVolumeRendering();

            Shader.SetGlobalFloat("TVE_ManagerActive", 0);
            Shader.SetGlobalFloat("TVE_IsEnabled", 0);

            DestroyRenderBuffers();
            DisableElementsRendering();
            DisableGlobalShaderProperties();
        }

        void SetGlobalShaderProperties()
        {
            Shader.SetGlobalFloat("TVE_RenderBaseFadeValue", (1 - 0.75f) * 0.999f);
            Shader.SetGlobalFloat("TVE_RenderNearFadeValue", (1 - elementRenderer.baseToNearBlend) * 0.999f);

            if (playerObject != null)
            {
                var pos = playerObject.transform.position;

                Shader.SetGlobalVector("TVE_PlayerPositionRadius", new Vector4(pos.x, pos.y, pos.z, playerRadius));
            }
            else
            {
                Shader.SetGlobalVector("TVE_PlayerPositionRadius", Vector4.zero);
            }

            if (mainLight != null)
            {
                var mainLightColor = mainLight.color.linear;
                var mainLightIntensity = mainLight.intensity;
                var mainLightValue = new Color(mainLightIntensity, mainLightIntensity, mainLightIntensity).linear;
                var mainLightParams = new Color(mainLightColor.r, mainLightColor.g, mainLightColor.b, mainLightValue.r);

                Shader.SetGlobalVector("TVE_MainLightParams", mainLightParams);
                Shader.SetGlobalVector("TVE_MainLightDirection", Vector4.Normalize(-mainLight.transform.forward));
            }
            else
            {
                var mainLightParams = new Vector4(1, 1, 1, 1);

                Shader.SetGlobalVector("TVE_MainLightParams", mainLightParams);
                Shader.SetGlobalVector("TVE_MainLightDirection", new Vector4(0, 1, 0, 0));
            }

            float seasonLerp = 0;

            if (seasonControl >= 0 && seasonControl < 1)
            {
                seasonLerp = seasonControl;
                Shader.SetGlobalVector("TVE_SeasonOption", new Vector4(1, 0, 0, 0));
                Shader.SetGlobalVector("TVE_SeasonParams", new Vector4(1 - seasonLerp, seasonLerp, 0, 0));
                //Shader.SetGlobalVector("TVE_SeasonColor", Color.Lerp(seasonSettings.seasonWinter, seasonSettings.seasonSpring, seasonLerp));

            }
            else if (seasonControl >= 1 && seasonControl < 2)
            {
                seasonLerp = seasonControl - 1.0f;
                Shader.SetGlobalVector("TVE_SeasonOption", new Vector4(0, 1, 0, 0));
                Shader.SetGlobalVector("TVE_SeasonParams", new Vector4(0, 1 - seasonLerp, seasonLerp, 0));
                //Shader.SetGlobalVector("TVE_SeasonColor", Color.Lerp(seasonSettings.seasonSpring, seasonSettings.seasonSummer, seasonLerp));

            }
            else if (seasonControl >= 2 && seasonControl < 3)
            {
                seasonLerp = seasonControl - 2.0f;
                Shader.SetGlobalVector("TVE_SeasonOption", new Vector4(0, 0, 1, 0));
                Shader.SetGlobalVector("TVE_SeasonParams", new Vector4(0, 0, 1 - seasonLerp, seasonLerp));
                //Shader.SetGlobalVector("TVE_SeasonColor", Color.Lerp(seasonSettings.seasonSummer, seasonSettings.seasonAutumn, seasonLerp));
            }
            else if (seasonControl >= 3 && seasonControl <= 4)
            {
                seasonLerp = seasonControl - 3.0f;
                Shader.SetGlobalVector("TVE_SeasonOption", new Vector4(0, 0, 0, 1));
                Shader.SetGlobalVector("TVE_SeasonParams", new Vector4(seasonLerp, 0, 0, 1 - seasonLerp));
                //Shader.SetGlobalVector("TVE_SeasonColor", Color.Lerp(seasonSettings.seasonAutumn, seasonSettings.seasonWinter, seasonLerp));
            }

            //var smoothLerp = Mathf.SmoothStep(0, 1, seasonLerp);
            Shader.SetGlobalFloat("TVE_SeasonLerp", seasonLerp);

            if (QualitySettings.activeColorSpace == ColorSpace.Linear)
            {
                var color = globalPaintData.tintingColor.linear;
                var alpha = globalPaintData.tintingIntensity;
                Shader.SetGlobalVector("TVE_PaintParams", new Vector4(color.r, color.g, color.b, alpha));
            }
            else
            {
                var color = globalPaintData.tintingColor;
                var alpha = globalPaintData.tintingIntensity;
                Shader.SetGlobalVector("TVE_PaintParams", new Vector4(color.r, color.g, color.b, alpha));
            }

            if (QualitySettings.activeColorSpace == ColorSpace.Linear)
            {
                var color = globalGlowData.emissiveColor.linear;
                var alpha = globalGlowData.emissiveIntensity;
                Shader.SetGlobalVector("TVE_GlowParams", new Vector4(color.r, color.g, color.b, alpha));
            }
            else
            {
                var color = globalGlowData.emissiveColor;
                var alpha = globalGlowData.emissiveIntensity;
                Shader.SetGlobalVector("TVE_GlowParams", new Vector4(color.r, color.g, color.b, alpha));
            }

            var coatParams = new Vector4(globalCoatData.layerIntensity, globalCoatData.detailIntensity, globalCoatData.stackIntensity, 0);
            Shader.SetGlobalVector("TVE_CoatParams", coatParams);

            var atmoParams = new Vector4(globalAtmoData.drynessIntensity, globalAtmoData.overlayIntensity, globalAtmoData.wetnessIntensity, globalAtmoData.rainfallIntensity);
            Shader.SetGlobalVector("TVE_AtmoParams", atmoParams);

            var fadeParams = new Color(globalEffexData.cutoutIntensity, 0, 0, 0);
            Shader.SetGlobalVector("TVE_FadeParams", fadeParams);

            var formParams = new Vector4(0.5f, 0.5f, 0.0f, 0.0f);
            Shader.SetGlobalVector("TVE_FormParams", formParams);

            var landParams = new Vector4(0.5f, 0.5f, 0.0f, 0.0f);
            Shader.SetGlobalVector("TVE_LandParams", formParams);

            var vertxParams = new Vector4(globalVertxData.sizeFadeValue, 0.0f, 0.0f, 0.0f);
            Shader.SetGlobalVector("TVE_VertxParams", vertxParams);

            var windDirection = gameObject.transform.forward;
            var windIntensity = Mathf.Clamp01(motionControl);

            Shader.SetGlobalVector("TVE_WindParams", new Vector4(windDirection.x * 0.5f + 0.5f, windDirection.z * 0.5f + 0.5f, windIntensity, 0));

            Shader.SetGlobalVector("TVE_FlowParams", new Vector4(0.5f, 0.5f, windIntensity, 0));

            // Shader custom settings
            //if (motionSettings.motionSpeed == TVEMotionSpeedMode.Dynamic)
            //{
            //    float motion = Mathf.Pow(motionControl, 1f);

            //    float time = Application.isPlaying ? Time.time : Time.unscaledTime;

            //    float wave1 = Mathf.Sin(time * 0.114f);
            //    float wave2 = Mathf.Sin(time * 0.271f);
            //    float wave3 = Mathf.Sin(time * 1.398f);

            //    float wave = (wave1 + wave2 + wave3) / 3f;
            //    wave = wave * 0.5f + 0.5f;
            //    float waveSlow = Mathf.Pow(wave, 3f);
            //    float waveFast = Mathf.Pow(wave, 1f);

            //    float motionSlow = Mathf.Lerp(0.5f, 2.0f, waveSlow);
            //    float motionFast = Mathf.Lerp(1.5f, 2.0f, waveFast);
            //    float speedLerp = Mathf.Lerp(motionSlow, motionFast, motion);

            //    //float motionLerp = Mathf.Lerp(wave, 0.5f, motion);
            //    //float speedLerp = Mathf.Lerp(1.0f, 2.5f, motionLerp);

            //    float delta = Application.isPlaying ? Time.deltaTime : Time.unscaledDeltaTime;
            //    customTime += delta * speedLerp * 0.02f;

            //    Shader.SetGlobalVector("TVE_MotionTimeParams", new Vector4(0f, customTime, 0, 1));
            //}

            if (metaGISettings.metaGIMode == TVEMetaGIMode.EnableHTraceSupport)
            {
                Shader.SetGlobalFloat("TVE_MetaIsEnabled", 1);
            }
        }

        void DisableGlobalShaderProperties()
        {
            //Shader.SetGlobalVector("TVE_MotionTimeParams", Vector4.zero);
            Shader.SetGlobalFloat("TVE_MetaIsEnabled", 0);
        }

        public void InitElementsRendering()
        {
            renderDataSet = new List<TVEElementBufferData>();
            renderElements = new List<TVEElement>();
            renderInstances = new List<TVEInstanced>();
        }

        public void DisableElementsRendering()
        {
            for (int e = 0; e < renderElements.Count; e++)
            {
                var element = renderElements[e];

                if (element != null)
                {
                    element.isActive = false;
                }
            }

            for (int e = 0; e < renderInstances.Count; e++)
            {
                var instances = renderInstances[e];

                for (int p = 0; p < instances.elements.Count; p++)
                {
                    if (instances.elements[p] != null)
                    {
                        instances.elements[p].isActive = false;
                    }
                }
            }

            renderDataSet = new List<TVEElementBufferData>();
            renderElements = new List<TVEElement>();
            renderInstances = new List<TVEInstanced>();
        }

        public void CreateRenderData(string renderName)
        {
            var renderData = new TVEElementBufferData();

            if (!renderData.isInitialized)
            {
                renderData.renderMode = TVEBool.On;
                renderData.renderName = "None";
                renderData.isRendering = true;
                renderData.isInitialized = true;
            }

            var globalName = "TVE_" + renderName;

            renderData.renderName = renderName;
            renderData.baseTexName = globalName + "BaseTex";
            renderData.baseTexCoord = globalName + "BaseCoord";
            renderData.nearTexName = globalName + "NearTex";
            renderData.nearTexCoord = globalName + "NearCoord";
            renderData.texParams = globalName + "Params";
            renderData.texLayers = globalName + "Layers";

            renderData.renderDataID = renderName.GetHashCode();
            renderData.bufferSize = -1;

            renderDataSet.Add(renderData);

            Shader.SetGlobalFloat(globalName + "Active", 1);
        }

        public void CreateRenderBuffer(TVEElementBufferData renderData)
        {
            if (renderData.baseObjectRT != null)
            {
                renderData.baseObjectRT.Release();
            }

            if (renderData.nearObjectRT != null)
            {
                renderData.nearObjectRT.Release();
            }

            if (renderData.commandBuffers != null)
            {
                for (int b = 0; b < renderData.commandBuffers.Length; b++)
                {
                    renderData.commandBuffers[b].Clear();
                }
            }

            renderData.bufferUsage = new float[9];

            // Might need initialization to avoid issues in the shaders
            for (int i = 0; i < renderData.bufferUsage.Length; i++)
            {
                renderData.bufferUsage[i] = 0f;
            }

            Shader.SetGlobalFloatArray(renderData.texLayers, renderData.bufferUsage);

            if (renderData.renderMode != TVEBool.Off && renderData.bufferSize > -1)
            {
                renderData.baseTexture = elementRenderer.baseTexture;
                renderData.baseFormat = TVETextureFormat.HDR16;
                renderData.baseMipmap = 0;

                renderData.nearTexture = elementRenderer.nearTexture;
                renderData.nearFormat = TVETextureFormat.HDR16;
                renderData.nearMipmap = 0;

                for (int i = 0; i < elementRenderer.rendererOverrides.Count; i++)
                {
                    if (!elementRenderer.rendererOverrides[i].isInitialized)
                    {
                        elementRenderer.rendererOverrides[i] = new TVEElementRendererSettings();
                        elementRenderer.rendererOverrides[i].isInitialized = true;
                    }

                    var rendererOverride = elementRenderer.rendererOverrides[i];

                    if (renderData.renderName.Contains(rendererOverride.rendererData.ToString()))
                    {
                        renderData.baseTexture = rendererOverride.baseTexture;
                        renderData.baseFormat = rendererOverride.baseFormat;
                        //renderData.baseMipmap = rendererOverride.baseMipmap;

                        renderData.nearTexture = rendererOverride.nearTexture;
                        renderData.nearFormat = rendererOverride.nearFormat;
                        //renderData.nearMipmap = rendererOverride.nearMipmap;
                    }
                }

                RenderTextureFormat baseFormat = RenderTextureFormat.Default;

                if (renderData.baseFormat == TVETextureFormat.HDR16)
                {
                    baseFormat = RenderTextureFormat.ARGBHalf;
                }
                else if (renderData.baseFormat == TVETextureFormat.HDR32)
                {
                    baseFormat = RenderTextureFormat.ARGBFloat;
                }

                RenderTextureFormat nearFormat = RenderTextureFormat.Default;

                if (renderData.nearFormat == TVETextureFormat.HDR16)
                {
                    nearFormat = RenderTextureFormat.ARGBHalf;
                }
                else if (renderData.nearFormat == TVETextureFormat.HDR32)
                {
                    nearFormat = RenderTextureFormat.ARGBFloat;
                }

                //#if THE_VISUAL_ENGINE_BLANKET_HQ
                //                if (renderData.renderName.Contains("Form"))
                //                {
                //                    RTFormat = RenderTextureFormat.ARGBFloat;
                //                }
                //#endif

                renderData.baseObjectRT = new RenderTexture((int)renderData.baseTexture, (int)renderData.baseTexture, 0, baseFormat, renderData.baseMipmap);
                renderData.nearObjectRT = new RenderTexture((int)renderData.nearTexture, (int)renderData.nearTexture, 0, nearFormat, renderData.nearMipmap);

                renderData.baseObjectRT.dimension = TextureDimension.Tex2DArray;
                renderData.baseObjectRT.volumeDepth = renderData.bufferSize + 1;
                renderData.baseObjectRT.name = renderData.baseTexName;
                renderData.baseObjectRT.wrapMode = TextureWrapMode.Clamp;
                renderData.baseObjectRT.useMipMap = false;

                if (renderData.baseMipmap > 0)
                {
                    renderData.baseObjectRT.useMipMap = true;
                }

                renderData.nearObjectRT.dimension = TextureDimension.Tex2DArray;
                renderData.nearObjectRT.volumeDepth = renderData.bufferSize + 1;
                renderData.nearObjectRT.name = renderData.nearTexName;
                renderData.nearObjectRT.wrapMode = TextureWrapMode.Clamp;
                renderData.nearObjectRT.useMipMap = false;

                if (renderData.nearMipmap > 0)
                {
                    renderData.nearObjectRT.useMipMap = true;
                }

                renderData.commandBuffers = new CommandBuffer[renderData.bufferSize + 1];

                for (int b = 0; b < renderData.commandBuffers.Length; b++)
                {
                    renderData.commandBuffers[b] = new CommandBuffer();
                    renderData.commandBuffers[b].name = "The Visual Engine/" + renderData.renderName;
                }

                Shader.SetGlobalTexture(renderData.baseTexName, renderData.baseObjectRT);
                Shader.SetGlobalTexture(renderData.nearTexName, renderData.nearObjectRT);
            }
            else
            {
                Shader.SetGlobalTexture(renderData.baseTexName, Resources.Load<Texture2DArray>("Internal ArrayTex"));
                Shader.SetGlobalTexture(renderData.nearTexName, Resources.Load<Texture2DArray>("Internal ArrayTex"));
            }
        }

        void SubmitRenderBuffers()
        {
            for (int d = 0; d < renderDataSet.Count; d++)
            {
                var renderData = renderDataSet[d];

                if (renderData == null || renderData.commandBuffers == null || renderData.renderMode == TVEBool.Off || !renderData.isRendering)
                {
                    continue;
                }

                var bufferParams = Shader.GetGlobalVector(renderData.texParams);

                for (int b = 0; b < renderData.commandBuffers.Length; b++)
                {
                    renderData.commandBuffers[b].Clear();
                    renderData.commandBuffers[b].ClearRenderTarget(true, true, bufferParams);
                    renderData.bufferUsage[b] = 0;

                    for (int e = 0; e < renderElements.Count; e++)
                    {
                        var element = renderElements[e];

                        if (element == null || element.isActive == false || element.elementRenderer == null)
                        {
                            renderElements.RemoveAt(e);

                            e--;

                            continue;
                        }

                        if (renderData.renderDataID == element.renderDataID)
                        {
                            if (element.renderLayers[b] == 1)
                            {
                                // Optimization when particle elements are not used
                                if (element.elementMesh == null)
                                {
                                    Camera.SetupCurrent(mainCamera);
                                }

                                propertyBlock.SetVector("_ElementParams", element.elementParams);
                                propertyBlock.SetVector("_ElementParams1", element.elementParams1);
                                propertyBlock.SetVector("_ElementParams2", element.elementParams2);
                                propertyBlock.SetVector("_ElementParams3", element.elementParams3);

                                element.elementRenderer.SetPropertyBlock(propertyBlock);

                                if (element.renderLayersAsPasses)
                                {
                                    renderData.commandBuffers[b].DrawRenderer(element.elementRenderer, element.elementMaterial, 0, b);
                                }
                                else
                                {
                                    renderData.commandBuffers[b].DrawRenderer(element.elementRenderer, element.elementMaterial, 0, 0);
                                }

                                renderData.bufferUsage[b] = 1;
                            }
                        }
                    }

                    for (int e = 0; e < renderInstances.Count; e++)
                    {
                        var instances = renderInstances[e];

                        if (instances.material == null)
                        {
                            continue;
                        }

                        if (!instances.material.enableInstancing)
                        {
                            continue;
                        }

                        if (instances.elements.Count == 0)
                        {
                            continue;
                        }

                        if (renderData.renderDataID == instances.renderDataID)
                        {
                            if (instances.renderLayers[b] == 1)
                            {
                                for (int p = 0; p < instances.elements.Count; p++)
                                {
                                    if (instances.elements[p] == null || instances.elements[p].isActive == false  || instances.renderers[p] == null)
                                    {
                                        instances.elements.RemoveAt(p);
                                        instances.renderers.RemoveAt(p);

                                        p--;

                                        continue;
                                    }
                                }

                                var elementsCount = instances.elements.Count;

                                if (elementsCount == 0)
                                {
                                    continue;
                                }

                                if (instances.matrices == null || instances.matrices.Length != elementsCount)
                                {
                                    instances.matrices = new Matrix4x4[elementsCount];
                                    instances.parameters = new Vector4[elementsCount];
                                    instances.parameters1 = new Vector4[elementsCount];
                                    instances.parameters2 = new Vector4[elementsCount];
                                    instances.parameters3 = new Vector4[elementsCount];
                                }

                                for (int p = 0; p < elementsCount; p++)
                                {
                                    // TODO: Check why this is needed, fix by Exhibyte
                                    if (instances.renderers[p] != null)
                                    {
                                        instances.matrices[p] = instances.renderers[p].localToWorldMatrix;
                                        instances.parameters[p] = instances.elements[p].elementParams;
                                        instances.parameters[p] = instances.elements[p].elementParams1;
                                        instances.parameters[p] = instances.elements[p].elementParams2;
                                        instances.parameters[p] = instances.elements[p].elementParams3;
                                    }
                                }

                                if (instances.propertyBlockCount != elementsCount)
                                {
                                    if (instances.propertyBlock == null)
                                    {
                                        instances.propertyBlock = new MaterialPropertyBlock();
                                    }
                                    else
                                    {
                                        instances.propertyBlock.Clear();
                                    }

                                    instances.propertyBlockCount = elementsCount;
                                }

                                instances.propertyBlock.SetVectorArray("_ElementParams", instances.parameters);
                                instances.propertyBlock.SetVectorArray("_ElementParams1", instances.parameters1);
                                instances.propertyBlock.SetVectorArray("_ElementParams2", instances.parameters2);
                                instances.propertyBlock.SetVectorArray("_ElementParams3", instances.parameters3);

                                if (instances.renderLayersAsPasses)
                                {
                                    renderData.commandBuffers[b].DrawMeshInstanced(instances.mesh, 0, instances.material, b, instances.matrices, elementsCount, instances.propertyBlock);
                                }
                                else
                                {
                                    renderData.commandBuffers[b].DrawMeshInstanced(instances.mesh, 0, instances.material, 0, instances.matrices, elementsCount, instances.propertyBlock);
                                }

                                renderData.bufferUsage[b] = 1;
                            }
                        }
                    }
                }

                Shader.SetGlobalFloatArray(renderData.texLayers, renderData.bufferUsage);

                //for (int u = 0; u < renderData.bufferUsage.Length; u++)
                //{
                //    Debug.Log(renderData.texLayers + " Index: " + u + " Usage: " + renderData.bufferUsage[u]);
                //}
            }
        }

        void ExecuteRenderBuffers(bool isBase)
        {
            Vector3 position = Vector3.zero;
            Vector3 scale = Vector3.one;

            if (isBase)
            {
                if (elementRenderer.baseCenter == null)
                {
                    if (focusTransform != null)
                    {
                        position = focusTransform.transform.position;
                    }
                }
                else
                {
                    position = elementRenderer.baseCenter.position;
                }

                scale = new Vector3(elementRenderer.baseRadius * 2f, 100000, elementRenderer.baseRadius * 2f);
            }
            else
            {
                if (elementRenderer.nearCenter == null)
                {
                    if (focusTransform != null)
                    {
                        position = focusTransform.transform.position;
                    }
                }
                else
                {
                    position = elementRenderer.nearCenter.position;
                }

                scale = new Vector3(elementRenderer.nearRadius * 2f, 100000, elementRenderer.nearRadius * 2f);
            }

            for (int d = 0; d < renderDataSet.Count; d++)
            {
                var renderData = renderDataSet[d];

                if (renderData == null || renderData.commandBuffers == null || renderData.renderMode == TVEBool.Off || !renderData.isRendering)
                {
                    continue;
                }

                position = GetVolumeCoords(renderData, position, scale, isBase);

                GL.modelview = modelViewMatrix;

                projectionMatrix = Matrix4x4.Ortho(-scale.x / 2 + position.x,
                                                    scale.x / 2 + position.x,
                                                    scale.z / 2 - position.z,
                                                   -scale.z / 2 - position.z,
                                                   -scale.y / 2 + position.y,
                                                    scale.y / 2 + position.y);


                GL.LoadProjectionMatrix(projectionMatrix);

                for (int b = 0; b < renderData.commandBuffers.Length; b++)
                {
                    if (isBase)
                    {
                        Graphics.SetRenderTarget(renderData.baseObjectRT, 0, CubemapFace.Unknown, b);
                    }
                    else
                    {
                        Graphics.SetRenderTarget(renderData.nearObjectRT, 0, CubemapFace.Unknown, b);
                    }

                    Graphics.ExecuteCommandBuffer(renderData.commandBuffers[b]);
                }
            }
        }

        void DestroyRenderBuffers()
        {
            for (int d = 0; d < renderDataSet.Count; d++)
            {
                var renderData = renderDataSet[d];

                if (renderData == null)
                {
                    continue;
                }

                if (renderData.baseObjectRT != null)
                {
                    renderData.baseObjectRT.Release();
                }

                if (renderData.nearObjectRT != null)
                {
                    renderData.nearObjectRT.Release();
                }

                if (renderData.commandBuffers != null)
                {
                    for (int b = 0; b < renderData.commandBuffers.Length; b++)
                    {
                        renderData.commandBuffers[b].Clear();
                        renderData.bufferUsage[b] = 0;
                    }
                }

                // Reset buffer usage because it is stored globally and is transfered to next scene
                Shader.SetGlobalFloatArray(renderData.texLayers, renderData.bufferUsage);
            }
        }

        Vector3 GetVolumeCoords(TVEElementBufferData renderData, Vector3 position, Vector3 scale, bool isBase)
        {
            int resolution = 32;

            if (isBase)
            {
                resolution = (int)renderData.baseTexture;
            }
            else
            {
                resolution = (int)renderData.nearTexture;
            }

            //float offsetX = 0;
            //float offsetZ = 0;

            //if (focusTransform != null)
            //{
            //    offsetX = scale.x / 2 * focusTransform.forward.x * elementRenderer.shiftFocusByView;
            //    offsetZ = scale.z / 2 * focusTransform.forward.z * elementRenderer.shiftFocusByView;
            //}

            //position = position + new Vector3(offsetX, 0, offsetZ);

            if (isBase)
            {
                Shader.SetGlobalVector("TVE_RenderBasePositionR", new Vector4(position.x, position.y, position.z, elementRenderer.baseRadius));
                Shader.SetGlobalVector("TVE_RenderBaseVolume", new Vector4(position.x, position.z, scale.x, scale.z));
            }
            else
            {
                Shader.SetGlobalVector("TVE_RenderNearPositionR", new Vector4(position.x, position.y, position.z, elementRenderer.nearRadius));
                Shader.SetGlobalVector("TVE_RenderNearVolume", new Vector4(position.x, position.z, scale.x, scale.z));
            }

            var gridX = scale.x / resolution;
            var gridZ = scale.z / resolution;
            var posX = Mathf.Round(position.x / gridX) * gridX;
            var posZ = Mathf.Round(position.z / gridZ) * gridZ;

            position = new Vector3(posX, position.y, posZ);

            var x = 1 / scale.x;
            var y = 1 / scale.z;
            var z = x * position.x - 0.5f;
            var w = y * position.z - 0.5f;
            var coords = new Vector4(x, y, -z, -w);

            if (isBase)
            {
                Shader.SetGlobalVector(renderData.baseTexCoord, coords);
            }
            else
            {
                Shader.SetGlobalVector(renderData.nearTexCoord, coords);
            }

            return position;
        }

        bool sortDirty = false;
        public void MarkSortDirty() => sortDirty = true;

        public void SortElementObjects()
        {
            renderElements.Sort((e1, e2) =>
            {
                if (e1 == null && e2 == null) return 0;
                if (e1 == null) return -1;
                if (e2 == null) return 1;
                return e1.transform.position.y.CompareTo(e2.transform.position.y);
            });
            sortDirty = false;
            //for (int i = 0; i < elementObjects.Count - 1; i++) { 
            //  for (int j = 0; j < elementObjects.Count - 1; j++) {
            //    var prevElement = elementObjects[j];
            //    var nextElement = elementObjects[j + 1];

            //    if (prevElement != null && nextElement != null) {
            //      if (prevElement.gameObject.transform.position.y > nextElement.gameObject.transform.position.y) {
            //        var next = elementObjects[j + 1];
            //        elementObjects[j + 1] = elementObjects[j];
            //        elementObjects[j] = next;
            //      }
            //    }
            //  }
            //}
        }

        public void SetElementsRendering(string renderName, bool isRendering)
        {
            for (int i = 0; i < renderDataSet.Count; i++)
            {
                if (renderDataSet[i].renderName == renderName)
                {
                    renderDataSet[i].isRendering = isRendering;
                }
            }
        }

        void SetElementsVisibility()
        {
            if (elementVisibility == TVEElementsVisibility.AlwaysHidden)
            {
                DisableElementsVisibility();
            }
            else if (elementVisibility == TVEElementsVisibility.AlwaysVisible)
            {
                EnableElementsVisibility();
            }
            else if (elementVisibility == TVEElementsVisibility.HiddenAtRuntime)
            {
                if (Application.isPlaying)
                {
                    DisableElementsVisibility();
                }
                else
                {
                    EnableElementsVisibility();
                }
            }
        }

        void EnableElementsVisibility()
        {
            for (int i = 0; i < renderElements.Count; i++)
            {
                var element = renderElements[i];

                if (element != null && element.customVisibility == TVEElementVisibility.UseGlobalSettings)
                {
                    element.elementRenderer.enabled = true;
                }
            }
        }

        void DisableElementsVisibility()
        {
            for (int i = 0; i < renderElements.Count; i++)
            {
                var element = renderElements[i];

                if (element != null && element.customVisibility == TVEElementVisibility.UseGlobalSettings)
                {
                    element.elementRenderer.enabled = false;
                }
            }
        }

        void SetGlobalLightingMainLight()
        {
#if UNITY_6000_4_OR_NEWER
            var allLights = FindObjectsByType<Light>();
#elif UNITY_2023_1_OR_NEWER
            var allLights = FindObjectsByType<Light>(FindObjectsSortMode.None);
#else
            var allLights = FindObjectsOfType<Light>();
#endif

            var intensity = 0.0f;

            for (int i = 0; i < allLights.Length; i++)
            {
                if (allLights[i].type == LightType.Directional)
                {
                    if (allLights[i].intensity > intensity)
                    {
                        mainLight = allLights[i];
                    }
                }
            }
        }

        // Control for UI
        public void SetMotionControl(float value)
        {
            motionControl = value;
        }

        public void SetSeasonControl(float value)
        {
            seasonControl = value;
        }

        public void SetAtmoDryness(float value)
        {
            globalAtmoData.drynessIntensity = value;
        }

        public void SetAtmoOverlay(float value)
        {
            globalAtmoData.overlayIntensity = value;
        }

        public void SetAtmoWetness(float value)
        {
            globalAtmoData.wetnessIntensity = value;
        }

        public void SetAtmoRainfall(float value)
        {
            globalAtmoData.rainfallIntensity = value;
        }

#if UNITY_EDITOR
        //void UpdateDebugData()
        //{
        //    for (int i = 0; i < renderDataSet.Count; i++)
        //    {
        //        var renderData = renderDataSet[i];

        //        float memory = 0;
        //        float pixels = 0;

        //        if (renderData.renderMode != OOBoolMode.Off && renderData.bufferSize > -1)
        //        {
        //            memory = renderData.textureBaseRT.height * renderData.textureBaseRT.width * (renderData.bufferSize + 1) * 0.00762939453125f / 1000f;
        //            pixels = (renderData.textureBaseRT.width / renderData.internalScale.x + renderData.textureBaseRT.height / renderData.internalScale.z) / 2;
        //        }

        //        string debug = "<size=10>Memory: " + memory.ToString("F2") + " mb | Resolution: " + pixels.ToString("F2") + " pix/unit </size>";

        //        if (renderData.renderName == "TVE_Colors")
        //        {
        //            renderColors.debugData = debug;
        //        }

        //        if (renderData.renderName == "TVE_Extras")
        //        {
        //            renderExtras.debugData = debug;
        //        }

        //        if (renderData.renderName == "TVE_Motion")
        //        {
        //            renderMotion.debugData = debug;
        //        }

        //        if (renderData.renderName == "TVE_Vertex")
        //        {
        //            renderVertex.debugData = debug;
        //        }
        //    }
        //}

        void OnDrawGizmosSelected()
        {
            Handles.color = new Color(0.0f, 0.0f, 0.0f, 0.5f);

            if (elementRenderer.baseCenter == null)
            {
                if (mainCamera != null)
                {
                    Handles.DrawWireDisc(mainCamera.transform.position, Vector3.up, elementRenderer.baseRadius);
                }
            }
            else
            {
                Handles.DrawWireDisc(elementRenderer.baseCenter.position, Vector3.up, elementRenderer.baseRadius);
            }

            if (elementRenderer.nearCenter == null)
            {
                if (mainCamera != null)
                {
                    Handles.DrawWireDisc(mainCamera.transform.position, Vector3.up, elementRenderer.nearRadius);
                }
            }
            else
            {
                Handles.DrawWireDisc(elementRenderer.nearCenter.position, Vector3.up, elementRenderer.nearRadius);
            }
        }

        void OnDrawGizmos()
        {
            Handles.color = new Color(0.0f, 0.0f, 0.0f, 0.1f);

            if (elementRenderer.baseCenter == null)
            {
                if (mainCamera != null)
                {
                    Handles.DrawWireDisc(mainCamera.transform.position, Vector3.up, elementRenderer.baseRadius);
                }
            }
            else
            {
                Handles.DrawWireDisc(elementRenderer.baseCenter.position, Vector3.up, elementRenderer.baseRadius);
            }

            if (elementRenderer.nearCenter == null)
            {
                if (mainCamera != null)
                {
                    Handles.DrawWireDisc(mainCamera.transform.position, Vector3.up, elementRenderer.nearRadius);
                }
            }
            else
            {
                Handles.DrawWireDisc(elementRenderer.nearCenter.position, Vector3.up, elementRenderer.nearRadius);
            }
        }

        void OnValidate()
        {
            for (int i = 0; i < renderDataSet.Count; i++)
            {
                var renderData = renderDataSet[i];

                if (renderData == null)
                {
                    continue;
                }

                CreateRenderBuffer(renderData);
            }

            for (int i = 0; i < elementRenderer.rendererOverrides.Count; i++)
            {
                var rendererOverride = elementRenderer.rendererOverrides[i];

                if (rendererOverride != null)
                {
                    rendererOverride.name = rendererOverride.rendererData.ToString();
                }
                else
                {
                    rendererOverride.name = "Missing";
                }
            }

            DisableGlobalShaderProperties();
        }
#endif
    }
}
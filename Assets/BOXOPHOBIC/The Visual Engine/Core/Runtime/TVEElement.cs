// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;
using Boxophobic.Utility;
using System.Collections.Generic;

#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TheVisualEngine
{
    [DefaultExecutionOrder(2)]
    [HelpURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.fd5y8rbb7aia")]
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Visual Engine/TVE Element")]
    public class TVEElement : StyledMonoBehaviour
    {
        [Tooltip("Sync the terrain data with the material in editor if the terrain is modified by external tools.")]
        public TVERefreshMode elementRefresh = TVERefreshMode.Realtime;
        [Tooltip("Sets the element visibility.")]
        [StyledDisplay("Element Visibility")]
        public TVEElementVisibility customVisibility = TVEElementVisibility.UseGlobalSettings;
        [Tooltip("Sets a custom material for element rendering.")]
        [StyledDisplay("Element Material")]
        public Material customMaterial;

        [Space(10)]
        [Tooltip("Sets the terrain height or splat map as element textures.")]
        public Terrain terrainData;
        public TVETerrainTexture terrainMask = TVETerrainTexture.Auto;

        [HideInInspector]
        public TVEElementMaterialData materialData;
        [System.NonSerialized]
        public Renderer elementRenderer;
        [System.NonSerialized]
        public Material elementMaterial;
        [System.NonSerialized]
        public Mesh elementMesh;
        [System.NonSerialized]
        public Vector4 elementParams = Vector4.one;
        [System.NonSerialized]
        public Vector4 elementParams1 = Vector4.one;
        [System.NonSerialized]
        public Vector4 elementParams2 = Vector4.one;
        [System.NonSerialized]
        public Vector4 elementParams3 = Vector4.one;
        [System.NonSerialized]
        public int elementID = 0;
        [System.NonSerialized]
        public int instancedID = 0;
        [System.NonSerialized]
        public string renderName = "";
        [System.NonSerialized]
        public int renderDataID = 0;
        [System.NonSerialized]
        public List<int> renderLayers;
        //[System.NonSerialized]
        //public int renderPass = 0;
        [System.NonSerialized]
        public bool renderLayersAsPasses = false;
        [System.NonSerialized]
        public bool isActive = false;

        new ParticleSystem particleSystem;

        int useVertexColorDirection = 0;
        int useRaycastFading = 0;
        Vector3 lastPosition;

        LayerMask raycastMask;
        float raycastStart = 0;
        float raycastLimit = 0;
        float raycastDistance = 0;

        float speedTreshold = 10;

        MaterialPropertyBlock terrainPropertyBlock;

        //Texture terrainHeightTex = null;

#if UNITY_EDITOR
        [System.NonSerialized]
        public bool isSelected = false;
#endif

        void OnEnable()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

#if UNITY_EDITOR
            TVEEvents.TVEOnAssetsSaved += OnAssetsSaved;
#endif            

            particleSystem = gameObject.GetComponent<ParticleSystem>();
            elementRenderer = gameObject.GetComponent<Renderer>();

            terrainPropertyBlock = new MaterialPropertyBlock();

            if (customMaterial != null)
            {
                elementMaterial = customMaterial;
            }
            else
            {
                elementMaterial = elementRenderer.sharedMaterial;
            }

            if (elementMaterial == null || elementMaterial.name == "Element")
            {
                if (materialData == null)
                {
                    materialData = new TVEElementMaterialData();
                }

                if (materialData.shader == null)
                {
#if UNITY_EDITOR
                    elementMaterial = new Material(Resources.Load<Material>("Internal Colors"));
                    SaveMaterialData(elementMaterial);
#endif
                }
                else
                {
                    elementMaterial = new Material(materialData.shader);
                    LoadMaterialData(elementMaterial);
                }

                elementMaterial.name = "Element";
                gameObject.GetComponent<Renderer>().sharedMaterial = elementMaterial;
            }
        }

        void OnDestroy()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

#if UNITY_EDITOR
            TVEEvents.TVEOnAssetsSaved -= OnAssetsSaved;
#endif

            isActive = false;
        }

        void OnDisable()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

#if UNITY_EDITOR
            TVEEvents.TVEOnAssetsSaved -= OnAssetsSaved;
#endif

            isActive = false;
        }

        void Update()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

            if (TVEManager.Instance == null)
            {
                isActive = false;

                return;
            }

            if (!isActive)
            {
                UpdateElement();

                isActive = true;
            }

#if UNITY_EDITOR
            if (isSelected)
            {
                UpdateElement();
            }
            else
            {
                if (elementRefresh == TVERefreshMode.Realtime)
                {
                    UpdateElementTerrainData();
                }
            }
            //else
            //{
            //    if (terrainData != null && elementMaterial != null)
            //    {
            //        if (terrainData.terrainData.heightmapTexture != terrainHeightTex)
            //        {
            //            TVEUtils.CopyTerrainDataToElement(terrainData, terrainMask, elementMaterial);

            //            terrainHeightTex = terrainData.terrainData.heightmapTexture;
            //        }
            //    }
            //}
#endif

            UpdateFading();
        }

        public void UpdateElement()
        {
            elementID = this.GetHashCode();

            if (customMaterial != null)
            {
                elementMaterial = customMaterial;
            }
            else
            {
                elementMaterial = elementRenderer.sharedMaterial;
            }

            if (elementMaterial != null)
            {
                TVEUtils.SetElementSettings(elementMaterial);
                TVEUtils.CopyTerrainDataToElement(terrainData, terrainMask, terrainPropertyBlock, elementMaterial);

                renderName = elementMaterial.GetTag("ElementType", false);
                renderDataID = renderName.GetHashCode();

                GetMaterialParameters();

#if UNITY_EDITOR
                if (!EditorUtility.IsPersistent(elementMaterial))
                {
                    SaveMaterialData(elementMaterial);
                }
#endif
            }

            var meshFilter = gameObject.GetComponent<MeshFilter>();

            if (meshFilter != null)
            {
                elementMesh = meshFilter.sharedMesh;
            }

            if (elementMesh != null && elementMaterial.enableInstancing == true)
            {
                instancedID = elementMesh.GetHashCode() + elementMaterial.GetHashCode();
            }

            AddElementToVolume();
            SetElementVisibility();

#if UNITY_EDITOR
            TVEManager.Instance.MarkSortDirty(); // SortElementObjects();
#endif
        }

        void UpdateElementTerrainData()
        {
            if (elementMaterial != null)
            {
                TVEUtils.CopyTerrainDataToElement(terrainData, terrainMask, terrainPropertyBlock, elementMaterial);
            }
        }

        void UpdateFading()
        {
            if (particleSystem != null)
            {
                var particleModule = particleSystem.main;
                var particleColor = particleModule.startColor.color;

                if (useVertexColorDirection > 0)
                {
                    var direction = transform.position - lastPosition;
                    var localDirection = transform.InverseTransformDirection(direction);
                    var worldDirection = transform.TransformVector(localDirection);
                    lastPosition = transform.position;

                    var worldDirectionX = Mathf.Clamp(worldDirection.x * speedTreshold, -1, 1) * 0.5f + 0.5f;
                    var worldDirectionZ = Mathf.Clamp(worldDirection.z * speedTreshold, -1, 1) * 0.5f + 0.5f;

                    //var directionLengh = Vector3.Magnitude(direction);

                    particleColor = new Color(worldDirectionX, worldDirectionZ, 0, 1);
                }

                if (useRaycastFading > 0)
                {
                    var fade = GetRacastFading();
                    particleColor = new Color(particleColor.r, particleColor.g, particleColor.b, fade);
                }
                //else
                //{
                //    particleColor = new Color(particleColor.r, particleColor.g, particleColor.b, particleColor.a);
                //}

                particleModule.startColor = particleColor;
            }
            else
            {
                if (useRaycastFading > 0)
                {
                    var fade = GetRacastFading();
                    elementParams.w = fade;
                }
                else
                {
                    elementParams.w = 1;
                }
            }
        }

        void AddElementToVolume()
        {
            var renderDataSet = TVEManager.Instance.renderDataSet;
            var elementObjects = TVEManager.Instance.renderElements;
            var elementInstances = TVEManager.Instance.renderInstances;

            var renderDataExists = false;

            for (int i = 0; i < renderDataSet.Count; i++)
            {
                var renderData = renderDataSet[i];

                if (renderData.renderDataID == renderDataID)
                {
                    renderDataExists = true;
                    break;
                }
            }

            if (!renderDataExists)
            {
                TVEManager.Instance.CreateRenderData(renderName);
            }

            for (int i = 0; i < renderDataSet.Count; i++)
            {
                var renderData = renderDataSet[i];

                if (renderData == null)
                {
                    continue;
                }

                if (renderData.renderDataID != renderDataID)
                {
                    continue;
                }

                var maxLayerCount = 0;
                var maxLayerValue = 9;

                if (elementMaterial.HasProperty("_ElementLayerMaxValue"))
                {
                    maxLayerValue = elementMaterial.GetInt("_ElementLayerMaxValue");

                    renderLayersAsPasses = true;
                }

                renderLayers = new List<int>(maxLayerValue);

                if (elementMaterial.HasProperty("_ElementLayerMask"))
                {
                    var bitmask = elementMaterial.GetInt("_ElementLayerMask");

                    for (int m = 0; m < maxLayerValue; m++)
                    {
                        if (((1 << m) & bitmask) != 0)
                        {
                            renderLayers.Add(1);
                            maxLayerCount = m;
                        }
                        else
                        {
                            renderLayers.Add(0);
                        }
                    }
                }
                else
                {
                    if (renderLayersAsPasses)
                    {
                        for (int m = 0; m < maxLayerValue; m++)
                        {
                            renderLayers.Add(1);
                        }
                    }
                    else
                    {
                        renderLayers.Add(1);

                        for (int m = 1; m < maxLayerValue; m++)
                        {
                            renderLayers.Add(0);
                        }
                    }
                }

                if (maxLayerCount > renderData.bufferSize)
                {
                    renderData.bufferSize = maxLayerCount;
                    TVEManager.Instance.CreateRenderBuffer(renderData);
                }

                if (Application.isPlaying && SystemInfo.supportsInstancing)
                {
                    if (instancedID == 0)
                    {
                        bool containsElement = false;

                        for (int e = 0; e < elementObjects.Count; e++)
                        {
                            if (elementObjects[e].elementID == elementID)
                            {
                                containsElement = true;
                                break;
                            }
                        }

                        if (!containsElement)
                        {
                            elementObjects.Add(this);
                        }
                    }
                    else
                    {
                        bool containsElement = false;
                        int index = 0;

                        for (int e = 0; e < elementInstances.Count; e++)
                        {
                            if (elementInstances[e].renderers.Count > 1022)
                            {
                                continue;
                            }

                            if (elementInstances[e].instancedDataID == instancedID)
                            {
                                containsElement = true;
                                index = e;
                                break;

                            }
                        }

                        if (!containsElement)
                        {
                            var elementInstanced = new TVEInstanced();
                            elementInstanced.instancedDataID = instancedID;
                            elementInstanced.renderDataID = renderDataID;
                            elementInstanced.renderLayers = renderLayers;
                            elementInstanced.renderLayersAsPasses = renderLayersAsPasses;
                            //elementInstanced.renderPass = renderPass;
                            elementInstanced.material = elementMaterial;
                            elementInstanced.mesh = elementMesh;
                            elementInstanced.elements.Add(this);
                            elementInstanced.renderers.Add(elementRenderer);

                            elementInstances.Add(elementInstanced);
                        }
                        else
                        {
                            bool containsRenderer = false;

                            for (int r = 0; r < elementInstances[index].renderers.Count; r++)
                            {
                                if (elementInstances[index].renderers[r] == elementRenderer)
                                {
                                    containsRenderer = true;
                                    break;
                                }
                            }

                            if (!containsRenderer)
                            {
                                elementInstances[index].elements.Add(this);
                                elementInstances[index].renderers.Add(elementRenderer);
                            }
                        }
                    }
                }
                else
                {
                    bool containsElement = false;

                    for (int e = 0; e < elementObjects.Count; e++)
                    {
                        if (elementObjects[e].elementID == elementID)
                        {
                            containsElement = true;
                            break;
                        }
                    }

                    if (!containsElement)
                    {
                        elementObjects.Add(this);
                    }
                }
            }
        }

        void SetElementVisibility()
        {
            if (customVisibility == TVEElementVisibility.UseGlobalSettings)
            {
                var visibility = TVEManager.Instance.elementVisibility;

                if (visibility == TVEElementsVisibility.AlwaysHidden)
                {
                    elementRenderer.enabled = false;
                }

                if (visibility == TVEElementsVisibility.AlwaysVisible)
                {
                    elementRenderer.enabled = true;
                }

                if (visibility == TVEElementsVisibility.HiddenAtRuntime)
                {
                    if (Application.isPlaying)
                    {
                        elementRenderer.enabled = false;
                    }
                    else
                    {
                        elementRenderer.enabled = true;
                    }
                }
            }
            else
            {
                if (customVisibility == TVEElementVisibility.AlwaysHidden)
                {
                    elementRenderer.enabled = false;
                }

                if (customVisibility == TVEElementVisibility.AlwaysVisible)
                {
                    elementRenderer.enabled = true;
                }

                if (customVisibility == TVEElementVisibility.HiddenAtRuntime)
                {
                    if (Application.isPlaying)
                    {
                        elementRenderer.enabled = false;
                    }
                    else
                    {
                        elementRenderer.enabled = true;
                    }
                }
            }
        }

#if UNITY_EDITOR
        void SaveMaterialData(Material material)
        {
            materialData = new TVEElementMaterialData();
            materialData.props = new List<TVEElementPropertyData>();

            var shader = material.shader;

            materialData.shader = shader;
            materialData.shaderName = shader.name;

            for (int i = 0; i < BoxoUtils.GetShaderPropertyCount(shader); i++)
            {
                var type = BoxoUtils.GetShaderPropertyType(shader, i);
                var prop = BoxoUtils.GetShaderPropertyName(shader, i);

                if (type == UnityEngine.Rendering.ShaderPropertyType.Texture)
                {
                    var propData = new TVEElementPropertyData();
                    propData.type = TVEPropertyType.Texture;
                    propData.prop = prop;
                    propData.texture = material.GetTexture(prop);

                    materialData.props.Add(propData);
                }

                if (type == UnityEngine.Rendering.ShaderPropertyType.Vector || type == UnityEngine.Rendering.ShaderPropertyType.Color)
                {
                    var propData = new TVEElementPropertyData();
                    propData.type = TVEPropertyType.Vector;
                    propData.prop = prop;
                    propData.vector = material.GetVector(prop);

                    materialData.props.Add(propData);
                }

                if (type == UnityEngine.Rendering.ShaderPropertyType.Float || type == UnityEngine.Rendering.ShaderPropertyType.Range)
                {
                    var propData = new TVEElementPropertyData();
                    propData.type = TVEPropertyType.Value;
                    propData.prop = prop;
                    propData.value = material.GetFloat(prop);

                    materialData.props.Add(propData);
                }
            }
        }
#endif

        void LoadMaterialData(Material material)
        {
            material.shader = materialData.shader;

            for (int i = 0; i < materialData.props.Count; i++)
            {
                if (materialData.props[i].type == TVEPropertyType.Texture)
                {
                    material.SetTexture(materialData.props[i].prop, materialData.props[i].texture);
                }

                if (materialData.props[i].type == TVEPropertyType.Vector)
                {
                    material.SetVector(materialData.props[i].prop, materialData.props[i].vector);
                }

                if (materialData.props[i].type == TVEPropertyType.Value)
                {
                    material.SetFloat(materialData.props[i].prop, materialData.props[i].value);
                }
            }
        }

        void GetMaterialParameters()
        {
            //if (elementMaterial.HasProperty("_ElementPassValue"))
            //{
            //    renderPass = elementMaterial.GetInt("_ElementPassValue");
            //}

            //if (elementMaterial.shader.name.Contains("VRT"))
            //if (elementMaterial.HasProperty("_ElementLayerMaxValue"))
            //{
            //    renderLayersAsPasses = true;
            //}

            if (elementMaterial.HasProperty("_MotionDirectionMode"))
            {
                if (elementMaterial.GetInt("_MotionDirectionMode") == 2)
                {
                    useVertexColorDirection = 1;
                }
                else
                {
                    useVertexColorDirection = 0;
                }
            }

            if (elementMaterial.HasProperty("_SpeedTresholdValue"))
            {
                speedTreshold = elementMaterial.GetFloat("_SpeedTresholdValue");
            }

            if (elementMaterial.HasProperty("_ElementRaycastMode"))
            {
                useRaycastFading = elementMaterial.GetInt("_ElementRaycastMode");
                raycastMask = elementMaterial.GetInt("_RaycastLayerMask");
                raycastStart = elementMaterial.GetFloat("_RaycastDistanceMinValue");
                raycastLimit = elementMaterial.GetFloat("_RaycastDistanceMaxValue");
                raycastDistance = elementMaterial.GetFloat("_RaycastDistanceCheckValue");
            }
        }

        float GetRacastFading()
        {
            float rayDistance = raycastLimit;

            if (raycastDistance > 0)
            {
                rayDistance = raycastDistance;
            }

            RaycastHit rayInfo;
            bool rayHit = Physics.Raycast(transform.position, -Vector3.up, out rayInfo, rayDistance, raycastMask);

            if (rayHit)
            {
                return 1 - Mathf.Clamp01(BoxoUtils.MathRemap(rayInfo.distance, raycastStart, raycastLimit));
            }
            else
            {
                return 1;
            }
        }

#if UNITY_EDITOR

        void OnAssetsSaved()
        {
            //UpdateElementTerrainData();
        }

        void OnDrawGizmosSelected()
        {
            DrawGizmos(true);
        }

        void OnDrawGizmos()
        {
            DrawGizmos(false);
        }

        void DrawGizmos(bool selected)
        {
            if (TVEManager.Instance == null || !isActive)
            {
                return;
            }

            var genericColor = new Color(0.0f, 0.0f, 0.0f, 0.1f);
            //var invalidColor = new Color(1.0f, 0.0f, 0.0f, 0.1f);

            if (selected)
            {
                genericColor = new Color(0.0f, 0.0f, 0.0f, 1.0f);
                //invalidColor = new Color(1.0f, 0.0f, 0.0f, 1.0f);
            }

            Gizmos.color = genericColor;

            if (selected)
            {
                if (useRaycastFading > 0)
                {
                    Gizmos.DrawLine(transform.position, new Vector3(transform.position.x, transform.position.y - raycastLimit, transform.position.z));
                }
            }

            Bounds gizmoBounds;

            if (elementMesh != null)
            {
                gizmoBounds = elementMesh.bounds;
                Gizmos.matrix = transform.localToWorldMatrix;
            }
            else
            {
                gizmoBounds = elementRenderer.bounds;
            }

            Gizmos.DrawWireCube(gizmoBounds.center, gizmoBounds.size);
        }
#endif
    }
}

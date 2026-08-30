// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;
using Boxophobic.Utility;

#if UNITY_EDITOR
using System.IO;
#endif

namespace TheVisualEngine
{
#if UNITY_EDITOR
    [HelpURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.q4fstlrr3cw4")]
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Visual Engine/TVE Terrain")]
#endif

    [DefaultExecutionOrder(1)]
    public class TVETerrain : StyledMonoBehaviour
    {
        [Tooltip("Sync the terrain data with the material in editor if the terrain is modified by external tools.")]
        public TVERefreshMode terrainRefresh = TVERefreshMode.Selection;
        [Tooltip("Sets the terrain bounds multiplier used to avoid patches culling when using vertex offset elements.")]
        public float terrainBounds = 1;
        public Material terrainMaterial;
        [Tooltip("Override the terrain layer maps and settings without modifying the actual terrain layer.")]
        public TVETerrainSettings terrainSettings = new TVETerrainSettings();
        [Tooltip("Override the terrain layer maps and settings without modifying the actual terrain layer.")]
        public TVETerrainRenderer terrainRenderer = new TVETerrainRenderer();

        [System.NonSerialized]
        public Terrain terrain;
        [System.NonSerialized]
        public Renderer meshRenderer;
        [System.NonSerialized]
        public MeshFilter meshFilter;
        [System.NonSerialized]
        public Vector3 terrainPosition;
        [System.NonSerialized]
        public Vector3 terrainSize;
        [System.NonSerialized]
        public int terrainLayers;
        [System.NonSerialized]
        public MaterialPropertyBlock terrainPropertyBlock;
        [System.NonSerialized]
        public bool isActive = false;

        [System.NonSerialized]
        public int terrainID = 0;

        bool isValidTerrain;
        bool isValidRenderer;

        Mesh terrainProxyMesh;

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

            InitializeTerrain();
            UpdateTerrainSettings();

            if (terrainRenderer.bakeMode == TVETerrainBaking.RuntimeRenderTexture)
            {
                DestroyProxyTextures();
                CreateProxyTextures(false);
            }

            UpdateProxySettings();
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

            if (terrainRenderer.bakeMode == TVETerrainBaking.RuntimeRenderTexture)
            {
                DestroyProxyTextures();
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

            if (terrainRenderer.bakeMode == TVETerrainBaking.RuntimeRenderTexture)
            {
                DestroyProxyTextures();
            }
        }

#if UNITY_EDITOR
        void Update()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

            if (terrainRefresh == TVERefreshMode.Realtime || isSelected)
            {
                UpdateTerrainSettings();
                UpdateOverrideNames();
            }
        }
#endif

        public void InitializeTerrain()
        {
            terrain = GetComponent<Terrain>();
            meshRenderer = GetComponent<Renderer>();
            meshFilter = GetComponent<MeshFilter>();

            isValidTerrain = terrain != null && terrain.terrainData != null && terrain.materialTemplate != null;
            isValidRenderer = meshRenderer != null && meshRenderer.sharedMaterial != null && meshFilter != null && meshFilter.sharedMesh != null;

            if (isValidTerrain && isValidRenderer)
            {
                isValidRenderer = false;
            }

            if (isValidTerrain)
            {
                if (terrainMaterial != null)
                {
                    terrain.materialTemplate = terrainMaterial;
                }

                terrainMaterial = terrain.materialTemplate;
                terrainPosition = terrain.transform.position;
                terrainSize = terrain.terrainData.size;
            }

            if (isValidRenderer)
            {
                if (terrainMaterial != null)
                {
                    meshRenderer.sharedMaterial = terrainMaterial;
                }

                terrainMaterial = meshRenderer.sharedMaterial;
                terrainPosition = meshRenderer.bounds.center - meshRenderer.bounds.extents;
                terrainSize = meshRenderer.bounds.size;
            }

            if (!terrainSettings.useCustomTransforms)
            {
                if (terrainSettings.terrainSize.x == -1)
                {
                    terrainSettings.terrainPosition = terrainPosition;
                    terrainSettings.terrainSize = terrainSize;
                }
            }

            if (terrainSettings.useCustomTransforms)
            {
                terrainPosition = terrainSettings.terrainPosition;
                terrainSize = terrainSettings.terrainSize;
            }

            //if (terrainProxyMesh != null)
            //{
            //    BoxoUtils.DestryObject(terrainProxyMesh);
            //}

            terrainProxyMesh = TVEUtils.CreateQuadFromTerrain(terrainPosition, terrainSize);

            terrainID = this.GetHashCode();
        }

        public void UpdateTerrainSettings()
        {
            if (terrainPropertyBlock == null)
            {
                terrainPropertyBlock = new MaterialPropertyBlock();
            }

            if (isValidTerrain)
            {
                if (terrain.normalmapTexture != null)
                {
                    terrainPropertyBlock.SetTexture("_TerrainNormalWSTex", terrain.normalmapTexture);
                }
                else if (terrainSettings.terrainNormal != null)
                {
                    terrainPropertyBlock.SetTexture("_TerrainNormalWSTex", terrainSettings.terrainNormal);
                }

                if (terrain.terrainData.holesTexture != null)
                {
                    terrainPropertyBlock.SetTexture("_TerrainHolesTex", terrain.terrainData.holesTexture);
                }
                //else
                //{
                //    terrainPropertyBlock.SetTexture("_TerrainHolesTex", Texture2D.whiteTexture);
                //}

                for (int i = 0; i < terrain.terrainData.alphamapTextures.Length; i++)
                {
                    var splat = terrain.terrainData.alphamapTextures[i];
                    var index = i + 1;

                    if (splat != null)
                    {
                        terrainPropertyBlock.SetTexture("_TerrainControlTex" + index, splat);
                    }
                    //else
                    //{
                    //    terrainPropertyBlock.SetTexture("_TerrainControlTex" + index, Texture2D.whiteTexture);
                    //}
                }

                terrainLayers = terrain.terrainData.terrainLayers.Length;

                var terrainMaxLayers = BoxoUtils.GetMaterialInt(terrain.materialTemplate, "_TerrainLayersMode", 1);                
               
                if (terrainMaxLayers > terrainLayers)
                {
                    terrainMaxLayers = terrainLayers;
                }

                //for (int i = 0; i < terrain.terrainData.terrainLayers.Length; i++)
                for (int i = 0; i < terrainMaxLayers; i++)
                {
                    var layer = terrain.terrainData.terrainLayers[i];
                    var index = i + 1;

                    if (layer == null)
                    {
                        continue;
                    }

                    CopyLayerSettings(terrainPropertyBlock, layer, index);
                }
            }

            if (isValidTerrain || isValidRenderer)
            {
                if (terrainSettings.useCustomTextures)
                {
                    if (terrainSettings.terrainHolesMask != null)
                    {
                        terrainPropertyBlock.SetTexture("_TerrainHolesTex", terrainSettings.terrainHolesMask);
                    }

                    if (terrainSettings.terrainControl01 != null)
                    {
                        terrainPropertyBlock.SetTexture("_TerrainControlTex1", terrainSettings.terrainControl01);
                    }

                    if (terrainSettings.terrainControl02 != null)
                    {
                        terrainPropertyBlock.SetTexture("_TerrainControlTex2", terrainSettings.terrainControl02);
                    }

                    if (terrainSettings.terrainControl03 != null)
                    {
                        terrainPropertyBlock.SetTexture("_TerrainControlTex3", terrainSettings.terrainControl03);
                    }

                    if (terrainSettings.terrainControl04 != null)
                    {
                        terrainPropertyBlock.SetTexture("_TerrainControlTex4", terrainSettings.terrainControl04);
                    }
                }

                // Terrain Layer Overrides
                for (int i = 0; i < terrainSettings.terrainLayers.Count; i++)
                {
                    if (!terrainSettings.terrainLayers[i].isInitialized)
                    {
                        terrainSettings.terrainLayers[i] = new TVETerrainLayerSettings();
                        terrainSettings.terrainLayers[i].isInitialized = true;
                    }

                    var overrideElement = terrainSettings.terrainLayers[i];

                    int index;

                    if (terrainSettings.useLayersOrderAsID)
                    {
                        index = i + 1;
                    }
                    else
                    {
                        index = overrideElement.layerID;
                    }

                    //if (index > terrainSettings.terrainLayers.Count)
                    //{
                    //    continue;
                    //}

                    if (/*terrainLayerSettings.overrideAllLayers && */ overrideElement.useCustomLayer)
                    {
                        if (overrideElement.terrainLayer != null)
                        {
                            CopyLayerSettings(terrainPropertyBlock, overrideElement.terrainLayer, index);
                        }
                    }

                    if (/*terrainLayerSettings.overrideAllTextures && */ overrideElement.useCustomTextures)
                    {
                        if (overrideElement.layerAlbedo != null)
                        {
                            terrainPropertyBlock.SetTexture("_TerrainAlbedoTex" + index, overrideElement.layerAlbedo);
                        }

                        if (overrideElement.layerNormal != null)
                        {
                            terrainPropertyBlock.SetTexture("_TerrainNormalTex" + index, overrideElement.layerNormal);
                        }

                        if (overrideElement.layerShader != null)
                        {
                            terrainPropertyBlock.SetTexture("_TerrainShaderTex" + index, overrideElement.layerShader);
                        }
                    }

                    if (/*terrainLayerSettings.overrideAllSettings &&*/ overrideElement.useCustomColor)
                    {
                        terrainPropertyBlock.SetVector("_TerrainColor" + index, overrideElement.layerColor);
                    }

                    if (/*terrainLayerSettings.overrideAllSettings &&*/ overrideElement.useCustomSettings)
                    {
                        var rcpX = 1 / (overrideElement.layerMetallicRemap.y - overrideElement.layerMetallicRemap.x);
                        var rcpY = 1 / (overrideElement.hayerOcclusionRemap.y - overrideElement.hayerOcclusionRemap.x);
                        var rcpZ = 1 / (overrideElement.hayerHeightRemap.y - overrideElement.hayerHeightRemap.x);
                        var rcpW = 1 / (overrideElement.layerSmoothnessRemap.y - overrideElement.layerSmoothnessRemap.x);

                        terrainPropertyBlock.SetVector("_TerrainSpecular" + index, new Vector4(overrideElement.layerEmissive, 0, 0, overrideElement.layerMultiMask));
                        terrainPropertyBlock.SetVector("_TerrainShaderMin" + index, new Vector4(overrideElement.layerMetallicRemap.x, overrideElement.hayerOcclusionRemap.x, overrideElement.hayerHeightRemap.x, overrideElement.layerSmoothnessRemap.x));
                        //terrainPropertyBlock.SetVector("_TerrainShaderMax" + index, overrideElement.layerRemapMax);
                        terrainPropertyBlock.SetVector("_TerrainShaderRcp" + index, new Vector4(rcpX, rcpY, rcpZ, rcpW));
                        terrainPropertyBlock.SetVector("_TerrainParams" + index, new Vector4(overrideElement.layerMetallic, 0, overrideElement.layerNormalScale, overrideElement.layerSmoothness));
                    }

                    if (/*terrainLayerSettings.overrideAllSettings &&*/ overrideElement.useCustomCoords)
                    {
                        if (overrideElement.layerUVMode == TVEUVMode.Tilling)
                        {
                            terrainPropertyBlock.SetVector("_TerrainCoord" + index, new Vector4(overrideElement.layerUVValue.x, overrideElement.layerUVValue.y, overrideElement.layerUVValue.z, overrideElement.layerUVValue.w));
                        }
                        else
                        {
                            terrainPropertyBlock.SetVector("_TerrainCoord" + index, new Vector4(1 / overrideElement.layerUVValue.x, 1 / overrideElement.layerUVValue.y, overrideElement.layerUVValue.z, overrideElement.layerUVValue.w));
                        }
                    }
                }
            }

            terrainPropertyBlock.SetVector("_TerrainPosition", terrainPosition);
            terrainPropertyBlock.SetVector("_TerrainSize", terrainSize);

            if (isValidTerrain)
            {
                terrainPropertyBlock.SetFloat("_TerrainModelMode", 0);

                terrain.SetSplatMaterialPropertyBlock(terrainPropertyBlock);

                terrainMaterial = terrain.materialTemplate;

                if (terrain.patchBoundsMultiplier.x != terrainBounds)
                {
                    terrain.patchBoundsMultiplier = new Vector3(terrainBounds, terrainBounds, terrainBounds);
                }
            }

            if (isValidRenderer)
            {
                terrainPropertyBlock.SetFloat("_TerrainModelMode", 1);

                meshRenderer.SetPropertyBlock(terrainPropertyBlock);

                terrainMaterial = meshRenderer.sharedMaterial;
            }
        }

        void CopyLayerSettings(MaterialPropertyBlock materialPropertyBlock, TerrainLayer layer, int index)
        {
            if (layer.diffuseTexture != null)
            {
                materialPropertyBlock.SetTexture("_TerrainAlbedoTex" + index, layer.diffuseTexture);
            }
            //else
            //{
            //    materialPropertyBlock.SetTexture("_TerrainAlbedoTex" + index, Texture2D.whiteTexture);
            //}

            if (layer.normalMapTexture != null)
            {
                materialPropertyBlock.SetTexture("_TerrainNormalTex" + index, layer.normalMapTexture);
            }
            //else
            //{
            //    materialPropertyBlock.SetTexture("_TerrainNormalTex" + index, Texture2D.linearGrayTexture);
            //}

            if (layer.maskMapTexture != null)
            {
                materialPropertyBlock.SetTexture("_TerrainShaderTex" + index, layer.maskMapTexture);
            }
            //else
            //{
            //    materialPropertyBlock.SetTexture("_TerrainShaderTex" + index, Texture2D.whiteTexture);
            //}

            materialPropertyBlock.SetVector("_TerrainColor" + index, layer.diffuseRemapMax);

            var rcpX = 1 / (layer.maskMapRemapMax.x - layer.maskMapRemapMin.x);
            var rcpY = 1 / (layer.maskMapRemapMax.y - layer.maskMapRemapMin.y);
            var rcpZ = 1 / (layer.maskMapRemapMax.z - layer.maskMapRemapMin.z);
            var rcpW = 1 / (layer.maskMapRemapMax.w - layer.maskMapRemapMin.w);

            materialPropertyBlock.SetVector("_TerrainShaderMin" + index, layer.maskMapRemapMin);
            //materialPropertyBlock.SetVector("_TerrainShaderMax" + index, layer.maskMapRemapMax);
            materialPropertyBlock.SetVector("_TerrainShaderRcp" + index, new Vector4(rcpX, rcpY, rcpZ, rcpW));
            materialPropertyBlock.SetVector("_TerrainParams" + index, new Vector4(layer.metallic, 0, layer.normalScale, layer.smoothness));
            materialPropertyBlock.SetVector("_TerrainSpecular" + index, layer.specular);

            if (layer.diffuseRemapMax.w == 0)
            {
                materialPropertyBlock.SetVector("_TerrainCoord" + index, new Vector4(layer.tileSize.x, layer.tileSize.y, layer.tileOffset.x, layer.tileOffset.y));
            }
            else
            {
                materialPropertyBlock.SetVector("_TerrainCoord" + index, new Vector4(1 / layer.tileSize.x, 1 / layer.tileSize.y, layer.tileOffset.x, layer.tileOffset.y));
            }
        }

        //void ClearLayerSettings(MaterialPropertyBlock materialPropertyBlock, TerrainLayer layer, int index)
        //{
        //    materialPropertyBlock.SetTexture("_TerrainAlbedoTex" + index, Texture2D.whiteTexture);
        //    materialPropertyBlock.SetTexture("_TerrainNormalTex" + index, Texture2D.linearGrayTexture);
        //    materialPropertyBlock.SetTexture("_TerrainShaderTex" + index, Texture2D.whiteTexture);
        //}

        public void DestroyProxyTextures()
        {
#if UNITY_EDITOR
            if (terrainSettings.terrainAlbedo != null && !EditorUtility.IsPersistent(terrainSettings.terrainAlbedo))
            {
                BoxoUtils.DestryObject(terrainSettings.terrainAlbedo);
            }

            if (terrainSettings.terrainNormal != null && !EditorUtility.IsPersistent(terrainSettings.terrainNormal))
            {
                BoxoUtils.DestryObject(terrainSettings.terrainNormal);
            }

            if (terrainSettings.terrainShader != null && !EditorUtility.IsPersistent(terrainSettings.terrainShader))
            {
                BoxoUtils.DestryObject(terrainSettings.terrainShader);
            }

            if (terrainSettings.terrainFeature != null && !EditorUtility.IsPersistent(terrainSettings.terrainFeature))
            {
                BoxoUtils.DestryObject(terrainSettings.terrainFeature);
            }
#endif
        }

        public void TryGetProxyTextures()
        {
#if UNITY_EDITOR
            var terrainName = GetProxyName();
            var savePath = GetProxyPath();

            terrainSettings.terrainAlbedo = AssetDatabase.LoadAssetAtPath<Texture>(savePath + "/" + terrainName + "_Albedo" + ".png");
            terrainSettings.terrainNormal = AssetDatabase.LoadAssetAtPath<Texture>(savePath + "/" + terrainName + "_Normal" + ".png");
            terrainSettings.terrainShader = AssetDatabase.LoadAssetAtPath<Texture>(savePath + "/" + terrainName + "_Shader" + ".png");
            terrainSettings.terrainFeature = AssetDatabase.LoadAssetAtPath<Texture>(savePath + "/" + terrainName + "_Feature" + ".png");
#endif
        }

        public void CreateProxyTextures(bool saveTextures)
        {
            var terrainName = GetProxyName();

#if UNITY_EDITOR
            var savePath = "";

            if (saveTextures)
            {
                savePath = GetProxyPath();
            }
#endif

            TVEProxyData proxyData = new TVEProxyData();

            proxyData.blitTVETerrain = this;
            proxyData.blitMesh = terrainProxyMesh;

            var blitMaterial = terrainMaterial;

            if (terrainRenderer.bakeMaterial != null)
            {
                blitMaterial = terrainRenderer.bakeMaterial;
            }

            proxyData.blitMaterial = new Material(blitMaterial);
            proxyData.blitMaterial.shader = terrainMaterial.shader.GetDependency("BakerShader");

            bool instancedTerrain = terrain.drawInstanced;

            if (!instancedTerrain)
            {
                terrain.drawInstanced = true;
            }

            if (terrain.normalmapTexture != null)
            {
                proxyData.blitMaterial.SetTexture("_TerrainNormalmapTexture", terrain.normalmapTexture);
            }

            // Bake Albedo
            proxyData.blitMaterial.SetInt("_BakeDataMode", 0);
            proxyData.saveSize = (int)terrainRenderer.bakeAlbedoSize;
            proxyData.saveAsSRGB = true;
            proxyData.saveAsDefault = true;

#if UNITY_EDITOR
            // Saved Albedo needs SRBG
            if (saveTextures)
            {
                proxyData.blitMaterial.SetInt("_BakeAlbedoSRGBMode", 1);
            }
            else
            {
                proxyData.blitMaterial.SetInt("_BakeAlbedoSRGBMode", 0);
            }
#endif

            terrainSettings.terrainAlbedo = TVEUtils.CreateProxyTextureFromTerrain(proxyData, terrainPropertyBlock, terrainPosition, terrainSize);
            terrainSettings.terrainAlbedo.name = terrainName + "_Albedo";
            terrainSettings.terrainAlbedo.hideFlags = HideFlags.DontSave;

#if UNITY_EDITOR
            if (saveTextures)
            {
                terrainSettings.terrainAlbedo = TVEUtils.SaveProxyTextureFromTerrain(savePath, terrainSettings.terrainAlbedo, proxyData);
            }
#endif

            // Bake Normal
            proxyData.blitMaterial.SetInt("_BakeDataMode", 1);
            proxyData.saveSize = (int)terrainRenderer.bakeNormalSize;
            proxyData.saveAsSRGB = false;
            proxyData.saveAsDefault = true;
            terrainSettings.terrainNormal = TVEUtils.CreateProxyTextureFromTerrain(proxyData, terrainPropertyBlock, terrainPosition, terrainSize);
            terrainSettings.terrainNormal.name = terrainName + "_Normal";
            terrainSettings.terrainNormal.hideFlags = HideFlags.DontSave;

#if UNITY_EDITOR
            if (saveTextures)
            {
                terrainSettings.terrainNormal = TVEUtils.SaveProxyTextureFromTerrain(savePath, terrainSettings.terrainNormal, proxyData);
            }
#endif

            // Bake Shader
            proxyData.blitMaterial.SetInt("_BakeDataMode", 2);
            proxyData.saveSize = (int)terrainRenderer.bakeShaderSize;
            proxyData.saveAsSRGB = false;
            proxyData.saveAsDefault = true;
            terrainSettings.terrainShader = TVEUtils.CreateProxyTextureFromTerrain(proxyData, terrainPropertyBlock, terrainPosition, terrainSize);
            terrainSettings.terrainShader.name = terrainName + "_Shader";
            terrainSettings.terrainShader.hideFlags = HideFlags.DontSave;

#if UNITY_EDITOR
            if (saveTextures)
            {
                terrainSettings.terrainShader = TVEUtils.SaveProxyTextureFromTerrain(savePath, terrainSettings.terrainShader, proxyData);
            }
#endif

            // Bake Feature
            proxyData.blitMaterial.SetInt("_BakeDataMode", 3);
            proxyData.saveSize = (int)terrainRenderer.bakeFeatureSize;
            proxyData.saveAsSRGB = false;
            proxyData.saveAsDefault = true;
            terrainSettings.terrainFeature = TVEUtils.CreateProxyTextureFromTerrain(proxyData, terrainPropertyBlock, terrainPosition, terrainSize);
            terrainSettings.terrainFeature.name = terrainName + "_Feature";
            terrainSettings.terrainFeature.hideFlags = HideFlags.DontSave;

#if UNITY_EDITOR
            if (saveTextures)
            {
                terrainSettings.terrainFeature = TVEUtils.SaveProxyTextureFromTerrain(savePath, terrainSettings.terrainFeature, proxyData);
            }
#endif

            terrain.drawInstanced = instancedTerrain;
        }

        public void UpdateProxySettings()
        {
            if (terrainSettings.terrainAlbedo != null)
            {
                terrainPropertyBlock.SetTexture("_TerrainAlbedoTex", terrainSettings.terrainAlbedo);
                //terrain.basemapDistance = terrainRenderer.baseRadius;
            }
            else
            {
                var firstAlbedo = terrainPropertyBlock.GetTexture("_terrainAlbedoTex1");

                if (firstAlbedo != null)
                {
                    terrainPropertyBlock.SetTexture("_TerrainAlbedoTex", firstAlbedo);
                }

                //terrain.basemapDistance = 20000;
            }

            if (terrainSettings.terrainNormal != null)
            {
                terrainPropertyBlock.SetTexture("_TerrainNormalTex", terrainSettings.terrainNormal);
            }

            if (terrainSettings.terrainShader != null)
            {
                terrainPropertyBlock.SetTexture("_TerrainShaderTex", terrainSettings.terrainShader);
            }

            if (terrainSettings.terrainFeature != null)
            {
                terrainPropertyBlock.SetTexture("_TerrainFeatureTex", terrainSettings.terrainFeature);
            }

            if (isValidTerrain)
            {
                terrain.SetSplatMaterialPropertyBlock(terrainPropertyBlock);
            }

            if (isValidRenderer)
            {
                meshRenderer.SetPropertyBlock(terrainPropertyBlock);
            }
        }

        string GetProxyName()
        {
            var terrainName = "Terrain";

            if (isValidTerrain)
            {
                terrainName = terrain.terrainData.name;
            }

            if (isValidRenderer)
            {
                terrainName = meshFilter.sharedMesh.name;// + "_" + terrainPosition.x.ToString("00") + "_" + terrainPosition.y.ToString("00") + "_" + terrainPosition.z.ToString("00");
            }

            return terrainName;
        }

#if UNITY_EDITOR
        string GetProxyPath()
        {
            var savePath = "Assets";

            if (isValidTerrain)
            {
                savePath = AssetDatabase.GetAssetPath(terrain.terrainData);
            }

            if (isValidRenderer)
            {
                savePath = AssetDatabase.GetAssetPath(meshFilter.sharedMesh);
            }

            if (savePath.Contains("unity default resources") || savePath.Contains("unity_builtin_extra") || savePath.Contains("Packages"))
            {
                savePath = "Assets/Terrain Data";
            }
            else
            {
                savePath = Path.GetDirectoryName(savePath);
                savePath = savePath + "/Terrain Data";
            }

            if (!Directory.Exists(savePath))
            {
                Directory.CreateDirectory(savePath);
                AssetDatabase.Refresh();
            }

            return savePath;
        }
#endif

#if UNITY_EDITOR
        void OnAssetsSaved()
        {
            InitializeTerrain();
            UpdateTerrainSettings();

            if (terrainRenderer.bakeMode == TVETerrainBaking.RuntimeRenderTexture)
            {
                DestroyProxyTextures();
                CreateProxyTextures(false);
            }

            UpdateProxySettings();
        }

        public void UpdateOverrideNames()
        {
            // Terrain Layer Overrides
            for (int i = 0; i < terrainSettings.terrainLayers.Count; i++)
            {
                var overrideElement = terrainSettings.terrainLayers[i];

                int index;

                if (terrainSettings.useLayersOrderAsID)
                {
                    index = i;
                }
                else
                {
                    index = overrideElement.layerID - 1;
                }

                bool validTerrain = terrain != null && terrain.terrainData != null;

                if (validTerrain && terrain.terrainData.terrainLayers != null && terrain.terrainData.terrainLayers.Length > index && terrain.terrainData.terrainLayers[index] != null)
                {
                    overrideElement.name = terrain.terrainData.terrainLayers[index].name;
                }
                else
                {
                    overrideElement.name = "Layer " + overrideElement.layerID + " (Missing)";
                }

                if (/*terrainLayerSettings.overrideAllLayers &&*/ overrideElement.useCustomLayer)
                {
                    if (overrideElement.terrainLayer != null)
                    {
                        overrideElement.name = overrideElement.terrainLayer.name;
                    }
                }
            }
        }

        //void UpdateOverrideDebugData()
        //{
        //    var perLayerMaps = 3;

        //    if (terrainShaderSettings.shaderMaps == TVETerrainMapsMode.Packed)
        //    {
        //        perLayerMaps = 2;
        //    }

        //    var sampleCountList = new List<int>();

        //    for (int i = 0; i < (int)terrainShaderSettings.shaderLayers; i++)
        //    {
        //        sampleCountList.Add(1);
        //    }

        //    // Terrain Shader Overrides
        //    for (int i = 0; i < terrainShaderSettings.shaderLayerOverrides.Count; i++)
        //    {
        //        var overrideElement = terrainShaderSettings.shaderLayerOverrides[i];
        //        var overrideID = overrideElement.layerID - 1;

        //        if (terrain.terrainData.terrainLayers != null && terrain.terrainData.terrainLayers.Length > overrideID && terrain.terrainData.terrainLayers[overrideID] != null)
        //        {
        //            if (terrainShaderSettings.useAllFeatureOverrides)
        //            {
        //                if (overrideElement.textureCoords == TVETextureCoordsMode.Planar)
        //                {
        //                    if (overrideElement.textureSample == TVETextureSampleMode.Stochastic)
        //                    {
        //                        sampleCountList[overrideID] = 3;
        //                    }
        //                    else
        //                    {
        //                        sampleCountList[overrideID] = 1;
        //                    }
        //                }

        //                if (overrideElement.textureCoords == TVETextureCoordsMode.Triplanar)
        //                {
        //                    if (overrideElement.textureSample == TVETextureSampleMode.Stochastic)
        //                    {
        //                        sampleCountList[overrideID] = 9;
        //                    }
        //                    else
        //                    {
        //                        sampleCountList[overrideID] = 3;
        //                    }
        //                }
        //            }
        //        }
        //    }

        //    var sampleCount = 0;

        //    for (int i = 0; i < sampleCountList.Count; i++)
        //    {
        //        sampleCount += sampleCountList[i];
        //    }

        //    terrainShaderSettings.debugData = "<size=10>Layers: " + (int)terrainShaderSettings.shaderLayers + " supported | Maps: " + (int)terrainShaderSettings.shaderLayers * perLayerMaps + " textures | Samples: " + sampleCount * perLayerMaps + " texture samples</size>";
        //}

        void OnValidate()
        {
            InitializeTerrain();
            UpdateTerrainSettings();

            if (terrainRenderer.bakeMode == TVETerrainBaking.Baked)
            {
                //DestroyProxyTextures();
                TryGetProxyTextures();
            }

            if (terrainRenderer.bakeMode == TVETerrainBaking.RuntimeRenderTexture)
            {
                DestroyProxyTextures();
                CreateProxyTextures(false);
            }

            UpdateProxySettings();
        }
#endif
    }
}




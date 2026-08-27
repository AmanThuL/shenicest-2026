// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;
using System.Collections.Generic;
using Boxophobic.Utility;

//#if UNITY_EDITOR
//using UnityEngine.SceneManagement;
//using UnityEditor.SceneManagement;
//#endif

namespace TheVisualEngine
{
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Visual Engine/TVE Blanket")]
    [DefaultExecutionOrder(3)]
    public class TVEBlanket : StyledMonoBehaviour
    {
        public TVEBlanketBlending blanketBlending = new TVEBlanketBlending();

        List<Renderer> prefabRenderers;
        Terrain[] activeTerrains;

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
            //EditorSceneManager.sceneSaved += OnSceneSaved;
            TVEEvents.TVEOnAssetsSaved += OnAssetsSaved;
#endif
            if (blanketBlending.blendMode == TVEBlendMode.AutoTerrainBlending)
            {
                GetPrefabRenderers();
                UpdatePrefabBlending();
            }
        }

#if UNITY_EDITOR
        void OnDisable()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

            TVEEvents.TVEOnAssetsSaved -= OnAssetsSaved;
        }

        void OnDestroy()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

            TVEEvents.TVEOnAssetsSaved -= OnAssetsSaved;
        }

        void Update()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

            if (isSelected)
            {
                if (blanketBlending.blendMode == TVEBlendMode.AutoTerrainBlending)
                {
                    UpdatePrefabBlending();
                }
            }
        }
#endif

        void GetPrefabRenderers()
        {
            prefabRenderers = new();

            List<GameObject> gameObjectsInPrefab = new();
            gameObjectsInPrefab.Add(gameObject);

            TVEUtils.GetChildRecursive(gameObject, gameObjectsInPrefab);

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                var gameObjectInPrefab = gameObjectsInPrefab[i];

                if (gameObjectInPrefab != null)
                {
                    var renderer = gameObjectInPrefab.GetComponent<Renderer>();

                    prefabRenderers.Add(renderer);
                }
            }
        }

        public void UpdatePrefabBlending()
        {
            activeTerrains = Terrain.activeTerrains;

            for (int i = 0; i < activeTerrains.Length; i++)
            {
                var terrain = activeTerrains[i];

                if (terrain == null || terrain.terrainData == null)
                {
                    continue;
                }

                var terrainPosition = terrain.transform.position;
                var terrainSize = terrain.terrainData.size;
                var terrainExtent = terrainPosition + terrainSize;

                if (transform.position.x > terrainPosition.x && transform.position.z > terrainPosition.z && transform.position.x < terrainExtent.x && transform.position.z < terrainExtent.z)
                {
                    for (int r = 0; r < prefabRenderers.Count; r++)
                    {
                        var renderer = prefabRenderers[r];

                        TVEUtils.CopyTerrainDataToRenderer(terrain, renderer);
                    }
                }
            }
        }

#if UNITY_EDITOR
        //void OnSceneSaved(Scene scene)
        //{
        //    if (blanketBlending.blendMode == 1)
        //    {
        //        UpdatePrefabBlending();
        //    }
        //}

        void OnAssetsSaved()
        {
            if (blanketBlending.blendMode == TVEBlendMode.AutoTerrainBlending)
            {
                UpdatePrefabBlending();
            }
        }

        void OnValidate()
        {
            if (blanketBlending.blendMode == TVEBlendMode.AutoTerrainBlending)
            {
                GetPrefabRenderers();
                UpdatePrefabBlending();
            }
        }
#endif
    }
}






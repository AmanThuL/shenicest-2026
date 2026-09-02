using System;
using RootsDance.App;
using RootsDance.Core;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Puts an invisible parapet along both long sides of the chapter house catwalk, so crossing
    /// the hall cannot end with the player stepping off the side.
    /// <para>
    /// The catwalk is 0.92 m wide and 6.9 m long, and the only thing under it is the cloth
    /// landscape three metres down — walking it is the level's one route, and its deck has no
    /// authored railing to lean on. The two walls here are collision only: no renderer, so the
    /// catwalk still reads as the bare metal plank it was modelled as.
    /// </para>
    /// <para>
    /// Both ends stay open, because the checkpoint at the near end and the doorways past the far
    /// end are how the player gets on and off the deck. Everything is derived from the catwalk's
    /// own bounds rather than typed in, for the same reason the checkpoints are: the blockout is a
    /// layout that still moves.
    /// </para>
    /// Menu: RootsDance &gt; Environment &gt; Apply Chapter House Bridge Railings.
    /// </summary>
    public static class ChapterHouseBridgeRailingBuilder
    {
        private const string k_GroupName = "BridgeRailings";

        /// <summary>Thin enough that the parapet does not eat into a deck less than a metre wide.</summary>
        private const float k_Thickness = 0.1f;

        /// <summary>
        /// Waist-high on a 1.8 m player, measured from the deck. High enough to stop a walk or a
        /// sprint sideways, low enough that the player still sees the undercroft over it.
        /// </summary>
        private const float k_HeightAboveDeck = 1.3f;

        /// <summary>
        /// How far the wall reaches below the deck, so a player who is mid-step — the controller
        /// rides a little above the surface — still meets it rather than clipping under its base.
        /// </summary>
        private const float k_DepthBelowDeck = 0.3f;

        [MenuItem("RootsDance/Environment/Apply Chapter House Bridge Railings")]
        public static void Apply()
        {
            if (EditorApplication.isPlaying)
            {
                throw new InvalidOperationException("Stop Play mode before placing the bridge railings.");
            }

            // Only this level's environment scene is opened, saved and closed again: whatever else
            // the Editor has open — and whatever unsaved work is in it — is left exactly as it was.
            Scene environment = SceneManager.GetSceneByPath(ScenePaths.k_ChapterHouseInteriorEnvironment);
            bool wasOpen = environment.isLoaded;

            if (wasOpen && environment.isDirty)
            {
                throw new InvalidOperationException(
                    "The chapter house environment scene has unsaved changes; save or revert it first.");
            }

            if (!wasOpen)
            {
                environment = EditorSceneManager.OpenScene(
                    ScenePaths.k_ChapterHouseInteriorEnvironment, OpenSceneMode.Additive);
            }

            try
            {
                Place(FindBuilding(environment));
                EditorSceneManager.MarkSceneDirty(environment);
                EditorSceneManager.SaveScene(environment);
            }
            finally
            {
                if (!wasOpen)
                {
                    EditorSceneManager.CloseScene(environment, true);
                }
            }
        }

        /// <summary>
        /// Also called by <see cref="ChapterHouseInteriorLevelBuilder"/>, so a geometry rebuild
        /// keeps the railings.
        /// </summary>
        public static void Place(GameObject building)
        {
            Bounds bridge = BridgeBounds(building);

            if (bridge.size.z <= bridge.size.x)
            {
                // The parapets run along Z and stand on the X faces. A catwalk that no longer
                // crosses the hall that way needs the placement rethought, not rotated blindly.
                throw new InvalidOperationException(
                    "The chapter house catwalk no longer runs along Z; the railing placement needs redoing.");
            }

            Transform parent = building.transform.parent;
            Transform existing = parent.Find(k_GroupName);

            if (existing != null)
            {
                UnityEngine.Object.DestroyImmediate(existing.gameObject);
            }

            GameObject group = new GameObject(k_GroupName);
            group.transform.SetParent(parent, false);

            float deck = bridge.max.y;
            float height = k_HeightAboveDeck + k_DepthBelowDeck;
            float centreY = deck + (k_HeightAboveDeck - k_DepthBelowDeck) * 0.5f;
            Vector3 size = new Vector3(k_Thickness, height, bridge.size.z);

            // Just outside each deck edge, so the walkable width stays what the model says it is.
            CreateWall(group.transform, "BridgeRailing_West", size,
                new Vector3(bridge.min.x - k_Thickness * 0.5f, centreY, bridge.center.z));
            CreateWall(group.transform, "BridgeRailing_East", size,
                new Vector3(bridge.max.x + k_Thickness * 0.5f, centreY, bridge.center.z));

            Log.Info($"Railed the chapter house catwalk: {bridge.size.z:F1} m of parapet a side, "
                + $"{k_HeightAboveDeck:F1} m over the deck.", group);
        }

        /// <summary>
        /// One parapet, sized in metres of the level rather than in the building's local units:
        /// the chapel hangs off a scaled root, so a <see cref="BoxCollider.size"/> written straight
        /// from the world-space measurements above would come out at whatever that scale is —
        /// twice as long and twice as thick, in the layout as it stands.
        /// </summary>
        private static void CreateWall(Transform parent, string name, Vector3 worldSize, Vector3 position)
        {
            GameObject wall = new GameObject(name);
            wall.transform.SetParent(parent, false);
            wall.transform.SetPositionAndRotation(position, Quaternion.identity);

            Vector3 scale = wall.transform.lossyScale;

            if (Mathf.Abs(scale.x) < 0.0001f || Mathf.Abs(scale.y) < 0.0001f || Mathf.Abs(scale.z) < 0.0001f)
            {
                throw new InvalidOperationException(
                    "The chapter house is on a degenerate scale; the railings cannot be sized against it.");
            }

            BoxCollider collider = wall.AddComponent<BoxCollider>();
            collider.size = new Vector3(
                worldSize.x / Mathf.Abs(scale.x),
                worldSize.y / Mathf.Abs(scale.y),
                worldSize.z / Mathf.Abs(scale.z));
            collider.isTrigger = false;
        }

        /// <summary>The catwalk's world bounds. Throws rather than railing the wrong piece.</summary>
        private static Bounds BridgeBounds(GameObject building)
        {
            Renderer[] renderers = building.GetComponentsInChildren<Renderer>(true);

            for (int i = 0; i < renderers.Length; i++)
            {
                if (renderers[i].gameObject.name == ChapterHouseInteriorLevelBuilder.k_BridgePart)
                {
                    return renderers[i].bounds;
                }
            }

            throw new InvalidOperationException(
                "The chapter house export has no piece named " + ChapterHouseInteriorLevelBuilder.k_BridgePart);
        }

        private static GameObject FindBuilding(Scene environment)
        {
            GameObject[] roots = environment.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                Transform[] transforms = roots[i].GetComponentsInChildren<Transform>(true);

                for (int j = 0; j < transforms.Length; j++)
                {
                    if (transforms[j].gameObject.name == "ChapterHouse")
                    {
                        return transforms[j].gameObject;
                    }
                }
            }

            throw new InvalidOperationException(
                "The chapter house environment scene has no ChapterHouse building to rail.");
        }
    }
}

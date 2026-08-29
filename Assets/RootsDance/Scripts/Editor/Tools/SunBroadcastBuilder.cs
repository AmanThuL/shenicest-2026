using RootsDance.Rendering;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Puts a <see cref="SunBroadcaster"/> on the level's Sun.
    /// <para>
    /// Hand-written unlit materials cannot read HDRP's lights — those live in
    /// <c>_DirectionalLightDatas</c>, which an unlit pass has no light loop to reach — so the Sun
    /// has to be published as shader globals for them. Without this the statue's growth falls back
    /// to a fixed key light baked into the shader and stops responding to the time of day.
    /// </para>
    /// <para>
    /// A builder rather than a note in a document because it is one component on one object in a
    /// scene nobody opens often, and because it has to be re-runnable: the lighting rig gets
    /// rebuilt, and the broadcaster has to come back with it.
    /// </para>
    /// Menu: RootsDance > Wire Sun Broadcast.
    /// </summary>
    public static class SunBroadcastBuilder
    {
        private const string k_LogPrefix = "SunBroadcastBuilder";

        private const string k_ScenePath = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment.unity";

        [MenuItem("RootsDance/Wire Sun Broadcast")]
        public static void Build()
        {
            // Use the scene if it is open. Opening it Single would close the rest of the Main
            // level out from under whoever is working in it.
            Scene scene = SceneManager.GetSceneByPath(k_ScenePath);

            if (!scene.IsValid() || !scene.isLoaded)
            {
                for (int i = 0; i < SceneManager.sceneCount; i++)
                {
                    if (SceneManager.GetSceneAt(i).isDirty)
                    {
                        Debug.LogError($"{k_LogPrefix}: unsaved changes are open. Save or discard "
                            + "them, then run this again.");
                        return;
                    }
                }

                scene = EditorSceneManager.OpenScene(k_ScenePath, OpenSceneMode.Single);
            }
            else if (scene.isDirty)
            {
                // This saves the scene, and a save writes everything in it -- including work
                // somebody else has open and has not committed to yet. Refusing is the only safe
                // answer. Leaving this check out once wrote another agent's half-finished
                // greenhouse edits to disk.
                Debug.LogError($"{k_LogPrefix}: '{scene.name}' has unsaved changes that are not "
                    + "this builder's. Save or discard them, then run this again.");
                return;
            }

            Light sun = FindSun(scene);

            if (sun == null)
            {
                Debug.LogError($"{k_LogPrefix}: no directional Light in {scene.name}.");
                return;
            }

            if (sun.GetComponent<SunBroadcaster>() != null)
            {
                Debug.Log($"{k_LogPrefix}: '{sun.name}' already broadcasts; left as it is.");
                return;
            }

            SunBroadcaster broadcaster = sun.gameObject.AddComponent<SunBroadcaster>();
            SerializedObject so = new SerializedObject(broadcaster);
            so.FindProperty("m_sun").objectReferenceValue = sun;
            so.ApplyModifiedPropertiesWithoutUndo();

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            Debug.Log($"{k_LogPrefix}: '{sun.name}' now broadcasts at {sun.intensity:F0} lux.");
        }

        /// <summary>
        /// The brightest directional light in the scene. Brightest rather than first, because a
        /// rig can carry a dim fill directional alongside the Sun and picking that one publishes
        /// a light nothing is actually lit by.
        /// </summary>
        private static Light FindSun(Scene scene)
        {
            Light best = null;

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                foreach (Light light in root.GetComponentsInChildren<Light>(true))
                {
                    if (light.type != LightType.Directional)
                    {
                        continue;
                    }

                    if (best == null || light.intensity > best.intensity)
                    {
                        best = light;
                    }
                }
            }

            return best;
        }
    }
}

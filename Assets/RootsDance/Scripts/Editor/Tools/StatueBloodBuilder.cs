using System;
using System.Collections.Generic;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Sequencing;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// The doomed endings' answer to the statue's water: the same fall, the same palms and finger
    /// gaps and stone, running red.
    /// <para>
    /// A wrong circulation choice does not leave the statue dry. The ecology answers the way it
    /// was told to — the water comes back — but what comes down the arm is blood. It is one
    /// image, so it is built as one clone: <c>StatueWater</c> duplicated in place as
    /// <c>StatueBlood</c> with every renderer's material swapped for the blood twin of the water
    /// material it had. Streams, splashes, mist and the stone pool all come along, because they
    /// are all under the one root — the reason <c>StonePoolOverflowBuilder</c> put them there.
    /// </para>
    /// <para>
    /// The good ending's rig is not touched: <c>StatueWater</c> and its <c>EndingCue</c> keep
    /// their flag, their materials and their place in the hierarchy. The blood has its own cues,
    /// one per doomed flag, because a <see cref="CueSequence"/> listens for exactly one flag and
    /// the two wrong answers are two flags. They copy the channels and the trickle from the good
    /// ending's cue so the two beats can never drift apart on plumbing.
    /// </para>
    /// <para>
    /// The blood materials are copies of the water materials with the colour changed and nothing
    /// else, so any later tuning of the water's maps or refraction is picked up by rebuilding.
    /// </para>
    /// Menu: RootsDance > Build Statue Blood (Doomed Endings). Idempotent: rebuilds the clone and
    /// its cues in place in both scenes that carry the statue.
    /// </summary>
    public static class StatueBloodBuilder
    {
        private const string k_LogPrefix = "StatueBloodBuilder";

        public const string k_WaterRootName = "StatueWater";
        public const string k_BloodRootName = "StatueBlood";
        public const string k_EndingCueName = "EndingCue";
        public const string k_DoomedCueName = "DoomedCue";

        /// <summary>
        /// Whether the doomed endings actually run the blood. Off: the clone and its cues are
        /// still built (so the beat can be switched back on without a rebuild), but the cue
        /// holder is left inactive and nothing ever hears the flags. Decided 2026-09-02: the
        /// wrong choices leave the statue dry for now.
        /// </summary>
        public const bool k_DoomedCuesArmed = false;

        private const string k_MaterialFolder = "Assets/RootsDance/VFX";

        private static readonly string[] k_ScenePaths =
        {
            ScenePaths.k_GreenhouseInteriorEnvironment,
            "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_Statue.unity",
        };

        /// <summary>The doomed choices, each with its own cue object.</summary>
        private static readonly (string flag, string suffix)[] k_DoomedFlags =
        {
            (WorldFlags.k_CirculationCore, "Core"),
            (WorldFlags.k_CirculationRing, "Ring"),
        };

        private static readonly int k_BaseColorId = Shader.PropertyToID("_BaseColor");
        private static readonly int k_ColorId = Shader.PropertyToID("_Color");
        private static readonly int k_UnlitColorId = Shader.PropertyToID("_UnlitColor");

        // Water → blood. Venous rather than paint-red: dark, nearly opaque in the sheet, a shade
        // brighter where it breaks into drops, and a faint red haze where the water had mist.
        private static readonly (string water, string blood, Color color)[] k_Materials =
        {
            (k_MaterialFolder + "/VFX_StatueWater.mat", k_MaterialFolder + "/VFX_StatueBlood.mat",
                new Color(0.42f, 0.02f, 0.03f, 0.88f)),
            (k_MaterialFolder + "/VFX_StatueWaterSplash.mat", k_MaterialFolder + "/VFX_StatueBloodSplash.mat",
                new Color(0.6f, 0.05f, 0.06f, 0.65f)),
            (k_MaterialFolder + "/VFX_StatueWaterMist.mat", k_MaterialFolder + "/VFX_StatueBloodMist.mat",
                new Color(0.45f, 0.03f, 0.04f, 0.1f)),
        };

        [MenuItem("RootsDance/Build Statue Blood (Doomed Endings)")]
        public static void Run()
        {
            ThrowIfAnyOpenSceneIsDirty();
            Dictionary<Material, Material> swap = EnsureBloodMaterials();
            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                for (int i = 0; i < k_ScenePaths.Length; i++)
                {
                    Scene scene = EditorSceneManager.OpenScene(k_ScenePaths[i], OpenSceneMode.Single);
                    BuildInto(scene, swap);
                    EditorSceneManager.MarkSceneDirty(scene);
                    EditorSceneManager.SaveScene(scene);
                }

                AssetDatabase.SaveAssets();
                Debug.Log($"{k_LogPrefix}: built the statue's blood into {k_ScenePaths.Length} scenes.");
            }
            finally
            {
                if (originalSetup.Length > 0)
                {
                    EditorSceneManager.RestoreSceneManagerSetup(originalSetup);
                }
            }
        }

        /// <summary>Clones the water as blood and wires its cues into an already-open scene.</summary>
        public static void BuildInto(Scene scene, Dictionary<Material, Material> swap)
        {
            Transform water = FindNamed(scene, k_WaterRootName);
            CueSequence endingCue = FindEndingCue(scene);

            if (water == null || endingCue == null)
            {
                throw new InvalidOperationException(
                    $"{k_LogPrefix}: {scene.path} has no {k_WaterRootName} with an {k_EndingCueName}; "
                    + "build the statue environment first.");
            }

            Transform parent = water.parent;
            DestroyChildrenNamed(parent, k_BloodRootName);
            DestroyChildrenNamed(endingCue.transform.parent, k_DoomedCueName);

            GameObject blood = UnityEngine.Object.Instantiate(water.gameObject, parent);
            blood.name = k_BloodRootName;
            blood.transform.SetSiblingIndex(water.GetSiblingIndex() + 1);
            blood.SetActive(false);
            SwapMaterials(blood, swap);

            GameObject cueHolder = new GameObject(k_DoomedCueName);
            SceneManager.MoveGameObjectToScene(cueHolder, scene);
            cueHolder.transform.SetParent(endingCue.transform.parent, false);
            cueHolder.transform.SetSiblingIndex(endingCue.transform.GetSiblingIndex() + 1);
            cueHolder.SetActive(k_DoomedCuesArmed);

            for (int i = 0; i < k_DoomedFlags.Length; i++)
            {
                BuildDoomedCue(cueHolder, blood, endingCue, k_DoomedFlags[i].flag, k_DoomedFlags[i].suffix);
            }
        }

        /// <summary>
        /// One cue per doomed flag, a copy of the good ending's cue with the target and flag
        /// changed: switch the blood on, and the same trickle from the same spot on the floor.
        /// </summary>
        private static void BuildDoomedCue(
            GameObject holder, GameObject blood, CueSequence endingCue, string flag, string suffix)
        {
            SerializedObject source = new SerializedObject(endingCue);

            GameObject cueObject = new GameObject($"{k_DoomedCueName}_{suffix}");
            cueObject.transform.SetParent(holder.transform, false);

            CueSequence sequence = cueObject.AddComponent<CueSequence>();
            SerializedObject serialized = new SerializedObject(sequence);
            serialized.FindProperty("m_playOn").enumValueIndex = (int)CueSequence.Moment.OnFlagRaised;
            serialized.FindProperty("m_startOnFlag").stringValue = flag;
            serialized.FindProperty("m_flagRaised").objectReferenceValue =
                source.FindProperty("m_flagRaised").objectReferenceValue;
            serialized.FindProperty("m_audioChannel").objectReferenceValue =
                source.FindProperty("m_audioChannel").objectReferenceValue;
            serialized.FindProperty("m_playsOnce").boolValue = true;

            SerializedProperty sourceSteps = source.FindProperty("m_steps");
            SerializedProperty steps = serialized.FindProperty("m_steps");
            steps.arraySize = 0;

            for (int i = 0; i < sourceSteps.arraySize; i++)
            {
                SerializedProperty from = sourceSteps.GetArrayElementAtIndex(i);
                CueStepKind kind = (CueStepKind)from.FindPropertyRelative("m_kind").enumValueIndex;

                if (kind != CueStepKind.SetActive && kind != CueStepKind.PlayAudio)
                {
                    continue;
                }

                steps.InsertArrayElementAtIndex(steps.arraySize);
                SerializedProperty to = steps.GetArrayElementAtIndex(steps.arraySize - 1);
                to.FindPropertyRelative("m_kind").enumValueIndex = (int)kind;
                to.FindPropertyRelative("m_delay").floatValue = from.FindPropertyRelative("m_delay").floatValue;

                if (kind == CueStepKind.SetActive)
                {
                    to.FindPropertyRelative("m_target").objectReferenceValue = blood;
                    to.FindPropertyRelative("m_isActive").boolValue = true;
                }
                else
                {
                    to.FindPropertyRelative("m_cue").objectReferenceValue =
                        from.FindPropertyRelative("m_cue").objectReferenceValue;
                    to.FindPropertyRelative("m_cueSource").objectReferenceValue =
                        from.FindPropertyRelative("m_cueSource").objectReferenceValue;
                }
            }

            if (steps.arraySize == 0)
            {
                throw new InvalidOperationException(
                    $"{k_LogPrefix}: {k_EndingCueName} has no SetActive or PlayAudio step to mirror.");
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        // ---------------------------------------------------------------------------- materials

        /// <summary>
        /// Each blood material is a copy of its water twin with only the colour changed. Copied
        /// fresh every build so the pair cannot diverge on anything but colour.
        /// </summary>
        private static Dictionary<Material, Material> EnsureBloodMaterials()
        {
            Dictionary<Material, Material> swap = new Dictionary<Material, Material>();

            for (int i = 0; i < k_Materials.Length; i++)
            {
                (string waterPath, string bloodPath, Color color) = k_Materials[i];
                Material water = AssetDatabase.LoadAssetAtPath<Material>(waterPath);

                if (water == null)
                {
                    throw new System.IO.FileNotFoundException(
                        $"{k_LogPrefix}: water material missing at {waterPath}; build the statue environment first.");
                }

                Material blood = AssetDatabase.LoadAssetAtPath<Material>(bloodPath);

                if (blood == null)
                {
                    if (!AssetDatabase.CopyAsset(waterPath, bloodPath))
                    {
                        throw new InvalidOperationException($"{k_LogPrefix}: could not copy {waterPath} to {bloodPath}.");
                    }

                    blood = AssetDatabase.LoadAssetAtPath<Material>(bloodPath);
                }
                else
                {
                    blood.CopyPropertiesFromMaterial(water);
                }

                if (blood.HasProperty(k_BaseColorId))
                {
                    blood.SetColor(k_BaseColorId, color);
                }

                if (blood.HasProperty(k_ColorId))
                {
                    blood.SetColor(k_ColorId, color);
                }

                if (blood.HasProperty(k_UnlitColorId))
                {
                    blood.SetColor(k_UnlitColorId, color);
                }

                HDMaterial.ValidateMaterial(blood);
                EditorUtility.SetDirty(blood);
                swap[water] = blood;
            }

            return swap;
        }

        private static void SwapMaterials(GameObject root, Dictionary<Material, Material> swap)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);

            for (int i = 0; i < renderers.Length; i++)
            {
                Material[] materials = renderers[i].sharedMaterials;
                bool changed = false;

                for (int m = 0; m < materials.Length; m++)
                {
                    if (materials[m] != null && swap.TryGetValue(materials[m], out Material blood))
                    {
                        materials[m] = blood;
                        changed = true;
                    }
                }

                if (!changed)
                {
                    throw new InvalidOperationException(
                        $"{k_LogPrefix}: {renderers[i].name} under {k_WaterRootName} uses a material with no "
                        + "blood twin; add it to the material table.");
                }

                renderers[i].sharedMaterials = materials;
            }
        }

        // ---------------------------------------------------------------------------- lookup

        private static Transform FindNamed(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                foreach (Transform child in root.GetComponentsInChildren<Transform>(true))
                {
                    if (child.name == name)
                    {
                        return child;
                    }
                }
            }

            return null;
        }

        private static CueSequence FindEndingCue(Scene scene)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                foreach (CueSequence sequence in root.GetComponentsInChildren<CueSequence>(true))
                {
                    SerializedObject serialized = new SerializedObject(sequence);

                    if (sequence.name == k_EndingCueName
                        && serialized.FindProperty("m_startOnFlag").stringValue == WorldFlags.k_CirculationOuter)
                    {
                        return sequence;
                    }
                }
            }

            return null;
        }

        private static void DestroyChildrenNamed(Transform parent, string name)
        {
            for (int i = parent.childCount - 1; i >= 0; i--)
            {
                Transform child = parent.GetChild(i);

                if (child.name == name)
                {
                    UnityEngine.Object.DestroyImmediate(child.gameObject);
                }
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
                        $"{k_LogPrefix}: stopped because an open scene has unsaved changes: {scene.path}");
                }
            }
        }
    }
}

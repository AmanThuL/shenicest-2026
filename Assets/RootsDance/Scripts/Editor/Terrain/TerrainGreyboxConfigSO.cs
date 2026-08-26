using System;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// One named review/spec anchor: the position the design spec asks for, and whether the builder
    /// must keep that Y or re-sample it from the generated terrain. Plain serializable data — it is
    /// only ever edited inside <see cref="TerrainGreyboxConfigSO"/>.
    /// </summary>
    [Serializable]
    public class AnchorDefinition
    {
        [SerializeField] private string m_name;
        [SerializeField] private Vector3 m_specPosition;
        [SerializeField] private bool m_useSpecHeight;

        /// <summary>Parameterless constructor for Unity's serializer and the Inspector's "add element".</summary>
        public AnchorDefinition()
        {
        }

        /// <summary>Creates an anchor that is dropped onto the terrain surface.</summary>
        /// <param name="name">GameObject name of the marker sphere.</param>
        /// <param name="specPosition">Position the spec asks for, in world metres.</param>
        public AnchorDefinition(string name, Vector3 specPosition)
            : this(name, specPosition, false)
        {
        }

        /// <summary>Creates an anchor, optionally keeping the spec Y instead of the terrain height.</summary>
        /// <param name="name">GameObject name of the marker sphere.</param>
        /// <param name="specPosition">Position the spec asks for, in world metres.</param>
        /// <param name="useSpecHeight">True to keep <paramref name="specPosition"/>.y instead of the ground.</param>
        public AnchorDefinition(string name, Vector3 specPosition, bool useSpecHeight)
        {
            m_name = name;
            m_specPosition = specPosition;
            m_useSpecHeight = useSpecHeight;
        }

        /// <summary>GameObject name of the marker sphere under the <c>_Anchors</c> root.</summary>
        public string Name => m_name;

        /// <summary>Position the spec asks for, in world metres.</summary>
        public Vector3 SpecPosition => m_specPosition;

        /// <summary>True when the marker keeps <see cref="SpecPosition"/>.y (it is not on the ground).</summary>
        public bool UseSpecHeight => m_useSpecHeight;
    }

    /// <summary>
    /// Every tunable <see cref="TerrainGreyboxBuilder"/> reads: the pure-maths terrain parameters,
    /// the scene and terrain-data asset paths, the lab blockout placement and the Chapter-00 anchor
    /// markers. Editor-only data — the asset lives at
    /// <c>Assets/RootsDance/Data/Config/TerrainGreyboxConfig.asset</c> and never ships in a build.
    /// </summary>
    [CreateAssetMenu(fileName = "TerrainGreyboxConfig", menuName = "RootsDance/Editor/Terrain Greybox Config")]
    public class TerrainGreyboxConfigSO : ScriptableObject
    {
        [SerializeField, TitleGroup("Terrain"), InlineProperty, HideLabel]
        private TerrainGreyboxParams m_params = TerrainGreyboxParams.CreateDefault();

        [SerializeField, TitleGroup("Scene")]
        private string m_scenePath = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment.unity";

        [SerializeField, TitleGroup("Scene")]
        private string m_terrainDataPath = "Assets/RootsDance/Scenes/Levels/Main/Main_TerrainData.asset";

        [SerializeField, TitleGroup("Lab Blockout"), Required]
        private GameObject m_labBlockout;

        [SerializeField, TitleGroup("Lab Blockout")]
        private Vector3 m_labPosition = new Vector3(0f, 7f, 112f);

        [SerializeField, TitleGroup("Lab Blockout")]
        private float m_labYawDegrees = -90f;

        [SerializeField, TitleGroup("Lab Blockout")]
        private bool m_deriveTerraceFromLab = true;

        [SerializeField, TitleGroup("Lab Blockout")]
        private string[] m_labIncludedChildren = CreateDefaultLabChildren();

        [SerializeField, TitleGroup("Anchors")]
        private AnchorDefinition[] m_anchors = CreateDefaultAnchors();

        /// <summary>The generator parameters. Mutable on purpose — the builder writes derived
        /// terrace numbers back into it before generating.</summary>
        public TerrainGreyboxParams Params => m_params;

        /// <summary>Scene the builder edits and saves.</summary>
        public string ScenePath => m_scenePath;

        /// <summary>Asset path of the generated <c>TerrainData</c>.</summary>
        public string TerrainDataPath => m_terrainDataPath;

        /// <summary>The imported <c>LabBlockout.fbx</c> model prefab, or null when it is not imported yet.</summary>
        public GameObject LabBlockout => m_labBlockout;

        /// <summary>World position used for the lab when <see cref="DeriveTerraceFromLab"/> is off.</summary>
        public Vector3 LabPosition => m_labPosition;

        /// <summary>Yaw of the lab, in degrees. -90 puts the gabled porch on the -Z approach.</summary>
        public float LabYawDegrees => m_labYawDegrees;

        /// <summary>
        /// Names of the top-level children of the FBX that make up the actual building. Everything
        /// else on the presentation board (display plates, the 12 m disc, the second scale model) is
        /// switched off on the scene instance.
        /// </summary>
        public string[] LabIncludedChildren => m_labIncludedChildren;

        /// <summary>When true the terrace extents, yaw and lab position are measured from the FBX bounds.</summary>
        public bool DeriveTerraceFromLab => m_deriveTerraceFromLab;

        /// <summary>The Chapter-00 review anchors.</summary>
        public AnchorDefinition[] Anchors => m_anchors;

        /// <summary>
        /// The spec anchors from the Chapter-00 blockout. The exhaust fan sits on the building wall,
        /// so it is the only one that keeps its authored Y instead of being dropped onto the terrain.
        /// </summary>
        /// <returns>A new array of the eight Chapter-00 anchors.</returns>
        public static AnchorDefinition[] CreateDefaultAnchors()
        {
            return new[]
            {
                new AnchorDefinition("Anchor_Center", new Vector3(0f, 7f, 112f)),
                new AnchorDefinition("Anchor_00-01_Wake", new Vector3(0f, 3f, -10f)),
                new AnchorDefinition("Anchor_00-07_GrassPlatform", new Vector3(-12f, 6f, 39f)),
                new AnchorDefinition("Anchor_00-09_MainGate", new Vector3(0f, 7f, 80f)),
                new AnchorDefinition("Anchor_00-10_Sign", new Vector3(-12f, 7f, 83f)),
                new AnchorDefinition("Anchor_00-11_Poster", new Vector3(-40f, 7f, 96f)),
                new AnchorDefinition("Anchor_00-14_ExhaustFan", new Vector3(36f, 11f, 103f), true),
                new AnchorDefinition("Anchor_00-16_ServiceEntrance", new Vector3(41f, 4f, 105f)),
            };
        }

        /// <summary>
        /// The building cluster sitting on the board's 12 m disc. <c>LabBlockout.fbx</c> is a
        /// presentation board — three flat plates plus a disc, each carrying a small scale model —
        /// and only this cluster is the lab; the rest is hidden on the instance.
        /// </summary>
        /// <returns>A new array of the top-level FBX child names that make up the lab.</returns>
        public static string[] CreateDefaultLabChildren()
        {
            return new[]
            {
                "Fence1", "Fence2", "Fence3",
                "Group81", "Group87", "Group106", "Group107", "Group108", "Group109", "Group110",
                "Group128", "Group147", "Group165", "Group166", "Group184", "Group185", "Group186",
                "Group187",
            };
        }

        [Button("Build Greybox Terrain"), TitleGroup("Terrain")]
        private void BuildFromInspector()
        {
            TerrainGreyboxBuilder.Build(this);
        }
    }
}

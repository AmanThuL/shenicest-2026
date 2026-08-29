using System.Collections.Generic;
using RootsDance.Player;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Serialization;

namespace RootsDance.Environment
{
    /// <summary>
    /// Opens a pair of door leaves away from their centre seam while a player trigger probe is nearby.
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(BoxCollider))]
    public sealed class AutomaticSlidingDoor : MonoBehaviour
    {
        private static readonly int k_EmissiveColorId = Shader.PropertyToID("_EmissiveColor");

        [Header("Door Leaves")]
        [SerializeField] private Transform m_leftLeaf;
        [SerializeField] private Transform m_rightLeaf;

        [Header("Motion")]
        [Min(0f)]
        [SerializeField] private float m_openDistance = 2.5f;

        [Min(0.01f)]
        [SerializeField] private float m_speed = 2.2f;

        [Header("Rune Activation")]
        [SerializeField] private Renderer[] m_innerRuneRenderers;

        [SerializeField] private Transform[] m_innerRuneRoots;

        [Min(1)]
        [SerializeField] private int m_innerRuneBandCount = 1;

        [SerializeField] private Renderer[] m_outerRuneRenderers;

        [SerializeField] private Light m_runeLight;

        [ColorUsage(false, true)]
        [SerializeField] private Color m_runeGlowColor = new Color(0.015f, 0.12f, 0.95f, 1f);

        [Min(0f)]
        [SerializeField] private float m_runeEmissionNits = 1400f;

        [Min(0.01f)]
        [SerializeField] private float m_innerRevealDuration = 0.9f;

        [Min(0.01f)]
        [SerializeField] private float m_outerIgnitionDuration = 0.2f;

        [Min(0.01f)]
        [SerializeField] private float m_innerRetractDuration = 0.24f;

        [Min(0f)]
        [SerializeField] private float m_innerRetractDistance = 0.38f;

        [Min(0f)]
        [SerializeField] private float m_openDelay = 0.12f;

        [Min(0.01f)]
        [SerializeField] private float m_deactivationDuration = 0.3f;

        [Min(0f)]
        [SerializeField] private float m_runeLightIntensity = 260f;

        [FormerlySerializedAs("m_openingStarted")]
        [SerializeField] private UnityEvent m_activationStarted = new UnityEvent();

        [SerializeField] private UnityEvent m_openingFinished = new UnityEvent();

        private readonly HashSet<PlayerTriggerProbe> m_occupants = new HashSet<PlayerTriggerProbe>();
        private Vector3 m_leftClosedPosition;
        private Vector3 m_rightClosedPosition;
        private Vector3[] m_innerRuneClosedPositions;
        private Material[] m_innerRuneMaterials;
        private Material[] m_outerRuneMaterials;
        private DoorState m_state;
        private float m_stateElapsed;

        private void Awake()
        {
            CacheClosedPositions();
            CacheInnerRunePositions();
            m_innerRuneMaterials = CreateRuneMaterialInstances(m_innerRuneRenderers);
            m_outerRuneMaterials = CreateRuneMaterialInstances(m_outerRuneRenderers);
            SetRuneStrengths(0f, 0f);
        }

        private void Update()
        {
            if (m_leftLeaf == null || m_rightLeaf == null)
            {
                return;
            }

            if (m_occupants.Count == 0 && m_state != DoorState.Dormant && m_state != DoorState.Closing)
            {
                EnterState(DoorState.Closing);
            }

            if (m_occupants.Count > 0 && m_state == DoorState.Dormant)
            {
                EnterState(DoorState.RevealingInner);
            }

            m_stateElapsed += Time.deltaTime;

            switch (m_state)
            {
                case DoorState.RevealingInner:
                    UpdateInnerReveal();
                    break;
                case DoorState.IgnitingOuter:
                    UpdateOuterIgnition();
                    break;
                case DoorState.OpeningDelay:
                    SetRuneStrengths(1f, 1f);

                    if (m_stateElapsed >= m_openDelay)
                    {
                        EnterState(DoorState.RetractingInner);
                    }
                    break;
                case DoorState.RetractingInner:
                    UpdateInnerRetraction();
                    break;
                case DoorState.Opening:
                    SetRuneStrengths(0f, 1f);
                    MoveLeaves(true);

                    if (AreLeavesAtTargets(true))
                    {
                        EnterState(DoorState.Open);
                    }
                    break;
                case DoorState.Open:
                    SetRuneStrengths(0f, 1f);
                    break;
                case DoorState.Closing:
                    UpdateClosing();
                    break;
            }
        }

        private void OnTriggerEnter(Collider other)
        {
            PlayerTriggerProbe probe = other.GetComponentInParent<PlayerTriggerProbe>();

            if (probe != null)
            {
                m_occupants.Add(probe);
            }
        }

        private void OnTriggerExit(Collider other)
        {
            PlayerTriggerProbe probe = other.GetComponentInParent<PlayerTriggerProbe>();

            if (probe != null)
            {
                m_occupants.Remove(probe);
            }
        }

        private void OnDisable()
        {
            if (m_state != DoorState.Dormant)
            {
                m_openingFinished.Invoke();
            }

            m_occupants.Clear();
            m_state = DoorState.Dormant;
            m_stateElapsed = 0f;

            if (m_leftLeaf != null)
            {
                m_leftLeaf.localPosition = m_leftClosedPosition;
            }

            if (m_rightLeaf != null)
            {
                m_rightLeaf.localPosition = m_rightClosedPosition;
            }

            ResetInnerRunePositions();
            SetRuneStrengths(0f, 0f);
        }

        private void OnDestroy()
        {
            DestroyMaterialInstances(m_innerRuneMaterials);
            DestroyMaterialInstances(m_outerRuneMaterials);
        }

        private void Reset()
        {
            BoxCollider trigger = GetComponent<BoxCollider>();
            trigger.isTrigger = true;
        }

        private void OnValidate()
        {
            m_openDistance = Mathf.Max(0f, m_openDistance);
            m_speed = Mathf.Max(0.01f, m_speed);
            m_innerRuneBandCount = Mathf.Max(1, m_innerRuneBandCount);
            m_runeEmissionNits = Mathf.Max(0f, m_runeEmissionNits);
            m_innerRevealDuration = Mathf.Max(0.01f, m_innerRevealDuration);
            m_outerIgnitionDuration = Mathf.Max(0.01f, m_outerIgnitionDuration);
            m_innerRetractDuration = Mathf.Max(0.01f, m_innerRetractDuration);
            m_innerRetractDistance = Mathf.Max(0f, m_innerRetractDistance);
            m_openDelay = Mathf.Max(0f, m_openDelay);
            m_deactivationDuration = Mathf.Max(0.01f, m_deactivationDuration);
            m_runeLightIntensity = Mathf.Max(0f, m_runeLightIntensity);
            BoxCollider trigger = GetComponent<BoxCollider>();

            if (trigger != null)
            {
                trigger.isTrigger = true;
            }
        }

        public void Configure(Transform leftLeaf, Transform rightLeaf, float openDistance, float speed)
        {
            m_leftLeaf = leftLeaf;
            m_rightLeaf = rightLeaf;
            m_openDistance = Mathf.Max(0f, openDistance);
            m_speed = Mathf.Max(0.01f, speed);
            CacheClosedPositions();
        }

        public void ConfigureRuneSequence(
            Renderer[] innerRuneRenderers,
            Transform[] innerRuneRoots,
            int innerRuneBandCount,
            Renderer[] outerRuneRenderers,
            Light runeLight,
            float innerRevealDuration,
            float outerIgnitionDuration,
            float innerRetractDuration,
            float innerRetractDistance,
            float openDelay)
        {
            m_innerRuneRenderers = innerRuneRenderers;
            m_innerRuneRoots = innerRuneRoots;
            m_innerRuneBandCount = Mathf.Max(1, innerRuneBandCount);
            m_outerRuneRenderers = outerRuneRenderers;
            m_runeLight = runeLight;
            m_innerRevealDuration = Mathf.Max(0.01f, innerRevealDuration);
            m_outerIgnitionDuration = Mathf.Max(0.01f, outerIgnitionDuration);
            m_innerRetractDuration = Mathf.Max(0.01f, innerRetractDuration);
            m_innerRetractDistance = Mathf.Max(0f, innerRetractDistance);
            m_openDelay = Mathf.Max(0f, openDelay);
        }

        public UnityEvent ActivationStarted
        {
            get { return m_activationStarted; }
        }

        public UnityEvent OpeningFinished
        {
            get { return m_openingFinished; }
        }

        private void CacheClosedPositions()
        {
            if (m_leftLeaf != null)
            {
                m_leftClosedPosition = m_leftLeaf.localPosition;
            }

            if (m_rightLeaf != null)
            {
                m_rightClosedPosition = m_rightLeaf.localPosition;
            }
        }

        private void CacheInnerRunePositions()
        {
            if (m_innerRuneRoots == null)
            {
                m_innerRuneClosedPositions = null;
                return;
            }

            m_innerRuneClosedPositions = new Vector3[m_innerRuneRoots.Length];

            for (int i = 0; i < m_innerRuneRoots.Length; i++)
            {
                Transform runeRoot = m_innerRuneRoots[i];

                if (runeRoot != null)
                {
                    m_innerRuneClosedPositions[i] = runeRoot.localPosition;
                }
            }
        }

        private static Material[] CreateRuneMaterialInstances(Renderer[] renderers)
        {
            if (renderers == null)
            {
                return null;
            }

            Material[] materials = new Material[renderers.Length];

            for (int i = 0; i < renderers.Length; i++)
            {
                Renderer runeRenderer = renderers[i];

                if (runeRenderer == null)
                {
                    continue;
                }

                materials[i] = runeRenderer.material;
                runeRenderer.enabled = false;
            }

            return materials;
        }

        private static void DestroyMaterialInstances(Material[] materials)
        {
            if (materials == null)
            {
                return;
            }

            for (int i = 0; i < materials.Length; i++)
            {
                if (materials[i] != null)
                {
                    Destroy(materials[i]);
                }
            }
        }

        private void UpdateInnerReveal()
        {
            float reveal = Mathf.Clamp01(m_stateElapsed / m_innerRevealDuration);
            SetRuneStrengths(reveal, 0f);

            if (reveal >= 1f)
            {
                EnterState(DoorState.IgnitingOuter);
            }
        }

        private void UpdateOuterIgnition()
        {
            float ignition = Mathf.Clamp01(m_stateElapsed / m_outerIgnitionDuration);
            SetRuneStrengths(1f, ignition);

            if (ignition >= 1f)
            {
                EnterState(DoorState.OpeningDelay);
            }
        }

        private void UpdateInnerRetraction()
        {
            float progress = Mathf.Clamp01(m_stateElapsed / m_innerRetractDuration);
            SetRuneStrengths(1f, 1f);
            SetInnerRuneRetraction(progress);

            if (progress >= 1f)
            {
                SetInnerRuneStrength(0f);
                EnterState(DoorState.Opening);
            }
        }

        private void UpdateClosing()
        {
            MoveLeaves(false);
            float strength = 1f - Mathf.Clamp01(m_stateElapsed / m_deactivationDuration);
            SetRuneStrengths(0f, strength);

            if (AreLeavesAtTargets(false) && strength <= 0f)
            {
                ResetInnerRunePositions();
                EnterState(DoorState.Dormant);
            }
        }

        private void SetInnerRuneRetraction(float progress)
        {
            if (m_innerRuneRoots == null || m_innerRuneClosedPositions == null)
            {
                return;
            }

            for (int i = 0; i < m_innerRuneRoots.Length; i++)
            {
                Transform runeRoot = m_innerRuneRoots[i];

                if (runeRoot == null || runeRoot.parent == null)
                {
                    continue;
                }

                float parentDepthScale = Mathf.Max(0.0001f, Mathf.Abs(runeRoot.parent.lossyScale.z));
                Vector3 retractedPosition = m_innerRuneClosedPositions[i]
                    + Vector3.forward * (m_innerRetractDistance / parentDepthScale);
                runeRoot.localPosition = Vector3.Lerp(
                    m_innerRuneClosedPositions[i],
                    retractedPosition,
                    Mathf.SmoothStep(0f, 1f, progress));
            }
        }

        private void ResetInnerRunePositions()
        {
            if (m_innerRuneRoots == null || m_innerRuneClosedPositions == null)
            {
                return;
            }

            int count = Mathf.Min(m_innerRuneRoots.Length, m_innerRuneClosedPositions.Length);

            for (int i = 0; i < count; i++)
            {
                if (m_innerRuneRoots[i] != null)
                {
                    m_innerRuneRoots[i].localPosition = m_innerRuneClosedPositions[i];
                }
            }
        }

        private void MoveLeaves(bool isOpening)
        {
            Vector3 leftTarget = m_leftClosedPosition + Vector3.left * (isOpening ? m_openDistance : 0f);
            Vector3 rightTarget = m_rightClosedPosition + Vector3.right * (isOpening ? m_openDistance : 0f);
            float step = m_speed * Time.deltaTime;
            m_leftLeaf.localPosition = Vector3.MoveTowards(m_leftLeaf.localPosition, leftTarget, step);
            m_rightLeaf.localPosition = Vector3.MoveTowards(m_rightLeaf.localPosition, rightTarget, step);
        }

        private bool AreLeavesAtTargets(bool areOpen)
        {
            Vector3 leftTarget = m_leftClosedPosition + Vector3.left * (areOpen ? m_openDistance : 0f);
            Vector3 rightTarget = m_rightClosedPosition + Vector3.right * (areOpen ? m_openDistance : 0f);
            return Vector3.SqrMagnitude(m_leftLeaf.localPosition - leftTarget) < 0.000001f
                && Vector3.SqrMagnitude(m_rightLeaf.localPosition - rightTarget) < 0.000001f;
        }

        private void SetRuneStrengths(float innerStrength, float outerStrength)
        {
            SetInnerRuneStrength(innerStrength);
            SetOuterRuneStrength(outerStrength);
            SetRuneLightStrength(Mathf.Max(innerStrength, outerStrength));
        }

        private void SetInnerRuneStrength(float reveal)
        {
            if (m_innerRuneMaterials == null || m_innerRuneRenderers == null)
            {
                return;
            }

            int renderersPerBand = Mathf.Max(1, m_innerRuneMaterials.Length / m_innerRuneBandCount);

            for (int i = 0; i < m_innerRuneMaterials.Length; i++)
            {
                int bandIndex = Mathf.Min(m_innerRuneBandCount - 1, i / renderersPerBand);
                float bandStart = bandIndex / (m_innerRuneBandCount + 1f);
                float bandEnd = (bandIndex + 2f) / (m_innerRuneBandCount + 1f);
                float bandProgress = Mathf.InverseLerp(bandStart, bandEnd, reveal);
                float bandStrength = Mathf.SmoothStep(0f, 1f, bandProgress);
                SetRendererStrength(m_innerRuneRenderers[i], m_innerRuneMaterials[i], bandStrength);
            }
        }

        private void SetOuterRuneStrength(float strength)
        {
            if (m_outerRuneMaterials != null && m_outerRuneRenderers != null)
            {
                for (int i = 0; i < m_outerRuneMaterials.Length; i++)
                {
                    SetRendererStrength(m_outerRuneRenderers[i], m_outerRuneMaterials[i], strength);
                }
            }

        }

        private void SetRuneLightStrength(float strength)
        {
            if (m_runeLight != null)
            {
                m_runeLight.intensity = m_runeLightIntensity * strength;
                m_runeLight.enabled = strength > 0.001f;
            }
        }

        private void SetRendererStrength(Renderer runeRenderer, Material material, float strength)
        {
            if (runeRenderer == null || material == null)
            {
                return;
            }

            material.SetColor(k_EmissiveColorId, m_runeGlowColor.linear * (m_runeEmissionNits * strength));
            runeRenderer.enabled = strength > 0.001f;
        }

        private void EnterState(DoorState state)
        {
            if (state == DoorState.RevealingInner && m_state != DoorState.RevealingInner)
            {
                m_activationStarted.Invoke();
            }

            if ((state == DoorState.Open && m_state != DoorState.Open)
                || (state == DoorState.Closing && m_state != DoorState.Closing))
            {
                m_openingFinished.Invoke();
            }

            m_state = state;
            m_stateElapsed = 0f;
        }

        private enum DoorState
        {
            Dormant,
            RevealingInner,
            IgnitingOuter,
            OpeningDelay,
            RetractingInner,
            Opening,
            Open,
            Closing,
        }
    }
}

using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.Archive
{
    /// <summary>
    /// Makes an archive sheet respond to the room it is in.
    /// <para>
    /// HDRP shades a uGUI canvas Unlit and there is no setting that changes it (guideline 07), so
    /// every layer of the sheet — the paper as much as the writing on it — is unlit and would
    /// otherwise keep full brightness in a pitch-dark room. This samples the light actually
    /// arriving at the sheet's face and tints the whole page with it, so paper and ink dim and warm
    /// together and the sheet reads as one object lying in the world.
    /// </para>
    /// <para>
    /// It reaches the page by two routes because the page is drawn by two kinds of material: the
    /// graphics share one <c>ArchiveInk</c> material and get it as <c>_PaperLight</c>, while text
    /// is drawn by TextMeshPro's own SDF material, cannot use that shader, and gets it folded into
    /// its vertex colour instead.
    /// </para>
    /// <para>
    /// Sampled a few times a second rather than every frame: it is a slowly changing value, and the
    /// probe evaluation is the only allocation-free way to ask the question.
    /// </para>
    /// </summary>
    /// <remarks>
    /// Runs in the Editor as well as in play, so a sheet looks the same in the Scene view, in a
    /// preview capture and in the game. That matters for more than convenience: an Editor render
    /// that skipped this would be testing a configuration that never ships.
    /// </remarks>
    [ExecuteAlways]
    [DisallowMultipleComponent]
    public class ArchivePaperLighting : MonoBehaviour
    {
        private static readonly int k_PaperLightId = Shader.PropertyToID("_PaperLight");
        private static readonly int k_LightDirectionId = Shader.PropertyToID("_LightDirection");

        [Tooltip("Every graphic on the sheet — the paper, the washes, the photo, the stamps. One "
            + "material instance is made per distinct material they use, and the light is written "
            + "once to each.")]
        [SerializeField] private Graphic[] m_inkGraphics = Array.Empty<Graphic>();

        [Tooltip("Text on the sheet. TextMeshPro draws with its own SDF material, so the light is "
            + "folded into the vertex colour for these instead.")]
        [SerializeField] private TextMeshProUGUI[] m_texts = Array.Empty<TextMeshProUGUI>();

        [Tooltip("The light the sheet is normally read by — in this game, the flashlight. Empty "
            + "leaves only the ambient probe.")]
        [SerializeField] private Light m_keyLight;

        [Tooltip("Darkest the page is ever allowed to get. Without a floor a sheet read in the "
            + "dark is not dim, it is blank.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_minimumLight = 0.18f;

        [Tooltip("Brightest it is allowed to get, so a flashlight held against the page does not "
            + "blow the writing out to white.")]
        [Range(0.2f, 4f)]
        [SerializeField] private float m_maximumLight = 1.15f;

        [Tooltip("Seconds between samples. The value changes slowly; sampling every frame is waste.")]
        [Range(0.02f, 1f)]
        [SerializeField] private float m_sampleInterval = 0.15f;

        private readonly Vector3[] m_sampleDirections = new Vector3[1];
        private readonly Color[] m_sampleResults = new Color[1];
        private readonly List<Material> m_ownedMaterials = new List<Material>();
        private Color[] m_authoredTextColors;
        private float m_nextSampleTime;

        private void Awake()
        {
            m_authoredTextColors = new Color[m_texts.Length];

            for (int i = 0; i < m_texts.Length; i++)
            {
                if (m_texts[i] != null)
                {
                    m_authoredTextColors[i] = m_texts[i].color;
                }
            }

            ShareMaterials();
        }

        private void OnEnable()
        {
            // Apply once immediately: waiting for the first interval would show one frame of the
            // authored colours, which is a visible flash on a page that opens in a dark room.
            m_nextSampleTime = 0f;
            Apply(Sample(), PageSpaceLightDirection());
        }

        private void Update()
        {
            // realtimeSinceStartup rather than time: the latter does not advance in the Editor,
            // and this component runs there too.
            if (Time.realtimeSinceStartup < m_nextSampleTime)
            {
                return;
            }

            m_nextSampleTime = Time.realtimeSinceStartup + m_sampleInterval;
            Apply(Sample(), PageSpaceLightDirection());
        }

        /// <summary>
        /// The light arriving at the printed face. Ambient from the probe, plus a direct term for
        /// the key light — an approximation of one lambert surface, which is all a flat sheet is.
        /// </summary>
        private Color Sample()
        {
            // The readable face looks back along the sheet's forward axis (see the read pose).
            Vector3 normal = -transform.forward;

            // The probe evaluates to the radiance a white diffuse surface would return, which is
            // the quantity the page's own colours are in. The direct term is irradiance, so it is
            // divided by pi to land in the same units before the two are added.
            m_sampleDirections[0] = normal;
            RenderSettings.ambientProbe.Evaluate(m_sampleDirections, m_sampleResults);
            Color light = m_sampleResults[0];

            if (m_keyLight != null && m_keyLight.isActiveAndEnabled)
            {
                light += DirectContribution(normal) / Mathf.PI;
            }

            float floor = m_minimumLight;

            return new Color(
                Mathf.Clamp(light.r, floor, m_maximumLight),
                Mathf.Clamp(light.g, floor, m_maximumLight),
                Mathf.Clamp(light.b, floor, m_maximumLight),
                1f);
        }

        private Color DirectContribution(Vector3 normal)
        {
            Transform lightTransform = m_keyLight.transform;
            Vector3 toLight;
            float attenuation;

            if (m_keyLight.type == LightType.Directional)
            {
                toLight = -lightTransform.forward;
                attenuation = 1f;
            }
            else
            {
                Vector3 offset = lightTransform.position - transform.position;
                float distance = offset.magnitude;
                toLight = distance < 1e-4f ? normal : offset / distance;

                float range = Mathf.Max(m_keyLight.range, 1e-3f);
                float normalised = Mathf.Clamp01(distance / range);
                attenuation = (1f - normalised) * (1f - normalised);
            }

            float lambert = Mathf.Max(0f, Vector3.Dot(normal, toLight));

            return m_keyLight.color * (m_keyLight.intensity * lambert * attenuation);
        }

        /// <summary>
        /// Where the light is coming from, in the page's own frame: x to the right of the writing,
        /// y up it, z out of the sheet towards whoever is reading it. The paper shader lights its
        /// folds with this, so the highlight along a crease moves when the flashlight does.
        /// </summary>
        private Vector4 PageSpaceLightDirection()
        {
            Vector3 toLight;

            if (m_keyLight == null || !m_keyLight.isActiveAndEnabled)
            {
                toLight = -transform.forward;
            }
            else if (m_keyLight.type == LightType.Directional)
            {
                toLight = -m_keyLight.transform.forward;
            }
            else
            {
                toLight = m_keyLight.transform.position - transform.position;
            }

            Vector3 local = transform.InverseTransformDirection(toLight.normalized);

            // The readable face looks back along the sheet's forward axis, so what is "out of the
            // page" is local -Z; the shader wants that as +Z.
            Vector3 pageSpace = new Vector3(local.x, local.y, -local.z);

            if (pageSpace.sqrMagnitude < 1e-6f)
            {
                pageSpace = Vector3.forward;
            }

            return pageSpace.normalized;
        }

        private void Apply(Color light, Vector4 lightDirection)
        {
            for (int i = 0; i < m_ownedMaterials.Count; i++)
            {
                Material material = m_ownedMaterials[i];

                if (material == null)
                {
                    continue;
                }

                material.SetColor(k_PaperLightId, light);

                if (material.HasProperty(k_LightDirectionId))
                {
                    material.SetVector(k_LightDirectionId, lightDirection);
                }
            }

            for (int i = 0; i < m_texts.Length; i++)
            {
                TextMeshProUGUI text = m_texts[i];

                if (text == null)
                {
                    continue;
                }

                Color authored = m_authoredTextColors[i];
                text.color = new Color(
                    authored.r * light.r, authored.g * light.g, authored.b * light.b, authored.a);
            }
        }

        /// <summary>
        /// Gives this sheet its own copy of each material its graphics use — one for the paper, one
        /// for the ink — and points the graphics at the copies. Writing the light into the material
        /// assets themselves would change them on disk for every other sheet in the project.
        /// </summary>
        private void ShareMaterials()
        {
            m_ownedMaterials.Clear();

            for (int i = 0; i < m_inkGraphics.Length; i++)
            {
                Graphic graphic = m_inkGraphics[i];

                if (graphic == null || graphic.material == null)
                {
                    continue;
                }

                Material shared = graphic.material;
                Material owned = FindOwnedCopyOf(shared);

                if (owned == null)
                {
                    owned = new Material(shared);
                    owned.name = shared.name + " (sheet)";
                    m_ownedMaterials.Add(owned);
                }

                graphic.material = owned;
            }
        }

        /// <summary>The copy already made for this shared material, or null when there is none.</summary>
        private Material FindOwnedCopyOf(Material shared)
        {
            for (int i = 0; i < m_ownedMaterials.Count; i++)
            {
                Material owned = m_ownedMaterials[i];

                if (owned != null && owned.shader == shared.shader)
                {
                    return owned;
                }
            }

            return null;
        }

        private void OnDestroy()
        {
            for (int i = 0; i < m_ownedMaterials.Count; i++)
            {
                Material owned = m_ownedMaterials[i];

                if (owned == null)
                {
                    continue;
                }

                // Destroy is a no-op outside play mode and logs; the Editor needs the immediate
                // form, and this component runs in both.
                if (Application.isPlaying)
                {
                    Destroy(owned);
                }
                else
                {
                    DestroyImmediate(owned);
                }
            }

            m_ownedMaterials.Clear();
        }
    }
}

using System;
using DG.Tweening;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// The thin semantic orchestration layer called for in the UI motion research: presenters ask for
    /// a motion *verb* (Snap / Flash / FlickerLock / TerminalWrite / ReadoutJitter / RasterHold /
    /// Reconstruct / HardCut) instead of hand-writing tweens, so every screen derives from one recipe
    /// and stays consistent.
    /// <para>
    /// DOTween supplies timing only. Every visible step here is a discrete state change on a terminal
    /// refresh grid — no eases, no interpolated fades, no directional movement.
    /// </para>
    /// <para>
    /// Each verb targets the component it drives, so a caller cancels its own motion with
    /// <see cref="Kill"/> (do this in <c>OnDisable</c>) without disturbing other presenters.
    /// </para>
    /// </summary>
    public static class TerminalMotion
    {
        /// <summary>Visibility the signal steps through while it locks on. Ends fully lit.</summary>
        private static readonly float[] k_FlickerPattern = { 1f, 0f, 0.75f, 0f, 0.4f, 1f };

        /// <summary>Upper bound for the meaningless digits a readout shows before it settles.</summary>
        private const int k_JitterMaxValue = 100;

        /// <summary>
        /// Stage-material properties the two image-side verbs drive, declared by
        /// <c>Assets/RootsDance/Shaders/UI/TerminalStage.shader</c>. Ids are cached because
        /// <see cref="RasterHold"/> and <see cref="Reconstruct"/> write them once per terminal step.
        /// </summary>
        private static readonly int k_RasterStrengthId = Shader.PropertyToID("_RasterStrength");

        private static readonly int k_RasterPhaseId = Shader.PropertyToID("_RasterPhase");

        private static readonly int k_CoverageId = Shader.PropertyToID("_Coverage");

        /// <summary>
        /// Signal acquisition: the element jumps through a few unstable visibilities, then locks at
        /// full. The representative way a panel or notice arrives.
        /// </summary>
        public static Sequence FlickerLock(CanvasGroup group, TerminalMotionProfile profile)
        {
            if (group == null || profile == null)
            {
                return null;
            }

            Kill(group);
            group.alpha = 0f;

            Sequence sequence = DOTween.Sequence().SetTarget(group);

            for (int i = 0; i < k_FlickerPattern.Length; i++)
            {
                float alpha = k_FlickerPattern[i];
                sequence.AppendCallback(() => group.alpha = alpha);
                sequence.AppendInterval(profile.StepSeconds);
            }

            sequence.AppendCallback(() => group.alpha = 1f);
            sequence.OnKill(() =>
            {
                if (group != null)
                {
                    group.alpha = 1f;
                }
            });

            return sequence;
        }

        /// <summary>
        /// Hard reveal: the element is simply there this frame. For prompts, tooltips and HUD icons
        /// that must not make the player wait for a flicker.
        /// </summary>
        public static void Snap(CanvasGroup group)
        {
            if (group == null)
            {
                return;
            }

            Kill(group);
            group.alpha = 1f;
        }

        /// <summary>
        /// A one-off brightness jump lasting a couple of terminal steps, then back. Pairs with
        /// <see cref="Snap"/> to mark the moment a state changed.
        /// </summary>
        public static Sequence Flash(Graphic graphic, Color flashColor, TerminalMotionProfile profile)
        {
            if (graphic == null || profile == null || profile.FlashSteps <= 0)
            {
                return null;
            }

            Kill(graphic);

            Color original = graphic.color;
            graphic.color = flashColor;

            Sequence sequence = DOTween.Sequence().SetTarget(graphic);
            sequence.AppendInterval(profile.StepSeconds * profile.FlashSteps);
            sequence.AppendCallback(() => graphic.color = original);
            sequence.OnKill(() =>
            {
                if (graphic != null)
                {
                    graphic.color = original;
                }
            });

            return sequence;
        }

        /// <summary>
        /// Machine write: the line arrives in chunks of several characters at a time, never as a
        /// per-character typewriter. Interrupting it leaves the full text visible.
        /// </summary>
        public static Sequence TerminalWrite(TMP_Text label, string text, TerminalMotionProfile profile)
        {
            if (label == null || profile == null)
            {
                return null;
            }

            Kill(label);

            label.text = text;
            label.maxVisibleCharacters = 0;
            label.ForceMeshUpdate();

            int total = label.textInfo.characterCount;
            int chunk = profile.WriteChunkSize;

            if (total <= chunk)
            {
                label.maxVisibleCharacters = int.MaxValue;
                return null;
            }

            label.maxVisibleCharacters = chunk;

            Sequence sequence = DOTween.Sequence().SetTarget(label);

            for (int visible = chunk * 2; visible < total; visible += chunk)
            {
                int step = visible;
                sequence.AppendInterval(profile.StepSeconds);
                sequence.AppendCallback(() => label.maxVisibleCharacters = step);
            }

            sequence.AppendInterval(profile.StepSeconds);
            sequence.AppendCallback(() => label.maxVisibleCharacters = int.MaxValue);
            sequence.OnKill(() =>
            {
                if (label != null)
                {
                    label.maxVisibleCharacters = int.MaxValue;
                }
            });

            return sequence;
        }

        /// <summary>
        /// The same machine write, on a dot-matrix line. The boot screen's text is drawn as dots into
        /// the low-resolution buffer rather than by TextMeshPro, so it needs its own overload.
        /// </summary>
        public static Sequence TerminalWrite(DotMatrixText label, string text, TerminalMotionProfile profile)
        {
            if (label == null || profile == null)
            {
                return null;
            }

            Kill(label);

            label.VisibleCharacters = 0;
            label.Text = text;

            int total = label.CharacterCount;
            int chunk = profile.WriteChunkSize;

            if (total <= chunk)
            {
                label.VisibleCharacters = int.MaxValue;
                return null;
            }

            label.VisibleCharacters = chunk;

            Sequence sequence = DOTween.Sequence().SetTarget(label);

            for (int visible = chunk * 2; visible < total; visible += chunk)
            {
                int step = visible;
                sequence.AppendInterval(profile.StepSeconds);
                sequence.AppendCallback(() => label.VisibleCharacters = step);
            }

            sequence.AppendInterval(profile.StepSeconds);
            sequence.AppendCallback(() => label.VisibleCharacters = int.MaxValue);
            sequence.OnKill(() =>
            {
                if (label != null)
                {
                    label.VisibleCharacters = int.MaxValue;
                }
            });

            return sequence;
        }

        /// <summary>
        /// Numeric stabilization: the readout shows a few unrelated values before it settles on the
        /// real one. Never a smooth count-up. Interrupting it leaves the settled value.
        /// </summary>
        /// <param name="format">Builds the whole line from a value, so labels and padding survive.</param>
        public static Sequence ReadoutJitter(TMP_Text label, int finalValue, Func<int, string> format,
            TerminalMotionProfile profile)
        {
            if (label == null || profile == null || format == null)
            {
                return null;
            }

            Kill(label);

            Sequence sequence = DOTween.Sequence().SetTarget(label);

            for (int i = 0; i < profile.JitterSteps; i++)
            {
                sequence.AppendCallback(() => label.text = format(UnityEngine.Random.Range(0, k_JitterMaxValue)));
                sequence.AppendInterval(profile.StepSeconds);
            }

            sequence.AppendCallback(() => label.text = format(finalValue));
            sequence.OnKill(() =>
            {
                if (label != null)
                {
                    label.text = format(finalValue);
                }
            });

            return sequence;
        }

        /// <summary>
        /// Signal present, image not yet: the stage shows only horizontal raster bands, which jump to a
        /// new offset every terminal step and never fade. The opening state of the boot sequence (P1),
        /// held for <see cref="TerminalMotionProfile.RasterHoldSteps"/> steps and then cut.
        /// <para>
        /// Drives stage-material properties rather than a <see cref="CanvasGroup"/>, so the bands are
        /// part of the dithered image instead of a separate UI layer.
        /// </para>
        /// </summary>
        public static Sequence RasterHold(Material stageMaterial, TerminalMotionProfile profile)
        {
            if (stageMaterial == null || profile == null)
            {
                return null;
            }

            Kill(stageMaterial);

            stageMaterial.SetFloat(k_RasterStrengthId, 1f);
            stageMaterial.SetFloat(k_CoverageId, 0f);

            Sequence sequence = DOTween.Sequence().SetTarget(stageMaterial);

            for (int i = 0; i < profile.RasterHoldSteps; i++)
            {
                int step = i;
                sequence.AppendCallback(() => stageMaterial.SetFloat(k_RasterPhaseId, step));
                sequence.AppendInterval(profile.StepSeconds);
            }

            sequence.AppendCallback(() => stageMaterial.SetFloat(k_RasterStrengthId, 0f));
            sequence.OnKill(() =>
            {
                if (stageMaterial != null)
                {
                    stageMaterial.SetFloat(k_RasterStrengthId, 0f);
                }
            });

            return sequence;
        }

        /// <summary>
        /// The image resolving out of coarse blocks: coverage climbs from
        /// <see cref="TerminalMotionProfile.ReconstructStartCoverage"/> to full in equal discrete steps,
        /// one per terminal step (P3–P4). Never interpolated — a block is absent or it is complete.
        /// Interrupting it leaves the image fully resolved.
        /// </summary>
        public static Sequence Reconstruct(Material stageMaterial, TerminalMotionProfile profile)
        {
            if (stageMaterial == null || profile == null)
            {
                return null;
            }

            Kill(stageMaterial);

            float start = profile.ReconstructStartCoverage;
            int steps = profile.ReconstructSteps;

            stageMaterial.SetFloat(k_RasterStrengthId, 0f);
            stageMaterial.SetFloat(k_CoverageId, start);

            Sequence sequence = DOTween.Sequence().SetTarget(stageMaterial);

            for (int i = 1; i <= steps; i++)
            {
                float coverage = Mathf.Lerp(start, 1f, i / (float)steps);
                sequence.AppendInterval(profile.StepSeconds);
                sequence.AppendCallback(() => stageMaterial.SetFloat(k_CoverageId, coverage));
            }

            sequence.OnKill(() =>
            {
                if (stageMaterial != null)
                {
                    stageMaterial.SetFloat(k_CoverageId, 1f);
                }
            });

            return sequence;
        }

        /// <summary>
        /// Normal close: the element is gone this frame. The caller still owns deactivating the
        /// GameObject afterwards.
        /// </summary>
        public static void HardCut(CanvasGroup group)
        {
            if (group == null)
            {
                return;
            }

            Kill(group);
            group.alpha = 0f;
        }

        /// <summary>
        /// Cancels motion targeting one component. Every verb's completed state is applied on kill,
        /// so a cancelled element is left readable rather than half-written.
        /// </summary>
        public static void Kill(Component target)
        {
            if (target == null)
            {
                return;
            }

            DOTween.Kill(target);
        }

        /// <summary>
        /// Cancels motion targeting one stage material. Separate overload because the image-side verbs
        /// drive a <see cref="Material"/>, which is not a <see cref="Component"/>.
        /// </summary>
        public static void Kill(Material target)
        {
            if (target == null)
            {
                return;
            }

            DOTween.Kill(target);
        }

        /// <summary>
        /// Resolves the <see cref="CanvasGroup"/> a verb drives, adding one if the prefab has none.
        /// Lets presenters animate without anyone hand-editing scene or prefab YAML.
        /// </summary>
        public static CanvasGroup EnsureCanvasGroup(GameObject target)
        {
            if (target == null)
            {
                return null;
            }

            CanvasGroup group = target.GetComponent<CanvasGroup>();

            if (group == null)
            {
                group = target.AddComponent<CanvasGroup>();
            }

            return group;
        }
    }
}

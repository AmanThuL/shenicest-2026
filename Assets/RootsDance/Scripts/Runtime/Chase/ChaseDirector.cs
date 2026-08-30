using System;
using System.Threading;
using RootsDance.App;
using RootsDance.Cameras;
using RootsDance.Core;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Chase
{
    /// <summary>
    /// Runs one leg of the wrong-cycle chase. On <see cref="WorldFlags.k_ChaseStarted"/> it births
    /// the boss at its spawn point, arms the chase-only triggers, turns the panic camera on and
    /// fires the scripted shoulder checks; on <see cref="WorldFlags.k_ChaseEscaped"/> — the car
    /// coming into view — it stands everything down.
    /// <para>
    /// One director sits in each gameplay scene the chase crosses. The greenhouse leg starts from
    /// the flag event; the forest leg cannot (its scene loads after the flag was raised, and a flag
    /// only fires its event once), so a director given a <c>Resume Spawn</c> reads the ground truth
    /// once the bootstrap is up and, mid-chase, moves the player there and carries straight on.
    /// </para>
    /// <para>
    /// It drives <see cref="PanicViewShake"/> through references rather than flags because the
    /// shoulder check repeats: a world flag can only ever fire once.
    /// </para>
    /// </summary>
    public class ChaseDirector : MonoBehaviour
    {
        [Header("Listens to")]
        [Tooltip("The bootstrap's FlagRaised channel.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Header("Cast")]
        [Tooltip("This scene's panic camera extension, on the first-person CinemachineCamera.")]
        [SerializeField] private PanicViewShake m_panicShake;

        [Tooltip("The boss. Kept inactive in the scene until the chase starts.")]
        [SerializeField] private ChaseMonster m_monster;

        [Tooltip("Where the boss appears when this leg starts.")]
        [SerializeField] private Transform m_monsterSpawn;

        [Tooltip("The Player root: pursuit target, and what gets moved on a resume.")]
        [SerializeField] private Transform m_player;

        [Tooltip("Chase-only objects — the exit portal, the victory volume — switched on when the "
            + "chase starts. Keep them inactive in the scene so normal play never touches them.")]
        [SerializeField] private GameObject[] m_armWhenChasing = new GameObject[0];

        [Header("Opening")]
        [Tooltip("Seconds the rooted form holds before it tears free and the pursuit begins.")]
        [Min(0f)]
        [SerializeField] private float m_birthSeconds = 1.1f;

        [Tooltip("Seconds after the chase starts at which the camera checks over its shoulder. "
            + "Repeats are why this is not a world flag.")]
        [SerializeField] private float[] m_lookBackDelays = { 2.5f, 10f };

        [Header("Resume")]
        [Tooltip("Set only in the scene the chase continues into after a level switch: the player "
            + "is moved here when the scene loads mid-chase. Leave empty where the chase starts.")]
        [SerializeField] private Transform m_resumeSpawn;

        [Header("Stand-down")]
        [Tooltip("Seconds after the escape before the boss is hidden. It stops immediately; this "
            + "just keeps it from vanishing while it could still be on screen.")]
        [Min(0f)]
        [SerializeField] private float m_despawnSeconds = 4f;

        private bool m_isChasing;
        private bool m_resumeChecked;

        /// <summary>True between the start of this leg and the escape.</summary>
        public bool IsChasing => m_isChasing;

        private void OnEnable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised += OnFlagRaised;
            }
        }

        private void OnDisable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised -= OnFlagRaised;
            }
        }

        private void Update()
        {
            // The resume check lives in Update because WorldAccess may not exist yet in OnEnable;
            // it runs exactly once, on the first frame the bootstrap answers.
            if (m_resumeChecked || m_isChasing)
            {
                return;
            }

            IWorldStateReader state = WorldAccess.State;

            if (state == null)
            {
                return;
            }

            m_resumeChecked = true;

            if (state.HasFlag(WorldFlags.k_ChaseStarted) && !state.HasFlag(WorldFlags.k_ChaseEscaped))
            {
                // The rescue loader has already placed the player at the selected checkpoint.
                // Normal cross-level chase continuation still uses its authored portal spawn.
                bool isRescue = GameBootstrap.Instance != null
                    && GameBootstrap.Instance.RescueService != null
                    && GameBootstrap.Instance.RescueService.IsBusy;

                if (m_resumeSpawn != null && !isRescue)
                {
                    MovePlayerTo(m_resumeSpawn);
                }

                StartChase(skipBirth: true);
            }
        }

        private void OnFlagRaised(string flagId)
        {
            if (flagId == WorldFlags.k_ChaseStarted)
            {
                StartChase();
            }

            if (flagId == WorldFlags.k_ChaseEscaped)
            {
                EndChase();
            }
        }

        /// <summary>Starts this leg of the chase. Harmless to call twice.</summary>
        public void StartChase()
        {
            StartChase(skipBirth: false);
        }

        /// <summary>
        /// A resumed leg skips the birth: the boss was already up and running when the level
        /// switched, so it appears in the uprooted form and pursues immediately.
        /// </summary>
        private void StartChase(bool skipBirth)
        {
            if (m_isChasing)
            {
                return;
            }

            m_isChasing = true;

            for (int i = 0; i < m_armWhenChasing.Length; i++)
            {
                if (m_armWhenChasing[i] != null)
                {
                    m_armWhenChasing[i].SetActive(true);
                }
            }

            if (m_monster != null && m_monsterSpawn != null)
            {
                m_monster.transform.SetPositionAndRotation(
                    m_monsterSpawn.position, m_monsterSpawn.rotation);
                m_monster.gameObject.SetActive(true);

                if (!skipBirth)
                {
                    m_monster.ShowRooted();
                }
            }

            if (m_panicShake != null)
            {
                m_panicShake.SetPanic(true);
            }

            RunOpeningEntryAsync(skipBirth ? 0f : m_birthSeconds, destroyCancellationToken);
        }

        private void EndChase()
        {
            if (!m_isChasing)
            {
                return;
            }

            m_isChasing = false;

            if (m_panicShake != null)
            {
                m_panicShake.SetPanic(false);
            }

            if (m_monster != null)
            {
                m_monster.StopPursuit();
            }

            DespawnEntryAsync(destroyCancellationToken);
        }

        private async void RunOpeningEntryAsync(float birthSeconds, CancellationToken cancellationToken)
        {
            try
            {
                float elapsed = 0f;

                if (birthSeconds > 0f)
                {
                    await Awaitable.WaitForSecondsAsync(birthSeconds, cancellationToken);
                    elapsed = birthSeconds;
                }

                if (m_isChasing && m_monster != null && m_player != null)
                {
                    m_monster.BeginPursuit(m_player);
                }

                for (int i = 0; i < m_lookBackDelays.Length; i++)
                {
                    float wait = m_lookBackDelays[i] - elapsed;

                    if (wait > 0f)
                    {
                        await Awaitable.WaitForSecondsAsync(wait, cancellationToken);
                        elapsed = m_lookBackDelays[i];
                    }

                    if (!m_isChasing)
                    {
                        return;
                    }

                    if (m_panicShake != null)
                    {
                        m_panicShake.LookBack();
                    }
                }
            }
            catch (OperationCanceledException)
            {
                // Scene unloaded mid-chase (the portal fired): nothing to do.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
        }

        private async void DespawnEntryAsync(CancellationToken cancellationToken)
        {
            try
            {
                if (m_despawnSeconds > 0f)
                {
                    await Awaitable.WaitForSecondsAsync(m_despawnSeconds, cancellationToken);
                }

                if (!m_isChasing && m_monster != null)
                {
                    m_monster.gameObject.SetActive(false);
                }
            }
            catch (OperationCanceledException)
            {
                // Object destroyed: nothing to do.
            }
        }

        /// <summary>Moves the player root, working around CharacterController's transform lock.</summary>
        private void MovePlayerTo(Transform spawn)
        {
            if (m_player == null)
            {
                return;
            }

            CharacterController controller = m_player.GetComponent<CharacterController>();
            bool wasEnabled = controller != null && controller.enabled;

            if (wasEnabled)
            {
                controller.enabled = false;
            }

            m_player.SetPositionAndRotation(
                spawn.position, Quaternion.Euler(0f, spawn.eulerAngles.y, 0f));

            if (wasEnabled)
            {
                controller.enabled = true;
            }

            Physics.SyncTransforms();
        }
    }
}

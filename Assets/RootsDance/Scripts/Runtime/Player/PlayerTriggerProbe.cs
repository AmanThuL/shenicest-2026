using UnityEngine;

namespace RootsDance.Player
{
    /// <summary>
    /// Marker for the child object that carries the player's trigger detection: a collider plus a
    /// kinematic Rigidbody, on its own layer, colliding with nothing but trigger volumes.
    /// It exists so trigger detection does not depend on CharacterController behaviour — changing a
    /// CharacterController property at runtime recreates it and drops its existing trigger contacts.
    /// The Rigidbody lives here, on a child, so the player root still has only a CharacterController.
    /// </summary>
    [RequireComponent(typeof(Rigidbody))]
    public class PlayerTriggerProbe : MonoBehaviour
    {
        private void Awake()
        {
            Rigidbody body = GetComponent<Rigidbody>();
            body.isKinematic = true;
            body.useGravity = false;
        }
    }
}

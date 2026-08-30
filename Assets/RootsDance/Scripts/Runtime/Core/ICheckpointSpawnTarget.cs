using UnityEngine;

namespace RootsDance.Core
{
    /// <summary>Applied during scene initialization, before Start and the first physics step.</summary>
    public interface ICheckpointSpawnTarget
    {
        Transform SpawnTransform { get; }
        void ApplyCheckpoint(Vector3 position, float yaw);
    }
}

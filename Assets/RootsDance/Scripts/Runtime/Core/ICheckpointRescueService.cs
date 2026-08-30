using System;
using System.Threading;
using RootsDance.Data;
using UnityEngine;

namespace RootsDance.Core
{
    public interface ICheckpointRescueService
    {
        RescueCheckpointCatalogSO Catalog { get; }
        bool IsBusy { get; }
        bool IsModalOpen { get; set; }
        string CurrentLevelName { get; }
        string LastCheckpointId { get; }
        string LastCheckpointLabel { get; }
        event Action Changed;
        event Action<string> Failed;
        bool TryValidate(RescueCheckpoint checkpoint, out string error);
        Awaitable JumpAsync(RescueCheckpoint checkpoint, CancellationToken cancellationToken);
    }
}

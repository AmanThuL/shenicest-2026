---
title: "patterns demo: BaseEventSO.cs"
source_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/Scripts/ScriptableObjects/EventMessages/BaseEventSO.cs"
final_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/Scripts/ScriptableObjects/EventMessages/BaseEventSO.cs"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "source"
---

# patterns demo: BaseEventSO.cs

```cs
using UnityEngine;
using System;

namespace DesignPatterns.Events
{
    /// <summary>
    /// Base class for ScriptableObject-based event messages. This can wrap around a static delegate for
    /// easier serialization. Use the public Action to add external listeners.
    /// </summary>
	public abstract class BaseEventSO : DescriptionSO
    {
        /// <summary>
        /// Listeners can subscribe to this Action
        /// </summary>
        public event Action EventRaised;

        [Space]
        [Space]
        [SerializeField] protected bool m_DebugLog;

        // Constructor
        public BaseEventSO()
        {
            // Initialize the EventRaised with an empty delegate
            EventRaised += () => { };
        }

        // Event-raising method
        public virtual void OnEventRaised()
        {
            EventRaised?.Invoke();
        }
    }
}
```

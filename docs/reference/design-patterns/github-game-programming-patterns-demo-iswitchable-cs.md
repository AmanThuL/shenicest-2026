---
title: "patterns demo SOLID: ISwitchable.cs"
source_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/_SOLID/5_DependencyInversion/Scripts/ISwitchable.cs"
final_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/_SOLID/5_DependencyInversion/Scripts/ISwitchable.cs"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "source"
---

# patterns demo SOLID: ISwitchable.cs

```cs
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace DesignPatterns.DIP
{
    /// <summary>
    /// Defines a contract for switchable objects. This interface helps implement the Dependency Inversion Principle (DIP)
    /// by abstracting the details of activating and deactivating objects.
    /// </summary>
    public interface ISwitchable 
    {
        public bool IsActive { get; }

        public void Activate();
        public void Deactivate();
    }
}

```

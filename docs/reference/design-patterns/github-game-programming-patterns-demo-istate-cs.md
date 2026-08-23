---
title: "patterns demo: IState.cs"
source_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/_DesignPatterns/5_State/Scripts/Pattern/SimpleStateMachine/IState.cs"
final_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/_DesignPatterns/5_State/Scripts/Pattern/SimpleStateMachine/IState.cs"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "source"
---

# patterns demo: IState.cs

```cs
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace DesignPatterns.StatePattern
{
    public interface IState: IColorable
    {
        public void Enter()
        {
            // code that runs when we first enter the state
        }

        public void Execute()
        {
            // per-frame logic, include condition to transition to a new state
        }

        public void Exit()
        {
            // code that runs when we exit the state
        }
    }
}

```

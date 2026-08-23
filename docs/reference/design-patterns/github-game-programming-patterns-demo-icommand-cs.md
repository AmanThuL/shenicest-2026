---
title: "patterns demo: ICommand.cs"
source_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/_DesignPatterns/4_Command/Scripts/Pattern/ICommand.cs"
final_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/_DesignPatterns/4_Command/Scripts/Pattern/ICommand.cs"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "source"
---

# patterns demo: ICommand.cs

```cs
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace DesignPatterns.Command
{
    // interface to wrap your actions in a "command object"
    public interface ICommand
    {
        public void Execute();
        public void Undo();
    }
}
```

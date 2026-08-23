---
title: "patterns demo: Subject.cs"
source_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/_DesignPatterns/6_Observer/Scripts/Pattern/Subject.cs"
final_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/_DesignPatterns/6_Observer/Scripts/Pattern/Subject.cs"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "source"
---

# patterns demo: Subject.cs

```cs
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

namespace DesignPatterns.Observer
{
    public class Subject: MonoBehaviour
    {
        // define an event with your own delegate
        //public delegate void ExampleDelegate();
        //public static event ExampleDelegate ExampleEvent;

        //... or just use the System.Action
        public event Action ThingHappened;

        // invoke the event to broadcast to any listeners/observers
        public void DoThing()
        {
            ThingHappened?.Invoke();
        }
    }
}


```

---
title: "Example scripts for collider events"
page_title: "Unity - Manual: Example scripts for collider events"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-example-scripts.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-example-scripts.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Example scripts for collider events

The following examples demonstrate ways to call events from collision functions. They use `OnCollisionEnter` and `OnTriggerEnter` respectively, but the concepts apply to all `OnCollision` and `OnTrigger` functions.

## Example: Different events for different GameObject properties

You can configure your scripts to trigger different events based on the properties of the other collider’s associated GameObject, such as its name or tag. This is useful if, for example, you want to allow some colliders to produce an event, but not others.

The following example prints a different message depending on whether the other collider that has touched this collider has a tag of “Player” or “Enemy”.

``` lang-cs
using UnityEngine;
using System.Collections;

public class DoorObject : MonoBehaviour

        if (other.CompareTag("Enemy"))
        
    }
}
```

## Example: Send an event message every physics update

The following example uses a trigger collider to produce a hoverpad. The trigger collider is positioned directly on top of a hoverpad GameObject, and applies a constant upward force to any GameObject within its trigger.

``` lang-cs
using UnityEngine;
using System.Collections;

public class HoverPad : MonoBehaviour

}
```

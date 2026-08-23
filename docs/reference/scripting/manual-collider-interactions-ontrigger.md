---
title: "OnTrigger events"
page_title: "Unity - Manual: OnTrigger events"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-ontrigger.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-ontrigger.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# OnTrigger events

Trigger colliders don’t cause collisions. Instead, they detect other colliders that pass through them, and call functions that you can use to initiate events.

Example uses for triggers include:

-   When the player reaches a specific area at the end of a corridor, activate a cinematic cutscene.
-   When the player character walks within a space in front of a sliding door, trigger an animation to open the door.
-   When projectiles pass through a trigger collider in the far distance, disable or destroy the projectile.

Working with trigger colliders primarily involves the following API functions:

-   [`Collider.OnTriggerEnter`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider.OnTriggerEnter.html): Unity calls this function on a trigger collider when it first makes contact with another collider.
-   [`Collider.OnTriggerStay`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider.OnTriggerStay.html): Unity calls this function on a trigger collider once per frame if it detects another Collider inside the trigger collider.
-   [`Collider.OnTriggerExit`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider.OnTriggerExit.html): Unity calls this function on a trigger collider when it ceases contact with another collider.

The following example prints a message to the Console when Unity calls each function.

``` lang-cs
using UnityEngine;
using System.Collections;

public class DoorObject : MonoBehaviour

    void OnTriggerStay (Collider other)
    
    void OnTriggerExit (Collider other)
    
}
```

For examples of practical applications for `OnTrigger` events, see [Example scripts for collider events](https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-example-scripts.html).

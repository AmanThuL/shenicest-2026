---
title: "Unity NavMesh (Unity Learn)"
page_title: "Unity NavMesh"
source_url: "https://learn.unity.com/course/unity-for-artists-curricular-framework-resources/tutorial/unity-navmesh"
final_url: "https://learn.unity.com/course/unity-for-artists-curricular-framework-resources/tutorial/unity-navmesh"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Unity NavMesh

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# Unity NavMesh

Tutorial

Beginner

+0XP

35m

864

\(678\)

Unity Technologies

![Unity NavMesh](https://connect-mediagw.unity.com/h1/20190130/p/images/bf3da1d9-5a11-4b34-9d03-27bbe143f7b5)

Summary

Learn how to create AI pathfinding using the Unity NavMesh components!  
This video was produced by Brackeys.

Resources

-   

    <a href="https://github.com/Brackeys/NavMesh-Tutorial" class="link-primary link-primary bodyS">NavMesh Tutorial Project Assets</a>

    

-   

    <a href="https://unity-connect-prd.storage.googleapis.com/20201207/38b9b6de-97ce-4716-81a5-29b2f3669a71/NavMesh-Tutorial-master.zip" class="link-primary link-primary bodyS">NavMesh-Tutorial-master.zip</a>

    

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Basics

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Learn how to create AI pathfinding using the Unity NavMesh components!

This video was produced by Brackeys.

Download the Example Project <a href="https://github.com/Brackeys/NavMesh-Tutorial" class="link-primary text-inherit">here</a>.

#### PlayerController

```
using UnityEngine;
using UnityEngine.AI;

public class PlayerController : MonoBehaviour 
        }
    }
}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Making it Dynamic

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Learn how to update your NavMesh at runtime!

This video was produced by Brackeys.

#### ObstacleAnimation

```
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObstacleAnimation : MonoBehaviour 
    // Update is called once per frame
    void Update () 
}
```

#### LevelGenerator

```
using UnityEngine;

public class LevelGenerator : MonoBehaviour 
    // Create a grid based level
    void GenerateLevel()
    {
        // Loop over the grid
        for (int x = 0; x <= width; x+=2)
        {
            for (int y = 0; y <= height; y+=2)
            {
                // Should we place a wall?
                if (Random.value > .7f)
                {
                    // Spawn a wall
                    Vector3 pos = new Vector3(x - width / 2f, 1f, y - height / 2f);
                    Instantiate(wall, pos, Quaternion.identity, transform);
                } else if (!playerSpawned) // Should we spawn a player?
                
            }
        }
    }
}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Animated Character

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Learn how to link together surfaces and how to add an animated character to our Agent.

This video was produced by Brackeys.

#### PlayerController

```
using UnityEngine;
using UnityEngine.AI;
using UnityStandardAssets.Characters.ThirdPerson;

public class PlayerController : MonoBehaviour 
    // Update is called once per frame
    void Update () 
    
        }

        if (agent.remainingDistance > agent.stoppingDistance)
        
        else
        
    }
}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete

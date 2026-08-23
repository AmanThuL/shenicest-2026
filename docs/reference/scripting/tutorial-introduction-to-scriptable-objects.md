---
title: "Introduction to Scriptable Objects (Unity Learn)"
page_title: "Introduction to Scriptable Objects"
source_url: "https://learn.unity.com/tutorial/introduction-to-scriptable-objects"
final_url: "https://learn.unity.com/tutorial/introduction-to-scriptable-objects"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to Scriptable Objects

![](https://learn.unity.com/_next/static/media/tutorial-coverImage-bg.8fcd34a7.jpeg)

# Introduction to Scriptable Objects

Tutorial

Beginner

+10XP

1h 5m

809

\(410\)

Unity Technologies

![Introduction to Scriptable Objects](https://connect-mediagw.unity.com/h1/20190531/learn/images/3de1ae8d-9158-446b-8391-8ef77380c8ec_Screen_Shot_2019_05_31_at_12.53.16_PM.png)

Summary

Scriptable Objects are amazing data containers. They don't need to be attached to a GameObject in a scene. They can be saved as assets in our project. Most often, they are used as assets which are only meant to store data, but can also be used to help serialize objects and can be instantiated in our scenes. We won't cover serialization in depth in this session, but will just touch on the subject and how Scriptable Objects can help us. We will cover not only what Scriptable Objects are, but show some very simple examples using Scriptable Objects.

Resources

-   

    <a href="https://blogs.unity3d.com/2014/06/24/serialization-in-unity/" class="link-primary link-primary bodyS">Unity Blog - Serialization in Unity</a>

    

-   

    <a href="https://learn.unity.com/tutorial/persistence-saving-and-loading-data" class="link-primary link-primary bodyS">Learn - Persistence: Saving and Loading Data</a>

    

Languages available:

EnglishEnglish日本語

<span id="react-aria-«R1ahmpmH7»">English</span><span class="pl-2"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Introduction to Scriptable Objects - February 2016 Live Training

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

#### MyScriptableObjectClass

```
using UnityEngine;
using System.Collections;

[CreateAssetMenu(fileName = "Data", menuName = "Inventory/List", order = 1)]
public class MyScriptableObjectClass : ScriptableObject 
```

#### UseMyScriptableObject

```
using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class UseMyScriptableObject : MonoBehaviour 
            else 
            
            myLights.Add (myLight.GetComponent<Light>());
        }
    }

    // Update is called once per frame
    void Update () 
        }
        if (Input.GetButtonDown("Fire2"))
        
    }

    void UpdateLights () 
    
    }
}
```

#### MakeScriptableObject

```
using UnityEngine;
using System.Collections;
using UnityEditor;

public class MakeScriptableObject 
}
```

#### InventoryItem

```
using UnityEngine;
using System.Collections;

[System.Serializable]                         //    Our Representation of an InventoryItem
public class InventoryItem 

```

#### InventoryItemList

```
using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class InventoryItemList : ScriptableObject 

```

#### InventoryItemEditor

```
using UnityEngine;
using UnityEditor;
using System.Collections;
using System.Collections.Generic;

public class InventoryItemEditor : EditorWindow 
    void  OnEnable () 
    }

    void  OnGUI () 
        }
        if (GUILayout.Button("Open Item List")) 
        
        if (GUILayout.Button("New Item List")) 
        
        GUILayout.EndHorizontal ();

        if (inventoryItemList == null) 
        
            if (GUILayout.Button("Open Existing Item List", GUILayout.ExpandWidth(false))) 
            
            GUILayout.EndHorizontal ();
        }

            GUILayout.Space(20);

        if (inventoryItemList != null) 
        
            GUILayout.Space(5);
            if (GUILayout.Button("Next", GUILayout.ExpandWidth(false))) 
            
            }

            GUILayout.Space(60);

            if (GUILayout.Button("Add Item", GUILayout.ExpandWidth(false))) 
            
            if (GUILayout.Button("Delete Item", GUILayout.ExpandWidth(false))) 
            
            GUILayout.EndHorizontal ();
            if (inventoryItemList.itemList == null)
                Debug.Log("Inventory is empty");
            if (inventoryItemList.itemList.Count > 0) 
            
            else 
            
        }
        if (GUI.changed) 
        
    }

    void CreateNewItemList () 
    
    }

    void OpenItemList () 
    
        }
    }

    void AddItem () 
    
    void DeleteItem (int index) 
    
}
```

#### CreateInventoryItemList

```
using UnityEngine;
using System.Collections;
using UnityEditor;

public class CreateInventoryItemList 
}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete

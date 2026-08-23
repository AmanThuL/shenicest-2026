---
title: "Assign tags to GameObjects"
page_title: "Unity - Manual: Assign tags to GameObjects"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/Tags.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/Tags.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Assign tags to GameObjects

A tag is a reference word which you can assign to one or more **GameObjects**. For example, you might define “Player” tags for player-controlled characters and an “Enemy” tag for non-player-controlled characters. You might define items the player can collect in a Scene with a “Collectable” tag. You can use any word you want as a tag. You can even use short phrases, but you might need to widen the Inspector to see the tag’s full name. A GameObject can only have one tag assigned to it.

Tags help you identify GameObjects for scripting purposes. They ensure you don’t need to manually add GameObjects to a script’s exposed properties with drag and drop, so you save time when you use the same script code in multiple GameObjects.

Tags are useful for triggers in [Collider](https://docs.unity3d.com/6000.3/Documentation/Manual/CollidersOverview.html) control scripts that need to determine if the player interacts with an enemy, a prop, or a collectable, for example.

You can use the [GameObject.FindWithTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.FindWithTag.html) function to find any GameObject that contains a tag you specify. The following example uses `GameObject.FindWithTag()`. It instantiates `respawnPrefab` at the location of GameObjects with the “Respawn” tag.

``` lang-cs
using UnityEngine;
using System.Collections;

public class Example : MonoBehaviour 
}
```

## Create new Tags

The **Inspector** displays the **Tag** and **Layer** dropdown menus below the name of a GameObject.

To create a new tag, select **Add Tag…**. This opens the [Tag and Layer Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TagManager.html) in the Inspector. Once you name a tag, it can’t be renamed later.

Layers are similar to tags, but are used to define how Unity renders GameObjects in the Scene. Refer to documentation on the [Layers](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html) page for more information.

## Apply a Tag

The **Inspector** shows the **Tag** and **Layer** dropdown menus just below the name of a GameObject. To apply an existing tag to a GameObject, open the **Tags** dropdown and choose the tag you want to apply. The GameObject is now associated with this tag.

## Understand built-in tags

The Editor includes the following built-in tags which don’t appear in the Tag Manager:

-   **Untagged**
-   **Respawn**
-   **Finish**
-   **EditorOnly**
-   **MainCamera**
-   **Player**
-   **GameController**

Some built-in tags like **MainCamera** and **EditorOnly** have unique functions.

The Editor caches GameObjects tagged with the **MainCamera** tag internally. When you access [Camera.main](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera-main.html), the Editor returns the first valid result from its cache. Refer to [Camera.main](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera-main.html) to learn more.

A GameObject tagged with **EditorOnly** in a Scene is destroyed when the game builds. Any child GameObjects of a GameObject tagged with **EditorOnly** are also destroyed when the game builds.

## Additional resources

-   [Camera.main](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera-main.html)
-   [Introduction to collision](https://docs.unity3d.com/6000.3/Documentation/Manual/CollidersOverview.html)
-   [GameObject.FindWithTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.FindWithTag.html)
-   [Layers](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html)

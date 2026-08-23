---
title: "Deactivate GameObjects"
page_title: "Unity - Manual: Deactivate GameObjects"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/DeactivatingGameObjects.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/DeactivatingGameObjects.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Deactivate GameObjects

To temporarily remove a GameObject from your scene, you can mark the GameObject as inactive.

To do this, navigate to the Inspector window and clear the checkbox to the left of the GameObject’s name. The names of deactivated GameObjects appear faded in the Hierarchy window.

To deactivate a GameObject through script, use the [SetActive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SetActive.html) method. To see if an object is active or inactive, check the [activeSelf](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeSelf.html) property.

If you deactivate a GameObject, coroutines attached to it are stopped.

## Deactivate a parent GameObject

If you deactivate a parent GameObject, you also deactivate all of its child GameObjects because the deactivation overrides the `activeSelf` setting on all child GameObjects. The child GameObjects return to their original state when you reactivate the parent.

To know if a child GameObject is active in your scene, use the [activeInHierarchy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeInHierarchy.html) property.

**Note:** The `activeSelf` property is not always accurate if you check a child GameObject because even if it is set to active, you might have set one of its parent GameObjects to inactive.

![The selected GameObject (Cube) is set as active, but remains inactive until you set its parent GameObject to active.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/deactivating2.png)

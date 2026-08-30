---
title: "Modify volume effects at runtime"
page_title: "Volume Scripting API | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Volume Scripting API

In the High Definition Render Pipeline (HDRP), [Volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) control environment settings in a scene. To give you control over Volumes at runtime, HDRP provides API that you can use to create, access, and edit Volumes via C# scripting. This page describes how to use the scripting API and provides examples to help you get started. You may notice that Volume Overrides, such as [Fog](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/fog-volume-override-reference.html), actually inherit from the VolumeComponent class. The documentation calls these Volume Overrides and not Volume Components to be consistent with the user interface and to avoid confusion with the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) component.

## Modify an existing Volume

Volumes store their [Volume Overrides](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/volume-component.html) in a [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html). To modify the properties of a Volume Override you need to retrieve the Volume Profile. You can do this in the following ways:

- [Access a shared Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#shared-volume-profile)

- [Access an owned Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html#owned-volume-profile)

<span id="shared-volume-profile"></span>

### Access a shared Volume Profile

One method is to access the Volume's shared Profile. You do this via the Volume's `sharedProfile` property. This gives you a reference to the instance of the Volume Profile asset. If you modify this Volume Profile:

- HDRP applies any changes you make to every Volume that uses this Volume Profile asset.

- The modifications you make affect the actual Volume Profile asset which means they do not reset when you exit Play mode

Note the `sharedProfile` property can return `null` if the Volume does not reference a Volume Profile asset.

<span id="owned-volume-profile"></span>

### Access an owned Volume Profile

The other method is to clone the Volume Profile asset. The advantage of this is that your modifications only affect the Volume component you clone the Volume Profile from and don't affect any other Volumes that use the same Volume Profile asset. To do this, use the Volume's `profile` property. This returns a reference to a new instance of a Volume Profile (if not already created). If you were already modifying the Volume's `sharedProfile`, any changes you made are copied over to the new instance. If you modify this Volume Profile:

- HDRP only applies changes to the particular Volume.
- The modification you make reset when you exit Play mode.
- It is your responsibility to destroy the duplicate Volume Profile when you no longer need it.

Note that you can use this property to assign a different Volume Profile to the Volume.

<span id="changing-volume-profile-properties"></span>

## Change Volume Profile properties

When you have a reference to the Volume Profile, you can change the properties of any Volume Overrides in it. This works in a similar way as changing properties in the Inspector.

First, you need to retrieve the particular Volume Override using the generic `TryGet<>` function on the profile. If the Volume Profile does not contain that particular Volume Override and the `TryGet<>` function returns false, you can use the `Add<>` function to add the Volume Override.

When you have a reference to the Volume Override, you can access and modify its public properties. For a property to have an effect on the scene, you need to specify that it has been overridden. This makes HDRP use the value you specify, rather than using the default value. Every property in a Volume Override is made up of two parts:

- A bool that contains the override state. This is `overrideState`.
- The property's value itself. This is `value`.

After you set a property's `overrideState` to true, you can then change the `value`.

The following example changes the `enabled` property of the [Fog](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/fog-volume-override-reference.html) Volume Override:

    using UnityEngine.Rendering;
    using UnityEngine.Rendering.HighDefinition;

    public Volume m_Volume;
    public bool enableFog;
    public bool overrideFog;

    VolumeProfile profile = m_Volume.sharedProfile;
    if (!profile.TryGet<Fog>(out var fog))
    
    fog.enabled.overrideState = overrideFog;
    fog.enabled.value = enableFog;

## Fade Volumes

Distance-based Volume blending is useful for many design use-cases, but you may want to manually trigger a fade in/out effect based on an event in your application. To do this, update the `weight` property of the Volume. The example below changes the weight property over time in the `Update` method of a `MonoBehaviour`. It fades the Volume in and out based on the Sin of the time since the application started, but you can use any method to update the `weight`:

    using UnityEngine;
    using UnityEngine.Rendering;

    public class VolumeWeightSin : MonoBehaviour
    
        }
    }

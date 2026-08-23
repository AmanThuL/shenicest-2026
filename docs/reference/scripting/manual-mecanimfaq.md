---
title: "Mecanim FAQ"
page_title: "Unity - Manual: Mecanim FAQ"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/MecanimFAQ.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/MecanimFAQ.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Mecanim FAQ

## General questions

**What’s the difference between the Animation window and the Animator window?**

Use the **Animation Window** to create and edit animation clips within Unity. You can use it to animate almost every property that you can edit in the inspector, from a Game Object’s position, a material color, a light’s brightness, a sound’s volume, and even arbitrary values in your own scripts.

Use the **Animator Window** to organize your existing animation clip assets into a flowchart-like system called a state machine.

Both of these windows are part of the Mecanim Animation system, and not the Legacy Animation system.

**We use the Legacy Animation system for character animations. Should we use the Mecanim Animation system instead?**

Generally, yes you should since most character animations are more complex.

## Import

**Why does my imported mesh have an animator component attached to it?**

When Unity detects that an imported file has animation, it will add an animation component on import. You can modify this in the asset’s import settings by setting the Animation Type to `None` in the import settings under the Rig tab. You can do this with several files at once.

## Layers

**Does the ordering of the layers matter?**

Yes. Layers are evaluated from top to bottom in order. Layers set to override will always override the previous layers (based on their mask, if they have a mask).

**Should the weight value of the base layer always be set to one or should the weight be zero when using another layer?**

The base layer weight is always 1 and override layers will completely override the base layer.

**Is there any way to get a variable value from the controller without using the name string?**

You can use integers to identify the states and parameters. Use the [Animator.StringToHash](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StringToHash.html) function to get the integer identifier values. For example:

``` lang-cs
runState = Animator.StringToHash("Base Layer.Run");
animator.SetBool(runState, false);
```

**What happens if a state on a Sync layer has a different length compared to the corresponding state in the base layer?**

If layers are of different lengths, they will become unsynchronized. Enable the Timing option to force the timing of the states on the current layer, on the source layer.

## Avatar Masks

**Is there a way to create AvatarIKGoals other than LeftFoot, RightFoot, LeftHand, RightHand?**

Yes, knee and elbow IK is supported.

**Is there a way to define what transforms are part of the Avatar Mask?**

Yes, for Generic clips you can define which transform animation is imported or not. For Humanoid clips, all human transforms are always imported and extra transforms can be defined.

## Animations curves

**How do animations that have Curves blend with those that don’t?**

When you have an animation with a curve and another animation without a curve, Unity will use the default value of the parameter connected to the curve to do blending. You can set default values for your parameters, so when blending takes place between a State that has a Curve Parameter and one that does not have one, it will blend between the curve value and the default parameter value. To set a default value for a Parameter, simply set its value in the Animator Tool window while not in LiveLink.

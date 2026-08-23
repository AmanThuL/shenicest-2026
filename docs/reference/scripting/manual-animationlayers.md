---
title: "Animation Layers"
page_title: "Unity - Manual: Animation Layers"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationLayers.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationLayers.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Animation Layers

Unity uses **Animation Layers** for managing complex state machines for different body parts. An example of this is if you have a lower-body layer for walking-jumping, and an upper-body layer for throwing objects / shooting.

You can manage animation layers from the **Layers** tab in the top-left corner of the **Animator Controller**.

![The Layers tab and gear icon](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/MecanimAnimationLayers.png)

Clicking the gear icon on the right of the window shows you the settings for this layer.

![The layer settings](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/MecanimAnimationLayers2.png)

On each layer, you can specify the mask and the Blending type. The mask specifies the body parts on which to apply the animation. The Blending type specifies how the animation is applied.

-   Select **Override** to use the animation on this layer, replacing the animation on previous layers.
-   Select **Additive** to add the animation on this layer on top of the animation from previous layers.  
    For additive blending to be successful, the animation on the additive layer must contain the same properties as the previous layers.

Add a new layer by pressing the **+**.

The **Mask** property is there to [specify the mask used on this layer](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AvatarMask.html). For example if you wanted to play a throwing animation on just the upper body of your model, while having your character also able to walk, run or stand still at the same time, you would use a mask on the layer which plays the throwing animation where the upper body sections are defined, like this:

![The **M** symbol in the Layers sidebar indicates that the layer has a mask applied.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AnimatorMaskOnLayer.png)

## Animation Layer syncing

Sometimes it is useful to be able to re-use the same state machine in different layers. For example if you want to simulate wounded behavior, and have wounded animations for walk / run / jump instead of the healthy ones. You can click the **Sync** checkbox on one of your layers, and then select the layer you want to sync with. The state machine structure will then be the same, but the actual animation clips used by the states will be distinct.

This means the Synced layer does not have its own state machine definition at all - instead, it is an instance of the source of the synced layer. Any changes you make to the layout or structure of the state machine in the synced layer view (eg, adding/deleting states or transitions) is done to the source of the synced layer. The only changes that are unique to the synced layer are the selected animations used within each state.

The Timing checkbox allows the animator to adjust how long each animation in synced layers takes, determined by the weight. If Timing is unselected then animations on the synced layer will be adjusted. The adjustment will be stretched to the length of the animation on the original layer. If the option is selected the animation length will be a balance for both animations, based on weight. In both cases (chosen and not chosen) the animator adjusts the length of the animations. If not chosen then the original layer is the sole master. If chosen, it is then a compromise.

![The `Fatigued` layer is synced with the base layer. The state machine structure is the same as the base layer. The animations used by each state are swapped for equivalent animations.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AnimatorSyncedLayer.png)

An **S** symbol in the Layers sidebar indicates that the layer is a synced layer.

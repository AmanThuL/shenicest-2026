---
title: "Unity 6.3 Manual: Humanoid Avatar"
page_title: "Unity - Manual: Humanoid Avatar"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AvatarCreationandSetup.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AvatarCreationandSetup.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Humanoid Avatar

Unity’s Animation System has special features for working with humanoid characters. Because humanoid characters are so common in games, Unity provides a specialized workflow, and an extended tool set for humanoid animations.

[The Avatar system](https://docs.unity3d.com/6000.3/Documentation/Manual/ConfiguringtheAvatar.html) is how Unity identifies that a particular animated model is a humanoid, and which parts of the model correspond to the legs, arms, head, and body.

Because of the similarity in bone structure between different humanoid characters, it is possible to map animations from one humanoid character to another.

![Unity’s Avatar structure](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AvatarIntro.jpg)

The following topics provide more details on humanoid animation and root motion:

| **Topic**                                                                                                                   | **Description**                                                                              |
|:----------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------|
| **[Retarget humanoid animation](https://docs.unity3d.com/6000.3/Documentation/Manual/Retargeting.html)**                    | Reuse humanoid clips on different models after you configure each Avatar.                    |
| **[Inverse Kinematics](https://docs.unity3d.com/6000.3/Documentation/Manual/InverseKinematics.html)**                       | Use inverse kinematics to pose joints from a fixed point.                                    |
| **[How Root Motion works](https://docs.unity3d.com/6000.3/Documentation/Manual/RootMotion.html)**                           | Learn how body and root transforms drive character motion from clips.                        |
| **[Scripting Root Motion](https://docs.unity3d.com/6000.3/Documentation/Manual/ScriptingRootMotion.html)**                  | Move characters from in-place clips using curves, controllers, and the `OnAnimatorMove` API. |
| **[Avatar Mapping tab reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Avatar.html)**                  | Reference for mapping bones to the humanoid Avatar.                                          |
| **[Avatar Muscle and Settings tab reference](https://docs.unity3d.com/6000.3/Documentation/Manual/MuscleDefinitions.html)** | Reference for muscle limits, previews, and range-of-motion settings on an Avatar.            |
| **[Avatar Mask window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AvatarMask.html)**              | Reference for masking humanoid body regions or transform paths in animation.                 |
| **[Human Template window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-HumanTemplate.html)**        | Reference for editing saved Human Template bone mappings.                                    |

## Additional resources

-   [Importing a model with humanoid animations](https://docs.unity3d.com/6000.3/Documentation/Manual/ConfiguringtheAvatar.html)
-   [Use Animation curves](https://docs.unity3d.com/6000.3/Documentation/Manual/animeditor-AnimationCurves.html)

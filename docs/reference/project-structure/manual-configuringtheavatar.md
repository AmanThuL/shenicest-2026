---
title: "Unity 6.3 Manual: Importing a model with humanoid animations"
page_title: "Unity - Manual: Importing a model with humanoid animations"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ConfiguringtheAvatar.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ConfiguringtheAvatar.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Importing a model with humanoid animations

This page contains guidance on importing a model for use with Unity’s [Animation System](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationOverview.html). For information on creating a model for use with the Animation System, see [Creating models for animation](https://docs.unity3d.com/6000.3/Documentation/Manual/UsingHumanoidChars.html).

The Animation System works with two types of models:

-   A **Humanoid** model is a specific structure, containing at least 15 bones organized in a way that loosely conforms to an actual human skeleton. This page contains guidance on importing this type of model.
-   A **Generic** model is everything else. This might be anything from a teakettle to a dragon. For information on importing this type of model, see [Importing a model with non-humanoid (generic) animations](https://docs.unity3d.com/6000.3/Documentation/Manual/GenericAnimations.html).

For general importing guidance that is applicable to all types of models, see [Importing a model](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingModelFiles.html).

## Overview

When Unity imports Model files that contain **Humanoid** Rigs and Animation, it needs to reconcile the bone structure of the Model to its Animation. It does this by mapping each bone in the file to a Humanoid Avatar so that it can play the Animation properly. For this reason, it is important to carefully prepare your Model file before importing into Unity.

1.  [Define the Rig type and create the Avatar](https://docs.unity3d.com/6000.3/Documentation/Manual/ConfiguringtheAvatar.html#AvatarSetup).
2.  [Correct or verify the Avatar’s mapping](https://docs.unity3d.com/6000.3/Documentation/Manual/ConfiguringtheAvatar.html#AvatarConfig).
3.  Once you are finished with the bone mapping, you can optionally click the **Muscles & Settings** tab to [tweak the Avatar’s muscle configuration](https://docs.unity3d.com/6000.3/Documentation/Manual/MuscleDefinitions.html).
4.  You can optionally [save the mapping of your skeleton’s bones to the Avatar](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Avatar.html#HumanTemplate) as a Human Template (.ht) file.
5.  You can optionally limit the animation that gets imported on certain bones by [defining an Avatar Mask](https://docs.unity3d.com/6000.3/Documentation/Manual/ConfiguringtheAvatar.html#AvatarMask).
6.  From the **Animation** tab, enable the **Import Animation** option and then set the other Asset-specific properties, .
7.  If the file consists of multiple animations or actions, you can [define specific action ranges as Animation Clips](https://docs.unity3d.com/6000.3/Documentation/Manual/Splittinganimations.html).
8.  For each Animation Clip defined in the file, you can:
    -   [Change the pose and root transform](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AnimationClip.html#ClipProperties)
    -   [Optimize looping](https://docs.unity3d.com/6000.3/Documentation/Manual/LoopingAnimationClips.html)
    -   **Mirror** the animation on both sides of the Humanoid skeleton.
    -   [Add curves to the clip](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationCurvesOnImportedClips.html) in order to animate the timings of other items
    -   [Add events to the clip](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationEventsOnImportedClips.html) in order to trigger certain actions in time with the animation
    -   [Discard part of the animation](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationMaskOnImportedClips.html) similar to using a runtime [Avatar Mask](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AvatarMask.html) but applied at import time
    -   [Select a different Root Motion Node](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AnimationClip.html#AllClipProperties) to drive the action from
    -   [Read any messages from Unity about importing the clip](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AnimationClip.html#ImportMessages)
    -   [Watch a preview of the animation clip](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AnimationClip.html#AnimationPreview)
9.  To save your changes, click the **Apply** button at the bottom of the **Import Settings** window or **Revert** to discard your changes.

<span id="AvatarSetup"></span>

## Set up the Avatar

From the [Rig tab of the Inspector window](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Rig.html), set the **Animation Type** to **Humanoid**. By default, the **Avatar Definition** property is set to **Create From This Model**. If you keep this option, Unity attempts to map the set of bones defined in the file to a Humanoid Avatar.

![Humanoid Rig](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/Rig-2.png)

In some cases, you can change this option to **Copy From Other Avatar** to use an Avatar you already defined for another Model file. For example, if you create a Mesh (skin) in your 3D modeling application with several distinct animations, you can export the Mesh to one FBX file, and each animation to its own FBX file. When you import these files into Unity, you only need to create a single Avatar for the first file you import (usually the Mesh). As long as all the files use the same bone structure, you can re-use that Avatar for the rest of the files (for example, all the animations).

If you enable this option, you must specify which Avatar you want to use by setting the **Source** property.

You can also change the maximum number of bones that can influence a given vertex with the [Skin Weights](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Rig.html#SkinWeights) property. By default, this property limits influence to four bones, but you can specify a different value.

When you click the **Apply** button, Unity tries to match up the existing bone structure to the Avatar bone structure. In many cases, it can do this automatically by analyzing the connections between bones in the rig.

If the match succeeds, a check mark appears next to the **Configure** menu. Unity also adds an Avatar sub-Asset to the Model Asset, which you can find in the Project view.

![Avatar appears as a sub-Asset of the imported Model](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/MecanimFBXNoAvatar.png)

A successful match simply means that Unity was able to match all of the required bones. However, for better results, you also need to match the optional bones and set the model in a proper **T-pose**.

If Unity can’t create the Avatar, a cross appears next to the **Configure** button, and no Avatar sub-asset appears in the Project view.

![Unity failed to create a valid Avatar](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/MecanimAvatarInvalid.png)

Since the Avatar is such an important aspect of the animation system, it is important to configure it properly for your **Model**.

For this reason, whether or not the automatic Avatar creation succeeds, you should always [check that your Avatar](https://docs.unity3d.com/6000.3/Documentation/Manual/ConfiguringtheAvatar.html#AvatarConfig) is valid and properly set up.

<span id="AvatarConfig"></span>

## Configure the Avatar

If you want to check that Unity correctly mapped your model’s bones to the Avatar, or if Unity failed to create the Avatar for your model, you can click the **Configure …** button on the **Rig** tab to enter the [Avatar configuration mode](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Avatar.html).

If Unity successfully creates an Avatar, the Avatar appears as a sub-asset of the model Asset. You can select the Avatar asset in the Project window, and then click the “Configure Avatar” button in the Inspector to enter the Avatar configuration mode. This mode allows to check or adjust how Unity maps your model’s bones to the Avatar layout.

![The Inspector for an Avatar sub-asset](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/MecanimAvatarCreated.png)

Once you have entered the Avatar configuration mode, the **Avatar** window appears in the **Inspector** displaying bone mapping.

Make sure the bone mapping is correct and that you map any optional bones that Unity did not assign.

Your skeleton needs to have at least the required bones in place for Unity to produce a valid match. In order to improve your chances for finding a match to the Avatar, name your bones in a way that reflects the body parts they represent. For example, “LeftArm” and “RightForearm” make it clear what these bones control.

### Mapping strategies

If the model does *not* yield a valid match, you can use a similar process to the one that Unity uses internally:

1.  Choose **Clear** from the **Mapping** menu at the bottom of the **Avatar** window to reset any mapping that Unity attempted.  
    ![The Mapping drop-down menu at the bottom of the Avatar window](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/MecanimMappingMenus.png)
2.  Choose **Sample Bind-pose** from the **Pose** menu at the bottom of the **Avatar** window to approximate the Model’s initial modeling pose.  
    ![The Pose drop-down menu at the bottom of the Avatar window](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/MecanimPoseMenus.png)
3.  Choose **Mapping** > **Automap** to create a bone-mapping from an initial pose.
4.  Choose **Pose** > **Enforce T-Pose** to set the Model back to to required T-pose.

If automapping fails completely or partially, you can manually assign bones by either dragging them from the **Scene** view or from the **Hierarchy** view. If Unity thinks a bone fits, it appears in green in the **Avatar Mapping** tab; otherwise it appears in red.

### Resetting the pose

The **T-pose** is the default pose required by Unity animation and is the recommended pose to model in your 3D modeling application. However, if you did not use the T-pose to model your character and the animation does not work as expected, you can select **Reset** from the **Pose** drop-down menu:

![The **Pose** drop-down menu at the bottom of the **Avatar** window](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/MecanimPoseMenus.png)

If the bone assignment is correct, but the character is not in the correct pose, you will see the message “Character not in T-Pose”. You can try to fix that by choosing **Enforce T-Pose** from the **Pose** menu. If the pose is still not correct, you can manually rotate the remaining bones into a T-pose.

<span id="AvatarMask"></span>

## Creating an Avatar Mask

Masking allows you to discard some of the animation data within a clip, allowing the clip to animate only parts of the object or character rather than the entire thing. For example, you may have a standard walking animation that includes both arm and leg motion, but if a character is carrying a large object with both hands then you wouldn’t want their arms to swing to the side as they walk. However, you could still use the standard walking animation while carrying the object by using a mask to only play the upper body portion of the carrying animation over the top of the walking animation.

You can apply masking to animation clips either during import time, or at runtime. Masking during import time is preferable, because it allows the discarded animation data to be omitted from your build, making the files smaller and therefore using less memory. It also makes for faster processing because there is less animation data to be blended at runtime. In some cases, import masking may not be suitable for your purposes. In that case, you can apply a mask at runtime by creating an **Avatar Mask** Asset, and [using it in the layer settings](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationLayers.html) of your **Animator Controller**.

To create an empty Avatar Mask Asset, you can either:

-   Choose **Create** > **Avatar Mask** from the **Assets** menu.
-   Click the Model object you want to define the mask on in the **Project** view, and then right-click and choose **Create** > **Avatar Mask**.

The new Asset appears in the **Project** view:

![The Avatar Mask window](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ConfiguringtheAvatar-Mask.png)

You can now [add portions of the body to the mask](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AvatarMask.html) and then add the mask to either an [Animation Layer](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationLayers.html) or add a reference to it under the [Mask](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationMaskOnImportedClips.html) section of the [Animation tab](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AnimationClip.html).

---
title: "About action assets"
page_title: "About action assets | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/about-action-assets.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/about-action-assets.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# About action assets

The Input System stores your configuration of [Input Actions](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Actions.html) and their associated [bindings](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/bindings.html), [action maps](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/create-edit-delete-action-maps.html) and [Control Schemes](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/control-schemes.html) in an [action asset](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/action-assets.html) file. These Assets have the `.inputactions` file extension and are stored in a plain JSON format.

## Project-wide action assets

The Input System creates an action asset when you set up the [default project-wide actions](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/about-project-wide-actions.html), which is the most common and recommended workflow, but you can also [create new empty action assets](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/create-empty-action-asset.html) directly in the Project window.

## Action maps

Actions assets allow you to group sets of related actions into [action maps](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/create-edit-delete-action-maps.html). For example, in an open-world city game, you might create separate action maps for different situations such as exploring on foot, driving a car, flying an aircraft, or navigating UI interfaces. This means, for most common scenarios, you don't need to use more than one Input action asset.

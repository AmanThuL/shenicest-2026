---
title: "Group bindings to control schemes"
page_title: "Group bindings to control schemes | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/group-binding-to-control-scheme.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/group-binding-to-control-scheme.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Group bindings to control schemes

[Control schemes](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/control-schemes.html) allow you to group types of bindings together according to their control type, so that you can enable or disable groups of bindings. For example, for games that support both gamepads and keyboard & mouse, you might want to enable all keyboard and mouse bindings if the user presses any keyboard button or uses the mouse.

You can select which [control schemes](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/control-schemes.html) a binding belongs to in the [Actions Editor window](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/actions-editor.html).

To do so:

1.  In the Actions panel, select the Action whose bindings you want to edit.
2.  Expand the Action's hierarchy as necessary to display the bindings.
3.  Select a binding to edit. For composite bindings, you must select one or more of its sub-bindings.
4.  In the Binding Properties panel, under **Use in control scheme**, enable or disable the control schemes that you want this binding to belong to.

You can edit the control schemes listed under **Use in control scheme**, by using the [Control Schemes menu](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/control-schemes-devices-menu-reference.html) at the top left of the [Actions Editor window](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/actions-editor.html).

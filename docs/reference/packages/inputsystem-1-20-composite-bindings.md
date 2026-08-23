---
title: "Composite bindings"
page_title: "Composite Bindings | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/composite-bindings.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/composite-bindings.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Composite Bindings

You might want to have several controls act in unison to mimic a different type of control. The most common example of this is using the W, A, S, and D keys on the keyboard to form a 2D vector control equivalent to mouse deltas or gamepad sticks. Another example is to use two keys to form a 1D axis equivalent to a mouse scroll axis.

This is difficult to implement with normal bindings. You can bind a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Controls.ButtonControl.html" class="xref"><code>ButtonControl</code></a> to an action expecting a `Vector2`, but doing so results in an exception at runtime when the Input System tries to read a `Vector2` from a control that can deliver only a `float`.

Composite bindings (that is, bindings that are made up of other bindings) solve this problem. Composites themselves don't bind directly to controls; instead, they source values from other bindings that do, and then synthesize input on the fly from those values.

To create a composite binding, select the appropriate [composite type](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/binding-types.html) for your action while [adding a binding in the actions editor](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/add-duplicate-delete-binding.html). The types of composite bindings available are as follows:

## Types of composite bindings

The **Add binding (+)** menu contains the following options.

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th style="text-align: left;">Value</th><th style="text-align: left;">Description</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Add Binding</strong></td><td style="text-align: left;">Adds a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/binding-types.html">simple binding</a> and is not a composite</td></tr><tr class="even"><td style="text-align: left;"><strong>Add Positive/Negative Binding</strong></td><td style="text-align: left;">Adds a 1D axis composite binding made of two button sub-bindings, one that pulls a 1D axis in its negative direction, and another that pulls it in its positive direction. It is implemented in the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Composites.AxisComposite.html" class="xref"><code>AxisComposite</code></a> class. The output is a <code>float</code>.<br />
<br />
If Controls from both the <code>positive</code> and the <code>negative</code> side are actuated, then the resulting value of the axis Composite depends on the <strong>Which side wins</strong> <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/binding-properties-panel-reference.html">binding property</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Add Up/Down/Left/Right Composite</strong></td><td style="text-align: left;">Adds a 2D axis composite binding that represents a 4-way button control like the D-pad on gamepads. Each button sub-binding represents a cardinal direction, is most useful for representing up-down-left-right controls, such as WASD keyboard input. It is implemented in the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Composites.Vector2Composite.html" class="xref"><code>Vector2Composite</code></a> class. The output is a <code>Vector2</code>. This composite's <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/binding-properties-panel-reference.html"><strong>mode</strong> property</a> allows you to choose whether the inputs should be treated as digital or analog controls.</td></tr><tr class="even"><td style="text-align: left;"><strong>Add Up/Down/Left/Right/Forward/Backward Composite</strong></td><td style="text-align: left;">Adds a 3D composite binding that represents a 6-way button where two combinations each control one axis of a 3D vector. Implemented in the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Composites.Vector3Composite.html" class="xref"><code>Vector3Composite</code></a> class. The output is a <code>Vector3</code>.<br />
<br />
This composite's <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/binding-properties-panel-reference.html"><strong>mode</strong> property</a> allows you to choose whether the inputs should be treated as digital or analog controls.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Add Binding With One Modifier</strong></td><td style="text-align: left;">Adds a composite with two sub-bindings, named <strong>Binding</strong> and <strong>Modifier</strong>, which requires the user to hold down the <strong>modifier</strong> button in addition to another control from which the actual value of the binding is determined. This can be used, for example, for bindings such as "SHIFT+1". Implemented in the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Composites.OneModifierComposite.html" class="xref"><code>OneModifierComposite</code></a> class. The buttons can be on any Device, and can be toggle buttons or full-range buttons such as gamepad triggers.<br />
<br />
The output is a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/control-types-reference.html">value of the same type</a> as the control bound to the sub-binding named <strong>Binding</strong>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Add Binding With Two Modifiers</strong></td><td style="text-align: left;">Adds a composite with three sub-bindings, named <strong>Binding</strong>, <strong>Modifier 1</strong> and <strong>Modifier 2</strong>, which requires the user to hold down two modifier buttons in addition to another control from which the actual value of the binding is determined. This can be used, for example, for bindings such as "SHIFT+CTRL+1". Implemented in the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Composites.TwoModifiersComposite.html" class="xref"><code>TwoModifiersComposite</code></a> class. The buttons can be on any Device, and can be toggle buttons or full-range buttons such as gamepad triggers.<br />
<br />
The output is a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/control-types-reference.html">value of the same type</a> as the control bound to the sub-binding named <strong>Binding</strong>.</td></tr></tbody></table>

##### Note

You can also [create custom composite bindings from code](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/create-custom-composite-binding.html)

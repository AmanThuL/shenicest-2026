---
title: "Scripting API: CharacterController.Move"
page_title: "Unity - Scripting API: CharacterController.Move"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CharacterController.Move.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CharacterController.Move.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [CharacterController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CharacterController.html).Move

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-CharacterController.html" class="switch-link gray-btn sbtn left show" title="Go to CharacterController Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public [CollisionFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CollisionFlags.html) <span class="sig-kw">Move</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">motion</span>);

### Description

Supplies the movement of a GameObject with an attached CharacterController component.

The [CharacterController.Move](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CharacterController.Move.html) motion moves the GameObject in the given direction. The given direction requires absolute movement delta values. A collision constrains the [Move](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CharacterController.Move.html) from taking place. The return, [CollisionFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CollisionFlags.html), indicates the direction of a collision: None, Sides, Above, and Below. [CharacterController.Move](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CharacterController.Move.html) does not use gravity.  
  
The example below demonstrates how to use [CharacterController.Move](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CharacterController.Move.html). `Update` causes a [Move](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CharacterController.Move.html) to re-position the player. In addition, `Jump` changes the player position in a vertical direction.

``` codeExampleCS
// This first example shows how to move using Input System Package (New)

using UnityEngine;
using UnityEngine.InputSystem;

public class Example : MonoBehaviour

    private void OnDisable()
    
    void Update()
    
        // Read input
        Vector2 input = moveAction.action.ReadValue<Vector2>();
        Vector3 move = new Vector3(input.x, 0, input.y);
        move = Vector3.ClampMagnitude(move, 1f);

        if (move != Vector3.zero)
            transform.forward = move;

        // Jump using WasPressedThisFrame()
        if (groundedPlayer && jumpAction.action.WasPressedThisFrame())
        
        // Apply gravity
        playerVelocity.y += gravityValue * Time.deltaTime;

        // Move
        Vector3 finalMove = move * playerSpeed + Vector3.up * playerVelocity.y;
        controller.Move(finalMove * Time.deltaTime);
    }
}
```

---
title: "Scripting API: ForceMode"
page_title: "Unity - Scripting API: ForceMode"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceMode.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceMode.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ForceMode

enumeration

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

<span style="color:red;"> </span>

### Description

Use ForceMode to specify how to apply a force using [Rigidbody.AddForce](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.AddForce.html) or [ArticulationBody.AddForce](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ArticulationBody.AddForce.html).

The AddForce function impacts how your GameObject moves by allowing you to define your own force vector, as well as choosing how to apply this force to the GameObject (this GameObject must have a Rigidbody component attached).  
  
ForceMode allows you to choose from four different ways to affect the GameObject using this Force: Acceleration, Force, Impulse, and VelocityChange.  
  
For more information on how ForceMode affects velocity, see [Rigidbody.AddForce](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.AddForce.html).

``` codeExampleCS
using UnityEngine;

public class ForceModeExample : MonoBehaviour
{
    //Use to switch between Force Modes
    enum ModeSwitching { Start, Impulse, Acceleration, Force, VelocityChange };
    ModeSwitching m_ModeSwitching;

    Vector3 m_StartPos, m_StartForce;
    Vector3 m_NewForce;
    Rigidbody m_Rigidbody;

    string m_ForceXString = string.Empty;
    string m_ForceYString = string.Empty;

    float m_ForceX, m_ForceY;
    float m_Result;

    void Start()
    
    void FixedUpdate()
    
        //Here, switching modes depend on button presses in the Game mode
        switch (m_ModeSwitching)
        
    }

    //The function outputs buttons, text fields, and other interactable UI elements to the Scene in Game view
    void OnGUI()
    
        //When you press the Acceleration button, switch to Acceleration mode
        if (GUI.Button(new Rect(100, 30, 150, 30), "Apply Acceleration"))
        
        //If you press the Impulse button
        if (GUI.Button(new Rect(100, 60, 150, 30), "Apply Impulse"))
        
        //If you press the Force Button, switch to Force state
        if (GUI.Button(new Rect(100, 90, 150, 30), "Apply Force"))
        
        //Press the button to switch to VelocityChange state
        if (GUI.Button(new Rect(100, 120, 150, 30), "Apply Velocity Change"))
        
    }

    //Changing strings to floats for the forces
    float ConvertToFloat(string Name)
    
    //Set the converted float from the text fields as the forces to apply to the Rigidbody
    void MakeCustomForce()
    
}
```

### Properties

| Property                                                                                                      | Description                                                         |
|---------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------|
| [Force](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceMode.Force.html)                   | Add a continuous force to the rigidbody, using its mass.            |
| [Acceleration](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceMode.Acceleration.html)     | Add a continuous acceleration to the rigidbody, ignoring its mass.  |
| [Impulse](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceMode.Impulse.html)               | Add an instant force impulse to the rigidbody, using its mass.      |
| [VelocityChange](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ForceMode.VelocityChange.html) | Add an instant velocity change to the rigidbody, ignoring its mass. |

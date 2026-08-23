---
title: "Scripting API: UIElements.UIDocument"
page_title: "Unity - Scripting API: UIDocument"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# UIDocument

class in UnityEngine.UIElements

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html" class="cl">MonoBehaviour</a>

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.UIElementsModule.html" class="cl">UnityEngine.UIElementsModule</a>

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

Defines a Component that connects [VisualElements](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualElement.html) to [GameObjects](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html).

This makes it possible to render UI defined in UXML documents in the Game view.  
  
The following example shows how to query a UIDocument component and interact with its elements.

``` codeExampleCS
using UnityEngine;
using UnityEngine.UIElements;

public class UIDocument_Example : MonoBehaviour
{
    // Configured via the inspector
    public UIDocument document;

    void OnEnable()
    {
        // Expects a button with the name "my-button" to be present in the UXML.
        // If it doesn't exist, create it.
        var button = document.rootVisualElement.Q<Button>("my-button");
        if (button == null)
        {
            button = new Button { name = "my-button", text = "Click me!" };
            document.rootVisualElement.Add(button);
        }

        button.clicked += ButtonClicked;
    }

    void ButtonClicked()
    {
        var label = document.rootVisualElement.Q<Label>("my-label");

        // Add a label if it doesn't exist
        if (label == null)
        {
            label = new Label { name = "my-label", text = "Button clicked!" };
            document.rootVisualElement.Add(label);
        }
        else
        
    }
}
```

### Properties

| Property                                                                                                                          | Description                                                                                                                                                                                                                                          |
|-----------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [panelSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument-panelSettings.html)           | Specifies the PanelSettings instance to connect this UIDocument component to.                                                                                                                                                                        |
| [parentUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument-parentUI.html)                     | If the GameObject that this UIDocument component is attached to has a parent GameObject, and that parent GameObject also has a UIDocument component attached to it, this value is set to the parent GameObject's UIDocument component automatically. |
| [pivot](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument-pivot.html)                           | Defines the pivot point for positioning and transformation, such as rotation and scaling, of the UI Document in world space. The default pivot is the center.                                                                                        |
| [pivotReferenceSize](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument-pivotReferenceSize.html) | Defines how the size of the container is calculated for pivot positioning.                                                                                                                                                                           |
| [position](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument-position.html)                     | The position (relative or absolute) of the root visual element. Relative only applies for nested UIDocuments.                                                                                                                                        |
| [rootVisualElement](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument-rootVisualElement.html)   | The root visual element where the UI hierarchy starts.                                                                                                                                                                                               |
| [runtimePanel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument-runtimePanel.html)             | The runtime panel whose visualTree contains this document's rootVisualElement, if any.                                                                                                                                                               |
| [sortingOrder](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument-sortingOrder.html)             | The order in which this UIDocument will show up on the hierarchy in relation to other UIDocuments either attached to the same PanelSettings, or with the same UIDocument parent.                                                                     |
| [visualTreeAsset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument-visualTreeAsset.html)       | The VisualTreeAsset loaded into the root visual element automatically.                                                                                                                                                                               |
| [worldSpaceSize](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument-worldSpaceSize.html)         | When the worldSpaceSizeMode is set to WorldSpaceSizeMode.Fixed, this property determines the size of the UIDocument in world space.                                                                                                                  |
| [worldSpaceSizeMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument-worldSpaceSizeMode.html) | Defines how the size of the root element is calculated for world space.                                                                                                                                                                              |

### Inherited Members

### Properties

| Property                                                                                                                              | Description                                                                                                                                    |
|---------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| [enabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-enabled.html)                                       | True if this Behaviour is enabled, otherwise false.                                                                                            |
| [isActiveAndEnabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-isActiveAndEnabled.html)                 | Checks whether a component is enabled, attached to a GameObject that is active in the hierarchy, and the component's OnEnable has been called. |
| [gameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-gameObject.html)                                 | The game object this component is attached to. A component is always attached to a game object.                                                |
| [tag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-tag.html)                                               | The tag of this game object.                                                                                                                   |
| [transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-transform.html)                                   | The Transform attached to this GameObject.                                                                                                     |
| [transformHandle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-transformHandle.html)                       | The TransformHandle of this GameObject.                                                                                                        |
| [destroyCancellationToken](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-destroyCancellationToken.html) | Cancellation token raised when the MonoBehaviour is destroyed (Read Only).                                                                     |
| [didAwake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-didAwake.html)                                 | Returns a boolean value which represents if Awake was called.                                                                                  |
| [didStart](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-didStart.html)                                 | Returns a boolean value which represents if Start was called.                                                                                  |
| [runInEditMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-runInEditMode.html)                       | Allow a specific instance of a MonoBehaviour to run in edit mode (only available in the editor).                                               |
| [useGUILayout](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-useGUILayout.html)                         | Disabling this lets you skip the GUI layout phase.                                                                                             |
| [hideFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-hideFlags.html)                                      | Controls whether the object is hidden, saved with the scene, and editable by the user.                                                         |
| [name](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-name.html)                                                | The name of the object.                                                                                                                        |

### Public Methods

| Method                                                                                                                          | Description                                                                                                                      |
|---------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| [BroadcastMessage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.BroadcastMessage.html)               | Calls the method named methodName on every MonoBehaviour in this game object or any of its children.                             |
| [CompareTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.CompareTag.html)                           | Checks the GameObject's tag against the defined tag.                                                                             |
| [GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponent.html)                       | Gets a reference to a component of type T on the same GameObject as the component specified.                                     |
| [GetComponentInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentInChildren.html)   | Gets a reference to a component of type T on the same GameObject as the component specified, or any child of the GameObject.     |
| [GetComponentIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentIndex.html)             | Gets the index of the component on its parent GameObject.                                                                        |
| [GetComponentInParent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentInParent.html)       | Gets a reference to a component of type T on the same GameObject as the component specified, or any parent of the GameObject.    |
| [GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponents.html)                     | Gets references to all components of type T on the same GameObject as the component specified.                                   |
| [GetComponentsInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentsInChildren.html) | Gets references to all components of type T on the same GameObject as the component specified, and any child of the GameObject.  |
| [GetComponentsInParent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentsInParent.html)     | Gets references to all components of type T on the same GameObject as the component specified, and any parent of the GameObject. |
| [SendMessage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.SendMessage.html)                         | Calls the method named methodName on every MonoBehaviour in this game object.                                                    |
| [SendMessageUpwards](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.SendMessageUpwards.html)           | Calls the method named methodName on every MonoBehaviour in this game object and on every ancestor of the behaviour.             |
| [TryGetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.TryGetComponent.html)                 | Gets the component of the specified type, if it exists.                                                                          |
| [CancelInvoke](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.CancelInvoke.html)                   | Cancels all Invoke calls on this MonoBehaviour.                                                                                  |
| [Invoke](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Invoke.html)                               | Invokes the method methodName in time seconds.                                                                                   |
| [InvokeRepeating](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.InvokeRepeating.html)             | Invokes the specified method after a specified delay, then repeatedly at the specified rate.                                     |
| [IsInvoking](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.IsInvoking.html)                       | Is any invoke on methodName pending?                                                                                             |
| [StartCoroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StartCoroutine.html)               | Starts a coroutine.                                                                                                              |
| [StopAllCoroutines](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StopAllCoroutines.html)         | Stops all coroutines running on this MonoBehaviour.                                                                              |
| [StopCoroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StopCoroutine.html)                 | Stops the first coroutine named methodName, or the coroutine stored in routine running on this behaviour.                        |
| [GetHashCode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetHashCode.html)                            | Returns the hash code for the object.                                                                                            |
| [GetInstanceID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetInstanceID.html)                        | Gets the instance ID of the object.                                                                                              |
| [ToString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.ToString.html)                                  | Returns the name of the object.                                                                                                  |

### Static Methods

| Method                                                                                                                   | Description                                                                                                                                                 |
|--------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [print](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-print.html)                          | Logs a message to the Unity Console. Functionally equivalent to Debug.Log.                                                                                  |
| [Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html)                             | Removes a GameObject, component, or asset.                                                                                                                  |
| [DestroyImmediate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DestroyImmediate.html)           | Destroys the specified object immediately. Use with caution and in Edit mode only.                                                                          |
| [DontDestroyOnLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html)         | Do not destroy the target Object when loading a new Scene.                                                                                                  |
| [FindAnyObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html)     | Retrieves any active loaded object of Type T.                                                                                                               |
| [FindFirstObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html) | Retrieves the first active loaded object of Type type.                                                                                                      |
| [FindObjectsByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html)         | Retrieves a list of all loaded objects of Type type and sorts the results according to sortMode.                                                            |
| [Instantiate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Instantiate.html)                     | Clones the object original and returns the clone.                                                                                                           |
| [InstantiateAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.InstantiateAsync.html)           | Captures a snapshot of the original object that's related to another GameObject and obtains an AsyncInstantiateOperation instance of the resulting objects. |

### Operators

| Operator                                                                                             | Description                                                             |
|------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [bool](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_Object.html)    | Determines whether the object exists.                                   |
| [operator !=](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_ne.html) | Compares if two objects refer to a different object.                    |
| [operator ==](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_eq.html) | Compares two object references to see if they refer to the same object. |

### Messages

| Message                                                                                                                                                       | Description                                                                                                                                                                                                                                              |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Awake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html)                                                               | Unity calls Awake when loading an instance of a script component.                                                                                                                                                                                        |
| [FixedUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html)                                                   | Update called at regular, fixed intervals as part of Unity's physics update loop.                                                                                                                                                                        |
| [LateUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.LateUpdate.html)                                                     | LateUpdate is called every frame, if the Behaviour is enabled.                                                                                                                                                                                           |
| [OnAnimatorIK](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnAnimatorIK.html)                                                 | Callback for setting up animation IK (inverse kinematics).                                                                                                                                                                                               |
| [OnAnimatorMove](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnAnimatorMove.html)                                             | Callback for processing animation movements for modifying root motion.                                                                                                                                                                                   |
| [OnApplicationFocus](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnApplicationFocus.html)                                     | Sent to all GameObjects when the player gets or loses focus.                                                                                                                                                                                             |
| [OnApplicationPause](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnApplicationPause.html)                                     | Sent to all GameObjects when the playing application pauses or resumes on losing or regaining focus.                                                                                                                                                     |
| [OnApplicationQuit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnApplicationQuit.html)                                       | Sent to all active GameObjects before the application quits.                                                                                                                                                                                             |
| [OnAudioFilterRead](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnAudioFilterRead.html)                                       | If OnAudioFilterRead is implemented, Unity will insert a custom filter into the audio DSP chain.                                                                                                                                                         |
| [OnBecameInvisible](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnBecameInvisible.html)                                       | Called when the renderer is no longer visible to any camera.                                                                                                                                                                                             |
| [OnBecameVisible](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnBecameVisible.html)                                           | Called when the renderer becomes visible to any camera.                                                                                                                                                                                                  |
| [OnChildRectTransformDimensionsChange](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnChildRectTransformDimensionsChange.html) | Called when a child RectTransform's dimensions change.                                                                                                                                                                                                   |
| [OnCollisionEnter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionEnter.html)                                         | OnCollisionEnter is called when this collider/rigidbody has begun touching another rigidbody/collider.                                                                                                                                                   |
| [OnCollisionEnter2D](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionEnter2D.html)                                     | Sent when an incoming collider makes contact with this object's collider (2D physics only).                                                                                                                                                              |
| [OnCollisionExit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionExit.html)                                           | OnCollisionExit is called when this collider/rigidbody has stopped touching another rigidbody/collider.                                                                                                                                                  |
| [OnCollisionExit2D](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionExit2D.html)                                       | Sent when a collider on another object stops touching this object's collider (2D physics only).                                                                                                                                                          |
| [OnCollisionStay](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionStay.html)                                           | OnCollisionStay is called once per frame for every Collider or Rigidbody that touches another Collider or Rigidbody.                                                                                                                                     |
| [OnCollisionStay2D](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionStay2D.html)                                       | Sent each frame where a collider on another object is touching this object's collider (2D physics only).                                                                                                                                                 |
| [OnControllerColliderHit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnControllerColliderHit.html)                           | OnControllerColliderHit is called when the CharacterController component hits a collider while performing a Move.                                                                                                                                        |
| [OnDestroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDestroy.html)                                                       | Called when a GameObject or component is about to be destroyed.                                                                                                                                                                                          |
| [OnDisable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDisable.html)                                                       | Called when a component itself is disabled or its parent GameObject is deactivated.                                                                                                                                                                      |
| [OnDrawGizmos](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDrawGizmos.html)                                                 | Implement OnDrawGizmos if you want to draw gizmos that can be pickable and are always drawn.                                                                                                                                                             |
| [OnDrawGizmosSelected](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDrawGizmosSelected.html)                                 | Implement OnDrawGizmosSelected to draw a gizmo if the object is selected.                                                                                                                                                                                |
| [OnEnable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnEnable.html)                                                         | Called when a component of an active GameObject is first enabled.                                                                                                                                                                                        |
| [OnGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnGUI.html)                                                               | OnGUI is called for rendering and handling GUI events.                                                                                                                                                                                                   |
| [OnJointBreak](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnJointBreak.html)                                                 | Called when a joint attached to the same game object broke.                                                                                                                                                                                              |
| [OnJointBreak2D](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnJointBreak2D.html)                                             | Called when a Joint2D attached to the same game object breaks.                                                                                                                                                                                           |
| [OnMouseDown](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnMouseDown.html)                                                   | OnMouseDown is called when the user presses the left mouse button while over the Collider.                                                                                                                                                               |
| [OnMouseDrag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnMouseDrag.html)                                                   | OnMouseDrag is called when the user has clicked on a Collider and is still holding down the mouse.                                                                                                                                                       |
| [OnMouseEnter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnMouseEnter.html)                                                 | Called when the mouse enters the Collider.                                                                                                                                                                                                               |
| [OnMouseExit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnMouseExit.html)                                                   | Called when the mouse is not any longer over the Collider.                                                                                                                                                                                               |
| [OnMouseOver](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnMouseOver.html)                                                   | Called every frame while the mouse is over the Collider.                                                                                                                                                                                                 |
| [OnMouseUp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnMouseUp.html)                                                       | Called on releasing the mouse button while the mouse pointer is over the Collider attached to this GameObject.                                                                                                                                           |
| [OnMouseUpAsButton](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnMouseUpAsButton.html)                                       | OnMouseUpAsButton is only called when the mouse is released over the same Collider as it was pressed.                                                                                                                                                    |
| [OnParticleCollision](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnParticleCollision.html)                                   | OnParticleCollision is called when a particle hits a Collider.                                                                                                                                                                                           |
| [OnParticleSystemStopped](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnParticleSystemStopped.html)                           | OnParticleSystemStopped is called when all particles in the system have died, and no new particles will be born. New particles cease to be created either after Stop is called, or when the duration property of a non-looping system has been exceeded. |
| [OnParticleTrigger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnParticleTrigger.html)                                       | OnParticleTrigger is called when any particles in a Particle System meet the conditions in the trigger module.                                                                                                                                           |
| [OnParticleUpdateJobScheduled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnParticleUpdateJobScheduled.html)                 | OnParticleUpdateJobScheduled is called when a Particle System's built-in update job has been scheduled.                                                                                                                                                  |
| [OnPostRender](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnPostRender.html)                                                 | Event function that Unity calls after a Camera renders the scene.                                                                                                                                                                                        |
| [OnPreCull](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnPreCull.html)                                                       | Event function that Unity calls before a Camera culls the scene.                                                                                                                                                                                         |
| [OnPreRender](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnPreRender.html)                                                   | Event function that Unity calls before a Camera renders the scene.                                                                                                                                                                                       |
| [OnRenderImage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnRenderImage.html)                                               | Event function that Unity calls after a Camera has finished rendering, that allows you to modify the Camera's final image.                                                                                                                               |
| [OnRenderObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnRenderObject.html)                                             | OnRenderObject is called after camera has rendered the Scene.                                                                                                                                                                                            |
| [OnTransformChildrenChanged](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTransformChildrenChanged.html)                     | Called when the list of direct children of a GameObject's Transform changes.                                                                                                                                                                             |
| [OnTransformParentChanged](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTransformParentChanged.html)                         | Called when a direct or indirect parent of a GameObject's Transform changes.                                                                                                                                                                             |
| [OnTriggerEnter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerEnter.html)                                             | Called when a collider enters a trigger collider.                                                                                                                                                                                                        |
| [OnTriggerEnter2D](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerEnter2D.html)                                         | Sent when another object enters a trigger collider attached to this object (2D physics only).                                                                                                                                                            |
| [OnTriggerExit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerExit.html)                                               | OnTriggerExit is called when a collider stops touching a trigger.                                                                                                                                                                                        |
| [OnTriggerExit2D](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerExit2D.html)                                           | Sent when another object leaves a trigger collider attached to this object (2D physics only).                                                                                                                                                            |
| [OnTriggerStay](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerStay.html)                                               | Called once per physics update for every collider that is touching the trigger.                                                                                                                                                                          |
| [OnTriggerStay2D](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerStay2D.html)                                           | Sent once per physics update when another object is within a trigger collider attached to this object (2D physics only).                                                                                                                                 |
| [OnValidate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnValidate.html)                                                     | Editor-only function that Unity calls when the script is loaded or a value changes in the Inspector.                                                                                                                                                     |
| [OnWillRenderObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnWillRenderObject.html)                                     | Called for each camera if the object is visible and not a UI element.                                                                                                                                                                                    |
| [Reset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Reset.html)                                                               | Reset a component to default values.                                                                                                                                                                                                                     |
| [Start](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Start.html)                                                               | Start is called on the frame when a script is enabled just before any of the Update methods are called the first time.                                                                                                                                   |
| [Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html)                                                             | Update is called every frame, if the MonoBehaviour is enabled.                                                                                                                                                                                           |

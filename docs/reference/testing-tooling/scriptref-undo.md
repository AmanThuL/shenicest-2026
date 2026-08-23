---
title: "Scripting API: Undo"
page_title: "Unity - Scripting API: Undo"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Undo

class in UnityEditor

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

Lets you register undo operations on specific objects you are about to perform changes on.

The Undo system stores delta changes in the undo stack.  
  
Undo operations automatically combine together based on events. For example, mouse down events split undo groups. Grouped undo operations appear and work as a single undo. To control grouping manually, use [Undo.IncrementCurrentGroup](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.IncrementCurrentGroup.html).  
  
By default, the name shown in the UI is selected from the actions from the group using a hardcoded ordering of the different kinds of actions. To manually set the name, use [Undo.SetCurrentGroupName](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.SetCurrentGroupName.html).  
  
Undo operations store either per property or per object state. They scale well with any Scene size.  
  
The most important operations are outlined below:  
  
Modify object properties:  
`Undo.RecordObject (myGameObject.transform, "Zero Transform Position");`  
`myGameObject.transform.position = Vector3.zero;`  
  
Add a component:  
`Undo.AddComponent<Rigidbody>(myGameObject);`  
  
Create a new GameObject:  
`var go = new GameObject();`  
`Undo.RegisterCreatedObjectUndo (go, "Created go");`  
  
Destroy a GameObject or component:  
`Undo.DestroyObjectImmediate (myGameObject);`  
  
Change transform parenting:  
`Undo.SetTransformParent (myGameObject.transform, newTransformParent, "Set new parent");`

### Static Properties

| Property                                                                                                                     | Description                                                                                  |
|------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|
| [isProcessing](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo-isProcessing.html)                         | Returns true if the editor is currently processing undo or redo operations, false otherwise. |
| [postprocessModifications](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo-postprocessModifications.html) | Callback that is triggered whenever a new set of property modifications is created.          |
| [undoRedoEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo-undoRedoEvent.html)                       | Callback that is triggered after any undo or redo event.                                     |
| [undoRedoPerformed](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo-undoRedoPerformed.html)               | Callback that is triggered after an undo or a redo was executed.                             |
| [willFlushUndoRecord](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo-willFlushUndoRecord.html)           | Invoked before the Undo system performs a flush.                                             |

### Static Methods

| Method                                                                                                                                     | Description                                                                                                                                                                                                                                                                                     |
|--------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [AddComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.AddComponent.html)                                       | Adds a component to the game object and registers an undo operation for this action.                                                                                                                                                                                                            |
| [ClearAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.ClearAll.html)                                               | Removes all undo and redo operations from respectively the undo and redo stacks.                                                                                                                                                                                                                |
| [ClearUndo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.ClearUndo.html)                                             | Removes all Undo operation for the identifier object registered using Undo.RegisterCompleteObjectUndo from the undo stack.                                                                                                                                                                      |
| [CollapseUndoOperations](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.CollapseUndoOperations.html)                   | Collapses all undo operations down to group index together into one step.                                                                                                                                                                                                                       |
| [DestroyObjectImmediate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.DestroyObjectImmediate.html)                   | Destroys the object and records an undo operation so that it can be recreated.                                                                                                                                                                                                                  |
| [FlushUndoRecordObjects](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.FlushUndoRecordObjects.html)                   | Ensure objects recorded using RecordObject or RecordObjects are registered as an undoable action. In most cases there is no reason to invoke FlushUndoRecordObjects since it's automatically done right after mouse-up and certain other events that conventionally marks the end of an action. |
| [GetCurrentGroup](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.GetCurrentGroup.html)                                 | Unity automatically groups undo operations by the current group index.                                                                                                                                                                                                                          |
| [GetCurrentGroupName](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.GetCurrentGroupName.html)                         | Get the name that will be shown in the UI for the current undo group.                                                                                                                                                                                                                           |
| [IncrementCurrentGroup](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.IncrementCurrentGroup.html)                     | Unity automatically groups undo operations by the current group index.                                                                                                                                                                                                                          |
| [MoveGameObjectToScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.MoveGameObjectToScene.html)                     | Move a GameObject from its current Scene to a new Scene. It is required that the GameObject is at the root of its current Scene.                                                                                                                                                                |
| [PerformRedo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.PerformRedo.html)                                         | Perform an Redo operation.                                                                                                                                                                                                                                                                      |
| [PerformUndo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.PerformUndo.html)                                         | Perform an Undo operation.                                                                                                                                                                                                                                                                      |
| [RecordObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.RecordObject.html)                                       | Records any changes done on the object after the RecordObject function.                                                                                                                                                                                                                         |
| [RecordObjects](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.RecordObjects.html)                                     | Records multiple undoable objects in a single call. This is the same as calling Undo.RecordObject multiple times.                                                                                                                                                                               |
| [RegisterChildrenOrderUndo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.RegisterChildrenOrderUndo.html)             | Stores a copy of the order of the object's children on the undo stack.                                                                                                                                                                                                                          |
| [RegisterCompleteObjectUndo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.RegisterCompleteObjectUndo.html)           | Stores a copy of the object states on the undo stack.                                                                                                                                                                                                                                           |
| [RegisterCreatedObjectUndo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.RegisterCreatedObjectUndo.html)             | Registers an undo operation to undo the creation of an object.                                                                                                                                                                                                                                  |
| [RegisterFullObjectHierarchyUndo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.RegisterFullObjectHierarchyUndo.html) | Copy the states of a hierarchy of objects onto the undo stack.                                                                                                                                                                                                                                  |
| [RegisterImporterUndo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.RegisterImporterUndo.html)                       | Copies the state of the importer for the given asset path.                                                                                                                                                                                                                                      |
| [RevertAllDownToGroup](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.RevertAllDownToGroup.html)                       | Performs all undo operations up to the group index without storing a redo operation in the process.                                                                                                                                                                                             |
| [RevertAllInCurrentGroup](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.RevertAllInCurrentGroup.html)                 | Performs the last undo operation but does not record a redo operation.                                                                                                                                                                                                                          |
| [SetCurrentGroupName](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.SetCurrentGroupName.html)                         | Set the name of the current undo group.                                                                                                                                                                                                                                                         |
| [SetSiblingIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.SetSiblingIndex.html)                                 | Sets the sibling index of transform and records an undo operation.                                                                                                                                                                                                                              |
| [SetTransformParent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.SetTransformParent.html)                           | Sets the parent of transform to the new parent and records an undo operation.                                                                                                                                                                                                                   |

### Delegates

| Delegate                                                                                                                     | Description                                 |
|------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------|
| [PostprocessModifications](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.PostprocessModifications.html) | Delegate used for postprocessModifications. |
| [UndoRedoCallback](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.UndoRedoCallback.html)                 | Delegate used for undoRedoPerformed.        |
| [UndoRedoEventCallback](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.UndoRedoEventCallback.html)       | Delegate used for undoRedoEvent.            |
| [WillFlushUndoRecord](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.WillFlushUndoRecord.html)           | Delegate used for willFlushUndoRecord.      |

---
title: "uGUI Supported Events"
page_title: "Supported Events | uGUI | 2.0.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/SupportedEvents.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/SupportedEvents.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Supported Events

The Event System supports a number of events, and they can be customized further in user custom user written Input Modules.

The events that are supported by the Standalone Input Module and Touch Input Module are provided by interface and can be implemented on a MonoBehaviour by implementing the interface. If you have a valid Event System configured the events will be called at the correct time.

-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IPointerEnterHandler.html" class="xref">IPointerEnterHandler</a> - OnPointerEnter - Called when a pointer enters the object
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IPointerExitHandler.html" class="xref">IPointerExitHandler</a> - OnPointerExit - Called when a pointer exits the object
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IPointerDownHandler.html" class="xref">IPointerDownHandler</a> - OnPointerDown - Called when a pointer is pressed on the object
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IPointerUpHandler.html" class="xref">IPointerUpHandler</a>- OnPointerUp - Called when a pointer is released (called on the GameObject that the pointer is clicking)
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IPointerClickHandler.html" class="xref">IPointerClickHandler</a> - OnPointerClick - Called when a pointer is pressed and released on the same object
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IInitializePotentialDragHandler.html" class="xref">IInitializePotentialDragHandler</a> - OnInitializePotentialDrag - Called when a drag target is found, can be used to initialize values
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IBeginDragHandler.html" class="xref">IBeginDragHandler</a> - OnBeginDrag - Called on the drag object when dragging is about to begin
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IDragHandler.html" class="xref">IDragHandler</a> - OnDrag - Called on the drag object when a drag is happening
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IEndDragHandler.html" class="xref">IEndDragHandler</a> - OnEndDrag - Called on the drag object when a drag finishes
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IDropHandler.html" class="xref">IDropHandler</a> - OnDrop - Called on the object where a drag finishes
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IScrollHandler.html" class="xref">IScrollHandler</a> - OnScroll - Called when a mouse wheel scrolls
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IUpdateSelectedHandler.html" class="xref">IUpdateSelectedHandler</a> - OnUpdateSelected - Called on the selected object each tick
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.ISelectHandler.html" class="xref">ISelectHandler</a> - OnSelect - Called when the object becomes the selected object
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IDeselectHandler.html" class="xref">IDeselectHandler</a> - OnDeselect - Called on the selected object becomes deselected
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.IMoveHandler.html" class="xref">IMoveHandler</a> - OnMove - Called when a move event occurs (left, right, up, down)
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.ISubmitHandler.html" class="xref">ISubmitHandler</a> - OnSubmit - Called when the submit button is pressed
-   <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/UnityEngine.EventSystems.ICancelHandler.html" class="xref">ICancelHandler</a> - OnCancel - Called when the cancel button is pressed

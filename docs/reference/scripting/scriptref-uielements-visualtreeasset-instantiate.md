---
title: "Scripting API: UIElements.VisualTreeAsset.Instantiate"
page_title: "Unity - Scripting API: UIElements.VisualTreeAsset.Instantiate"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset.Instantiate.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset.Instantiate.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [VisualTreeAsset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset.html).Instantiate

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

## Declaration

public [UIElements.TemplateContainer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.TemplateContainer.html) <span class="sig-kw">Instantiate</span>();

### Returns

**TemplateContainer** The root of the tree of VisualElements that was just cloned.

### Description

Build a tree of VisualElements from the asset.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public [UIElements.TemplateContainer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.TemplateContainer.html) <span class="sig-kw">Instantiate</span>(string <span class="sig-kw">bindingPath</span>);

### Parameters

| Parameter   | Description                                                                    |
|-------------|--------------------------------------------------------------------------------|
| bindingPath | The path to the property that you want to bind to the root of the cloned tree. |

### Returns

**TemplateContainer** The root of the tree of VisualElements that was just cloned.

### Description

Build a tree of VisualElements from the asset.

---
title: "Scripting API: UIElements.UQueryExtensions.Q"
page_title: "Unity - Scripting API: UIElements.UQueryExtensions.Q"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQueryExtensions.Q.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQueryExtensions.Q.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [UQueryExtensions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQueryExtensions.html).Q

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

public static T <span class="sig-kw">Q</span>([UIElements.VisualElement](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualElement.html) <span class="sig-kw">e</span>, string <span class="sig-kw">name</span>, params string\[\] <span class="sig-kw">classes</span>);

### Parameters

| Parameter | Description                                                                                                      |
|-----------|------------------------------------------------------------------------------------------------------------------|
| e         | Root VisualElement on which the selector will be applied.                                                        |
| name      | If specified, will select elements with this name.                                                               |
| classes   | If provided, it selects elements with all the specified classes (case sensitive, to be distinguished from Type). |

### Returns

**T** The first element matching all the criteria, or null if none was found.

### Description

Convenience overload, shorthand for `Query<T>().Build().First().`

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static [UIElements.VisualElement](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualElement.html) <span class="sig-kw">Q</span>([UIElements.VisualElement](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualElement.html) <span class="sig-kw">e</span>, string <span class="sig-kw">name</span>, params string\[\] <span class="sig-kw">classes</span>);

### Parameters

| Parameter | Description                                                                                                      |
|-----------|------------------------------------------------------------------------------------------------------------------|
| e         | Root VisualElement on which the selector will be applied.                                                        |
| name      | If specified, will select elements with this name.                                                               |
| classes   | If provided, it selects elements with all the specified classes (case sensitive, to be distinguished from Type). |

### Returns

**VisualElement** The first element matching all the criteria, or null if none was found.

### Description

Convenience overload, shorthand for `Query<T>().Build().First().`

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">Q</span>([UIElements.VisualElement](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualElement.html) <span class="sig-kw">e</span>, string <span class="sig-kw">name</span>, string <span class="sig-kw">className</span>);

### Parameters

| Parameter | Description                                                                                                |
|-----------|------------------------------------------------------------------------------------------------------------|
| e         | Root VisualElement on which the selector will be applied.                                                  |
| name      | If specified, will select elements with this name.                                                         |
| className | If provided, it selects elements with the specified class (case sensitive, to be distinguished from Type). |

### Returns

**T** The first element matching all the criteria, or null if none was found.

### Description

Convenience overload, shorthand for `Query<T>().Build().First().`

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static [UIElements.VisualElement](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualElement.html) <span class="sig-kw">Q</span>([UIElements.VisualElement](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualElement.html) <span class="sig-kw">e</span>, string <span class="sig-kw">name</span>, string <span class="sig-kw">className</span>);

### Parameters

| Parameter | Description                                                                                                |
|-----------|------------------------------------------------------------------------------------------------------------|
| e         | Root VisualElement on which the selector will be applied.                                                  |
| name      | If specified, will select elements with this name.                                                         |
| className | If provided, it selects elements with the specified class (case sensitive, to be distinguished from Type). |

### Returns

**VisualElement** The first element matching all the criteria, or null if none was found.

### Description

Convenience overload, shorthand for `Query<T>().Build().First().`

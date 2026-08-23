---
title: "Scripting API: MonoBehaviour.destroyCancellationToken"
page_title: "Unity - Scripting API: MonoBehaviour.destroyCancellationToken"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-destroyCancellationToken.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-destroyCancellationToken.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).destroyCancellationToken

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html" class="switch-link gray-btn sbtn left show" title="Go to MonoBehaviour Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>public CancellationToken <span class="sig-kw">destroyCancellationToken</span>;

### Description

Cancellation token raised when the MonoBehaviour is destroyed (Read Only).

**Note:** You must cache the `destroyCancellationToken` before you destroy the MonoBehaviour object.

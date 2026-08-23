---
title: "Scripting API: AsyncOperation"
page_title: "Unity - Scripting API: AsyncOperation"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# AsyncOperation

class in UnityEngine

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/YieldInstruction.html" class="cl">YieldInstruction</a>

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

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

Class representing an asynchronous operation, which can be used as a yield instruction in a coroutine or awaited with the await operator.

`AsyncOperation` inherits from [YieldInstruction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/YieldInstruction.html) and can be `yield` returned from a coroutine. You can also perform actions like the following:

-   Check its progress without any coroutine, for example checking [AsyncOperation.isDone](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation-isDone.html) or [AsyncOperation.progress](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation-progress.html) inside [MonoBehaviour.Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html).
-   Subscribe to its completed event [AsyncOperation.completed](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation-completed.html) to receive a callback when it finishes.
-   Adjust properties such as [AsyncOperation.allowSceneActivation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation-allowSceneActivation.html) while it's running.
-   Await its completion with the `await` key word as part of Unity's [Awaitable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html) support.

Additional resources: [SceneManager.LoadSceneAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html), [AssetBundle.LoadAssetAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetBundle.LoadAssetAsync.html), [Resources.LoadAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.LoadAsync.html).

``` codeExampleCS
using System.Collections;
using UnityEngine;

public class ExampleClass : MonoBehaviour

    public IEnumerator Example_AsyncTests()
    
}
```

### Properties

| Property                                                                                                                       | Description                                                                                                                                   |
|--------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| [allowSceneActivation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation-allowSceneActivation.html) | Allows a scene to be activated as soon as it's ready.                                                                                         |
| [isDone](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation-isDone.html)                             | When the value is true, then the operation has finished. Otherwise, the operation is in progress. (Read Only)                                 |
| [priority](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation-priority.html)                         | Integer representing the execution order priority of this AsyncOperation.                                                                     |
| [progress](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation-progress.html)                         | A floating point value representing the operation's current state of progress toward completion, where 1.0 represents completion. (Read Only) |

### Events

| Event                                                                                                    | Description                                              |
|----------------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| [completed](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation-completed.html) | Raised when this AsyncOperation operation has completed. |

### Inherited Members

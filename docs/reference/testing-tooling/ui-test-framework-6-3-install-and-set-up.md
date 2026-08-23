---
title: "UI Test Framework: install and set up"
page_title: "Install and set up UI Test Framework | UI Test Framework | 6.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/install-and-set-up.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/install-and-set-up.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Install and set up UI Test Framework

UI Test Framework leverages [NUnit](https://nunit.org) and works with the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/test-framework-introduction.html" class="xref">Unity Test Framework (UTF)</a>. You can use it to create and execute automated UI tests in your Unity projects.

To set up your project to use the UI Test Framework, follow these steps.

## Install the packages

Follow these steps to install the required packages:

1.  In **Package Manager**, install **UI Test Framework** from the **Unity Registry**.
2.  In the **Built-in** tab of **Package Manager**, enable the **UIElements** package if it's not already enabled.

## Add assembly references and import namespaces

UI Test Framework functionality is distributed across two assemblies.

| Assembly                         | Namespace                                                                                                                                                                       | Usage                                                                        |
|:---------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------|
| `Unity.UI.TestFramework.Runtime` | <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/api/UnityEngine.UIElements.TestFramework.html" class="xref">UnityEngine.UIElements.TestFramework</a> | For tests that need access to functionality available at Editor and Runtime. |
| `Unity.UI.TestFramework.Editor`  | <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/api/UnityEditor.UIElements.TestFramework.html" class="xref">UnityEditor.UIElements.TestFramework</a> | For tests that only need access to Editor-specific functionality.            |

To add references to the assemblies to your test assembly:

1.  In the **Project** window, locate the test assembly that needs the reference.
2.  In the **Inspector** window, In the **Assembly Definition Reference** section, select **+**.
3.  Select the following assemblies as needed:
    -   `Unity.UI.TestFramework.Runtime`
    -   `Unity.UI.TestFramework.Editor`

To import the namespaces for UI Test Framework functionality, add the following `using` statements to your test scripts:

``` lang-csharp
// Use this when a test class needs access to functionality available at Editor and Runtime.
using UnityEngine.UIElements.TestFramework;
// Use this when a test class needs access to Editor-specific functionality.
using UnityEditor.UIElements.TestFramework;
```

## Additional resources

-   <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui.html" class="xref">The Package Manager window</a>
-   <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-files.html" class="xref">Organize scripts into assemblies</a>

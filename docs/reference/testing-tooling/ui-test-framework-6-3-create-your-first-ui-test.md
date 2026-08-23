---
title: "UI Test Framework: create your first UI test"
page_title: "Create your first UI test | UI Test Framework | 6.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/create-your-first-ui-test.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/create-your-first-ui-test.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create your first UI test

Use this simple example to get started with the UI Test Framework. This example demonstrates how to set up a simple UI, create a test using the test fixtures, and run a test that simulates a button click to verify its behavior.

## Create a simple UI for testing

Create a simple Editor window with a button to test. When the button is clicked, its text changes to `Button was clicked!`.

1.  Create a Unity project and <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/install-and-set-up.html" class="xref">install the UI Test Framework package</a>.

2.  In the **Project** window, create a folder named `Editor` (if it doesn't already exist).

3.  In the `Editor` folder, create a new C# script named `SimpleEditorWindow.cs` with the following content:

    ``` lang-cs
    using UnityEditor;
    using UnityEngine;
    using UnityEngine.UIElements;

    public class SimpleEditorWindow : EditorWindow
    
        public void CreateGUI()
        {
            VisualElement root = rootVisualElement;

            Button button = new Button() { text = "Button not clicked" };
            button.clicked += () => { button.text = "Button was clicked!"; };
            root.Add(button);
        }
    }
    ```

## Create the assembly definition

Create an assembly definition for the `SimpleEditorWindow` script to allow the test class to reference it. Also create an assembly definition for the test fixture itself and reference the necessary test framework assemblies.

1.  In the `Editor` folder, right-click and select **Create** > **Scripting** > **Assembly Definition** to create an assembly definition file named `SimpleEditorWindow.Editor.asmdef` with the following content:

    ``` lang-json
    
    ```

2.  Inside the `Editor` folder, create a folder named `Tests`.

3.  Inside the `Tests` folder, right-click and select **Create** > **Scripting** > **Assembly Definition** to create an assembly definition file named `SimpleEditorWindow.Tests.Editor.asmdef` with the following content:

    ``` lang-json
    
    ```

## Create the test script and run the tests

Create a test class that inherits from the `EditorWindowUITestFixture` because the test requires an actual `EditorWindow` instance. For more information, refer to <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/test-fixtures/introduction-to-test-fixtures.html" class="xref">Introduction to test fixtures</a>. The test simulates a button click, and verifies that the button text changes as expected.

1.  Inside the `Editor/Tests` folder, create a C# script named `SimpleEditorWindowTest.cs` with the following content:

    ``` lang-cs
    using NUnit.Framework;
    using UnityEditor.UIElements.TestFramework;
    using UnityEngine;
    using UnityEngine.UIElements;

    public class SimpleEditorWindowTest : EditorWindowUITestFixture<SimpleEditorWindow>
    
    }
    ```

2.  From the menu, select **Window** > **General** > **Test Runner**.

3.  In the **Test Runner** window, select the **EditMode** tab.

4.  Select `SimpleEditorWindow.Tests.Editor.dll`.

5.  Select **Run** to execute your tests.

## Additional resources

-   <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/test-fixtures/introduction-to-test-fixtures.html" class="xref">Introduction to test fixtures</a>
-   <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/simulate/simulate-ui-interaction-landing.html" class="xref">Simulate UI interactions</a>

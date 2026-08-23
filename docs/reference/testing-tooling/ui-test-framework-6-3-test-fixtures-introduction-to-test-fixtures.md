---
title: "UI Test Framework: introduction to test fixtures"
page_title: "Introduction to UI test fixtures | UI Test Framework | 6.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/test-fixtures/introduction-to-test-fixtures.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/test-fixtures/introduction-to-test-fixtures.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to UI test fixtures

The UI test fixtures are base classes that your test classes can inherit from. The test fixtures manage the lifetime (set up and tear down) of your test's UI. Depending on the test fixture, they can provide your test with an empty UI ready for you to populate, or they can spawn an existing UI you provide to it.

## Choose the appropriate test fixture

There are 4 test fixtures available to use. The following table summarizes each test fixture and its intended purpose:

| Test fixture                                                                                                                                                                                     | Intended purpose                                                                                                                                                                                                                                                                                          |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/api/UnityEngine.UIElements.TestFramework.UITestFixture.html" class="xref">UITestFixture</a>                           | <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/test-fixtures/test-in-both-editor-and-runtime-states.html" class="xref">Create tests that run in both Editor and Runtime states</a>. This fixture provides an empty panel instance for you to populate during the test. |
| <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/api/UnityEditor.UIElements.TestFramework.EditorWindowUITestFixture-1.html" class="xref">EditorWindowUITestFixture</a> | <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/test-fixtures/test-ui-with-editor-window-instances.html" class="xref">Create tests that require an actual <code>EditorWindow</code> instance</a>. This fixture spawns and manages an `EditorWindow` instance for you.   |
| <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/api/UnityEngine.UIElements.TestFramework.RuntimeUITestFixture.html" class="xref">RuntimeUITestFixture</a>             | <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/test-fixtures/test-ui-in-runtime.html" class="xref">Create tests that run in the runtime state</a>. This fixture provides an empty `UIDocument` object for runtime testing.                                             |

The following decision tree can help you decide which test fixture to use based on how you structure your UI:

flowchart TD A{{Are you testing an EditorWindow?}} B{{Are you testing a UI in a scene?}} C("UITestFixture \<span style='font-size:10px;'>Can be used in Editor or Runtime\</span>") D(EditorWindowUITestFixture) E(RuntimeUITestFixture) A --> \|No\| B A --> \|"Yes, my window logic relies on \<span style='font-family:Courier New;'>CreateGUI()\</span> or \<span style='font-family:Courier New;'>GUIView\</span> to run properly"\| D B --> \|No, I only need my UXML or custom controls\| C B --> \|Yes, my UI logic relies on my GameObject with a UIDocument component\| E classDef question fill:#FFF class A,B question click D "test-ui-with-editor-window-instances.html" "Test UI with Editor window instances" click E "test-ui-in-runtime.html" "Test UI in runtime" click C "test-in-both-editor-and-runtime-states.html" "Test in both Editor and runtime states"

## PanelSimulator

A key aspect of the test fixtures is the <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/api/UnityEngine.UIElements.TestFramework.PanelSimulator.html" class="xref">PanelSimulator</a>. Each test fixture initializes a `simulate` property, which inherits from the `PanelSimulator` base class. This property allows you to <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/test-fixtures/trigger-and-update-ui.html" class="xref">control the timing of your UI, update the UI as needed</a>, and <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/simulate/simulate-ui-interaction-landing.html" class="xref">simulate user interactions and events</a>.

There are different types of `PanelSimulator`, each designed to work in specific environments or scenarios. For more information about the different types of `PanelSimulator` and which test fixture uses which type, refer to <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/test-fixtures/create-multi-window-tests.html" class="xref">Create multi-window tests</a>.

## Test fixture properties

The test fixtures share common base classes and therefore have some common properties that are important to know for writing tests.

The following table summarizes several important properties for writing tests.

| Common Property                                                                                                                                                                                                                                                | Description                                                          |
|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/api/UnityEngine.UIElements.TestFramework.CommonUITestFixture.html#UnityEngine_UIElements_TestFramework_CommonUITestFixture_simulate" class="xref"><code>simulate</code></a>         | Simulates events and time increments, and updates your UI.           |
| <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/api/UnityEngine.UIElements.TestFramework.PanelSimulator.html#UnityEngine_UIElements_TestFramework_PanelSimulator_rootVisualElement" class="xref"><code>rootVisualElement</code></a> | Modifies your UI, adds or removes elements, or queries for elements. |
| <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/api/UnityEngine.UIElements.TestFramework.AbstractUITestFixture.html#UnityEngine_UIElements_TestFramework_AbstractUITestFixture_panelSize" class="xref"><code>panelSize</code></a>   | Sets the size of the panel managed by the test fixture.              |

For a complete reference of all the common properties and methods, refer to <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/api/UnityEngine.UIElements.TestFramework.AbstractUITestFixture.html" class="xref">AbstractUITestFixture</a> and <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/api/UnityEngine.UIElements.TestFramework.CommonUITestFixture.html" class="xref">CommonUITestFixture</a>.

## Test fixture class diagram

This class diagram illustrates the relationships between the different test fixtures:

--- config: class: hideEmptyMembersBox: true --- classDiagram direction TB class AbstractUITestFixture { } class CommonUITestFixture { } class RuntimeUITestFixture { } class UITestFixture { } class EditorUITestFixture { } style AbstractUITestFixture fill:#FFF style CommonUITestFixture fill:#FFF style EditorUITestFixture fill:#FFF \<\<internal>\> AbstractUITestFixture \<\<internal>\> CommonUITestFixture \<\<internal>\> EditorUITestFixture namespace Editor { class EditorWindowUITestFixture { } class EditorUITestFixture { } class UITestFixture { } } namespace Runtime { class RuntimeUITestFixture { } class UITestFixture { } } AbstractUITestFixture \<\|-- CommonUITestFixture CommonUITestFixture \<\|-- EditorUITestFixture CommonUITestFixture \<\|-- EditorWindowUITestFixture CommonUITestFixture \<\|-- RuntimeUITestFixture AbstractUITestFixture \<\|-- UITestFixture RuntimeUITestFixture \<\|.. UITestFixture : can instantiate EditorUITestFixture \<\|.. UITestFixture : can instantiate

## Additional resources

-   <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorWindow.html" class="xref">EditorWindow</a>
-   <a href="https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/api/UnityEngine.UIElements.TestFramework.PanelSimulator.html" class="xref">PanelSimulator</a>
-   <a href="https://docs.unity3d.com/6000.0/Documentation/Manual/UIE-panels.html" class="xref">Panels</a>

---
title: "Add tests to your package"
page_title: "Unity - Manual: Add tests to your package"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/cus-tests.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/cus-tests.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Add tests to your package

Add tests to your Unity Package Manager (UPM) package to verify its behavior and identify issues during development.

Adding tests is relevant if you’re creating a package that contains scripts or logic you want to validate as your package evolves. Including tests helps you catch bugs, improve reliability, and support safe reuse of the package across projects. Unity’s test framework lets you organize and run these tests from within the Unity Editor or as part of your continuous integration (CI) pipeline.

When you [create your package](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-create.html) with the Package Manager window, Package Manager creates `Tests/Editor` and `Tests/Runtime` folders with C# and assembly definition (`.asmdef`) files in each, to help you get started.

To complete the test files for your package:

1.  Go to your package folder, either by using the **Project** window or your file management application.
2.  Go to the `Tests/Editor` or `Tests/Runtime` folder for the tests you want to complete.
3.  Open the sample C# script.
4.  Add test cases as needed. A good practice is to create at least one test file for each C# script. Refer to [Writing tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/writing-tests.html).
5.  Save your file.
6.  If you create a more elaborate folder structure in your `Tests` folder, you can optionally create additional `asmdef` files for the code you want to put in separate assemblies. If you choose to create additional assembly definitions, refer to [Assembly definition files for tests](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-tests.html#files).
7.  [Enable tests](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-tests.html#tests) for your package.
8.  Run your tests. For more information, refer to [Running tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/running-tests.html).

<span id="files"></span>

## Assembly definition files for tests

Use the [Test Framework](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/test-framework-introduction.html) to create or edit your assembly definition files. For more information, refer to [Create a test assembly](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-create-test-assembly.html).

When you [create your package](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-create.html) with the Package Manager window, Package Manager creates assembly definition files (`.asmdef`) in `Tests/Editor` and `Tests/Runtime` to accompany the test scripts it created in those folders.

The sample assembly definition files have the required properties and values. If you want to add optional properties and values, use the **Inspector** window to edit the assembly definitions. For more information, refer to [Assembly Definition properties reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html).

You can also edit `.asmdef` files directly, but this method is more error prone. For more information, refer to [Assembly Definition File Format reference](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-file-format.html).

### Editor file example

The `.asmdef` file in the `Tests/Editor` folder looks like this:

``` lang-json

```

### Runtime file example

The `.asmdef` file in the `Tests/Runtime` folder looks like this:

``` lang-json

```

<span id="tests"></span>

## Enable tests for a package

You might need to enable tests depending on the folder where you’re developing your package.

If you’re developing your package in the `Packages` folder of your project, you don’t need to explicitly enable tests.

However, if you’re developing a package outside the project’s `Packages` folder, you need to manually enable its tests. To do this, add the [testables](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html#testables) property to your project manifest and list the packages whose tests you want to run. If you also want to run tests from packages they depend on, include those indirect dependencies as well. For example:

``` lang-json
{
  "dependencies": {
    "com.unity.some-package": "1.0.0",
    "com.unity.other-package": "2.0.0",
    "com.unity.yet-another-package": "3.0.0"
  },
  "testables": ["com.unity.some-package", "com.unity.other-package"]
}
```

This example adds tests for the `com.unity.some-package` and `com.unity.other-package` packages in Unity’s [Test Framework](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/test-framework-introduction.html) package.

## Additional resources

-   [Testing your code](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/test-framework-introduction.html)
-   [Organizing scripts into assemblies](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-files.html)
-   [Assembly Definition properties reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html)
-   [Comparison of package creation locations](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-location.html)
-   [Package dependency and resolution](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-dependencies.html)

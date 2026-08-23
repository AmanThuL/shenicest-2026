---
title: "Preserving code using annotations"
page_title: "Unity - Manual: Preserving code using annotations"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-preserving.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-preserving.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Preserving code using annotations

You can use annotations to prevent the Unity linker from stripping specific sections of your code. This is helpful if your application produces runtime code which doesn’t exist when Unity performs the static analysis; for example, through [reflection](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/reflection). Annotations either provide general guidance to the Unity linker about which code patterns it shouldn’t strip, or instructions not to strip a specific, defined section of code.

There are two broad approaches you can use to annotate your code to preserve it from the managed code stripping process:

-   [Root annotations](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-preserving.html#root-annotations) identify parts of your code as roots. The Unity linker doesn’t strip any code marked as a root. Root annotations are less complicated to use but can also lead to the Unity linker preserving some code that it should strip.
-   [Dependency annotations](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-preserving.html#dependency-annotations) define the connections between code elements. Dependency annotations can reduce unnecessary code preservation compared to root annotations.

Each of these techniques provides more control over the amount of code the Unity linker strips at higher stripping levels and reduces the chance of vital code being stripped. Annotations are especially useful when your code references other code through reflection, because the Unity linker can’t always detect uses of reflection.

Preserve code that uses reflection or generates other code at runtime to significantly reduce the likelihood of unexpected behavior when your application is executed. For examples of reflection patterns that the Unity linker can recognize, refer to [Unity Intermediate Language Linker reflection test suite](https://github.com/Unity-Technologies/linker/tree/unity-master/test/Mono.Linker.Tests.Cases/Reflection).

<span id="root-annotations"></span>

## Root annotations

Root annotations force the Unity linker to treat code elements as roots, which aren’t stripped in the code stripping process. There are two types of root annotations you can use, depending on whether you need to preserve individual types with their constructors or assemblies:

-   [Preserve Attribute](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-preserving.html#PreserveAttribute): Annotates individual types as roots to preserve them.
-   [Link.xml](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-preserving.html#LinkXMLAnnotation): Annotates assemblies and any types or other code entities within those assemblies as roots to preserve them.

<span id="PreserveAttribute"></span>

### Annotate roots using the Preserve attribute

Use the [`[Preserve]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.PreserveAttribute.html) attribute to individually exclude specific sections of your code from the Unity linker’s static analysis. To annotate a piece of code with this attribute, add `[Preserve]` immediately before the first part of the code you want to preserve. The following list describes what entities the Unity linker preserves when you annotate different code elements with the `[Preserve]` attribute:

-   **Assembly**: Preserves all types that are used and defined in the assembly. To assign the `[Preserve]` attribute to an assembly, place the attribute declaration in any C# file included in the assembly, before any namespace declarations.
-   **Type**: Preserves a class or type and its default constructor.
-   **Method**: Preserves the method, the type that declares the method, the type the method returns, and the types of all of its arguments.
-   **Property**: Preserves the property, the type that declares the property, the value type of the property, and methods that get and set the property value.
-   **Field**: Preserves the field, the field type, and the type that declares the field.
-   **Event**: Preserves the event, the type that declares the event, type, the type the event returns, the `[add]` accessor, and the `[remove]` accessor.
-   **Delegate**: Preserves the delegate type and all methods that the delegate invokes.

Use the `[Preserve]` attribute when you want to preserve both a type and its default constructor. If you want to keep one or the other but not both, use a `link.xml` file.

You can define the `[Preserve]` attribute in any assembly and in any namespace. You can use the [`PreserveAttribute`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.PreserveAttribute.html) class, create a subclass of it, or create your own class. For example:

``` lang-cs
class Foo

}
```

<span id="LinkXMLAnnotation"></span>

### Annotate roots using a Link XML file

You can include a .xml file named `link.xml` in your project to preserve a list of specific assemblies or parts of assemblies. The `link.xml` file must be present in the `Assets` folder or a subdirectory of the `Assets` folder in your project and must include the `<linker>` tag in the file. The Unity linker treats any assembly, type, or member preserved in a `link.xml` file as a root type.

You can use any number of `link.xml` files in your project. As a result, you can provide separate preservation declarations for each plug-in. You can’t include a `link.xml` file in a package, but you can reference package assemblies from non-package `link.xml` files.

For information on how to format the `link.xml` file, refer to [Link XML formatting reference](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-xml-formatting.html).

<span id="dependency-annotations"></span>

## Dependency annotations

Dependency annotations define dependencies between various code elements. These annotations are useful for preserving code patterns that the Unity linker can’t statically analyze, such as reflection. These annotations also ensure that these code elements aren’t erroneously preserved when no root element uses them. There are two methods you can use to change how the Unity linker processes code elements:

-   [Annotation attributes](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-preserving.html#AnnotationAttributes): These attributes indicate that the Unity linker should preserve a particular code pattern, such as any type that derives from the annotated type.
-   [AlwaysLinkAssemblyAttribute](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-preserving.html#AlwaysLinkAssemblyAttribute): Use this attribute to indicate that the Unity linker should process an assembly even if it’s not referenced by any other assemblies in your Project.

<span id="AnnotationAttributes"></span>

### Annotation attributes

The `[Preserve]` attribute is useful for situations when an API is always needed. Other attributes can be useful for more general preservations. For example, you can preserve all types that implement a particular interface by annotating the interface with the [`[RequireImplementorsAttribute]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.RequireImplementorsAttribute.html).

To annotate specific coding patterns, use one or more of the following attributes:

-   [`RequireImplementorsAttribute`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.RequireImplementorsAttribute.html): Marks all types that implement this interface as dependencies.
-   [`RequireDerivedAttribute`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.RequireDerivedAttribute.html): Marks all types that derive from this type as dependencies.
-   [`RequiredInterfaceAttribute`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.RequiredInterfaceAttribute.html): Marks interface implementations on types as dependencies.
-   [`RequiredMemberAttribute`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.RequiredMemberAttribute.html): Marks all members of a type as dependencies.
-   [`RequireAttributeUsagesAttribute`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.RequireAttributeUsagesAttribute.html): Marks custom attributes as dependencies.

You can combine these attributes in various ways to more precisely control how the Unity linker preserves your code.

<span id="AlwaysLinkAssemblyAttribute"></span>

### AlwaysLinkAssembly attribute

The [`[AlwaysLinkAssembly]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.AlwaysLinkAssemblyAttribute.html) attribute forces the Unity linker to search an assembly regardless of whether or not the assembly is referenced by another assembly that is included in the build. You can only apply the attribute to an assembly.

The attribute doesn’t directly preserve code within the assembly. Instead, this attribute instructs the Unity linker to apply the [root marking rules](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-marking-rules.html#root-marking-rules) to the assembly. If no code elements match the root marking rules for the assembly, the Unity linker still removes the assembly from the build.

Use this attribute on precompiled or package assemblies that contain one or more methods with the `[RuntimeInitializeOnLoadMethod]` attribute, but which might not contain types used directly or indirectly in any scenes in a project.

If an assembly defines `[assembly: AlwaysLinkAssembly]` and is also referenced by another assembly included in the build, the attribute has no effect on the output.

## Additional resources

-   [Managed code stripping and the Unity linker](https://docs.unity3d.com/6000.3/Documentation/Manual/unity-linker.html)
-   [Configure managed code stripping](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-configure.html)
-   [Link XML formatting reference](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-xml-formatting.html)
-   [Unity linker marking rules reference](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-marking-rules.html)
-   [IUnityLinkerProcessor.GenerateAdditionalLinkXmlFile](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IUnityLinkerProcessor.GenerateAdditionalLinkXmlFile.html)

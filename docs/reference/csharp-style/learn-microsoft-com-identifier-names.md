---
title: "Microsoft: C# identifier names"
page_title: "Identifier names - rules and conventions - C# | Microsoft Learn"
source_url: "https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/identifier-names"
final_url: "https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/identifier-names"
topic: "csharp-style"
publisher: "third-party"
fetched: "2026-08-23"
kind: "html"
---

# Identifier names - rules and conventions - C# | Microsoft Learn

<span class="icon" aria-hidden="true"><span class="docon docon-menu"></span></span> <span class="contents-expand-title"> Table of contents </span>

<span class="icon" aria-hidden="true"><span class="docon docon-exit-mode"></span></span> Exit editor mode

<span class="icon" aria-hidden="true"> <span class="docon docon-more"></span> </span>

<span class="icon" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span>

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon" aria-hidden="true"> <span class="docon docon-more-vertical"></span> </span>

<span class="icon" aria-hidden="true"> <span class="docon docon-glasses"></span> </span> Reading mode

<span class="icon" aria-hidden="true"><span class="docon docon-editor-list-bullet"></span></span> <span class="contents-expand-title">Table of contents</span>

<a href="https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/identifier-names#" id="lang-link-overflow" class="button-sm inner-focus button button-clear button-block justify-content-flex-start text-align-left"><span class="icon" aria-hidden="true" data-read-in-link-icon=""> <span class="docon docon-locale-globe"></span> </span> <span data-read-in-link-text="">Read in English</span></a>

<span class="icon" aria-hidden="true"> <span class="docon docon-circle-addition"></span> </span> <span class="collection-status">Add</span>

<span class="icon" aria-hidden="true"> <span class="docon docon-circle-addition"></span> </span> <span class="plan-status">Add to Plans</span>

<a href="https://github.com/dotnet/docs/blob/main/docs/csharp/fundamentals/coding-style/identifier-names.md" class="button button-clear button-block button-sm inner-focus justify-content-flex-start text-align-left text-decoration-none"><span class="icon" aria-hidden="true"> <span class="docon docon-edit-outline"></span> </span> <span>Edit</span></a>

------------------------------------------------------------------------

<span class="icon color-primary" aria-hidden="true"> <span class="docon docon-code-lang" show-when="idle"></span> <span class="loader" show-when="loading" hidden=""></span> <span class="docon docon-check-mark" show-when="success" hidden=""></span> </span> Copy Markdown

<span class="icon color-primary" aria-hidden="true"> <span class="docon docon-print"></span> </span> Print

------------------------------------------------------------------------

<span class="icon" aria-hidden="true"><span class="docon docon-exclamation-circle-solid"></span></span> Note

Access to this page requires authorization. You can try <a href="https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/identifier-names#" class="docs-sign-in">signing in</a> or <span class="docs-change-directory">changing directories</span>.

Access to this page requires authorization. You can try <span class="docs-change-directory">changing directories</span>.

# C# identifier naming rules and conventions

<span class="icon" aria-hidden="true"> <span class="docon docon-like"></span> </span> Feedback

<span class="icon" aria-hidden="true"> <span class="docon docon-sparkle-fill gradient-text-vivid"></span> </span>

<span class="ai-summary-cta-text"> Summarize this article for me </span>

An **identifier** is the name you assign to a type (class, interface, struct, delegate, or enum), member, variable, or namespace.

This article covers the essential rules for valid C# identifiers and the naming conventions used to help you write consistent, professional code.

## Naming rules

Valid identifiers must follow these rules. The C# compiler produces an error for any identifier that doesn't follow these rules:

-   Identifiers must start with a letter or underscore (`_`).
-   Identifiers can contain Unicode letter characters, decimal digit characters, Unicode connecting characters, Unicode combining characters, or Unicode formatting characters. For more information on Unicode categories, see the [Unicode Category Database](https://www.unicode.org/reports/tr44/).

You can declare identifiers that match C# keywords by using the `@` prefix on the identifier. The `@` isn't part of the identifier name. For example, `@if` declares an identifier named `if`. These [verbatim identifiers](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/verbatim) are primarily for interoperability with identifiers declared in other languages.

For a complete definition of valid identifiers, see the [Identifiers article in the C# Language Specification](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/lexical-structure#643-identifiers).

Important

[The C# language specification](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/lexical-structure#643-identifiers) only allows letter (Lu, Ll, Lt, Lm, or Nl), digit (Nd), connecting (Pc), combining (Mn or Mc), and formatting (Cf) categories. Anything outside that is automatically replaced using `_`. This might impact certain Unicode characters.

## Naming conventions

In addition to the rules, conventions for identifier names are used throughout the .NET APIs. These conventions provide consistency for names, but the compiler doesn't enforce them. You're free to use different conventions in your projects.

By convention, C# programs use `PascalCase` for type names, namespaces, and all public members. In addition, the `dotnet/docs` team uses the following conventions, adopted from the [.NET Runtime team's coding style](https://github.com/dotnet/runtime/blob/main/docs/coding-guidelines/coding-style.md):

-   Interface names start with a capital `I`.

-   Attribute types end with the word `Attribute`.

-   Enum types use a singular noun for nonflags, and a plural noun for flags.

-   Identifiers shouldn't contain two consecutive underscore (`_`) characters. Those names are reserved for compiler-generated identifiers.

-   Use meaningful and descriptive names for variables, methods, and classes.

-   Prefer clarity over brevity.

-   Use PascalCase for class names and method names.

-   Use camelCase for method arguments, local variables, and private and internal non-constant fields.

-   Private and internal non-constant instance fields start with an underscore (`_`).

-   To maintain consistency across all access modifiers, use PascalCase for constant names, both fields and local constants, including `private` and `internal` constants.

-   Static fields start with `s_`. This convention isn't the default Visual Studio behavior, nor part of the [Framework design guidelines](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/names-of-type-members#names-of-fields), but is [configurable in editorconfig](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/style-rules/naming-rules).

-   Avoid using abbreviations or acronyms in names, except for widely known and accepted abbreviations.

-   Use meaningful and descriptive namespaces that follow the reverse domain name notation.

-   Choose assembly names that represent the primary purpose of the assembly.

-   Avoid using single-letter names, except for simple loop counters. Also, syntax examples that describe the syntax of C# constructs often use the following single-letter names that match the convention used in the [C# language specification](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/readme). Syntax examples are an exception to the rule.

    -   Use `S` for structs, `C` for classes.
    -   Use `M` for methods.
    -   Use `v` for variables, `p` for parameters.
    -   Use `r` for `ref` parameters.

Tip

You can enforce naming conventions that concern capitalization, prefixes, suffixes, and word separators by using [code-style naming rules](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/style-rules/naming-rules).

In the following examples, guidance pertaining to elements marked `public` is also applicable when working with `protected` and `protected internal` elements, all of which are intended to be visible to external callers.

### Pascal case

Use pascal casing ("PascalCasing") when naming a `class`, `interface`, `struct`, or `delegate` type.

``` lang-csharp
public class DataService

```

``` lang-csharp
public record PhysicalAddress(
    string Street,
    string City,
    string StateOrProvince,
    string ZipCode);
```

``` lang-csharp
public struct ValueCoordinate

```

``` lang-csharp
public delegate void DelegateType(string message);
```

When naming an `interface`, use pascal casing in addition to prefixing the name with an `I`. This prefix clearly indicates to consumers that it's an `interface`.

``` lang-csharp
public interface IWorkerQueue

```

When naming `public` members of types, such as fields, properties, events, use pascal casing. Also, use pascal casing for all methods and local functions.

``` lang-csharp
public class ExampleEvents

    // An event
    public event Action EventProcessing;

    // Method
    public void StartEventProcessing()
    
}
```

When writing positional records, use pascal casing for parameters as they're the public properties of the record.

``` lang-csharp
public record PhysicalAddress(
    string Street,
    string City,
    string StateOrProvince,
    string ZipCode);
```

For more information on positional records, see [Positional syntax for property definition](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/record#positional-syntax-for-property-and-field-definition).

### Camel case

Use camel casing ("camelCasing") when naming `private` or `internal` non-constant fields, and prefix them with `_`. Use camel casing when naming local variables, including instances of a delegate type.

``` lang-csharp
public class DataService

```

Tip

When editing C# code that follows these naming conventions in an IDE that supports statement completion, typing `_` will show all of the object-scoped members.

When working with `static` fields that are `private` or `internal`, use the `s_` prefix and for thread static use `t_`.

``` lang-csharp
public class DataService

```

When writing method parameters, use camel casing.

``` lang-csharp
public T SomeMethod<T>(int someNumber, bool isValid)

```

#### Primary constructor parameters

How you name primary constructor parameters depends on the type being declared:

-   For `class` and `struct` types: Use camel casing, consistent with other method parameters.

    ``` lang-csharp
    public class DataService(IWorkerQueue workerQueue, ILogger logger)
    
    }
    ```

    ``` lang-csharp
    public struct Point(double x, double y)
    
    ```

-   For `record` types: Use Pascal casing, as the parameters become public properties.

    ``` lang-csharp
    public record Person(string FirstName, string LastName);
    public record Address(string Street, string City, string PostalCode);
    ```

For more information on primary constructors, see [Primary constructors](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/instance-constructors#primary-constructors).

For more information on C# naming conventions, see the [.NET Runtime team's coding style](https://github.com/dotnet/runtime/blob/main/docs/coding-guidelines/coding-style.md).

### Type parameter naming guidelines

The following guidelines apply to type parameters on generic type parameters. Type parameters are the placeholders for arguments in a generic type or a generic method. You can read more about [generic type parameters](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/generic-type-parameters) in the C# programming guide.

-   **Do** name generic type parameters with descriptive names, unless a single letter name is completely self explanatory and a descriptive name wouldn't add value.

    ``` lang-csharp
    public interface ISessionChannel<TSession> 
    public delegate TOutput Converter<TInput, TOutput>(TInput from);
    public class List<T> 
    ```

-   **Consider** using `T` as the type parameter name for types with one single letter type parameter.

    ``` lang-csharp
    public int IComparer<T>() => 0;
    public delegate bool Predicate<T>(T item);
    public struct Nullable<T> where T : struct 
    ```

-   **Do** prefix descriptive type parameter names with "T".

    ``` lang-csharp
    public interface ISessionChannel<TSession>
    
    }
    ```

-   **Consider** indicating constraints placed on a type parameter in the name of parameter. For example, a parameter constrained to `ISession` might be called `TSession`.

The code analysis rule [CA1715](https://learn.microsoft.com/en-us/visualstudio/code-quality/ca1715) can be used to ensure that type parameters are named appropriately.

### Extra naming conventions

-   Examples that don't include [using directives](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/using-directive), use namespace qualifications. If you know that a namespace is imported by default in a project, you don't have to fully qualify the names from that namespace. Qualified names can be broken after a dot (.) if they're too long for a single line, as shown in the following example.

    ``` lang-csharp
    var currentPerformanceCounterCategory = new System.Diagnostics.
        PerformanceCounterCategory();
    ```

-   You don't have to change the names of objects that were created by using the Visual Studio designer tools to make them fit other guidelines.

<span class="icon margin-right-xxs" aria-hidden="true"> <span class="docon docon-brand-github"></span> </span> <span class="font-weight-semibold"> Collaborate with us on GitHub </span>

<span class="line-height-normal"> The source for this content can be found on GitHub, where you can also create and review issues and pull requests. For more information, see [our contributor guide](https://learn.microsoft.com/contribute/content/dotnet/dotnet-contribute). </span>

![](https://learn.microsoft.com/media/logos/logo_net.svg) ![](https://learn.microsoft.com/media/logos/logo_net.svg)

.NET

[<span class="icon margin-right-xxs" aria-hidden="true"> <span class="docon docon-bug"></span> </span> Open a documentation issue](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/identifier-names#) <a href="https://aka.ms/feedback/report?space=61" class="display-block margin-top-auto font-size-md"><span class="icon margin-right-xxs" aria-hidden="true"> <span class="docon docon-feedback"></span> </span> <span>Provide product feedback</span></a>

------------------------------------------------------------------------

## Feedback

Was this page helpful?

<span class="icon" aria-hidden="true"> <span class="docon docon-like"></span> </span> Yes

<span class="icon" aria-hidden="true"> <span class="docon docon-dislike"></span> </span> No

<span class="icon" aria-hidden="true"> <span class="docon docon-dislike"></span> </span> No

Need help with this topic?

Want to try using Ask Learn to clarify or guide you through this topic?

<span class="icon" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span>

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon" aria-hidden="true"> <span class="docon docon-feedback"></span> </span> Suggest a fix?

------------------------------------------------------------------------

## Additional resources

------------------------------------------------------------------------

-   <span class="badge badge-sm text-wrap-pretty"> Last updated on 2026-07-14 </span>

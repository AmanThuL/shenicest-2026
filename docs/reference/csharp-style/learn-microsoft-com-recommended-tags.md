---
title: "Microsoft: Recommended XML tags for C# documentation comments"
page_title: "Recommended XML documentation tags - C# reference | Microsoft Learn"
source_url: "https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags"
final_url: "https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags"
topic: "csharp-style"
publisher: "third-party"
fetched: "2026-08-23"
kind: "html"
---

# Recommended XML documentation tags - C# reference | Microsoft Learn

<span class="icon" aria-hidden="true"><span class="docon docon-menu"></span></span> <span class="contents-expand-title"> Table of contents </span>

<span class="icon" aria-hidden="true"><span class="docon docon-exit-mode"></span></span> Exit editor mode

<span class="icon" aria-hidden="true"> <span class="docon docon-more"></span> </span>

<span class="icon" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span>

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon" aria-hidden="true"> <span class="docon docon-more-vertical"></span> </span>

<span class="icon" aria-hidden="true"> <span class="docon docon-glasses"></span> </span> Reading mode

<span class="icon" aria-hidden="true"><span class="docon docon-editor-list-bullet"></span></span> <span class="contents-expand-title">Table of contents</span>

<a href="https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#" id="lang-link-overflow" class="button-sm inner-focus button button-clear button-block justify-content-flex-start text-align-left"><span class="icon" aria-hidden="true" data-read-in-link-icon=""> <span class="docon docon-locale-globe"></span> </span> <span data-read-in-link-text="">Read in English</span></a>

<span class="icon" aria-hidden="true"> <span class="docon docon-circle-addition"></span> </span> <span class="collection-status">Add</span>

<span class="icon" aria-hidden="true"> <span class="docon docon-circle-addition"></span> </span> <span class="plan-status">Add to Plans</span>

<a href="https://github.com/dotnet/docs/blob/main/docs/csharp/language-reference/xmldoc/recommended-tags.md" class="button button-clear button-block button-sm inner-focus justify-content-flex-start text-align-left text-decoration-none"><span class="icon" aria-hidden="true"> <span class="docon docon-edit-outline"></span> </span> <span>Edit</span></a>

------------------------------------------------------------------------

<span class="icon color-primary" aria-hidden="true"> <span class="docon docon-code-lang" show-when="idle"></span> <span class="loader" show-when="loading" hidden=""></span> <span class="docon docon-check-mark" show-when="success" hidden=""></span> </span> Copy Markdown

<span class="icon color-primary" aria-hidden="true"> <span class="docon docon-print"></span> </span> Print

------------------------------------------------------------------------

<span class="icon" aria-hidden="true"><span class="docon docon-exclamation-circle-solid"></span></span> Note

Access to this page requires authorization. You can try <a href="https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#" class="docs-sign-in">signing in</a> or <span class="docs-change-directory">changing directories</span>.

Access to this page requires authorization. You can try <span class="docs-change-directory">changing directories</span>.

# Recommended XML tags for C# documentation comments

<span class="icon" aria-hidden="true"> <span class="docon docon-like"></span> </span> Feedback

<span class="icon" aria-hidden="true"> <span class="docon docon-sparkle-fill gradient-text-vivid"></span> </span>

<span class="ai-summary-cta-text"> Summarize this article for me </span>

C# documentation comments use XML elements to define the structure of the output documentation. One consequence of this feature is that you can add any valid XML in your documentation comments. The C# compiler copies these elements into the output XML file. While you can use any valid XML in your comments (including any valid HTML element), documenting code is recommended for many reasons.

The C# language reference documents the most recently released version of the C# language. It also contains initial documentation for features in public previews for the upcoming language release.

The documentation identifies any feature first introduced in the last three versions of the language or in current public previews.

Tip

To find when a feature was first introduced in C#, consult the article on the [C# language version history](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-version-history).

What follows are some recommendations, general use case scenarios, and things that you should know when using XML documentation tags in your C# code. While you can put any tags into your documentation comments, this article describes the recommended tags for the most common language constructs. Adhere to these recommendations:

-   For the sake of consistency, document all publicly visible types and their public members.
-   You can also document private members by using XML comments. However, this approach exposes the inner (potentially confidential) workings of your library.
-   At a bare minimum, types and their members should have a `<summary>` tag.
-   Write documentation text using complete sentences that end with full stops.
-   Partial classes are fully supported, and documentation information is concatenated into a single entry for each type. If both declarations of a partial member have documentation comments, the comments on the implementing declaration are written to the output XML.

XML documentation starts with `///`. When you create a new project, the templates put some starter `///` lines in for you. The processing of these comments has some restrictions:

-   The documentation must be well-formed XML. If the XML isn't well formed, the compiler generates a warning. The documentation file contains a comment that says that an error was encountered.
-   Some of the recommended tags have special meanings:
    -   The `<param>` tag describes parameters. If you use this tag, the compiler verifies that the parameter exists and that all parameters are described in the documentation. If the verification fails, the compiler issues a warning.
    -   Attach the `cref` attribute to any tag to reference a code element. The compiler verifies that this code element exists. If the verification fails, the compiler issues a warning. The compiler respects any `using` directives when it looks for a type described in the `cref` attribute.
    -   IntelliSense inside Visual Studio uses the `<summary>` tag to display additional information about a type or member.
        

        Note

        The XML file doesn't provide full information about the type and members (for example, it doesn't contain any type information). To get full information about a type or member, use the documentation file together with reflection on the actual type or member.

        
-   Developers are free to create their own set of tags. The compiler copies these tags to the output file.

Some of the recommended tags can be used on any language element. Others have more specialized usage. Finally, some of the tags are used to format text in your documentation. This article describes the recommended tags organized by their use.

The compiler verifies the syntax of the elements followed by a single \* in the following list. Visual Studio provides IntelliSense for the tags verified by the compiler and all tags followed by \*\* in the following list. In addition to the tags listed here, the compiler and Visual Studio validate the `<b>`, `<i>`, `<u>`, `<br/>`, and `<a>` tags. The compiler also validates `<tt>`, which is deprecated HTML.

Note

HTML tags like `<br/>` are useful for formatting within documentation comments. The `<br/>` tag creates line breaks, while other HTML tags provide text formatting. These tags work in IntelliSense tooltips and generated documentation.

-   [General Tags](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#general-tags) used for multiple elements - These tags are the minimum set for any API.
    -   [`<summary>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#summary): The value of this element is displayed in IntelliSense in Visual Studio.
    -   [`<remarks>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#remarks) \*\*
-   [Tags used for members](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#document-members) - These tags are used when documenting methods and properties.
    -   [`<returns>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#returns): The value of this element is displayed in IntelliSense in Visual Studio.
    -   [`<param>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#param) \*: The value of this element is displayed in IntelliSense in Visual Studio.
    -   [`<paramref>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#paramref)
    -   [`<exception>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#exception) \*
    -   [`<value>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#value): The value of this element is displayed in IntelliSense in Visual Studio.
-   [Format documentation output](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#format-documentation-output) - These tags provide formatting directions for tools that generate documentation.
    -   [`<para>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#para)
    -   [`<list>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#list)
    -   [`<c>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#c)
    -   [`<code>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#code)
    -   [`<example>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#example) \*\*
    -   [`<b>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#b)
    -   [`<i>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#i)
    -   [`<u>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#u)
    -   [`<br/>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#br)
    -   [`<a>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#a)
-   [Reuse documentation text](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#reuse-documentation-text) - These tags provide tools that make it easier to reuse XML comments.
    -   [`<inheritdoc>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#inheritdoc) \*\*
    -   [`<include>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#include) \*
-   [Generate links and references](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#generate-links-and-references) - These tags generate links to other documentation.
    -   [`<see>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#see) \*
    -   [`<seealso>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#seealso) \*
    -   [`cref`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#cref-attribute)
    -   [`href`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#href-attribute)
-   [Tags for generic types and methods](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#generic-types-and-methods) - Use these tags only on generic types and methods.
    -   [`<typeparam>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#typeparam) \*: IntelliSense in Visual Studio shows the value of this element.
    -   [`<typeparamref>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#typeparamref)

Note

You can't apply documentation comments to a namespace.

If you want angle brackets to appear in the text of a documentation comment, use the HTML encoding of `<` and `>`, which is `&lt;` and `&gt;` respectively. The following example shows this encoding.

``` lang-csharp
/// <summary>
/// This property always returns a value &lt; 1.
/// </summary>
```

## General tags

### `<summary>`

``` lang-xml
<summary>description</summary>
```

Use the `<summary>` tag to describe a type or a type member. Use [`<remarks>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#remarks) to add supplemental information to a type description. Use the [cref attribute](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#cref-attribute) to enable documentation tools such as [DocFX](https://dotnet.github.io/docfx/) and [Sandcastle](https://github.com/EWSoftware/SHFB) to create internal hyperlinks to documentation pages for code elements. The text for the `<summary>` tag appears in IntelliSense and in the Object Browser window.

### `<remarks>`

``` lang-xml
<remarks>
description
</remarks>
```

Use the `<remarks>` tag to add information about a type or a type member, supplementing the information specified with [`<summary>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#summary). This information appears in the Object Browser window. This tag can include more lengthy explanations. You might find that using `CDATA` sections for markdown make writing it more convenient. Tools such as [docfx](https://dotnet.github.io/docfx/) process the markdown text in `CDATA` sections.

## Document members

### `<returns>`

``` lang-xml
<returns>description</returns>
```

Use the `<returns>` tag in the comment for a method declaration to describe the return value.

### `<param>`

``` lang-xml
<param name="name">description</param>
```

-   `name`: The name of a method parameter. Enclose the name in quotation marks ("). The names for parameters must match the API signature. If one or more parameters aren't covered, the compiler issues a warning. The compiler also issues a warning if the value of `name` doesn't match a formal parameter in the method declaration.

Use the `<param>` tag in the comment for a method declaration to describe one of the parameters for the method. To document multiple parameters, use multiple `<param>` tags. The text for the `<param>` tag appears in IntelliSense, the Object Browser, and the Code Comment Web Report.

### `<paramref>`

``` lang-xml
<paramref name="name"/>
```

-   `name`: The name of the parameter to refer to. Enclose the name in quotation marks (").

The `<paramref>` tag provides a way to indicate that a word in the code comments, such as in a `<summary>` or `<remarks>` block, refers to a parameter. You can process the XML file to format this word in a distinct way, such as by using a bold or italic font.

### `<exception>`

``` lang-xml
<exception cref="member">description</exception>
```

-   cref = "`member`": A reference to an exception that's available from the current compilation environment. The compiler checks that the given exception exists and translates `member` to the canonical element name in the output XML. `member` must appear within quotation marks (").

The `<exception>` tag lets you specify which exceptions a member can throw. Apply this tag to definitions for methods, properties, events, and indexers.

### `<value>`

``` lang-xml
<value>property-description</value>
```

The `<value>` tag lets you describe the value that a property represents. When you add a property by using the code wizard in the Visual Studio .NET development environment, it adds a [`<summary>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#summary) tag for the new property. You manually add a `<value>` tag to describe the value that the property represents.

### `<safety>`

``` lang-xml
<safety>description</safety>
```

Use the `<safety>` tag to document the contract that a caller of a *caller-unsafe* member must satisfy under the [updated memory safety model](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/unsafe-code#the-updated-memory-safety-model-preview), a preview feature in C# 15 and .NET 11. In the completed design, marking a member `unsafe` pushes the obligation to audit safety onto the caller, and the `<safety>` block states the conditions the caller must guarantee. The current preview compiler doesn't yet enforce that obligationâ€”see the caveat in [Unsafe code, pointer types, and function pointers](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/unsafe-code#the-updated-memory-safety-model-preview)â€”so today, `<safety>` documents a contract you maintain by convention. You can also place a `<safety>` block on an `unsafe` field to record the invariant that the enclosing type maintains.

The C# compiler doesn't recognize or process the `<safety>` tag. Like any custom tag, the compiler copies it verbatim to the output XML file. A memory safety analyzer might flag a caller-unsafe member that's missing a `<safety>` block, but the compiler itself doesn't enforce its presence or contents. For more information, see [Safety documentation](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/unsafe-code#safety-documentation).

## Format documentation output

### `<para>`

``` lang-xml
<remarks>
    <para>
        This is an introductory paragraph.
    </para>
    <para>
        This paragraph contains more details.
    </para>
</remarks>
```

Use the `<para>` tag inside a tag, such as [`<summary>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#summary), [`<remarks>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#remarks), or [`<returns>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#returns), to add structure to the text. The `<para>` tag creates a double spaced paragraph. Use the `<br/>` tag if you want a single spaced paragraph.

Here's an example showing the difference between `<para>` and `<br/>`:

``` lang-csharp
/// <summary>
/// Example using para tags:
/// <para>This is the first paragraph.</para>
/// <para>This is the second paragraph with double spacing.</para>
/// 
/// Example using br tags:
/// First line of text<br/>
/// Second line of text with single spacing<br/>
/// Third line of text
/// </summary>
public void FormattingExample()

```

### `<list>`

``` lang-xml
<list type="bullet|number|table">
    <listheader>
        <term>term</term>
        <description>description</description>
    </listheader>
    <item>
        <term>Assembly</term>
        <description>The library or executable built from a compilation.</description>
    </item>
    <item>
        <term>Namespace</term>
        <description>A logical grouping of related types such as classes and interfaces.</description>
    </item>
    <item>
        <term>Class</term>
        <description>A blueprint used to create objects, containing properties and methods.</description>
    </item>
</list>
```

Use the `<listheader>` block to define the heading row of either a table or definition list.

When defining a table:

-   Supply an entry for `term` in the heading.
-   Specify each item in the list with an `<item>` block. For each `item`, supply an entry for `description`.

When creating a definition list:

-   Supply an entry for `term` in the heading.
-   Specify each item in the list with an `<item>` block. Each `item` must contain both a `term` and `description`.

A list or table can have as many `<item>` blocks as needed.

### `<c>`

``` lang-xml
<c>text</c>
```

Use the `<c>` tag to mark text within a description as code. Use [`<code>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#code) to indicate multiple lines as code.

### `<code>`

``` lang-xml
<code>
    var index = 5;
    index++;
</code>
```

Use the `<code>` tag to indicate multiple lines of code. Use [`<c>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#c) to mark single-line text within a description as code.

### `<example>`

``` lang-xml
<example>
This shows how to increment an integer.
<code>
    var index = 5;
    index++;
</code>
</example>
```

Use the `<example>` tag to provide an example of how to use a method or other library member. An example commonly involves using the [`<code>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#code) tag.

### `<b>`

``` lang-xml
<b>text</b>
```

Use the `<b>` tag to make text bold within documentation comments. The compiler and Visual Studio validate this HTML formatting tag. The formatted text appears in IntelliSense and generated documentation.

### `<i>`

``` lang-xml
<i>text</i>
```

Use the `<i>` tag to make text italic within documentation comments. The compiler and Visual Studio validate this HTML formatting tag. The formatted text appears in IntelliSense and generated documentation.

### `<u>`

``` lang-xml
<u>text</u>
```

Use the `<u>` tag to underline text within documentation comments. The compiler and Visual Studio validate this HTML formatting tag. The formatted text appears in IntelliSense and generated documentation.

### `<br/>`

``` lang-xml
Line one<br/>Line two
```

Use the `<br/>` tag to insert a line break within documentation comments. Use this tag when you want a single spaced paragraph, as opposed to the `<para>` tag which creates double spaced paragraphs.

### `<a>`

``` lang-xml
<a href="https://example.com">Link text</a>
```

Use the `<a>` tag to create hyperlinks within documentation comments. The `href` attribute specifies the URL to link to. The compiler and Visual Studio validate this HTML formatting tag.

Note

The compiler also validates the `<tt>` tag, which is deprecated HTML. Use the [`<c>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#c) tag instead for inline code formatting.

## Reuse documentation text

### `<inheritdoc>`

``` lang-xml
<inheritdoc [cref=""] [path=""]/>
```

Inherit XML comments from base classes, interfaces, and similar methods. By using `inheritdoc`, you eliminate unwanted copying and pasting of duplicate XML comments and automatically keep XML comments synchronized. When you add the `<inheritdoc>` tag to a type, all members inherit the comments as well.

-   `cref`: Specify the member to inherit documentation from. The inherited tags don't override already defined tags on the current member.
-   `path`: The XPath expression query that results in a node set to show. Use this attribute to filter the tags to include or exclude from the inherited documentation.

Note

Visual Studio automatically inherits XML documentation for undocumented members that override or implement documented members. This feature displays inherited documentation in IntelliSense and Quick Info without requiring the `<inheritdoc>` tag. However, this automatic inheritance only applies within the Visual Studio IDE and doesn't affect the XML documentation file generated by the compiler.

For public APIs in libraries that you distribute, explicitly use the `<inheritdoc>` tag or provide complete documentation to ensure the generated XML documentation file includes all necessary information for consumers of your library.

Add your XML comments in base classes or interfaces and let inheritdoc copy the comments to implementing classes. Add your XML comments to your synchronous methods and let inheritdoc copy the comments to your asynchronous versions of the same methods. To copy the comments from a specific member, use the `cref` attribute to specify the member.

### `<include>`

``` lang-xml
<include file='filename' path='tagpath' />
<include file='filename' path='tagpath[@attribName]' />
<include file='filename' path='tagpath[@attribName="attribValue"]' />
<include file='filename' path='tagpath[@attribName1="attribValue1"][@attribName2="attribValue2"][@attribName3]' />
```

Recommendation:

``` lang-xml
<include file='filename' path='tagpath[@name="id"]' />
```

-   `filename`: The name of the XML file containing the documentation. Qualify the file name with a path relative to the source code file. Enclose `filename` in single quotation marks (' ').
-   `path`: The path of the tags in `filename` that leads to the XML comment to use. The path can include one or multiple attributes like `name`, but they're not required. The attributes can have values like `id`, but values aren't required either. Enclose the path, including possible attributes, in single quotation marks (' ').
-   `attribName`, `attribName1`: The names of optional attributes.
-   `attribValue`, `attribValue1`: The optional values of the attributes. If you don't specify a value, any value is accepted when searching for the comment in `filename`. Enclose the attribute value in quotation marks (").

By using the `<include>` tag, you can refer to comments in another file that describe the types and members in your source code. Including an external file is an alternative to placing documentation comments directly in your source code file. By putting the documentation in a separate file, you can apply source control to the documentation separately from the source code. One person can check out the source code file and someone else can check out the documentation file. The `<include>` tag uses the XML XPath syntax. Refer to XPath documentation for ways to customize your `<include>` use.

For example, the following source code uses the `<include>` tag to include remarks. The file path is relative to the source.

``` lang-csharp
namespace MyNamespace;

public class MyType

```

The XML source for the include file is shown in the following sample. It's structured the same as the XML file generated by the C# compiler. The XML file can contain text for multiple methods or types, as long as an XPath expression can identify them.

``` lang-xml
<?xml version="1.0"?>
<doc>
    <members>
        <member name="M:MyNamespace.MyType.MyMethod">
            <param name="p">This is the description of the parameter p of MyMethod. It comes from the included file.</param>
            <summary>This is the summary of MyMethod. It comes from the included file.</summary>
        </member>
    </members>
</doc>
```

The XML output for this method is shown in the following example:

``` lang-xml
<member name="M:MyNamespace.MyType.MyMethod(System.Int32)">
    <summary>This is the summary of MyMethod. It comes from the included file.</summary>
    <returns>This is the returns text of MyMethod. It comes from triple slash comments.</returns>
    <remarks>This is the remarks text of MyMethod. It comes from triple slash comments.</remarks>
    <param name="p">This is the description of the parameter p of MyMethod. It comes from the included file.</param>
</member>
```

Tip

The .NET Runtime team uses the `<include>` tag extensively in its documentation. You can see many examples by [searching the `dotnet/runtime` repository](https://github.com/search?q=repo%3Adotnet%2Fruntime+language%3Acsharp+%3Cinclude+file+&type=code).

## Generate links and references

### `<see>`

``` lang-xml
<see cref="member"/>
<!-- or -->
<see cref="member">Link text</see>
<!-- or -->
<see href="link">Link Text</see>
<!-- or -->
<see langword="keyword"/>
```

-   `cref="member"`: A reference to a member or field that you can call from the current compilation environment. The compiler checks that the given code element exists and passes `member` to the element name in the output XML. Place *member* within quotation marks ("). You can provide different link text for a `cref`, by using a separate closing tag.
-   `href="link"`: A clickable link to a given URL. For example, `<see href="https://github.com">GitHub</see>` produces a clickable link with text <span class="no-loc" dir="ltr" lang="en-us">GitHub</span> that links to `https://github.com`. Use `href` instead of `cref` when linking to external web pages, as `cref` is designed for code references and doesn't create clickable links for external URLs.
-   `langword="keyword"`: A language keyword, such as `true` or one of the other valid [keywords](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/).

The `<see>` tag lets you specify a link from within text. Use [`<seealso>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#seealso) to indicate that text should be placed in a See Also section. Use the [cref attribute](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#cref-attribute) to create internal hyperlinks to documentation pages for code elements. Include the type parameters to specify a reference to a generic type or method, such as `cref="IDictionary{T, U}"`. Also, `href` is a valid attribute that functions as a hyperlink.

Here's an example showing the difference between `cref` and `href` when referencing external URLs:

``` lang-csharp
/// <summary>
/// This method demonstrates URL linking:
/// <see cref="https://learn.microsoft.com/dotnet/csharp"/> (won't create clickable link)
/// <see href="https://learn.microsoft.com/dotnet/csharp">C# documentation</see> (creates clickable link)
/// </summary>
public void UrlLinkingExample()

```

### `<seealso>`

``` lang-xml
<seealso cref="member"/>
<!-- or -->
<seealso href="link">Link Text</seealso>
```

-   `cref="member"`: A reference to a member or field that you can call from the current compilation environment. The compiler checks that the given code element exists and passes `member` to the element name in the output XML. `member` must appear within quotation marks (").
-   `href="link"`: A clickable link to a given URL. For example, `<seealso href="https://github.com">GitHub</seealso>` produces a clickable link with text <span class="no-loc" dir="ltr" lang="en-us">GitHub</span> that links to `https://github.com`.

The `<seealso>` tag lets you specify the text that you might want to appear in a **See Also** section. Use [`<see>`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#see) to specify a link from within text. You can't nest the `seealso` tag inside the `summary` tag.

### cref attribute

The `cref` attribute in an XML documentation tag means "code reference." It specifies that the inner text of the tag is a code element, such as a type, method, or property. Documentation tools like [DocFX](https://dotnet.github.io/docfx/) and [Sandcastle](https://github.com/EWSoftware/SHFB) use the `cref` attributes to automatically generate hyperlinks to the page where the type or member is documented.

### href attribute

The `href` attribute means a reference to a web page. You can use it to directly reference online documentation about your API or library. When you need to link to external URLs in your documentation comments, use `href` instead of `cref` to ensure the links are clickable in IntelliSense tooltips and generated documentation.

## Generic types and methods

### `<typeparam>`

``` lang-xml
<typeparam name="TResult">The type returned from this method</typeparam>
```

-   `TResult`: The name of the type parameter. Enclose the name in quotation marks (").

Use the `<typeparam>` tag in the comment for a generic type or method declaration to describe a type parameter. Add a tag for each type parameter of the generic type or method. The text for the `<typeparam>` tag appears in IntelliSense.

### `<typeparamref>`

``` lang-xml
<typeparamref name="TKey"/>
```

-   `TKey`: The name of the type parameter. Enclose the name in quotation marks (").

Use this tag to enable consumers of the documentation file to format the word in some distinct way, such as in italics.

### User-defined tags

All the tags outlined in this article represent tags recognized by the C# compiler. However, you can define your own tags. Tools like [Sandcastle](https://ewsoftware.github.io/XMLCommentsGuide/html/81bf7ad3-45dc-452f-90d5-87ce2494a182.htm) bring support for extra tags like [`<event>`](https://ewsoftware.github.io/XMLCommentsGuide/html/81bf7ad3-45dc-452f-90d5-87ce2494a182.htm) and [`<note>`](https://ewsoftware.github.io/XMLCommentsGuide/html/4302a60f-e4f4-4b8d-a451-5f453c4ebd46.htm), and even support [documenting namespaces](https://ewsoftware.github.io/XMLCommentsGuide/html/BD91FAD4-188D-4697-A654-7C07FD47EF31.htm). You can also use custom or in-house documentation generation tools with the standard tags, and support multiple output formats from HTML to PDF.

<span class="icon margin-right-xxs" aria-hidden="true"> <span class="docon docon-brand-github"></span> </span> <span class="font-weight-semibold"> Collaborate with us on GitHub </span>

<span class="line-height-normal"> The source for this content can be found on GitHub, where you can also create and review issues and pull requests. For more information, see [our contributor guide](https://learn.microsoft.com/contribute/content/dotnet/dotnet-contribute). </span>

![](https://learn.microsoft.com/media/logos/logo_net.svg) ![](https://learn.microsoft.com/media/logos/logo_net.svg)

.NET

[<span class="icon margin-right-xxs" aria-hidden="true"> <span class="docon docon-bug"></span> </span> Open a documentation issue](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags#) <a href="https://aka.ms/feedback/report?space=61" class="display-block margin-top-auto font-size-md"><span class="icon margin-right-xxs" aria-hidden="true"> <span class="docon docon-feedback"></span> </span> <span>Provide product feedback</span></a>

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

-   <span class="badge badge-sm text-wrap-pretty"> Last updated on 2026-08-14 </span>

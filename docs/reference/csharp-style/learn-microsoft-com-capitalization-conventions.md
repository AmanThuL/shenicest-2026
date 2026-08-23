---
title: "Microsoft: Capitalization Conventions"
page_title: "Capitalization Conventions - Framework Design Guidelines | Microsoft Learn"
source_url: "https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/capitalization-conventions"
final_url: "https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/capitalization-conventions"
topic: "csharp-style"
publisher: "third-party"
fetched: "2026-08-23"
kind: "html"
---

# Capitalization Conventions - Framework Design Guidelines | Microsoft Learn

<span class="icon" aria-hidden="true"><span class="docon docon-menu"></span></span> <span class="contents-expand-title"> Table of contents </span>

<span class="icon" aria-hidden="true"><span class="docon docon-exit-mode"></span></span> Exit editor mode

<span class="icon" aria-hidden="true"> <span class="docon docon-more"></span> </span>

<span class="icon" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span>

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon" aria-hidden="true"> <span class="docon docon-more-vertical"></span> </span>

<span class="icon" aria-hidden="true"> <span class="docon docon-glasses"></span> </span> Reading mode

<span class="icon" aria-hidden="true"><span class="docon docon-editor-list-bullet"></span></span> <span class="contents-expand-title">Table of contents</span>

<a href="https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/capitalization-conventions#" id="lang-link-overflow" class="button-sm inner-focus button button-clear button-block justify-content-flex-start text-align-left"><span class="icon" aria-hidden="true" data-read-in-link-icon=""> <span class="docon docon-locale-globe"></span> </span> <span data-read-in-link-text="">Read in English</span></a>

<span class="icon" aria-hidden="true"> <span class="docon docon-circle-addition"></span> </span> <span class="collection-status">Add</span>

<span class="icon" aria-hidden="true"> <span class="docon docon-circle-addition"></span> </span> <span class="plan-status">Add to Plans</span>

<a href="https://github.com/dotnet/docs/blob/main/docs/standard/design-guidelines/capitalization-conventions.md" class="button button-clear button-block button-sm inner-focus justify-content-flex-start text-align-left text-decoration-none"><span class="icon" aria-hidden="true"> <span class="docon docon-edit-outline"></span> </span> <span>Edit</span></a>

------------------------------------------------------------------------

<span class="icon color-primary" aria-hidden="true"> <span class="docon docon-code-lang" show-when="idle"></span> <span class="loader" show-when="loading" hidden=""></span> <span class="docon docon-check-mark" show-when="success" hidden=""></span> </span> Copy Markdown

<span class="icon color-primary" aria-hidden="true"> <span class="docon docon-print"></span> </span> Print

------------------------------------------------------------------------

<span class="icon" aria-hidden="true"><span class="docon docon-exclamation-circle-solid"></span></span> Note

Access to this page requires authorization. You can try <a href="https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/capitalization-conventions#" class="docs-sign-in">signing in</a> or <span class="docs-change-directory">changing directories</span>.

Access to this page requires authorization. You can try <span class="docs-change-directory">changing directories</span>.

# Capitalization Conventions

<span class="icon" aria-hidden="true"> <span class="docon docon-like"></span> </span> Feedback

<span class="icon" aria-hidden="true"> <span class="docon docon-sparkle-fill gradient-text-vivid"></span> </span>

<span class="ai-summary-cta-text"> Summarize this article for me </span>

Note

This content is reprinted by permission of Pearson Education, Inc. from *Framework Design Guidelines: Conventions, Idioms, and Patterns for Reusable .NET Libraries, 2nd Edition*. That edition was published in 2008, and the book has since been fully revised in the [third edition](https://www.informit.com/store/framework-design-guidelines-conventions-idioms-and-9780135896464). Some of the information on this page may be out-of-date.

The guidelines in this chapter lay out a simple method for using case that, when applied consistently, make identifiers for types, members, and parameters easy to read.

## Capitalization Rules for Identifiers

To differentiate words in an identifier, capitalize the first letter of each word in the identifier. Do not use underscores to differentiate words, or for that matter, anywhere in identifiers. There are two appropriate ways to capitalize identifiers, depending on the use of the identifier:

-   PascalCasing

-   camelCasing

The PascalCasing convention, used for all identifiers except parameter names, capitalizes the first character of each word (including acronyms over two letters in length), as shown in the following examples:

`PropertyDescriptor` `HtmlTag`

A special case is made for two-letter acronyms in which both letters are capitalized, as shown in the following identifier:

`IOStream`

The camelCasing convention, used only for parameter names, capitalizes the first character of each word except the first word, as shown in the following examples. As the example also shows, two-letter acronyms that begin a camel-cased identifier are both lowercase.

`propertyDescriptor` `ioStream` `htmlTag`

âœ”ï¸? DO use PascalCasing for all public member, type, and namespace names consisting of multiple words.

âœ”ï¸? DO use camelCasing for parameter names.

The following table describes the capitalization rules for different types of identifiers.

<table><colgroup><col style="width: 33%" /><col style="width: 33%" /><col style="width: 33%" /></colgroup><thead><tr class="header"><th>Identifier</th><th>Casing</th><th>Example</th></tr></thead><tbody><tr class="odd"><td>Namespace</td><td>Pascal</td><td><code>namespace System.Security { ... }</code></td></tr><tr class="even"><td>Type</td><td>Pascal</td><td><code>public class StreamReader { ... }</code></td></tr><tr class="odd"><td>Interface</td><td>Pascal</td><td><code>public interface IEnumerable { ... }</code></td></tr><tr class="even"><td>Method</td><td>Pascal</td><td><code>public class Object {</code><br />
<code>public virtual string ToString();</code><br />
<code>}</code></td></tr><tr class="odd"><td>Property</td><td>Pascal</td><td><code>public class String {</code><br />
<code>public int Length { get; }</code><br />
<code>}</code></td></tr><tr class="even"><td>Event</td><td>Pascal</td><td><code>public class Process {</code><br />
<code>public event EventHandler Exited;</code><br />
<code>}</code></td></tr><tr class="odd"><td>Field</td><td>Pascal</td><td><code>public class MessageQueue {</code><br />
<code>public static readonly TimeSpan</code><br />
<code>InfiniteTimeout;</code><br />
<code>}</code><br />
<code>public struct UInt32 {</code><br />
<code>public const Min = 0;</code><br />
<code>}</code></td></tr><tr class="even"><td>Enum value</td><td>Pascal</td><td><code>public enum FileMode {</code><br />
<code>Append,</code><br />
<code>...</code><br />
<code>}</code></td></tr><tr class="odd"><td>Parameter</td><td>Camel</td><td><code>public class Convert {</code><br />
<code>public static int ToInt32(string value);</code><br />
<code>}</code></td></tr></tbody></table>

## Capitalizing Compound Words and Common Terms

Most compound terms are treated as single words for purposes of capitalization.

â?Œ DO NOT capitalize each word in so-called closed-form compound words.

These are compound words written as a single word, such as endpoint. For the purpose of casing guidelines, treat a closed-form compound word as a single word. Use a current dictionary to determine if a compound word is written in closed form.

| Pascal        | Camel         | Not                  |
|---------------|---------------|----------------------|
| `BitFlag`     | `bitFlag`     | `Bitflag`            |
| `Callback`    | `callback`    | `CallBack`           |
| `Canceled`    | `canceled`    | `Cancelled`          |
| `DoNot`       | `doNot`       | `Don't`              |
| `Email`       | `email`       | `EMail`              |
| `Endpoint`    | `endpoint`    | `EndPoint`           |
| `FileName`    | `fileName`    | `Filename`           |
| `Gridline`    | `gridline`    | `GridLine`           |
| `Hashtable`   | `hashtable`   | `HashTable`          |
| `Id`          | `id`          | `ID`                 |
| `Indexes`     | `indexes`     | `Indices`            |
| `LogOff`      | `logOff`      | `LogOut`             |
| `LogOn`       | `logOn`       | `LogIn`              |
| `Metadata`    | `metadata`    | `MetaData, metaData` |
| `Multipanel`  | `multipanel`  | `MultiPanel`         |
| `Multiview`   | `multiview`   | `MultiView`          |
| `Namespace`   | `namespace`   | `NameSpace`          |
| `Ok`          | `ok`          | `OK`                 |
| `Pi`          | `pi`          | `PI`                 |
| `Placeholder` | `placeholder` | `PlaceHolder`        |
| `SignIn`      | `signIn`      | `SignOn`             |
| `SignOut`     | `signOut`     | `SignOff`            |
| `UserName`    | `userName`    | `Username`           |
| `WhiteSpace`  | `whiteSpace`  | `Whitespace`         |
| `Writable`    | `writable`    | `Writeable`          |

## Case Sensitivity

Languages that can run on the CLR are not required to support case-sensitivity, although some do. Even if your language supports it, other languages that might access your framework do not. Any APIs that are externally accessible, therefore, cannot rely on case alone to distinguish between two names in the same context.

â?Œ DO NOT assume that all programming languages are case sensitive. They are not. Names cannot differ by case alone.

*Portions Â© 2005, 2009 Microsoft Corporation. All rights reserved.*

*Reprinted by permission of Pearson Education, Inc. from [Framework Design Guidelines: Conventions, Idioms, and Patterns for Reusable .NET Libraries, 2nd Edition](https://www.informit.com/store/framework-design-guidelines-conventions-idioms-and-9780321545619) by Krzysztof Cwalina and Brad Abrams, published Oct 22, 2008 by Addison-Wesley Professional as part of the Microsoft Windows Development Series.*

## See also

-   [Framework Design Guidelines](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/)
-   [Naming Guidelines](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/naming-guidelines)

------------------------------------------------------------------------

## Additional resources

------------------------------------------------------------------------

-   <span class="badge badge-sm text-wrap-pretty"> Last updated on 2023-10-03 </span>

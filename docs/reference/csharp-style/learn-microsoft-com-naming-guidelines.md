---
title: "Microsoft: Naming Guidelines"
page_title: "Naming Guidelines - Framework Design Guidelines | Microsoft Learn"
source_url: "https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/naming-guidelines"
final_url: "https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/naming-guidelines"
topic: "csharp-style"
publisher: "third-party"
fetched: "2026-08-23"
kind: "html"
---

# Naming Guidelines - Framework Design Guidelines | Microsoft Learn

<span class="icon" aria-hidden="true"><span class="docon docon-menu"></span></span> <span class="contents-expand-title"> Table of contents </span>

<span class="icon" aria-hidden="true"><span class="docon docon-exit-mode"></span></span> Exit editor mode

<span class="icon" aria-hidden="true"> <span class="docon docon-more"></span> </span>

<span class="icon" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span>

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon" aria-hidden="true"> <span class="docon docon-more-vertical"></span> </span>

<span class="icon" aria-hidden="true"> <span class="docon docon-glasses"></span> </span> Reading mode

<span class="icon" aria-hidden="true"><span class="docon docon-editor-list-bullet"></span></span> <span class="contents-expand-title">Table of contents</span>

<a href="https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/naming-guidelines#" id="lang-link-overflow" class="button-sm inner-focus button button-clear button-block justify-content-flex-start text-align-left"><span class="icon" aria-hidden="true" data-read-in-link-icon=""> <span class="docon docon-locale-globe"></span> </span> <span data-read-in-link-text="">Read in English</span></a>

<span class="icon" aria-hidden="true"> <span class="docon docon-circle-addition"></span> </span> <span class="collection-status">Add</span>

<span class="icon" aria-hidden="true"> <span class="docon docon-circle-addition"></span> </span> <span class="plan-status">Add to Plans</span>

<a href="https://github.com/dotnet/docs/blob/main/docs/standard/design-guidelines/naming-guidelines.md" class="button button-clear button-block button-sm inner-focus justify-content-flex-start text-align-left text-decoration-none"><span class="icon" aria-hidden="true"> <span class="docon docon-edit-outline"></span> </span> <span>Edit</span></a>

------------------------------------------------------------------------

<span class="icon color-primary" aria-hidden="true"> <span class="docon docon-code-lang" show-when="idle"></span> <span class="loader" show-when="loading" hidden=""></span> <span class="docon docon-check-mark" show-when="success" hidden=""></span> </span> Copy Markdown

<span class="icon color-primary" aria-hidden="true"> <span class="docon docon-print"></span> </span> Print

------------------------------------------------------------------------

<span class="icon" aria-hidden="true"><span class="docon docon-exclamation-circle-solid"></span></span> Note

Access to this page requires authorization. You can try <a href="https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/naming-guidelines#" class="docs-sign-in">signing in</a> or <span class="docs-change-directory">changing directories</span>.

Access to this page requires authorization. You can try <span class="docs-change-directory">changing directories</span>.

# Naming guidelines

<span class="icon" aria-hidden="true"> <span class="docon docon-like"></span> </span> Feedback

<span class="icon" aria-hidden="true"> <span class="docon docon-sparkle-fill gradient-text-vivid"></span> </span>

<span class="ai-summary-cta-text"> Summarize this article for me </span>

Following a consistent set of naming conventions in developing a framework can be a major contribution to the frameworkâ€™s usability. It allows the framework to be used by many developers on widely separated projects. Beyond consistency of form, the names of framework elements must be easily understood and convey each element's function.

The goal of this chapter is to provide a consistent set of naming conventions that results in names that make immediate sense to developers.

Adopting these naming conventions as general code development guidelines results in more consistent naming throughout your code. However, you're only required to apply them to APIs that are publicly exposed (public or protected types and members, and explicitly implemented interfaces).

## In this section

[Capitalization Conventions](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/capitalization-conventions)  
[General Naming Conventions](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/general-naming-conventions)  
[Names of Assemblies and DLLs](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/names-of-assemblies-and-dlls)  
[Names of Namespaces](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/names-of-namespaces)  
[Names of Classes, Structs, and Interfaces](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/names-of-classes-structs-and-interfaces)  
[Names of Type Members](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/names-of-type-members)  
[Naming Parameters](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/naming-parameters)  
[Naming Resources](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/naming-resources)  
*Portions Â© 2005, 2009 Microsoft Corporation. All rights reserved.*

*Reprinted by permission of Pearson Education, Inc. from [Framework Design Guidelines: Conventions, Idioms, and Patterns for Reusable .NET Libraries, 2nd Edition](https://www.informit.com/store/framework-design-guidelines-conventions-idioms-and-9780321545619) by Krzysztof Cwalina and Brad Abrams, published Oct 22, 2008 by Addison-Wesley Professional as part of the Microsoft Windows Development Series.*

## See also

-   [Framework Design Guidelines](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/)

------------------------------------------------------------------------

## Additional resources

------------------------------------------------------------------------

-   <span class="badge badge-sm text-wrap-pretty"> Last updated on 2022-10-04 </span>

---
title: "Microsoft: Code-style rule options (.editorconfig)"
page_title: ".NET code style rule options - .NET | Microsoft Learn"
source_url: "https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/code-style-rule-options"
final_url: "https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/code-style-rule-options"
topic: "csharp-style"
publisher: "third-party"
fetched: "2026-08-23"
kind: "html"
---

# .NET code style rule options - .NET | Microsoft Learn

<span class="icon" aria-hidden="true"><span class="docon docon-menu"></span></span> <span class="contents-expand-title"> Table of contents </span>

<span class="icon" aria-hidden="true"><span class="docon docon-exit-mode"></span></span> Exit editor mode

<span class="icon" aria-hidden="true"> <span class="docon docon-more"></span> </span>

<span class="icon" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span>

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon" aria-hidden="true"> <span class="docon docon-more-vertical"></span> </span>

<span class="icon" aria-hidden="true"> <span class="docon docon-glasses"></span> </span> Reading mode

<span class="icon" aria-hidden="true"><span class="docon docon-editor-list-bullet"></span></span> <span class="contents-expand-title">Table of contents</span>

<a href="https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/code-style-rule-options#" id="lang-link-overflow" class="button-sm inner-focus button button-clear button-block justify-content-flex-start text-align-left"><span class="icon" aria-hidden="true" data-read-in-link-icon=""> <span class="docon docon-locale-globe"></span> </span> <span data-read-in-link-text="">Read in English</span></a>

<span class="icon" aria-hidden="true"> <span class="docon docon-circle-addition"></span> </span> <span class="collection-status">Add</span>

<span class="icon" aria-hidden="true"> <span class="docon docon-circle-addition"></span> </span> <span class="plan-status">Add to Plans</span>

<a href="https://github.com/dotnet/docs/blob/main/docs/fundamentals/code-analysis/code-style-rule-options.md" class="button button-clear button-block button-sm inner-focus justify-content-flex-start text-align-left text-decoration-none"><span class="icon" aria-hidden="true"> <span class="docon docon-edit-outline"></span> </span> <span>Edit</span></a>

------------------------------------------------------------------------

<span class="icon color-primary" aria-hidden="true"> <span class="docon docon-code-lang" show-when="idle"></span> <span class="loader" show-when="loading" hidden=""></span> <span class="docon docon-check-mark" show-when="success" hidden=""></span> </span> Copy Markdown

<span class="icon color-primary" aria-hidden="true"> <span class="docon docon-print"></span> </span> Print

------------------------------------------------------------------------

<span class="icon" aria-hidden="true"><span class="docon docon-exclamation-circle-solid"></span></span> Note

Access to this page requires authorization. You can try <a href="https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/code-style-rule-options#" class="docs-sign-in">signing in</a> or <span class="docs-change-directory">changing directories</span>.

Access to this page requires authorization. You can try <span class="docs-change-directory">changing directories</span>.

# Code-style rule options

<span class="icon" aria-hidden="true"> <span class="docon docon-like"></span> </span> Feedback

<span class="icon" aria-hidden="true"> <span class="docon docon-sparkle-fill gradient-text-vivid"></span> </span>

<span class="ai-summary-cta-text"> Summarize this article for me </span>

You can define and maintain consistent *code style* in your codebase by defining .NET code-style rules and their associated options in a [configuration file](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/configuration-files). These rules are surfaced by various development IDEs, such as Visual Studio, as you edit your code. For .NET projects, these rules can also be [enforced at build time](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/overview#code-style-analysis). You can enable or disable individual rules and configure the degree to which you want each rule enforced, via a severity level.

Tip

-   When you define code style options in an EditorConfig file, you're configuring how you want the [code style analyzers](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/overview#code-style-analysis) to analyze your code. The EditorConfig file is the configuration file for these analyzers.
-   Code style options can also be set in Visual Studio in the [Text editor options](https://learn.microsoft.com/en-us/visualstudio/ide/code-styles-and-code-cleanup) dialog. These are per-user options that are only respected while editing in Visual Studio. These options aren't respected at build time or by other IDEs. Additionally, if the project or solution opened inside Visual Studio has an EditorConfig file, then options from the EditorConfig file take precedence. In Visual Studio on Windows, you can also generate an EditorConfig file from your text-editor options. Select **Tools** > **Options** > **Text Editor** > \[**C#** or **Basic**\] > **Code Style** > **General**, and then select **Generate .editorconfig file from settings**. For more information, see [Code style preferences](https://learn.microsoft.com/en-us/visualstudio/ide/code-styles-and-code-cleanup).

Code style rules are divided into following subcategories:

-   [Language rules](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/style-rules/language-rules)
-   [Formatting rules](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/style-rules/ide0055)
-   [Naming rules](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/style-rules/naming-rules)

Each of these subcategories defines its own syntax for specifying options. For more information about these rules and the corresponding options, see [Code-style rule reference](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/style-rules/).

## Example EditorConfig file

To help you get started, here's an example *.editorconfig* file with the default options.

Note

If you're using .NET 8 or an earlier version, the syntax that's used to specify severity in this example file might not be respected at build time. In that case, you can set the severity by using the rule ID-based severity configuration syntax for analyzers instead. For more information, see [Option format](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/style-rules/language-rules#option-format).

Tip

-   In Visual Studio, you can add the following default .NET .editorconfig file to your project from the **Add New Item** dialog box. For detailed steps, see [Add and remove EditorConfig files](https://learn.microsoft.com/en-us/visualstudio/ide/create-portable-custom-editor-options?#add-and-remove-editorconfig-files).
-   For Visual Studio Code, you can use the [EditorConfig for VS Code plugin](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig) to override user/workspace settings with settings found in .editorconfig files.

``` lang-ini
# Remove the line below if you want to inherit .editorconfig settings from higher directories
root = true

# C# files
[*.cs]

#### Core EditorConfig Options ####

# Indentation and spacing
indent_size = 4
indent_style = space
tab_width = 4

# New line preferences
end_of_line = crlf
insert_final_newline = false

#### .NET Coding Conventions ####

# Organize usings
dotnet_separate_import_directive_groups = false
dotnet_sort_system_directives_first = false
file_header_template = unset

# this. and Me. preferences
dotnet_style_qualification_for_event = false
dotnet_style_qualification_for_field = false
dotnet_style_qualification_for_method = false
dotnet_style_qualification_for_property = false

# Language keywords vs BCL types preferences
dotnet_style_predefined_type_for_locals_parameters_members = true
dotnet_style_predefined_type_for_member_access = true

# Parentheses preferences
dotnet_style_parentheses_in_arithmetic_binary_operators = always_for_clarity
dotnet_style_parentheses_in_other_binary_operators = always_for_clarity
dotnet_style_parentheses_in_other_operators = never_if_unnecessary
dotnet_style_parentheses_in_relational_binary_operators = always_for_clarity

# Modifier preferences
dotnet_style_require_accessibility_modifiers = for_non_interface_members

# Expression-level preferences
dotnet_style_coalesce_expression = true
dotnet_style_collection_initializer = true
dotnet_style_explicit_tuple_names = true
dotnet_style_namespace_match_folder = true
dotnet_style_null_propagation = true
dotnet_style_object_initializer = true
dotnet_style_operator_placement_when_wrapping = beginning_of_line
dotnet_style_prefer_auto_properties = true
dotnet_style_prefer_collection_expression = when_types_loosely_match
dotnet_style_prefer_compound_assignment = true
dotnet_style_prefer_conditional_expression_over_assignment = true
dotnet_style_prefer_conditional_expression_over_return = true
dotnet_style_prefer_foreach_explicit_cast_in_source = when_strongly_typed
dotnet_style_prefer_inferred_anonymous_type_member_names = true
dotnet_style_prefer_inferred_tuple_names = true
dotnet_style_prefer_is_null_check_over_reference_equality_method = true
dotnet_style_prefer_non_hidden_explicit_cast_in_source = true
dotnet_style_prefer_simplified_boolean_expressions = true
dotnet_style_prefer_simplified_interpolation = true
dotnet_prefer_system_hash_code = true

# Field preferences
dotnet_style_readonly_field = true

# Parameter preferences
dotnet_code_quality_unused_parameters = all:silent

# Suppression preferences
dotnet_remove_unnecessary_suppression_exclusions = none

# New line preferences
dotnet_style_allow_multiple_blank_lines_experimental = true
dotnet_style_allow_statement_immediately_after_block_experimental = true

#### C# Coding Conventions ####

# var preferences
csharp_style_var_elsewhere = false
csharp_style_var_for_built_in_types = false
csharp_style_var_when_type_is_apparent = false

# Expression-bodied members
csharp_style_expression_bodied_accessors = true
csharp_style_expression_bodied_constructors = false
csharp_style_expression_bodied_indexers = true
csharp_style_expression_bodied_lambdas = true
csharp_style_expression_bodied_local_functions = false
csharp_style_expression_bodied_methods = false
csharp_style_expression_bodied_operators = false
csharp_style_expression_bodied_properties = true

# Pattern matching preferences
csharp_style_pattern_matching_over_as_with_null_check = true
csharp_style_pattern_matching_over_is_with_cast_check = true
csharp_style_prefer_extended_property_pattern = true
csharp_style_prefer_not_pattern = true
csharp_style_prefer_pattern_matching = true
csharp_style_prefer_switch_expression = true

# Null-checking preferences
csharp_style_conditional_delegate_call = true

# Modifier preferences
csharp_prefer_static_local_function = true
csharp_preferred_modifier_order = public,private,protected,internal,file,static,extern,new,virtual,abstract,sealed,override,readonly,unsafe,required,volatile,async
csharp_style_prefer_readonly_struct = true
csharp_style_prefer_readonly_struct_member = true

# Code-block preferences
csharp_prefer_braces = true
csharp_prefer_simple_using_statement = true
csharp_style_namespace_declarations = block_scoped
csharp_style_prefer_method_group_conversion = true
csharp_style_prefer_primary_constructors = true
csharp_style_prefer_top_level_statements = true

# Expression-level preferences
csharp_prefer_simple_default_expression = true
csharp_style_deconstructed_variable_declaration = true
csharp_style_implicit_object_creation_when_type_is_apparent = true
csharp_style_inlined_variable_declaration = true
csharp_style_prefer_index_operator = true
csharp_style_prefer_local_over_anonymous_function = true
csharp_style_prefer_null_check_over_type_check = true
csharp_style_prefer_range_operator = true
csharp_style_prefer_tuple_swap = true
csharp_style_prefer_utf8_string_literals = true
csharp_style_throw_expression = true
csharp_style_unused_value_assignment_preference = discard_variable
csharp_style_unused_value_expression_statement_preference = discard_variable

# 'using' directive preferences
csharp_using_directive_placement = outside_namespace

# New line preferences
csharp_style_allow_blank_line_after_colon_in_constructor_initializer_experimental = true
csharp_style_allow_blank_line_after_token_in_arrow_expression_clause_experimental = true
csharp_style_allow_blank_line_after_token_in_conditional_expression_experimental = true
csharp_style_allow_blank_lines_between_consecutive_braces_experimental = true
csharp_style_allow_embedded_statements_on_same_line_experimental = true

#### C# Formatting Rules ####

# New line preferences
csharp_new_line_before_catch = true
csharp_new_line_before_else = true
csharp_new_line_before_finally = true
csharp_new_line_before_members_in_anonymous_types = true
csharp_new_line_before_members_in_object_initializers = true
csharp_new_line_before_open_brace = all
csharp_new_line_between_query_expression_clauses = true

# Indentation preferences
csharp_indent_block_contents = true
csharp_indent_braces = false
csharp_indent_case_contents = true
csharp_indent_case_contents_when_block = true
csharp_indent_labels = one_less_than_current
csharp_indent_switch_labels = true

# Space preferences
csharp_space_after_cast = false
csharp_space_after_colon_in_inheritance_clause = true
csharp_space_after_comma = true
csharp_space_after_dot = false
csharp_space_after_keywords_in_control_flow_statements = true
csharp_space_after_semicolon_in_for_statement = true
csharp_space_around_binary_operators = before_and_after
csharp_space_around_declaration_statements = false
csharp_space_before_colon_in_inheritance_clause = true
csharp_space_before_comma = false
csharp_space_before_dot = false
csharp_space_before_open_square_brackets = false
csharp_space_before_semicolon_in_for_statement = false
csharp_space_between_empty_square_brackets = false
csharp_space_between_method_call_empty_parameter_list_parentheses = false
csharp_space_between_method_call_name_and_opening_parenthesis = false
csharp_space_between_method_call_parameter_list_parentheses = false
csharp_space_between_method_declaration_empty_parameter_list_parentheses = false
csharp_space_between_method_declaration_name_and_open_parenthesis = false
csharp_space_between_method_declaration_parameter_list_parentheses = false
csharp_space_between_parentheses = false
csharp_space_between_square_brackets = false

# Wrapping preferences
csharp_preserve_single_line_blocks = true
csharp_preserve_single_line_statements = true

#### Naming styles ####

# Naming rules

dotnet_naming_rule.interface_should_be_begins_with_i.severity = suggestion
dotnet_naming_rule.interface_should_be_begins_with_i.symbols = interface
dotnet_naming_rule.interface_should_be_begins_with_i.style = begins_with_i

dotnet_naming_rule.types_should_be_pascal_case.severity = suggestion
dotnet_naming_rule.types_should_be_pascal_case.symbols = types
dotnet_naming_rule.types_should_be_pascal_case.style = pascal_case

dotnet_naming_rule.non_field_members_should_be_pascal_case.severity = suggestion
dotnet_naming_rule.non_field_members_should_be_pascal_case.symbols = non_field_members
dotnet_naming_rule.non_field_members_should_be_pascal_case.style = pascal_case

# Symbol specifications

dotnet_naming_symbols.interface.applicable_kinds = interface
dotnet_naming_symbols.interface.applicable_accessibilities = public, internal, private, protected, protected_internal, private_protected
dotnet_naming_symbols.interface.required_modifiers = 

dotnet_naming_symbols.types.applicable_kinds = class, struct, interface, enum
dotnet_naming_symbols.types.applicable_accessibilities = public, internal, private, protected, protected_internal, private_protected
dotnet_naming_symbols.types.required_modifiers = 

dotnet_naming_symbols.non_field_members.applicable_kinds = property, event, method
dotnet_naming_symbols.non_field_members.applicable_accessibilities = public, internal, private, protected, protected_internal, private_protected
dotnet_naming_symbols.non_field_members.required_modifiers = 

# Naming styles

dotnet_naming_style.pascal_case.required_prefix = 
dotnet_naming_style.pascal_case.required_suffix = 
dotnet_naming_style.pascal_case.word_separator = 
dotnet_naming_style.pascal_case.capitalization = pascal_case

dotnet_naming_style.begins_with_i.required_prefix = I
dotnet_naming_style.begins_with_i.required_suffix = 
dotnet_naming_style.begins_with_i.word_separator = 
dotnet_naming_style.begins_with_i.capitalization = pascal_case
```

## See also

-   [Code style analysis rule reference](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/style-rules/)
-   [Enforce code style on build](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/overview#code-style-analysis)
-   [Quick Actions in Visual Studio](https://learn.microsoft.com/en-us/visualstudio/ide/quick-actions)
-   [Create portable custom editor options in Visual Studio](https://learn.microsoft.com/en-us/visualstudio/ide/create-portable-custom-editor-options)
-   [.NET Compiler Platform "Roslyn" .editorconfig file](https://github.com/dotnet/roslyn/blob/main/.editorconfig)
-   [.NET runtime .editorconfig file](https://github.com/dotnet/runtime/blob/main/.editorconfig)

<span class="icon margin-right-xxs" aria-hidden="true"> <span class="docon docon-brand-github"></span> </span> <span class="font-weight-semibold"> Collaborate with us on GitHub </span>

<span class="line-height-normal"> The source for this content can be found on GitHub, where you can also create and review issues and pull requests. For more information, see [our contributor guide](https://learn.microsoft.com/contribute/content/dotnet/dotnet-contribute). </span>

![](https://learn.microsoft.com/media/logos/logo_net.svg) ![](https://learn.microsoft.com/media/logos/logo_net.svg)

.NET

[<span class="icon margin-right-xxs" aria-hidden="true"> <span class="docon docon-bug"></span> </span> Open a documentation issue](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/code-style-rule-options#) <a href="https://aka.ms/feedback/report?space=61" class="display-block margin-top-auto font-size-md"><span class="icon margin-right-xxs" aria-hidden="true"> <span class="docon docon-feedback"></span> </span> <span>Provide product feedback</span></a>

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

-   <span class="badge badge-sm text-wrap-pretty"> Last updated on 2025-10-22 </span>

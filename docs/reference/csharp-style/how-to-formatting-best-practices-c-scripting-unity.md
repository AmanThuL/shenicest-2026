---
title: "Formatting Best Practices for C# Scripting & Code"
page_title: "Formatting Best Practices for C# Scripting & Code"
source_url: "https://unity.com/how-to/formatting-best-practices-c-scripting-unity"
final_url: "https://unity.com/how-to/formatting-best-practices-c-scripting-unity"
topic: "csharp-style"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Formatting best practices for C# scripting in Unity

While there might not be one right way to format your C# code, agreeing on a consistent style across your team can result in a cleaner, more readable and scalable codebase. This page offers tips and key considerations to keep in mind for your classes, methods, and comments when creating your own style guide.

**Note**: The recommendations shared here are based on those provided by Microsoft. The best code style guide rules are the ones that work for your team’s needs.

You can find a code style guide example [here](https://github.com/thomasjacobsen-unity/Unity-Code-Style-Guide) or download the full e-book, [*Use a C# style guide for clean and scalable game code (Unity 6 edition)*](https://unity.com/resources/c-sharp-style-guide-unity-6).

Formatting your code

Properties

Expression-bodied properties

Auto-implemented property

Serialization

Brace or indentation style

Decide on a uniform indentation

Don’t omit braces

Keep braces for clarity in multiline statements

Standardize switch statements

## Formatting your code

Along with naming, formatting helps reduce guesswork and improves code clarity. By following a standardized style guide, code reviews become less about how the code looks and more about what it does.

Omit, expand, or modify these example rules to fit your team’s needs.

In all cases, consider how your team will implement each formatting rule and then have everyone apply it uniformly. Refer back to your team’s style to resolve any discrepancies.

Consider each of the following code formatting suggestions when setting up your Unity dev style guide.

## Properties

A property provides a flexible mechanism to read, write, or compute class values. Properties behave as if they were public member variables, but in fact they’re special methods called [accessors](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/using-properties). Each property has a get and set method to access a private field, called a [backing field](https://docs.microsoft.com/en-us/ef/core/modeling/backing-field?tabs=data-annotations).

In this way, the property [encapsulates](https://en.wikipedia.org/wiki/Encapsulation_(computer_programming)#Information_hiding) the data, hiding it from unwanted changes by the user or external objects. The getter and setter each have their own access modifier, allowing your property to be read-write, read-only, or write-only.

You can also use the accessors to validate or convert the data (e.g., verify that the data fits your preferred format or change a value to a particular unit).

The syntax for properties can vary, so your style guide should define how to format them. Use these tips to keep properties consistent in your code.

## Expression-bodied properties

Use expression-bodied properties for **single-line, read-only properties** (=>): This returns the private backing field.

``` hljs
// EXAMPLE: Expression-bodied properties
public class PlayerHealth

}
```

## Auto-implemented property

**Everything else uses the older** { get; set; } **syntax:** If you just want to expose a public property without specifying a backing field, use the [Auto-Implemented Property](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/auto-implemented-properties). Apply the expression-bodied syntax for the set and get accessors. Remember to make the setter private if you don’t want to give write access. Align the closing with the opening brace for multi-line code blocks.

``` hljs
// EXAMPLE: Expression-bodied properties
public class PlayerHealth

    // write-only (not using backing field)
    public int Health 
    // write-only, without an explicit setter
    public SetMaxHealth(int newMaxValue) => _maxHealth = newMaxValue;

}
```

## Serialization

Script serialization is the automatic process of transforming data structures or object states into a format that Unity can store and reconstruct later. For performance reasons, Unity handles serialization differently than in other programming environments.

Serialized fields appear in the Inspector, but you cannot serialize static, constant, or read-only fields. They must be either public or tagged with the **\[SerializeField\]** attribute. Unity only serializes certain field types, so refer to the [documentation page](https://docs.unity3d.com/Manual/script-Serialization.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=clean-code&utm_content=clean-code-that-scales-ebook) for the complete set of serialization rules.

Observe a few basic guidelines when working with serialized fields:

-   **Use the** \[SerializeField\] **attribute:** The SerializeField attribute can work with private or protected variables to make them appear in the Inspector. This encapsulates the data better than marking the variable **public** and prevents an external object from overwriting its values.
-   **Use the Range attribute to set minimum and maximum values:** The **\[Range(min, max)\]** attribute is handy if you want to limit what the user can assign to a numeric field. It also conveniently represents the field as a slider in the Inspector.
-   **Group data in serializable classes or structs to clean up the Inspector:** Define a public class or struct and mark it with the **\[Serializable\]** attribute. Define public variables for each type you want to expose in the Inspector.

Reference this serializable class from another class. The resulting variables appear within collapsible units in the Inspector.

A SERIALIZABLE CLASS OR STRUCT CAN HELP ORGANIZE THE INSPECTOR.

``` hljs
// EXAMPLE: A serializable class for PlayerStats

using System;
using UnityEngine;

public class Player : MonoBehaviour

// EXAMPLE: The private field is visible in the Inspector.

    [SerializeField]
    private PlayerStats _stats;
}
```

## Brace or indentation style

There are two common indentation styles in C#:

-   The [Allman style](https://en.wikipedia.org/wiki/Indentation_style#Allman_style), also known as the BSD style (from BSD Unix), places the opening curly braces on a new line.
-   The [K&R style](https://en.wikipedia.org/wiki/Indentation_style#K&R_style), or “one true brace style,” keeps the opening brace on the same line as the previous header.

There are variations on these [indentation styles](https://en.wikipedia.org/wiki/Indentation_style) as well. The examples in this guide use the Allman style from the [Microsoft Framework Design Guidelines](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/). Regardless of which one you choose as a team, make sure everyone follows the same indentation and brace style.

``` hljs
// EXAMPLE: Allman or BSD style puts opening brace on a new line.

void DisplayMouseCursor(bool showMouse) 

     else
     
}

// EXAMPLE: K&R style puts opening brace on the previous line.

void DisplayMouseCursor(bool showMouse)
     else 
}
```

## Decide on a uniform indentation

The indentation is typically two or four spaces. Get everyone on your team to agree on a setting in your Editor preferences without igniting a [tabs versus spaces flame war](https://thenewstack.io/spaces-vs-tabs-a-20-year-debate-and-now-this-what-the-hell-is-wrong-with-go/). Note that Visual Studio provides the option to convert tabs to spaces.

In Visual Studio (Windows), navigate to **Tools \> Options \> Text Editor \> C# \> Tabs**.

On Visual Studio for Mac, navigate to **Preferences \> Source Code \> C# Source Code**. Select the Text Style to adjust the settings.

TABS SETTINGS IN VISUAL STUDIO FOR WINDOWS

## Don’t omit braces

Don’t omit braces – not even for single-line statements. Braces increase consistency, which makes your code easier to read and maintain. In this example, the braces clearly separate the action, **DoSomething**, from the loop.

If later you need to add a Debug line or to run **DoSomethingElse**, the braces will already be in place. Keeping the clause on a separate line allows you to add a breakpoint easily.  

``` hljs
// EXAMPLE: Keep braces for clarity...

for (int i = 0; i < 100; i++) 
// … and/or keep the clause on a separate line.
for (int i = 0; i < 100; i++)

// AVOID: Omitting braces

for (int i = 0; i < 100; i++) DoSomething(i);
```

## Keep braces for clarity in multiline statements

Don’t remove braces from nested multiline statements. Removing braces in this case won’t throw an error, but will likely cause confusion. Apply braces for clarity, even if they’re optional. Braces also ensure that modifications, such as adding new logic, can be done safely without needing to refactor the surrounding structure.

``` hljs
// EXAMPLE: Keep braces for clarity.

for (int i = 0; i < 10; i++)

}
// AVOID: Removing braces from nested multiline statements

for (int i = 0; i < 10; i++)
    for (int j = 0; j < 10; j++)
        ExampleAction();
```

## Standardize switch statements

Formatting can vary, so document your team preferences in your style guide and standardize your **switch** statements accordingly.

Here is one example where you indent the case statements. It’s generally recommended to include a default case as well. Even if the default case is not needed (for example, in cases where all possibilities are covered), including one ensures that the code is prepared to handle unexpected values.

``` hljs
// EXAMPLE: Indent cases from the switch statement.
switch (someExpression) 

```

Horizontal spacing

Add spaces

Spacing after a comma

No spacing after parenthesis

No space between a function and parenthesis

Avoid spaces inside brackets

Spacing before flow control conditions

Spacing with comparison operators

Readability tips

Vertical spacing and regions

Code formatting in Visual Studio

Set up an .editorconfig file

## Horizontal spacing

Something as simple as spacing can enhance your code’s appearance onscreen. Your personal formatting preferences can vary, but try the following suggestions to improve readability.

## Add spaces

Add spaces to decrease code density. The extra whitespace can give a sense of visual separation between parts of a line improving readability.

``` hljs
// EXAMPLE: Add spaces to make lines easier to read.
for (int i = 0; i < 100; i++) 
// AVOID: No spaces
for(inti=0;i<100;i++)
```

## Spacing after a comma

Use a single space after a comma between function arguments.

``` hljs
// EXAMPLE: Use a single space after comma between arguments.
CollectItem(myObject, 0, 1);

// AVOID:
CollectItem(myObject,0,1);
```

## No spacing after parenthesis

Don’t add a space after the parenthesis and function arguments.

``` hljs
// EXAMPLE: No space after the parenthesis and function arguments
DropPowerUp(myPrefab, 0, 1);

//AVOID:
DropPowerUp( myPrefab, 0, 1 );
```

## No space between a function and parenthesis

Don’t use spaces between a function name and parenthesis.

``` hljs
// EXAMPLE: Omit spaces between a function name and parenthesis.
DoSomething()

// AVOID:
DoSomething ()
```

## Avoid spaces inside brackets

As much as possible, avoid spaces inside brackets.

``` hljs
// EXAMPLE: Omit spaces inside brackets.
x = dataArray[index];

// AVOID:
x = dataArray[ index ];
```

## Spacing before flow control conditions

Use a single space before flow control conditions and add a space between the flow comparison operator and parentheses.

``` hljs
// EXAMPLE: Use space before condition; separate parentheses with a space.
while (x == y)

// AVOID:
while(x==y)
```

## Spacing with comparison operators

Use a single space before and after comparison operators.

``` hljs
// EXAMPLE: Use space before condition; separate parentheses with a space.
if (x == y)

// AVOID:
if (x==y)
```

## Readability tips

**Keep lines short. Consider horizontal whitespace:** Decide on a standard line width (80-120 characters). Break a long line into smaller statements rather than letting it overflow.

**Maintain indentation/hierarchy:** Indent your code to increase legibility.

**Don’t use column alignment unless needed for readability:** This type of spacing aligns the variables but can make it difficult to pair the type with the name.

Column alignment, however, can be useful for bitwise expressions or structs with a lot of data. Just be aware that it may create more work for you to maintain the column alignment as you add more items. Some auto-formatters might also change which part of the column gets aligned.

``` hljs
// EXAMPLE: One space between type and name

    public float Speed = 12f;
    public float Gravity = -10f;
    public float JumpHeight = 2f;

    public Transform GroundCheck;
    public float GroundDistance = 0.4f;
    public LayerMask GroundMask;

// AVOID: Column alignment

    public float                Speed = 12f;
    public float                Gravity = -10f;
    public float                JumpHeight = 2f;
    public Transform            GroundCheck;
    public float                GroundDistance = 0.4f;
    public LayerMask            GroundMask;
```

## Vertical spacing and regions

You can use the vertical spacing to your advantage as well. Keep related parts of the script together and use blank lines to your advantage. Try these suggestions to organize your code from top to bottom:

-   **Group dependent and/or similar methods together:** Code needs to be logical and coherent. Keep methods that do the same thing next to one another, so someone reading your logic doesn’t have to jump around the file.
-   **Use the vertical whitespace to your advantage to separate distinct parts of your class**: For example, you can add two blank lines between:
    -   Variable declarations and methods
    -   Classes and Interfaces
    -   **if-then-else blocks** (if it helps readability)

Keep this to a minimum and note on your style guide where applicable.

**Using regions in your code**

The #region directive enables you to collapse and hide sections of code in C# files, making large files more manageable and easier to read.

However, if you follow the general advice for Classes from this guide, your class size should be manageable and the **#region** directive superfluous. Break your code into smaller classes instead of hiding code blocks behind regions. You will be less inclined to add a region if the source file is short.

**Note**: Many developers consider [regions to be code smells or anti-patterns](https://softwareengineering.stackexchange.com/questions/53086/are-regions-an-antipattern-or-code-smell). Decide as a team on which side of the debate you fall.

## Code formatting in Visual Studio

Don’t despair if these formatting rules seem overwhelming. Modern IDEs make it efficient to set up and enforce them. You can create a template of formatting rules and then convert your project files at once.

To set up formatting rules for the script editor:

-   In Visual Studio (Windows), navigate to **Tools > Options**. Locate **Text Editor > C# > Code Style Formatting**. Use the settings to modify the General, Indentation, New Lines, Spacing, and Wrapping options.
-   In Visual Studio for Mac, select **Visual Studio > Preferences,** then navigate to **Source Code > Code Formatting > C# source code**. Select the Policy at the top. Then set your spacing and indentation in the Text Style tab. In the C# Format tab, adjust the Indentation, New Lines, Spacing, and Wrapping settings.

If at any time you want to force your script file to conform to the style guide:

-   In Visual Studio (Windows), go to **Edit > Advanced > Format Document** (**Ctrl + K, Ctrl + D** hotkey chord). If you want only to format white spaces and tab alignment, you can also use Run Code Cleanup (**Ctrl + K , Ctrl + E**) at the bottom of the editor.
-   In Visual Studio for Mac, go to **Edit > Format Document** (**Ctrl + I** hotkey)

On Windows, you can also share your editor settings from **Tools \> Import and Export Settings**. Export a file with the style guide’s C# code formatting and then have every team member import that file.  

Visual Studio makes it easy to follow the style guide. Formatting then becomes as simple as using a hotkey.

**Note:** You can configure an [EditorConfig](https://editorconfig.org) file instead of importing and exporting Visual Studio settings. Doing this allows you to share formatting more easily across different IDEs, and it has the added benefit of working with version control. See the [.NET code style rule options](https://docs.microsoft.com/en-us/dotnet/fundamentals/code-analysis/code-style-rule-options) for more information.

Though this isn’t specific to clean code, be sure to check out [10 ways to speed up your programming workflow in Unity with Visual Studio](https://blog.unity.com/technology/10-ways-to-speed-up-your-programming-workflows-in-unity-with-visual-studio-2019?utm_source=demand-gen&utm_medium=pdf&utm_campaign=clean-code&utm_content=clean-code-that-scales-ebook). Clean code is much easier to format and refactor if you apply these productivity tips.

THE PREVIEW WINDOW SHOWS OFF YOUR STYLE GUIDE CHOICES.

## Set up an .editorconfig file

To set up an .editorconfig file in Visual Studio Code, follow these steps:

-   In the root directory of your project, create a new file named .editorconfig.
-   Open the .editorconfig file and add your desired configuration settings.

Here’s an example configuration for C#:

**# top-most EditorConfig file**

**root = true**

**# Unix-style newlines with a newline ending every file**

**\[\*\]**

**end_of_line = lf**

**insert_final_newline = true**

**# 4 space indentation**

**\[\*.cs\]**

**indent_style = space**

**indent_size = 4**

**charset = utf-8**

**trim_trailing_whitespace = true**

**# Tab indentation for Makefiles**

**\[Makefile\]**

**indent_style = tab**

**# Specific settings for JSON files**

**\[\*.json\]**

**indent_style = space**

**indent_size = 2**

## Get more code style tips

Learn more about naming conventions [here](https://unity.com/how-to/naming-and-code-style-tips-c-scripting-unity) or check out the [full e-book](https://unity.com/resources/c-sharp-style-guide-unity-6). You can also explore our detailed [code style guide example](https://github.com/thomasjacobsen-unity/Unity-Code-Style-Guide).

---
title: "Naming Rules & Style Conventions for C# Scripting Code"
page_title: "Naming Rules & Style Conventions  for C# Scripting Code"
source_url: "https://unity.com/how-to/naming-and-code-style-tips-c-scripting-unity"
final_url: "https://unity.com/how-to/naming-and-code-style-tips-c-scripting-unity"
topic: "csharp-style"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Naming and code style tips for C# scripting in Unity

While there might not be one right way to format your C# code, agreeing on a consistent style across your team can result in a cleaner, more readable and scalable codebase. A well-organized style guide can help you rein in discrepancies to produce a cohesive final product.

The names of your variables, classes, and methods aren’t mere labels. They carry weight and meaning. Good naming style impacts how someone reading your program can comprehend the idea you’re trying to convey.

This page provides tips and key considerations to keep in mind for naming conventions and code formatting when creating your own style guide.

**Note**: The recommendations shared here are based on those provided by Microsoft. The best code style guide rules are the ones that work best for your team’s needs.

You can find a code style guide example [here](https://github.com/thomasjacobsen-unity/Unity-Code-Style-Guide) or download the full e-book, *[Use a C# style guide for clean and scalable game code (Unity 6 edition)](https://unity.com/resources/c-sharp-style-guide-unity-6).*

Identifier names

Casing terminology

Fields and variables

Enums

Classes and interfaces

Methods

Events and event handlers

Use verbs

Use System.Action

Prefix method with “On”

Prefix with subject’s name and underscore

Use EventArgs carefully

Namespaces

Prefixes

## Identifier names

An [identifier](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/lexical-structure#identifiers) is any name you assign to a type (class, interface, struct, delegate, or enum), member, variable, or namespace.

Avoid special characters (backslashes, symbols, Unicode characters) in your identifiers, even though C# permits them. These can interfere with certain Unity command-line tools. Steer clear of unusual characters to ensure compatibility with most platforms.

## Casing terminology

You can’t define variables with spaces in the name because C# uses the space character to separate identifiers. Casing schemes can alleviate the issue of having to use compound names or phrases in source code.

Listed below are several well-known naming and casing conventions:

**Camel case (camelCase)**

Also known as camel caps, [camel case](https://en.wikipedia.org/wiki/Camel_case) is the practice of writing phrases without spaces or punctuation, separating words with a single capitalized letter. The very first letter is lowercase. Local variables and method parameters are camel case. For example:

  
**examplePlayerController**

**maxHealthPoints**

**endOfFile**

**Pascal case (PascalCase)**

Pascal case is a variation of camel case, where the initial letter is capitalized. Use this for class, public fields and method names in Unity development. For example:

  
**ExamplePlayerController**

**MaxHealthPoints**

**EndOfFile**

**Snake case (snake_case)**

In this case, spaces between words are replaced with an underscore character. For example:

**example_player_controller**

**max_health_points**

**end_of_file**

**Kebab case (kebab-case)**

Here, spaces between words are replaced with dashes. The words appear on a “skewer” of dash characters. For example:  

**example-player-controller**

**Max-health-points**

**end-of-file**

**naming-conventions-methodology**

The Kebab-case is widely used in web technologies and namely for CSS. We are also recommending it for use with UI Toolkit USS.

**Hungarian notation**

The variable or function name often indicates its intention or type. For example:  

**int iCounter**

**string strPlayerName**

  
Hungarian notation is an older convention and is not common in Unity development.

## Fields and variables

Consider these rules for your variables and [fields](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/fields):

-   **Use nouns for variable names:** Variable names should be descriptive, clear, and unambiguous because they represent a thing or state. So use a noun when naming them except when the variable is of the type **bool** (see below).
-   **Prefix Booleans with a verb:** These variables indicate a **true** or **false** value. Often they are the answer to a question, such as – is the player running? Is the game over? Prefix them with a verb to make their meaning more apparent. Often this is paired with a description or condition, e.g. **isDead**, **isWalking**, **hasDamageMultiplier**, etc.
-   **Use meaningful names. Don’t abbreviate (unless it’s math):** Your variable names should reveal their intent. Choose names that are easy to pronounce and search for – not just for your colleagues but also to provide extra context to the code for when using AI tools, as this can contribute to more accurate code generation and suggestions. Choose identifier names that are easily readable. For example, a property named HorizontalAlignment is more readable than AlignmentHorizontal. Single letter variables are fine for loops and math expressions, but otherwise, don’t abbreviate. Clarity is more important than any time saved from omitting a few vowels. You might be tempted to use short “junk” names when prototyping, but this won’t save you time if you need to refactor the code at a later date. Pick meaningful names from the beginning.
-   **Use pascal case (MyPropertyName) for public fields. Use camel case (myPrivateVariable) for private variables:** For an alternative to public fields, use Properties with a public getter (see Formatting above and below).
-   **Consider using prefixes or special encoding:** Some guides suggest adding a prefix to private member variables with an underscore (\_) to differentiate them from local variables. In our style guides we use prefixes for private member variables (m\_), constants (k\_), or static variables (s\_), so the name can reveal more about the variable at a glance. For example, movementSpeed becomes m_movementSpeed.Mixing PascalCase with the prefix such as m_MovementSpeed is also an option but is generally less commonly used in modern C#. Alternatively, use the this keyword to distinguish between member and local variables in context and skip the prefix. Public fields and properties generally don’t have prefixes. Local variables and parameters use camel case with no prefix. Many developers eschew these and rely on the editor instead. However, not all IDEs support highlighting and color coding, and some tools can’t show rich context at all.
-   **Fields are automatically initialized to their default values:** Default value is typically 0 for numeric types like int, while reference type fields (e.g., objects) are initialized to null by default, and bool fields are initialized to false by default. Given this, explicitly setting a field to its default value is generally unnecessary.
-   **Name constant variables with k\_ as prefix and in PascalCase:** This helps to distinguish constants from regular variables or properties, and makes the code easier to read and maintain.
-   **Specify (or omit) access level modifiers consistently:** If you leave off the access modifier, the compiler will assume the access level to be private. This works well, but be consistent in how you omit the default access modifier. MSFT guidelines recommended to explicitly specify private to make the access level clear and to avoid any ambiguity. Other guides argue you should drop redundant access specifiers (leave off 'private' at type scope) and, similarly, drop redundant initializers (i.e. no '= 0' on the ints, '= null' on ref types, etc.). Remember that you’ll need to use protected if you want this in a subclass later. However, it’s generally considered good practice to specify access level modifiers.
-   **Favor readability over brevity:** As [this example](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/general-naming-conventions) from the MSFT documentation shows, the property name CanScrollHorizontally is better than ScrollableX (an obscure reference to the X-axis).
-   **Use one variable declaration per line:** It’s less compact, but enhances readability.
-   **Avoid redundant names:** If your class is called Player, you don’t need to create member variables called PlayerScore or PlayerTarget. Trim them down to Score or Target.
-   Drop redundant initializers (i.e. no '= 0' on the ints, '= null' on ref types, etc.).
-   **Avoid jokes or puns:** While they might elicit a chuckle now, the infiniteMonkeys or dudeWheresMyChar variables won’t hold up after a few dozen reads, and more importantly, it violates our previous stated goal of naming revealing context.
-   **Limit the use of the** var **keyword to only implicitly typed local variables if it helps readability and the type is obvious:** Specify when to use var in your style guide. For example, many developers avoid var when it obscures the variable’s type or with primitive types outside a loop.

``` hljs
// EXAMPLE: Public and private variables

public float DamageMultiplier = 1.5f;
public float MaxHealth;
public bool IsInvincible;

private bool _isDead;
private float _currentHealth;

// parameters
public void InflictDamage(float damage, bool isSpecialDamage)

    // local variable versus private member variable
    if (totalDamage > _currentHealth)
    
}
```

## Enums

Enums are special value types defined by a set of named constants. By default, the constants are integers, counting up from zero.

Use Pascal case for enum names and values. You can place public enums outside of a class to make them global. Use a singular noun for the enum name as it represents a single value from a set of possible values. They should have no prefix or suffix.

**Note**: Bitwise enums marked with the [System.FlagsAttribute](https://docs.microsoft.com/en-us/dotnet/api/system.flagsattribute?view=net-5.0) attribute are the exception to this rule. You typically pluralize these as they represent more than one type.

  

``` hljs
// EXAMPLE: Enums use singular nouns …
public enum WeaponType

public enum FireMode

// EXAMPLE: … but a bitwise enum is plural.

[Flags] 
public enum AttackModes 

```

## Classes and interfaces

Follow these standard rules when naming your classes and interfaces:

-   **Use Pascal case nouns or noun phrases for class names:** This distinguishes type names from methods, which are named with verb phrases.
-   **If you have a Monobehaviour in a file, the source file name must match:** You may have other internal classes in the file, but only one Monobehaviour should exist per file.
-   **Prefix interface names with a capital I:** Follow this with an adjective that describes the functionality.

``` hljs
// EXAMPLE: Class formatting
public class ExampleClass : MonoBehaviour

}

// EXAMPLE: Interfaces
public interface IKillable

public interface IDamageable<T>

```

## Methods

In C#, every executed instruction is performed in the context of a method.

**Note**: “function” and “method” are often used interchangeably in Unity development. However, because you can’t write a function without incorporating it into a class in C#, “method” is the accepted term.

Methods perform actions, so apply these rules to name them accordingly:

-   **Start the name with a verb or verb phrases:** Add context if necessary. e.g. **GetDirection**, **FindTarget**, etc.
-   **Use camel case for parameters:** Format parameters passed into the method like local variables.
-   **Methods returning bool should ask questions:** Much like Boolean variables themselves, prefix methods with a verb if they return a true-false condition This phrases them in the form of a question, e.g. **IsGameOver**, **HasStartedTurn**.

``` hljs
// EXAMPLE: Methods start with a verb.
public void SetInitialPosition(float x, float y, float z)

// EXAMPLE: Methods ask a question when they return bool.
public bool IsNewPosition(Vector3 currentPosition)

```

## Events and event handlers

Events in C# implement the [observer pattern](https://en.wikipedia.org/wiki/Observer_pattern). This software design pattern defines a relationship in which one object, the subject (or publisher), can notify a list of dependent objects called observers (or subscribers). Thus, the subject can broadcast state changes to its observers without tightly coupling the objects involved. You can learn more about using the observer and other design patterns in your Unity projects in the e-book [*Level up your code with design patterns and SOLID*](https://unity.com/resources/design-patterns-solid-ebook?isGated=false).

## Use verbs

Name the event with a verb phrase. Choose a name that communicates the state change accurately. Use the present or past participle to indicate events “before” or “after.” For example, specify “OpeningDoor” for an event before opening a door or “DoorOpened” for an event afterward.

## Use System.Action

In most cases, the [Action\<T>](https://docs.microsoft.com/en-us/dotnet/api/system.action-1?view=net-5.0) delegate can handle the events needed for gameplay. You may pass anywhere from 0 to 16 input parameters of different types with a return type of void. Using the predefined delegate saves code.

**Note**: You can also use the [EventHandler](https://docs.microsoft.com/en-us/dotnet/api/system.eventhandler?view=net-5.0) or [EventHandler\<TEventArgs>](https://docs.microsoft.com/en-us/dotnet/api/system.eventhandler-1?view=net-5.0) delegates. Agree as a team on how everyone will implement events.

``` hljs
// EXAMPLE: Events 

// using System.Action delegate

public event Action OpeningDoor;    // event before
public event Action DoorOpened;     // event after

public event Action<int> PointsScored;
public event Action<CustomEventArgs> ThingHappened;
```

## Prefix method with “On”

The subject that invokes the event typically does so from a method prefixed with “On,” e.g. “OnOpeningDoor” or “OnDoorOpened.”

``` hljs
// raises the Event if you have subscribers
public void OnDoorOpened()

public void OnPointsScored(int points)

```

## Prefix with subject’s name and underscore

If the subject is named “GameEvents,” your observers can have a method called “GameEvents_OpeningDoor” or “GameEvents_DoorOpened.” Note that this is called the “event handling method”, not to be confused with the EventHandler delegate.

## Use EventArgs carefully

Create custom EventArgs only as necessary. If you need to pass custom data to your Event, create a new type of EventArgs, either inherited from [System.EventArgs](https://docs.microsoft.com/en-us/dotnet/api/system.eventargs?view=net-5.0) or from a custom struct.

``` hljs
// define an EventArgs if needed

// EXAMPLE: Read-only, custom struct used to pass an ID and Color
public struct CustomEventArgs

    public Color Color 
    public CustomEventArgs(int objectId, Color color)
    
}
```

## Namespaces

Use [namespaces](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/types/namespaces) to ensure that your classes, interfaces, enums, etc. won’t conflict with existing ones from other namespaces or the global namespace. Namespaces can also prevent conflicts with third-party assets from the Asset Store.

When applying namespaces:

-   Use PascalCase without special symbols or underscores.
-   Add a **using** directive at the top of the file to avoid repeated typing of the namespace prefix.
-   Create sub-namespaces as well. Use the dot(.) operator to delimit the name levels, allowing you to organize your scripts into hierarchical categories. For example, you can create MyApplication.GameFlow, MyApplication.AI, MyApplication.UI, and so on to hold different logical components of your game.
-   It’s generally considered good practice to have namespaces that reflect the folder structure of the project as having logically grouped related classes and components together, also makes it easier to find and understand the structure of the codebase.

``` hljs
namespace Enemy 

    public class Controller2 : MonoBehaviour 
    
}
```

## Prefixes

In code, these classes are referred to as **Enemy.Controller1** and **Enemy.Controller2**, respectively. Add a using line to save typing out the prefix:

**using Enemy;**

When the compiler finds the class names **Controller1** and **Controller2**, it understands you mean **Enemy.Controller1** and **Enemy.Controller2**.

If the script needs to refer to classes with the same name from different namespaces, use the prefix to differentiate them. For instance, if you have a **Controller1** and **Controller2** class in the **Player** namespace, you can write out **Player.Controller1** and **Player.Controller2** to avoid any conflicts. Otherwise, the compiler will report an error.

**using Enemy;**

## Get more code style tips

Learn more about general formatting [here](https://unity.com/how-to/formatting-best-practices-c-scripting-unity?) or check out the [full e-book](https://unity.com/resources/c-sharp-style-guide-unity-6). You can also explore our [code style guide example](https://github.com/thomasjacobsen-unity/Unity-Code-Style-Guide).

---
title: "Clean up your code: How to create your own C# code style (Unity blog)"
page_title: "Clean up your code: How to create your own C# code style"
source_url: "https://unity.com/blog/engine-platform/clean-up-your-code-how-to-create-your-own-c-code-style"
final_url: "https://unity.com/blog/engine-platform/clean-up-your-code-how-to-create-your-own-c-code-style"
topic: "csharp-style"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Clean up your code: How to create your own C# code style

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# Clean up your code: How to create your own C# code style

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">THOMAS KROGH-JACOBSEN / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Technical Content Marketing Manager</span>

<span class="mr-2">Sep 7, 2022</span><span class="mr-2">\|</span><span class="mr-2">15 Min</span>

Programming and DevOps

Testing and performance

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

**While there’s more than one way to format Unity C# code, agreeing on a consistent code style for your project enables your team to develop a clean, readable, and scalable codebase. In this blog, we provide some guidelines and examples you can use to develop and maintain your own code style guide.**

Please note that these are only recommendations based on those provided by Microsoft. This is your chance to get inspired and decide what works best for your team.

Use our C# style guide as a starting point

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Ideally, a Unity project should feel like it’s been developed by a single author, no matter how many developers actually work on it. A style guide can help unify your approach for creating a more cohesive codebase.

It’s a good idea to follow industry standards wherever possible and browse through existing style guides as a starting point for creating your own. In partnership with internal and external Unity experts, we released a new e-book, [*Create a C# style guide: Write cleaner code that scales*](https://resources.unity.com/games/create-code-style-guide-e-book) for inspiration, based on [Microsoft’s comprehensive C# style](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions).

The [Google C# style guide](https://google.github.io/styleguide/csharp-style.html) is another great resource for defining guidelines around naming, formatting, and commenting conventions. Again, there is no right or wrong method, but we chose to follow Microsoft standards for our own guide.

Our e-book, along with an [example C# file](https://github.com/thomasjacobsen-unity/Unity-Code-Style-Guide), are available for free. Both resources focus on the most common coding conventions you’ll encounter while developing in Unity. These are all, essentially, a subset of the [Microsoft Framework Design guidelines](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/), which include an extensive number of best practices beyond what we cover in this post.

No right or wrong way

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We recommend customizing the guidelines provided in our style guide to suit your team’s preferences. These preferences should be prioritized over our suggestions and the Microsoft Framework Design guidelines if they’re in conflict.

The development of a style guide requires an upfront investment but will pay dividends later. For example, managing a single set of standards can reduce the time developers spend on ramping up if they move onto another project.

Of course, consistency is key. If you follow these suggestions and need to modify your style guide in the future, a few find-and-replace operations can quickly migrate your codebase.

What should a C# code style guide include?

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Concentrate on creating a pragmatic style guide that fits your needs by covering the majority of day-to-day use cases. Don’t overengineer it by attempting to account for every single edge case from the start. The guide will evolve organically over time as your team iterates on it from project to project.

Most style guides include basic formatting rules. Meanwhile, specific naming conventions, policy on use of namespaces, and strategies for classes are somewhat abstract areas that can be refined over time.

Let’s look at some common formatting and naming conventions you might consider for your style guide.

Formatting rules

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The two common indentation styles in C# are the Allman style, which places the opening curly braces on a new line (also known as the BSD style from BSD Unix), and the K&R style, or “one true brace style,” which keeps the opening brace on the same line as the previous header.

In an effort to improve readability, we picked the Allman style for our guide, based on the Microsoft Framework Design guidelines:  

pre]:rounded-xl [&>pre]:!p-4">

```
// EXAMPLE: Allman or BSD style puts opening brace on a new line.

void DisplayMouseCursor(bool showMouse) 

}

// EXAMPLE: K&R style puts opening brace on the previous line.

void DisplayMouseCursor(bool showMouse)
}
```

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Whatever style you choose, ensure that every programmer on your team follows it.

A guide should also indicate whether braces from nested multiline statements should be included. While removing braces in the following example won’t throw an error, it can be confusing to read. That’s why our guide recommends applying braces for clarity, even if they are optional.

pre]:rounded-xl [&>pre]:!p-4">

```
// EXAMPLE: Keep braces for clarity.

for (int i = 0; i < 10; i++)

}
// AVOID: Removing braces from nested multiline statements

for (int i = 0; i < 10; i++)
   for (int j = 0; j < 10; j++)
     ExampleAction();
```

For improving readability

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Something as simple as horizontal spacing can enhance your code’s appearance onscreen. While your personal formatting preferences can vary, here are a few recommendations from our style guide to improve overall readability:

-   **Add spaces to decrease code density**:The extra whitespace can give a sense of visual separation between parts of a line

pre]:rounded-xl [&>pre]:!p-4">

```
// EXAMPLE: Add spaces to make lines easier to read.
for (int i = 0; i < 100; i++) 
// AVOID: No spaces
for(int i=0;i<100;i++)
```

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

-   **Use a single space after a comma, between function arguments**.

pre]:rounded-xl [&>pre]:!p-4">

```
// EXAMPLE: Single space after comma between arguments
CollectItem(myObject, 0, 1);

// AVOID:
CollectItem(myObject,0,1);
```

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

-   **Don’t add a space after the parenthesis and function arguments**.

pre]:rounded-xl [&>pre]:!p-4">

```
// EXAMPLE: No space after the parenthesis and function arguments 
DropPowerUp(myPrefab, 0, 1);

// AVOID:
DropPowerUp( myPrefab, 0, 1 );
```

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

-   **Don’t use spaces between a function name and parenthesis**.

pre]:rounded-xl [&>pre]:!p-4">

```
// EXAMPLE: Omit spaces between a function name and parenthesis.
DoSomething()

// AVOID:
DoSomething ()
```

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

-   **Avoid spaces inside brackets**.

pre]:rounded-xl [&>pre]:!p-4">

```
// EXAMPLE: Omit spaces inside brackets.
x = dataArray[index];

// AVOID:
x = dataArray[ index ];
```

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

-   **Use a single space before flow control conditions**: Add a space between the flow comparison operator and the parentheses.

pre]:rounded-xl [&>pre]:!p-4">

```
// EXAMPLE: Space before condition; separate parentheses with a space
while (x == y)

// AVOID:
while(x==y)
```

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

-   **Use a single space before and after comparison operators**.

pre]:rounded-xl [&>pre]:!p-4">

```
// EXAMPLE: Space before condition; separate parentheses with a space
while (x == y)

// AVOID:
while(x==y)
```

Naming conventions

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Variables typically represent a state, so try to attribute clear and descriptive nouns to their names. You can then prefix booleans with a verbfor variables that must indicate a true or false value. Often they are the answer to a question such as, is the player running? Is the game over? Prefix them with a verb to clarify their meaning. This is often paired with a description or condition, e.g., isPlayerDead, isWalking, hasDamageMultiplier, etc.

Since methods perform actions, a good rule of thumb is to start their names with a verb and add context as needed, e.g., GetDirection, FindTarget, and so on, based on the return type. If the method has a bool return type, it can also be framed as a question.

Much like boolean variables themselves, prefix methods with a verb if they return a true-false condition. This phrases them in the form of a question, e.g., IsGameOver, HasStartedTurn.

Several conventions exist for naming events and event handles. In our style guide, we name the event with a verb phrase,similar to a method. Choose a name that communicates the state change accurately.Use the present or past participle to indicate events “before” or “after.” For instance, specify OpeningDoor for an event before opening a door and DoorOpened for an event afterward.

We also recommend that you don’t abbreviate names. While saving a few characters can feel like a productivity gain in the short term, what is obvious to you now might not be in a year’s time to another teammate. Your variable names should reveal their intent and be easy to pronounce. Single letter variables are fine for loops and math expressions, but otherwise, you should avoid abbreviations. Clarity is more important than any time saved from omitting a few vowels.

At the same time, use one variable declaration per line; it’s less compact, but also less error prone and enhances readability. Avoid redundant names. If your class is called Player, you don’t need to create member variables called PlayerScore or PlayerTarget. Trim them down to Score or Target.

In addition, avoid too many prefixes or special encoding.A practice highlighted in our guide is to prefix private member variables with an underscore (\_) to differentiate them from local variables. Some style guides use prefixes for private member variables (m\_), constants (k\_), or static variables (s\_), so the name reveals more about the variable.

However, it’s good practice to prefix interface names with a capital “I” and follow this with an adjective that describes the functionality. You can even prefix the event raising method (in the subject) with “On”: The subject that invokes the event usually does so from a method prefixed with “On,” e.g., OnOpeningDoor or OnDoorOpened.

pre]:rounded-xl [&>pre]:!p-4">

```
// EXAMPLE: Prefix interface names with a capital “I”
public interface IDamageable<T>

// EXAMPLE: Raising an event if you have subscribers
public void OnDoorOpened()

```

Casing terminology

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Camel case and Pascal case are common standards in use, compared to Snake or Kebab case, or Hungarian notations. Our guide recommends Pascal case for public fields, enums, classes, and methods, and Camel case for private variables, as this is common practice in Unity.

Don’t formalize everything

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

There are many additional rules to consider outside of what’s covered here. The [example guide](https://github.com/thomasjacobsen-unity/Unity-Code-Style-Guide) and our new e-book, [*Create a C# style guide: Write cleaner code that scales*](https://resources.unity.com/games/create-code-style-guide-e-book), provide many more tips for better organization.

The concept of clean code aims to make development more scalable by conforming to a set of production standards. A style guide should remove most of the guesswork developers would otherwise have regarding the conventions they should follow. Ultimately, this guide should help your team establish a consensus around your codebase to grow your project into a commercial-scale production.

Just how comprehensive your style guide should be depends on your situation. It’s up to your team to decide if they want their guide to set rules for more abstract, intangible concepts. This could include rules for using namespaces, breaking down classes, or implementing directives like the #region directive (or not). While #region can help you collapse and hide sections of code in C# files, making large files more manageable, it’s also an example of something that many developers consider to be [code smells or anti-patterns](https://softwareengineering.stackexchange.com/questions/53086/are-regions-an-antipattern-or-code-smell). Therefore, you might want to avoid setting strict standards for these aspects of code styling. Not everything needs to be outlined in the guide – sometimes it’s enough to simply discuss and make decisions as a team.

Clarity above all else

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

When we talked to the experts who helped create our guide, their main piece of advice was code readability above all else. Here are some pointers on how to achieve that:

-   **Use fewer arguments:** Arguments can increase the complexity of your method. By reducing their number, you make methods easier to read and test.
-   **Avoid excessive overloading:** You can generate an endless permutation of method overloads. Select the few that reflect how you’ll call the method, and then implement those. If you do overload a method, prevent confusion by making sure that each method signature has a distinct number of arguments.
-   **Avoid side effects:** A method only needs to do what its name advertises. Avoid modifying anything outside of its scope. Pass in arguments by value instead of reference when possible. So when sending back results via the out or ref keyword, verify that’s the one thing you intend the method to accomplish. Though side effects are useful for certain tasks, they can lead to unintended consequences. Write a method without side effects to cut down on unexpected behavior.

Download our code style guide and e-book here

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We hope that this blog helps you kick off the development of your own style guide. Learn more from our example [C# file](https://github.com/thomasjacobsen-unity/Unity-Code-Style-Guide) and brand new [e-book](https://resources.unity.com/games/create-code-style-guide-e-book) where you can review our suggested rules and customize them to your team’s preferences.

The specifics of individual rules are less important than having everyone agree to follow them consistently. When in doubt, rely on your team’s own evolving guide to settle any style disagreements. After all, this is a group effort.

Create a C# style guide: Write cleaner code that scales e-book

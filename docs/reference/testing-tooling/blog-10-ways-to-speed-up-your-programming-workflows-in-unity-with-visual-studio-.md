---
title: "10 ways to speed up your programming workflows in Unity with Visual Studio 2019 (Unity blog)"
page_title: "10 ways to speed up your programming workflows in Unity with Visual Studio 2019"
source_url: "https://unity.com/blog/engine-platform/10-ways-to-speed-up-your-programming-workflows-in-unity-with-visual-studio-2019"
final_url: "https://unity.com/blog/engine-platform/10-ways-to-speed-up-your-programming-workflows-in-unity-with-visual-studio-2019"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# 10 ways to speed up your programming workflows in Unity with Visual Studio 2019

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

Event

# 10 ways to speed up your programming workflows in Unity with Visual Studio 2019

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">THOMAS KROGH-JACOBSEN / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Technical Content Marketing Manager</span>

<span class="mr-2">Jul 14, 2020</span><span class="mr-2">\|</span><span class="mr-2">11 Min</span>

Programming and DevOps

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Visual Studio 2019 offers world-class debugging, and lots of new tools and customization options so that you can set up your coding environment exactly the way you want it. It also comes with a range of powerful features for working with C# in Unity that helps you write and refactor code quicker than before. In this blog post, we will take a look at 10 tips on some of these features which may speed up your workflow too.

Our Unity evangelist [Arturo Nereu](https://twitter.com/arturonereu) and [Abdullah Hamed](https://twitter.com/indiesaudi), program manager for Visual Studio Tools for Unity at Microsoft, recently [hosted a Unite Now session](https://resources.unity.com/unitenow/onlinesessions/tips-and-tricks-to-develop-in-unity-with-visual-studio-2019) sharing tips and tricks on how to get the most out of Visual Studio 2019 when developing in Unity.

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

This post shows a quick overview of some of these tips. We also added links directly to those sections from the talk as well as other related content, if you want to dig deeper.

Tip 1: Attach the Debugger to Unity and Play

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Using Console.Log is an easy and quick way to help debug your project utilizing Unity’s console view. However, Visual Studio offers a more efficient way which becomes increasingly valuable as your project gets more complex. In Visual Studio, [simply click the **Attach to Unity** button](https://youtu.be/KH0nqTpOVuM?t=1000) in the Visual Studio menu. This creates a connection between the two applications so that you can insert breakpoints and step through your code, while being in Play mode in Unity. You can also click **Attach to Unity and play** to start the execution without leaving your IDE. The beauty here is that it allows you to inspect the state of your code flow and values of the properties etc. at runtime. While this may seem trivial, being able to pause the execution at any time during gameplay and step through to inspect the specific state of the game and values of your properties in that exact frame, is a very powerful tool when debugging.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Another handy option when working with breakpoints is that you can [insert your own conditions](https://youtu.be/KH0nqTpOVuM?t=1169) with related actions such as a conditional expression which has to evaluate as true before applying in your debug flow.

Tip 2: Get performance insights and suggestions for best practices

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Visual Studio 2019 introduces Unity Analyzers. An analyzer works by detecting a code pattern and can offer to replace it with a more recommended pattern. Unity Analyzers are a collection of Unity-specific code diagnostics and code fixes that are open source and available on [GitHub](https://github.com/microsoft/Microsoft.Unity.Analyzers/blob/main/doc/index.md). Analyzers can provide you with a better understanding of Unity-specific diagnostics or simply help your project by removing general C# diagnostics that don’t apply to Unity projects. An example could be a simple conditional statement where you need to check if the GameObject has a specific tag to apply a certain behavior to it.

if(collision.gameObject.tag == "enemy")  

The analyzer would be able to analyze your code, will detect the pattern and offer to use the more optimized method instead. In this case, the analyzer would suggest the [CompareTag](https://docs.unity3d.com/ScriptReference/GameObject.CompareTag.html) method which is more efficient.

if(collision.gameObject.CompareTag("enemy"))  

While the above example represents a minor optimization tweak with no significant impact in a single script attached to a single GameObject, this may be different for a large scale project with 1000s of GameObjects with the script attached. It’s the sum of all parts when looking into performance optimization and Analyzers can make it easy to help you identify and improve your performance simply by reducing the unneeded overhead by optimizing the code syntax.

You can also find a list of the [analyzers here](https://github.com/microsoft/Microsoft.Unity.Analyzers/) and if you are interested in learning more visit this [blog post](https://devblogs.microsoft.com/visualstudio/making-our-unity-analyzers-open-source/) or jump directly to this part of the [Unite Now talk](https://youtu.be/KH0nqTpOVuM?t=466).

Tip 3: Use the Task List as a followup checklist

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

A common challenge when creating your scripts is the need to come back at a later point and revisit the code. That might be a result of implementing code snippets which eventually will need refactoring for better performance later but serves the current needs as you are f.x. testing out game mechanics. Visual Studio has a handy feature to keep track of this called **Task List** which allows you to track code comments that use tokens such as TODO and HACK, or even custom tokens. You can also manage shortcuts that take you directly to a predefined location in code. To create a task for later simply add the token in your code:

// TODO: Change the collision detection once new colliders are ready

The Task List window, which you can access from under **View** in the menu, gives you an overview of all the tasks you tagged and links you to those specific parts of the code in just one click.

Leverage the task list in Visual Studio

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

As the list of action items in your project grows, you can even configure your own custom tokens in the task list and assign priorities and organizing for your refactoring process effectively. To customize your Task List tokens: go to **Tools** \> **Options**.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

See the full example in the [Unite Now session](https://youtu.be/KH0nqTpOVuM?t=1461) here.

Tip 4: Use snippets to speed up your workflows

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Code snippets are small blocks of reusable code that can be inserted in a code file using a right-click menu (context menu) command or a combination of hotkeys. They typically contain commonly used code blocks such as try-finally or if-else blocks, but you can also use them to insert entire classes or methods. In short, they offer you a handy way to save a lot of time by creating the boilerplate code for you.

To surround your code with a snippet such as a namespace or region, press CTRL + K + S. That allows you to apply the snippet as demonstrated in the video below:

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

You can find a step-by-step walkthrough of creating your own code snippets in Microsoft’s documentation ([Visual Studio](https://docs.microsoft.com/en-us/visualstudio/ide/walkthrough-creating-a-code-snippet?view=vs-2019), [Visual Studio for Mac](https://docs.microsoft.com/en-us/visualstudio/mac/snippets?view=vsmac-2019#creating-a-new-template)).

Tip 5: Rename all variables in just a few clicks

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

A common workflow when you are refactoring your code is renaming your variables to more descriptive and accurate names. Changing it one place obviously means you also have to fix all references to that variable. However, Visual Studio offers an easy shortcut to do this in one operation. Simply highlight the name of the variable you want to rename and right-click (or use the keyboard shortcut CTRL + R) and then rename the variable. Select **preview changes** to review the implications of the change before applying.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

You can use the same tip for changing the classes of your script but remember you have to rename the C# file accordingly to avoid the compilation errors. Learn more about the class renaming flow [this part](https://youtu.be/KH0nqTpOVuM?t=2075) of the Unite Now session.

Tip 6: Comment out your code with a keyboard shortcut

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Commenting or uncommenting blocks of code is another common workflow when refactoring or debugging your code. It can be a time-consuming task when you do it one line at the time. Visual Studio, however, allows you to comment out entire blocks of code using a simple shortcut command: Ctrl+K+C and Ctrl+K+U for uncommenting it again. If you are on Mac, simply use CMD+K+C to comment out and CMD+K+U to remove the comments again.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Being able to comment out entire blocks quickly can be an efficient way to suppress specific game logic during your testing workflows.

Tip 7: Set up integration with GitHub in a few clicks

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

While [Unity Collaborate](https://unity3d.com/unity/features/collaborate) makes it easy to save, share, and sync your project with others directly from Unity with a user-friendly visual interface, some teams and developers prefer using source control solutions such as GitHub. Working with GitHub for source control is now much easier with the [Github for Unity](https://unity.github.com/) plugin. The extension is completely open source and it allows you to view your project history, experiment in branches, craft a commit from your changes, and push your code to GitHub without leaving Unity. The GitHub authentication is embedded in Unity, including 2FA and with a click of a button, you can quickly initialize your game’s repository without having to use command-line instructions. It allows you to create a Unity specific .gitignore file so you don’t have to set it up manually. With Visual Studio 2019 also comes a new interface which makes it even easier to work with GitHub directly in the IDE.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

To activate the new interface in Visual Studio: Go to **Tools \> Options \> Environment \> Preview features \> New Git user experience.**

You can also follow along with the video instructions from the [Unite Now session](https://youtu.be/KH0nqTpOVuM?t=2742), which shows a more in-depth walkthrough of getting started.

Tip 8: Collaborate remotely in real-time with Live Share

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Live Share enables you to share your instance of Visual Studio directly with your teammate using just a link, allowing them to edit your code and collaborate on your project in real-time. You don’t have to clone a repo or set up the environment first in order to do the sharing. You both just need to have Visual Studio installed and then it’s as easy as clicking a button to create the Live Share session.

LIiveShare allows you to collaborate on the code in realtime

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

To get started simply select **Live Share** to generate a link to the parts of your code that you want to share with anyone that has Visual Studio or Visual Studio Code installed. A sharing session is created between you and your collaborators, allowing them to see your code without having to install anything except for the editor. It works almost instantly.

You can learn more about Live Share from our [Unite Session here](https://youtu.be/KH0nqTpOVuM?t=2232), visit the [Visual Studio product page](https://visualstudio.microsoft.com/services/live-share/) or jump directly to the [Quickstart guide](https://docs.microsoft.com/en-us/visualstudio/liveshare/quickstart/share) here.

Tip 9: Create boilerplate code easily for Unity Messages

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Remembering the signature of all the MonoBehaviour methods is tricky and while the Unity documentation will have you covered, Visual Studio provides a neat feature that allows you to look it up directly in the IDE. Simply click CTRL + Shift + M, search for the function you would like to implement, and filter through the search result to find the method. Select the checkbox and click Ok to insert the boilerplate code for the method directly in your code ready for you to use.

Tip 10: Keyboard shortcuts

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Several of the above tips are available with handy shortcuts and at the end of the day, knowing those shortcuts may be the biggest timesaver of them all. So let’s wrap up the list with a summary of the keyboard shortcuts to these tips and a few more as a bonus.

**What** **Windows** **Mac** Search your entire project for anything. Use CTRL+T CMD + . Implement Unity Messages CTRL + Shift + M CMD + Shift + M Comment out code blocks CTRL + K / CTRL + C CMD + / Uncomment blocks of code CTRL + K / CTRL + U CMD + / Copy from clipboard history CTRL + Shift + V View task list CTRL + T No default keybinding, but you can bind it. Insert a surrounding snippet such as namespace CTRL + K + S: No default keybinding, but you can bind it. Renaming a variable while updating all references CTRL + R CMD +R Compile the code CTRL+SHIFT+B CMD + Shift + B

Share your tips?

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Visual Studio 2019 is packaged with features and there are so many customization options that can enhance your productivity working with Unity depending on your specific workflows. There’s too many to cover them all here. We hope that the few tips that we shared here will inspire you to dive in and that you’re finding the format useful. Let us know if you have any tips we didn't cover, and feel free to share them with the community in the comments. We’d also love to hear if you would like more tips and tricks on how to improve your workflows in Unity and if there are any topics, in particular, that you would like to have covered in a future blog post.

Got feedback on how Visual Studio could be improved?

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We are constantly working on improving the workflows and our teams are working closely with Microsoft in terms of giving you the best IDE experience. Hence we would love to hear from you if you have any ideas or feedback. Feel free to ping John Miller at [@jmillerdev](https://twitter.com/jmillerdev), Senior Program Manager, Visual Studio Tools for Unity at Microsoft, or share your feedback with us in our [Scripting forum](https://forum.unity.com/forums/scripting.12/).

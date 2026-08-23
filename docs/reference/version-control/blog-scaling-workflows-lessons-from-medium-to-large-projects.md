---
title: "Unity Blog: Scaling Unity workflows for medium to large projects"
page_title: "Scaling Unity Workflows for Medium To Large Projects"
source_url: "https://unity.com/blog/scaling-workflows-lessons-from-medium-to-large-projects"
final_url: "https://unity.com/blog/scaling-workflows-lessons-from-medium-to-large-projects"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Scaling Unity Workflows for Medium To Large Projects

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

Article

# Scaling Unity workflows: Lessons from medium to large projects

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">MATTHEW WOJTECHKO / MEGA CAT STUDIOS</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Lead Game Developer</span>

<span class="mr-2">Mar 31, 2026</span>

Game design

Engine

Programming and DevOps

World building

Programming

Testing and performance

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

*This blog post is the first in a series by Mega Cat Studios, where they share their Unity expertise and solutions for real-world commercial game development challenges. Check out the other posts in this series that cover input and level and environment design:*

-   [Batting a thousand: How Unity’s event-driven Input System powers controls in Backyard Baseball 2026](https://unity.com/blog/input-system-event-driven-architecture-for-scalable-controls)
-   [How to reimagine a classic sports game for a new generation with level design, worldbuilding, and VFX](https://unity.com/blog/reimagining-backyard-baseball-3d-level-design-and-environment-art)
-   [Rendering at scale: Efficient strategies for massive object counts](https://unity.com/blog/rendering-at-scale-efficient-strategies-for-massive-object-counts)

*We hope you pick up some great tips!*

You have an awesome idea, and the code flies as fast as you can type it. With each commit, a new feature takes shape. But it’s the very speed at which your ideas form that could soon result in you looking at a big, buggy mess.

At Mega Cat Studios, we begin all our projects with passion, so we understand the allure of playing fast and loose, and getting things done as soon as possible. For a prototype, this approach is fine, and in fact, we recommend it! A wise developer knows when to prioritize iteration velocity and when to prioritize stability. Because when you exit the prototype phase, that “fast and loose” approach becomes a liability.

We’ve survived this transition many times at [Mega Cat Studios](https://megacatstudios.com/), and with every project, we learn something new. We’d like to share some of the lessons we learned to get our most recent project, [*Backyard Baseball*](https://megacatstudios.com/pages/backyard-baseball-97), ready for launch.

## Lesson 1: Structure for scale

The prefab hierarchy of the scene shows its organization into clearly defined groups and parent prefabs, facilitating easy navigation and efficient modifications.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Scaling issues are rarely caused by bad code; instead, they arise more often due to unplanned architecture. If a developer or artist can’t find an asset in 10 seconds, the workflow needs to change. A few tips for setting up your project to scale include:

-   **Organize by Type and Purpose**: We group by Type, then Purpose. Type includes categories like art, code, and audio. Purpose is what they’re used for. Intuitive organization reduces onboarding friction; a new artist should know exactly where a "Character Idle" sprite belongs without asking.
-   **Keep scenes simple**: We’ve thrown away the "Mega-Scene” and instead opt for smaller scenes, such as a main scene that holds save data and critical systems, along with a title screen and baseball diamond scenes that additively load depending on whether the player is in a match. Similarly, we use prefabs for self-contained features, so the changes are less likely to be serialized in the scene file that contains them. This allows an artist to work on the environment while a designer tweaks gameplay in the same "level" without file conflicts (more on this later).
-   **Set up the Addressables system**: Instead of traditional Resources folders, we use the [Addressables system](https://docs.unity3d.com/Packages/com.unity.addressables@2.10/manual/index.html) to load assets only when needed, keeping memory usage lean. Plus, loading an asset with its Addressable key is clearer and less prone to breaking than loading via a file path to a specific location in the Resources folder.

The hard part isn't understanding these best practices. It's committing to them at the start and maintaining that discipline even years down the line.

Know which phase of development you’re in and what you’re prioritizing at that stage.

“In the prototyping phase, since there's barely any code, it's okay to make it functional first before making it modular,” says Paolo Roxas, a developer on *Backyard Baseball*. “We want to see how the project plays out before making it more complex.”

Between the playable characters, game modes, and lively environments, the enormity of Backyard Baseball made good architecture a necessity.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

## Lesson 2: Work with Unity, not against it

Small, focused considerations and actions plug together to form complex fielding decisions. No "god" scripts, just composable building blocks working in concert.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

"There's nothing more powerful than creating building blocks – whether Components, [ScriptableObjects](https://unity.com/resources/create-modular-game-architecture-scriptableobjects-unity-6), or custom classes – that are focused, concise, and self-contained," says David Chávez Armenteros, Head of Engineering at Mega Cat Studios. Unity embraces modularity at its core. To stay flexible, we follow three classic principles:

1\. **Single responsibility**: Each script or class should have one well-defined role.

2\. **Loose coupling**: Systems should interact through interfaces or events rather than direct references, and only when appropriate. We recommend graphing out dependencies between systems before implementing them in code to avoid cyclical or tangled architecture.

3\. **Plug and play**: Combine small, focused units to create complex behavior rather than writing sprawling "god” scripts.

## Lesson 3: Use limitations to set you free

Assembly Definition files contain the logic for specific systems and clearly specify dependencies. As shown, at Mega Cat Studios, we use many small assemblies to keep things modular and organized. Just be careful not to introduce "cyclic dependencies."

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

[Assembly Definitions](https://docs.unity3d.com/Manual/assembly-definition-files.html) (AsmDefs) are C# constructs that group your code. Their advertised advantage is reduced compile times, but their secret superpower is enforcing modularity.

Nico Gaudenzi, lead developer and spaghetti-code hater, swears by them.

"In *Backyard Baseball*, the Input layer and Gameplay layer are in different DLLs. The gameplay is completely agnostic to input details."

This saves engineers from themselves by making each dependency a calculated decision. If we really had to, we could rewrite the entire input system – from gamepad handling to netcode – without risking breaking player physics or AI behavior. More likely, it lets one engineer work in a single domain of the codebase without accidentally cascading changes to another system, and reduces the amount of code a developer needs to keep straight for feature implementations and bug fixes.

## Lesson 4: Test smarter, not harder

As projects grow, the "domino effect" can take over: A small change over here breaks something over there. Good architecture goes a long way, but it’s no silver bullet.

Before feature changes reach the paws of our esteemed Quality Assurance cats for manual testing, the game is rigorously analyzed in a series of automated unit tests.

"Tests work as a list of requirements," says Nico. "They describe what’s expected and provide key use cases."

When a character in *Backyard Baseball* pitches a fastball, steals a base, or hits a home run, there are specific gameplay results we want to achieve, such as ensuring the ball travels at a speed that feels authentic to the pitch, the runner’s timing aligns with base-stealing mechanics, or fielders react correctly to a hit. The character needs to correctly collide with the ground, the ball needs to move at the right speed, and more granular systems like player controller flags that track actions like winding up, swinging, or sprinting between bases, need to work.

When we make a tweak to Pablo Sanchez’s power, or even more critically, adjust the shared code that governs bat swings, we need to ensure every interaction, from contact timing to ball trajectory, behaves consistently across the entire game.

Often, what breaks is something you wouldn’t expect, which is the whole reason testing is so important.

With this system integrated into our workflow, we become aware the moment a specific requirement breaks, which cuts down on the testing and troubleshooting sessions that are as time-consuming as finding a needle in a haystack.

Unity's [Test Runner](https://docs.unity3d.com/Manual/test-framework/running-tests.html) works most effectively when your systems are modular, which is another reason we use Assembly Definitions.

## Lesson 5: Get your assets in gear

A visual scaling error like this is often a symptom of a broken workflow. To prevent human error, developers implement automated systems that enforce project standards before an asset even enters the scene.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

"To err is human; to forgive, divine."

But to set up systems to prevent human error in the first place is downright legendary.

After hours of coding and debugging, it's inevitable that some bleary-eyed developer will make a few misclicks or accidentally push changes to the repo that were only ever meant to be temporary. While forgivable (I say, as one of the occasionally bleary-eyed), an asset with poorly configured import settings could have huge consequences. And since many developers work on powerful machines, the nightmare scenario is that the performance issue goes unnoticed until later, like when a stadium scene with characters, animations, and effects starts causing slowdowns or instability on lower-end hardware.

To mitigate this risk, you could limit who has access to assets, but this leads to a bottleneck due to the many reasons game content needs to be adjusted:

-   The model is too big to fit with the camera setup.
-   This audio clip has less volume, so it needs a specific effect.
-   Every texture needs adjusting now that the shader has changed.

In a game like *Backyard Baseball*, where visual identity is premium, models and VFX receive hundreds of tweaks as we get the look and feel just right ahead of release.

“No amount of technical specifications can avoid the fact that having content variety means dealing with slight but significant differences between different assets,” says Nico.

Automation helps here as well:

-   **AssetPostprocessor**: We write custom import logic that enforces project standards.
-   **OnValidate**: We use the OnValidate method to report missing references in the Editor, which always fires before building.

Finally, though, don’t let all this talk of automation distract you from simple, manual fixes when they are faster.

"Never spend 10 days automating a task that takes 10 minutes to do manually,” David cautions.

## Lesson 6: Master the human element (collaboration)

At Mega Cat Studios, developers collaborate across departments using version control and simple guidelines to avoid conflicts while working on the game.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

[Version control](https://docs.unity3d.com/Manual/VersionControl.html) systems like Git are among the first things that come to mind when coordinating hundreds of changes from dozens of developers every day. David advocates these tried-and-true methodologies for all our projects at Mega Cat:

-   **Small, atomic changes**: Avoid “mega commits” that touch many systems at once. Isolate work on individual feature branches until they are stable and reviewed. Keep individual changes in individual commits for a well-documented version history that also makes cherry picking and other git magic easier when needed.
-   **Daily merges from main**: Keep feature, department, and long-lived branches up to date with the main branch as this can reduce the size and complexity of final merges, helping to prevent large-scale conflicts.
-   **Review merge requests**: This is the first line of quality assurance, where you catch bugs, enforce project standards, and ensure cohesion with the overall system.

“In large Unity projects, code reviews are not just a formality,” David advises. “They are a key part of conflict prevention and overall project quality.”

Just make sure those reviewing code have expertise in the area being implemented and are aware of coding best practices, so they can accurately assess correctness and maintainability.

There are specific tips and tricks to make version control as smooth as possible in Unity. Scenes and prefabs make up the bedrock of your project, so optimize them not only for CPU performance but also for developer collaboration.

We always prefer smaller, additive, and nested components over a big scene or monolithic prefab. This way, developers can work in parallel without conflicts.

This is important, since merge conflicts in scenes and prefabs are the hardest to resolve because their data is not easily readable by developers. To smoothen out this process, we serialize these files as text, not binary, and enable the auto-merge feature of our Git config for YAML files. This makes Git more likely to solve merge conflicts itself and safeguards developer time for the important work of making new features.

But despite all of that:

“Preventing the conflicts is usually a better strategy than trying to solve them,” Nico says.

Clear asset ownership can go a long way for this.

“Define who can modify specific scenes or prefabs,” David says. “Then team members request changes outside their ownership instead of editing assets directly.”

Nico describes a similar procedure as a “semaphore system.” This is basically a spreadsheet where developers log when they are changing an asset, effectively “locking” it. If another developer needs to make changes to that file, they need to wait until the developer who locked the file pushes their change to the repo and “unlocks” it.

As always, find what procedure works best for your team.

## Building for the Future

The iconic Pablo Sanchez and Mr. Clanky are here, ready to play ball.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

At Mega Cat Studios, we’ve learned that scaling a Unity project is less about "coding harder" and more about architectural discipline. By respecting Unity’s component-based nature, enforcing boundaries with Assembly Definitions, and organizing assets with future-proofing in mind, we keep much of the creative flow of the prototype phase without collapsing the project into technical debt before launch.

While these lessons are important, remember that no codebase is perfect. Software development is an epic battle where recommended programming patterns and practical considerations clash on a daily basis. If following one of these principles stalls development without netting a beneficial tradeoff, it’s a sign you need to be more sensitive to the specifics of your own team and not textbook recommendations. After all, every project, team, and person is different.

We try to strike that balance every day at Mega Cat Studios. With every new project, as our game library continues to grow, we hope to become better Unity developers and better collaborators.

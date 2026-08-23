---
title: "Unity Learn: Clone a Unity project from GitHub"
page_title: "Clone a Unity project from GitHub"
source_url: "https://learn.unity.com/course/collaborate-with-github-desktop/tutorial/clone-a-unity-project-from-github"
final_url: "https://learn.unity.com/course/collaborate-with-github-desktop/tutorial/clone-a-unity-project-from-github"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Clone a Unity project from GitHub

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# Clone a Unity project from GitHub

Tutorial

Beginner

+0XP

4m

0

\(59\)

Unity Technologies

![Clone a Unity project from GitHub](https://storage.googleapis.com/learn-platform-bucket-production/tutorial/8ddae9c9-7685-4825-89e1-714b0a05f5f9/thumbnail/5_20251210_181849.png)

Summary

In this tutorial, you'll clone an existing GitHub repository to create a local copy of a Unity project so you can contribute and collaborate smoothly with your team.

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In many collaborative scenarios, your team will already have an established project hosted on GitHub. Rather than initializing a new repository, your first step as a new contributor or team member will be to clone this existing repository. **Cloning** a repository downloads a complete copy of the remote project, including its entire version history, to your local machine. This allows you to immediately access all the files and begin contributing to the shared Unity build.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Clone a repository

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Beyond collaborating with colleagues, cloning existing repositories is a powerful way to accelerate your learning and expand your skillset. As you become more advanced, exploring sample projects, demo builds, and other open-source Unity creations on GitHub will be a vital part of your workflow. This allows you to study best practices, deconstruct complex feature implementations, and discover new techniques directly from working codebases.

In this step, you'll select an existing Unity project from GitHub and clone it to your local machine, creating a personal copy for exploration.

**1. Select a repository to clone**

-   Find a repository you’d like to clone from GitHub. This could be a classmate’s or colleague’s project or a public example. Alternatively, choose from one of the sample Unity projects provided below:
    -   <a href="https://github.com/Unity-Technologies/com.unity.multiplayer.samples.coop" class="link-primary text-inherit inline-flex items-center gap-1">BossRoom project</a> - A small-scale cooperative game sample built on the new Unity networking framework to teach developers about creating a similar multiplayer game.
    -   <a href="https://github.com/oculus-samples/Unity-NorthStar" class="link-primary text-inherit inline-flex items-center gap-1">North Star</a> - North Star is a VR showcase for Unity, demonstrating cutting-edge graphics and immersive gameplay on Meta Quest devices.
    -   <a href="https://github.com/GMGStudio/CatchEveryFruit" class="link-primary text-inherit inline-flex items-center gap-1">CatchEveryFruit</a> - Sample game with video series.
    -   Any of <a href="https://github.com/UnityCommunity/AwesomeUnityCommunity?tab=readme-ov-file#games" class="link-primary text-inherit inline-flex items-center gap-1">these cool projects</a>.
-   Once you’ve chosen a repository, copy its URL for the next step.

**2. Clone the repository using GitHub Desktop**

-   Open GitHub Desktop.
-   In the top menu, select **File** > **Clone Repository...**.
-   In the dialog window, go to the **URL** tab.
-   Paste the repository URL you copied earlier into the **URL** box.
-   Select or create an empty local folder where you want the project to be saved.
-   Select **Clone** and wait for the files to download.

The repository is successfully cloned to your local computer, creating a complete copy of the remote project.

  
  

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Open the cloned project in Unity

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Unity doesn’t automatically detect cloned projects, so you'll need to manually add them to the Unity Hub.  

**Instructions**

**1. Add the project to Unity Hub**

-   Open the Unity Hub.
-   Select **Add** > **Add project from disk**.
-   Navigate to the folder where you cloned the repository.
-   Open the folder with the same name as the repository – this is the actual Unity project containing the Assets/, Packages/, and ProjectSettings/ folders.
-   Select your folder to add it to Unity Hub.

**2. Open the project in Unity Editor**

-   Once added, select the project in the **Unity Hub** to open it.

**Note:** To create branches in a GitHub repository and push changes, you typically need to be added as a **collaborator**. If this were a real project and you had the appropriate access, you would be able to create your own branches, make changes, and merge them back into the main project. Without those permissions, your access is limited; you can still clone the project and explore it locally, but you won’t be able to push changes or create new branches on the remote repository.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. Next steps

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Congratulations, you’ve completed the **Collaborating on a Project with GitHub** course! Throughout these tutorials, you’ve gained essential skills for professional game development. You learned how to do the following:

-   Install and configure GitHub Desktop for managing version control.
-   Connect your **Unity** projects to Git, understanding how to track changes and keep your repository clean with **.gitignore** files.
-   Perform fundamental Git operations like committing and pushing your work to GitHub.
-   Set up Git LFS for handling large Unity assets.
-   Navigate collaborative workflows by creating and merging branches, and critically, by resolving merge conflicts.
-   Clone existing repositories, a key skill for joining and contributing to established team projects.

As you continue your journey, keep practicing these version control techniques. Consider exploring more advanced Git features like <a href="https://docs.github.com/en/pull-requests" class="link-primary text-inherit inline-flex items-center gap-1">pull requests</a> and <a href="https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository" class="link-primary text-inherit inline-flex items-center gap-1">deeper branching</a> strategies. This foundation will empower you to work effectively with others and protect your valuable development work.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete

---
title: "Unity Learn: Create branches and resolve merge conflicts"
page_title: "Create branches and resolve merge conflicts"
source_url: "https://learn.unity.com/course/collaborate-with-github-desktop/tutorial/create-branches-and-resolve-merge-conflicts"
final_url: "https://learn.unity.com/course/collaborate-with-github-desktop/tutorial/create-branches-and-resolve-merge-conflicts"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create branches and resolve merge conflicts

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# Create branches and resolve merge conflicts

Tutorial

Beginner

+0XP

7m

2

\(34\)

Unity Technologies

![Create branches and resolve merge conflicts](https://storage.googleapis.com/learn-platform-bucket-production/tutorial/0c550acb-3701-436b-a533-c5d8f4cb855d/thumbnail/4_20251210_175001.png)

Summary

In this tutorial, you'll learn how to effectively manage your project's development using Git branches. You'll create a dedicated branch for a new feature, make isolated changes, simulate a common merge conflict scenario, and then walk through the process of resolving that conflict using GitHub Desktop.

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In collaborative game development, your project will grow and evolve over time, one commit at a time. It’s important to keep your changes organized and separated from the main project. This is done by creating branches. A **branch** is a collection of commits that represents a parallel or alternate timeline of your project's development. A feature branch, for example, allows you to develop a new feature without affecting the stable main branch.

However, when multiple team members work on different branches and modify the same parts of a file, merge conflicts can occur. A **merge** **conflict** happens when Git cannot automatically combine changes from two branches because it doesn't know which version of the conflicting lines to keep.

In this tutorial, you'll do the following:

-   Create a new feature branch to work on a specific part of the project.
-   Make and commit changes on your isolated branch.
-   Simulate a scenario where another team member makes conflicting changes on the main branch.
-   Attempt to merge your feature branch into main, trigger a merge conflict, and learn how to resolve it using GitHub Desktop.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Create a feature branch

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

A **feature branch** isolates your changes, allowing you to work on new features or bug fixes without disrupting the main project. Clear branch names help your team understand what each branch is for. In this step, you'll create a new branch dedicated to developing boss fight functionality.

**Instructions**

**1. Create a new branch**

-   In Github Desktop, go to **Branch** > **New Branch...** in the top menu, or open the **Current branch** dropdown and select **New Branch**.

**2. Name your branch**

-   Name your branch “feature/bossfight-function”.

**Note:** Best practice for naming branches is to use lowercase and describe the branch purpose clearly. You can also use prefixes like feature/, bugfix/, or hotfix/ when needed.

**3. Create the branch**

-   Select **Create Branch**.
-   GitHub Desktop automatically switches you to the new branch.

Your feature branch for the boss fight system has been created, providing an isolated workspace for your new functionality.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Make and commit changes on your branch

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Now that you’re on your feature branch, you'll make specific changes related to the boss fight functionality. This simulates you working independently on a new feature, making changes to GameObjects and scripts that will later be integrated into the main project. These changes will introduce the first part of a potential merge conflict.

**Instructions**

**1. Open Unity and make changes to the Boss GameObject**

-   Open the Unity project. If prompted, select **Reload** to ensure you’re viewing the current state of your feature/bossfight-functions branch.
-   In the **Hierarchy** window, select the **BossCharacter** GameObject.
-   In the **Inspector** window, open the **Tag** property dropdown and select **Boss**.
-   Drag the **Yellow** material from **Assets** > **Materials** folder onto the **BossCharacter** GameObject to apply it.
-   Save the scene.

**2. Test the changes**

-   Press the **Play** button to test the scene. Now that the **BossCharacter** GameObject has the tag that the script expects, shooting it with projectiles should damage and destroy it after four hits.

**3. Commit your changes to the feature branch**

-   Open GitHub Desktop. The **Changes** tab will show your updated scene.
-   In the **Summary** box, enter “ Update Boss tag to Boss and apply yellow material”.
-   Select **Commit to feature/bossfight-functions**.

**4. Push your changes to GitHub**

-   Select **Publish branch** to upload your changes to GitHub.com.

Your feature/bossfight-functions branch now contains unique committed changes related to the boss fight, which are isolated from the main branch.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. Simulate conflicting changes on the main branch

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

To understand merge conflicts, you need to simulate a scenario where another team member has made different changes to the same part of the project on the main branch. This step represents a common situation where parallel development leads to conflicting edits.  

**Instructions**

**1. Switch to the main branch**

-   In GitHub Desktop, switch to the **main** branch by opening the **Current Branch** dropdown and selecting main.

**2. Open Unity and make conflicting changes**

-   Open the Unity project. When prompted, select **Reload** to update to the main branch version.

**Note:** You'll observe that the **BossCharacter** material is red again. This is because you’re now working in the main branch, where your previous changes from the feature/bossfight-functions branch have not been applied.

-   In the **Hierarchy** window, select the **BossCharacter** GameObject.
-   In the **Inspector** window, open the **Tag** property dropdown and select **Enemy**.
-   Drag the **Orange** material from the **Assets** > **Materials** folder onto the **BossCharacter** GameObject.
-   Save the scene.

**3. Commit the conflicting changes to the main branch**

-   Return to GitHub Desktop. The **Changes** tab will show your updated scene.
-   In the **Summary** box, enter “Change Boss tag to Enemy and update material on main”.
-   Select **Commit to main**.

**4. Push the changes to GitHub**

-   Select **Push origin** to upload the updated main branch to GitHub.com.

The main branch now contains a committed change to the **BossCharacter** tag and material that directly conflicts with the changes you made on your feature/bossfight-functions branch.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. Trigger and resolve the merge conflict

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Now that both your feature/bossfight-functions branch and the main branch have conflicting changes to the same GameObject, Git will detect this when you attempt to merge them. You'll now initiate the merge and resolve the conflict.

**Instructions**

**1. Start the merge process**

-   In GitHub Desktop, ensure you’re on the main branch.
-   Go to **Branch** > **Merge into current branch**.
-   In the **Merge a branch into the current branch** dialog, select your feature/bossfight-functions branch from the dropdown.

**2. Handle the merge conflict warning**

-   A warning will appear, indicating that this merge will create a conflict. Select **Create a merge commit**.
-   A new dialog will prompt you to resolve the conflict. The conflicting file (your scene file) will be listed.

**3. Resolve the conflict**

-   Next to the conflicting file, open the dropdown menu and select **Use modified file from feature/bossfight-functions**. This means you’re deciding to keep the changes you made on your feature branch (Boss tag, yellow material) over the changes made on the main branch (Enemy tag, orange material).

**Important:** Before resolving real-world merge conflicts, always discuss the change with your team. Agree on which version should be kept, or how to combine the changes, to ensure no valuable work is lost.

**4. Complete the merge**

-   Select **Continue merge**.
-   GitHub Desktop will then present a commit message for the merge. You can modify it if needed, then select **Commit merge** (for example, Merge branch 'feature/bossfight-functions' into main).
-   Select **Push origin** to upload the merged changes to GitHub.com.

The conflict is now resolved, and your main branch reflects the chosen changes from your feature branch.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. Next steps

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In this tutorial, you learned the critical skills of creating isolated branches for feature development, including making and committing changes within those branches. Most importantly, you gained practical experience in triggering and resolving merge conflicts, a common and essential task in collaborative development.

In the next tutorial, you’ll **clone** a repository, creating a local copy of an existing online repo.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete

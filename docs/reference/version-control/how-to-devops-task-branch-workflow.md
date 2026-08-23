---
title: "Unity DevOps: How to set up a task branching workflow"
page_title: "How to set up a task branching workflow"
source_url: "https://unity.com/how-to/devops-task-branch-workflow"
final_url: "https://unity.com/how-to/devops-task-branch-workflow"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# How to implement a task branch workflow

Always be ready to deploy. A task branch workflow uses DevOps principles to help teams achieve speed through a continuous flow of high-quality changes.

<a href="https://resources.unity.com/games/version-control-project-organization-best-practices-ebook" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Find more best practices<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a><a href="https://unity.com/features/version-control" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-gray-50 text-mango-black btn-secondary-shadow-default data-[hovered]:bg-mango-gray-100 data-[pressed]:bg-mango-gray-200 data-[pressed]:btn-secondary-shadow-pressed dark:bg-mango-gray-800 dark:text-mango-white dark:btn-secondary-shadow-default-dark dark:data-[hovered]:bg-mango-gray-900 dark:data-[pressed]:bg-mango-gray-950 dark:data-[pressed]:btn-secondary-shadow-pressed-dark h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Explore solutions<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

<a href="https://unity.com/how-to/devops-task-branch-workflow#overview" class="mango-text-heading-5xs px-6 py-3 rounded-full whitespace-nowrap text-mango-white hover:text-mango-black hover:bg-mango-gray-200 dark:hover:bg-mango-gray-700 transition-colors">Overview</a><a href="https://unity.com/how-to/devops-task-branch-workflow#benefits" class="mango-text-heading-5xs px-6 py-3 rounded-full whitespace-nowrap text-mango-white hover:text-mango-black hover:bg-mango-gray-200 dark:hover:bg-mango-gray-700 transition-colors">Benefits</a><a href="https://unity.com/how-to/devops-task-branch-workflow#key-steps" class="mango-text-heading-5xs px-6 py-3 rounded-full whitespace-nowrap text-mango-white hover:text-mango-black hover:bg-mango-gray-200 dark:hover:bg-mango-gray-700 transition-colors">Key steps</a><a href="https://unity.com/how-to/devops-task-branch-workflow#best-practices" class="mango-text-heading-5xs px-6 py-3 rounded-full whitespace-nowrap text-mango-white hover:text-mango-black hover:bg-mango-gray-200 dark:hover:bg-mango-gray-700 transition-colors">Best practices</a><a href="https://unity.com/how-to/devops-task-branch-workflow#faq" class="mango-text-heading-5xs px-6 py-3 rounded-full whitespace-nowrap text-mango-white hover:text-mango-black hover:bg-mango-gray-200 dark:hover:bg-mango-gray-700 transition-colors">FAQ</a>

<a href="https://unity.com/features/version-control" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.375rem] px-[1.25rem] ml-4"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Explore solutions<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

<span class="mango-text-heading-5xs flex items-center gap-4 text-white"></span>

Overview

<a href="https://unity.com/how-to/devops-task-branch-workflow#overview" class="flex h-8 w-full shrink-0 items-center justify-between px-6 text-left transition-colors hover:bg-white/5"><span class="mango-text-heading-2xs text-white/70">Overview</span><span class="h-2 w-2 rounded-full bg-white"></span></a><a href="https://unity.com/how-to/devops-task-branch-workflow#benefits" class="flex h-8 w-full shrink-0 items-center justify-between px-6 text-left transition-colors hover:bg-white/5"><span class="mango-text-heading-2xs text-white/70">Benefits</span></a><a href="https://unity.com/how-to/devops-task-branch-workflow#key-steps" class="flex h-8 w-full shrink-0 items-center justify-between px-6 text-left transition-colors hover:bg-white/5"><span class="mango-text-heading-2xs text-white/70">Key steps</span></a><a href="https://unity.com/how-to/devops-task-branch-workflow#best-practices" class="flex h-8 w-full shrink-0 items-center justify-between px-6 text-left transition-colors hover:bg-white/5"><span class="mango-text-heading-2xs text-white/70">Best practices</span></a><a href="https://unity.com/how-to/devops-task-branch-workflow#faq" class="flex h-8 w-full shrink-0 items-center justify-between px-6 text-left transition-colors hover:bg-white/5"><span class="mango-text-heading-2xs text-white/70">FAQ</span></a>

<a href="https://unity.com/features/version-control" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem] w-full"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Explore solutions<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## What is a task branch workflow?

The pattern is simple: You create a new branch to work on for each new task in your issue tracker. Task branches are best suited to work with Unity Version Control because it can easily handle thousands of branches. This workflow is not required, and ultimately, you must evaluate what workflow is best for your organization.

## Key benefits

Parallel development

A task branch workflow is designed to better facilitate parallel development than traditional approaches, which may only use a single branch. With each task in a separate branch, you’re always ready to release from main.

Content is always under control

Typically, developers are careful about committing changes, which can keep changes outside source control for too long. Task branch workflows allow for frequent checkins, so you can always see the full change history within the system.

Keep the main branch clean

Main branch organization is one of the goals of the branch-per-task method. Carefully controlling everything entering the main branch means there’s no easy way to break the build accidentally, since new bugs are isolated in a task branch.

## Key steps of a task branch workflow

In the DevOps spirit, this workflow can shorten task cycle times and get new content into production as soon as possible. Root software deployments in your daily routine.

Task and task branch

Develop

Review

Validate

Automate testing and merging

Deploy

## Task and task branch

The process starts with a task in your issue tracker or project management system: Jira, Bugzilla, Mantis, OnTime, or your own in-house solution. The key here is that everything you do must have an associated task. It doesn’t matter whether it’s part of a new feature or a bug fix – create a task for it.

Next, you create a branch for that task.

We recommend a straightforward branch naming convention: A prefix (“task” in the example) followed by the task number in the issue tracker. This helps you keep full traceability of changes.

## Develop

Work on the task branch and make as many checkins as needed. Explain each step in the comments to provide clarity to any reviewer.

When the task is done, set a “status” attribute on the branch as “resolved.”

Alternatively, you can mark it as completed in your issue tracker. It all depends on your particular toolset and how you will actually end up implementing the workflow.

## Review

Once you mark your task as completed, it can be reviewed by a colleague.

Now it’s the reviewer’s turn to look at your changes and see if they can spot bugs, errors, or inconsistencies in your coding style, or any aspects of design that should be changed. If so, the task will be reopened and the cycle restarts.

## Validate

Validation is an optional step.

Some teams will “validate” the task – another team member will do a short exploratory test to make sure the new feature or change makes sense. They don’t look for bugs (automated tests take care of that) but look into the change from a customer perspective. The status can be set to “validated” in the attribute.

## Automate testing and merging

Configure your continuous integration (CI) system to monitor all branches that have a given attribute set. A branch will only be considered by the CI system when it reaches a given status (in this case, “validated”).

Once the task is reviewed/validated, the task branch is automatically tested before being merged into main.

If the test suite passes the merge, it will be confirmed and submitted to the CI system to build and test. This process helps prevent breaking the build. If it fails, the process will be restarted, and you will have to rebase from main to solve any conflicts.

## Deploy

If tests pass, the merge is checked in and the branch is now ready to be delivered. Notice the status is now set to “merged.”

If the new release is ready to be deployed, the new changeset on main is labeled as such and the software deployed to production.

You can get a new release after every new task passes through this cycle, or you can decide to group a few. When practicing continuous deployment, deploying every task to production is the most logical workflow.

## Best practices

Setting up continuous integration

Branch naming convention best practices

Keep task branches short

Workflow and culture

Keep task branches independent

Check in with reviewers in mind

Finished tasks must be deployable

Feature toggles

Using feature toggles

## Setting up continuous integration

With Unity Version Control, the automated testing and merging step can be configured using the plug-in for your chosen CI tool, such as Jenkins, Bamboo or [Unity Cloud Build.](https://unity.com/solutions/cloud-build)

This step can also be orchestrated using Unity Version Control’s mergebot feature. The mergebot can merge the branches and trigger a build to make sure it works. Merges are confirmed only if the build is good, avoiding broken builds.

## Branch naming convention best practices

We like to stick to the following naming convention: prefix + task number. For example, branches might be named task1213, task1209, and task1221. The prefix is “task,” and the number represents the actual task number in the associated issue tracker.

The screenshot also shows a description for each branch together with the number since the branch explorer retrieves the number from the issue tracker. You can also see the branch description by selecting “display branch task info.”

## Keep task branches short

Scrum rules state that tasks shouldn’t be longer than 16 hours. This practice keeps project timelines under control.

Task branches must be closed quickly. Ideally, you should have many small tasks that you can close in just a few hours. This structure helps maintain your project rhythm and facilitates continuous deployment. A larger task that spans for a week, for example, grinds the cycle to a halt.

One red flag to keep in mind: Don’t create “machete cut” tasks. If you need to cut a task into smaller pieces, ensure the task still makes sense in isolation and can be deployed independently.

## Workflow and culture

Task branch workflows can only succeed with buy-in across the whole team.

Like any DevOps process, there’s a cultural component to this workflow. Task branches are about openly communicating progress and avoiding silos. Before mandating a workflow or particular way of working with tasks, you need to drive for alignment. Help team members understand the benefits of closing a small piece of a larger task today, rather than struggling with larger tasks for longer.

## Keep task branches independent

Ask yourself (or your teammates): Do you really need the code you just finished in task1213 to start task1209?

Tasks tend to be much more independent than you might think. Yes, they may be on the same topic, but you don’t need to touch exactly the same code. You can simply add something new and trust the merge to do its job.

Suppose that 1213 and 1209 in the example above were bug fixes instead of tasks. You don’t want one to depend on the other. You want them to hit main and be released as quickly as possible. Even if they touch the same code, they are different fixes.

<a href="https://www.plasticscm.com/book/#_techniques_to_keep_branches_independent" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">See advanced techniques<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## Check in with reviewers in mind

Every checkin must help the reviewer follow your train of thought and process to understand how you tackled the task.

Leaving details in the comments of your checkin will help the reviewer, as they won’t need to diff the entire branch. Instead, they’ll diff changeset by changeset. And they’ll be following the prerecorded explanation you made to clarify each stage of the task. They won’t find themselves looking at a bold list of 100+ modified files. Instead, they’ll go step by step.

<a href="https://www.plasticscm.com/book/#_checkin_often_and_keep_reviewers_in_mind" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Explore in more detail<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## Finished tasks must be deployable

Every task branch must be ready to integrate once finished. If a change is fragile or will make the product behave awkwardly, then the task shouldn’t be set as finished.

This is a small price to pay for the benefits of automation. The team must align on the definition of “done,” meaning “ready for production.” In return, you can enjoy peace of mind knowing that moving your task to production is easy, fully automated, and won’t lead to a fire drill at 2:00 am.

## Feature toggles

What are feature toggles? These are critical for continuous deployment. This software development technique allows features to be tested before they’re completed and ready for release.

A feature toggle can hide, enable, or disable the feature during runtime. It allows you to enable a feature only for the dev team, a small number of early adopters, or for everyone. For example, a developer can enable a feature for testing and disable it for other users during development.

## Using feature toggles

Let’s look at an example. You have a big feature split into seven parts that will be converted to tasks and implemented using task branches. How is it possible to deploy Part 4 if nothing else is ready?

Part 4 can be merged to the main branch and even deployed while still hidden using a feature toggle.

Hidden doesn’t mean the new code skips testing before release. When the entire feature is ready to be activated, the individual parts will already have been tested several times. The integration of the last piece won’t trigger a big-bang merge; it’s just a smaller part going through into main.

## More helpful guides

Best practices for organizing your Unity project

Position your team for effective game development with these useful tips on setting standards for your Unity projects.

<a href="https://unity.com/how-to/organizing-your-project" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Discover how<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

Best practices for version control

Discover best practices to help you make the most of whatever version control system you choose.

<a href="https://unity.com/how-to/version-control-systems" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Explore more<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## Want to learn more?

If you found this helpful, check out another resource on best practices for organizing your projects.

<a href="https://resources.unity.com/games/version-control-project-organization-best-practices-ebook" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[3.125rem] px-[2rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Read our free e-book<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a><a href="https://unity.com/features/version-control" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border border-transparent bg-transparent text-mango-black data-[hovered]:border-mango-black data-[pressed]:border-mango-gray-300 dark:text-mango-white dark:data-[hovered]:border-mango-white dark:data-[pressed]:border-mango-gray-600 h-[3.125rem] px-[2rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Explore solutions<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## Frequently asked questions

### <span class="mango-text-heading-3xs pr-4 text-left">What parts described here are included in Unity Version Control?</span>

Unity Version Control can help you with branching and merging. Branching and merging (even the visualizations in the examples above) are part of the product. Version Control is not a CI system, but it is a coordinator. It can trigger builds, automate merges, perform labeling, and more.

### <span class="mango-text-heading-3xs pr-4 text-left">What CI systems does Plastic integrate with?</span>

Plastic provides an API to integrate with virtually all CI systems on the market. Out of the box, it integrates with [Unity Build Automation](https://unity.com/solutions/ci-cd), Jenkins, Bamboo, and TeamCity.

### <span class="mango-text-heading-3xs pr-4 text-left">Can I plug in my own CI?</span>

Yes, you can plug in your own CI and implement the cycle described above.

### <span class="mango-text-heading-3xs pr-4 text-left">Do I need a CI system and an issue tracker?</span>

If you want to take full advantage of the cycle above and complete automation, you should. But you can always go manually: you can create task branches, work on them, and have someone on the team (integrator/build engineer) perform the merges.

### <span class="mango-text-heading-3xs pr-4 text-left">Are task branches mandatory in Unity Version Control?</span>

No. Unity Version Control is extremely flexible, and you’re free to implement any pattern you want.

We strongly trust task branches because they blend very well with modern patterns like trunk-based development.

For instance, many game teams (artists in particular) prefer working on a single branch, always checking in the main branch, which is fine.

### <span class="mango-text-heading-3xs pr-4 text-left">Do I need a task in Jira for every task?</span>

Submitting a task will be part of some product manager/scrum master/you-name-it most of the time. But even if, as a developer, you have to submit it, every minute saved in describing what to do will save you an immense amount of questions, problems, and misunderstandings.

### <span class="mango-text-heading-3xs pr-4 text-left">What if my new features are too big for one task?</span>

For this workflow, you would need to split them. Some of these may be more of a “story,” or even an “epic” with many associated tasks. By tasks, we mean the actual units of work: the smallest possible pieces of work that are delivered as a unit.

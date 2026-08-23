---
title: "Unity: Best practices for version control systems"
page_title: "Best practices for version control systems"
source_url: "https://unity.com/how-to/version-control-systems"
final_url: "https://unity.com/how-to/version-control-systems"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Best practices for version control

Get tips and best practices to make the most out of any version control solution, as featured in our latest e-book Version control and project organization best practices for game developers.

<a href="https://resources.unity.com/games/version-control-project-organization-best-practices-ebook" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Read the e-book<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

Understanding [version control](https://unity.com/solutions/what-is-version-control) can be daunting for game developers and creators without a technical background. But it doesn’t need to be that way. On this page, you’ll find a few best practices to help you make the most out of whatever version control system (VCS) you choose.

Commit little, commit often

Keep commit messages clean

Avoid indiscriminate commits

Get the latest, first

Plastic SCM workflows

Multisite configurations in Plastic SCM

Know your toolset

Feature branches in Plastic SCM

Git Flow

Plastic SCM task branches

Perforce Helix Core workflows

Pull requests

Stick to your standards

## Commit little, commit often

This is by far the simplest improvement you can make to your workflow, yet it’s the one that some developers struggle with the most. When working with other project management tools, it’s likely that you’ve already broken down the work into small, manageable tasks. Commits should be treated the exact same way.

A single commit should only relate to one task or ticket, unless a single line of code magically fixes several bugs. If you are working on a larger feature, break it down into smaller tasks, and make commits for each.

The greatest advantage of using smaller commits is that, if something does go wrong, you can detect and revert undesirable changes much more easily.

## Keep commit messages clean

Commit messages describe the history of your project. After all, it’s much easier to find the change that added high-score tables to your game if its commit message reads “added high-score tables to the menu” rather than “bet you can’t beat my score on these new tables!”

When working with a task ticketing system like Jira or GitLab, it’s even better to include a ticket number in your commit. Many systems can be set up to work together with smart commits so that you can actually reference tickets and change their status from your commit message.

For example, a commit that reads “JRA-123 #close #comment task completed” would set the Jira ticket JRA-123 to closed, leaving the comment “task completed” on the ticket.

For more on setting up this workflow, see the [documentation in Jira](https://support.atlassian.com/jira-software-cloud/docs/process-issues-with-smart-commits/) or the [Pivotal Tracker service in GitLab.](https://docs.gitlab.com/ee/user/project/integrations/pivotal_tracker.html#pivotal-tracker-service)

## Avoid indiscriminate commits

The only time “commit -a” (the Git command for “commit all changes”) or any of its counterparts should be used is with the first commit of a project. Usually, this is when the only files in the project are README.md.

A commit should only include files that are related to the change you are committing to the repo. You should be particularly careful when working with Unity projects because some changes can result in several files being marked as changed, such as scenes, Prefabs, or Sprite Atlases, even though you didn’t intend to make any changes to them.

If you accidentally commit a change to a scene that someone else is working on, for example, this can cause a headache for them when they go to commit their changes and see that they need to merge your changes first.

This is one of the most common mistakes that people who are new to version control will make. It’s important to understand that you should only commit your own changes to the project. To learn more, check out [this blog post](https://blog.plasticscm.com/2018/10/checkin-with-reviewers-in-mind-how-to-fix-pull-requests.html?utm_source=demand-gen&utm_medium=PDF&utm_campaign=asset-links-gmg-achieve-quality&utm_content=version-control-and-project-organization-ebook) on how to speed up your workflow.

## Get the latest, first

As often as it makes sense, pull the latest changes from the repo into your working copy. It’s not a good idea to work off in isolation, as this only increases the likelihood of merge conflicts. See the table above to get an idea of a typical daily workflow for each system.

## Plastic SCM workflows

Plastic SCM workflows are a little different because you can work in centralized, distributed, or multisite configurations.

MULTISITE PLASTIC SCM CONFIGURATION

## Multisite configurations in Plastic SCM

Multisite configurations can be fairly unique, with each user working in either a centralized or distributed workflow.

Consider the following example:

-   Two teams
-   Each team has an onsite server
-   Team members check in locally or distributed at each site, but benefit from the speed of a close onsite server
-   Servers push and pull between one another to stay fully or partially in sync

GLUON IN PLASTIC SCM

## Know your toolset

Regardless of the [VCS](https://unity.com/solutions/version-control-systems) your team chooses to work with, make sure that everyone is comfortable using it and understands the tools at their disposal.

If you’re working with Git, not everyone needs to use the same GUI client. But make it a priority to see that everyone feels comfortable with the **commit \> pull \> push** workflow. In other words, they should have the knowledge to commit only the files they need.

If you’re working with Plastic SCM, encourage the artists on your team to get used to [Gluon](https://www.plasticscm.com/gluon?utm_source=demand-gen&utm_medium=PDF&utm_campaign=asset-links-gmg-achieve-quality&utm_content=version-control-and-project-organization-ebook), a user-friendly GUI to simplify their workflow. Gluon lets you decide on the files you want to work on, removing the need to download and manage the entire project. It also enables you to lock files, which prevents others from working on them. Once you’re finished, submit the files back to the repository and unlock them again as needed.

## Feature branches in Plastic SCM

When working on a long-standing project with multiple release cycles, feature branching is highly beneficial to your workflow. Often, teams work out of the same branch of a repo, likely called trunk, master,or main.

When you do this, your entire project moves along the same timeline. However, it can be useful to split the work off into several branches to collaborate more effectively as a team.

A GIT FLOW WORKFLOW FACILITATES RELEASE MANAGEMENT

## Git Flow

In Git, a specific workflow called Git Flow focuses on using different branches for features, bug fixes, and releases.

So if a developer starts working on a new feature inside of an isolated branch, it will merge back into the main branch once they’re finished. Meanwhile, another teammate can do a hotfix on the previous release, or fix a bug, and release a new version safely, without including any of the features still under development.

PLASTIC SCM BRANCH PER TASK PATTERN

## Plastic SCM task branches

Plastic SCM also features [task branches](https://www.plasticscm.com/book/#_one_task_one_branch?utm_source=demand-gen&utm_medium=PDF&utm_campaign=asset-links-gmg-achieve-quality&utm_content=version-control-and-project-organization-ebook). For this pattern, you create a new branch for every task that you track. While in Git Flow, we use feature branches to develop complete, sometimes large, features. Task branches in Plastic SCM are meant to be short-lived. If a task takes more than a handful of commits to implement, odds are that it can be broken down into smaller tasks.

## Perforce Helix Core workflows

Perforce Helix Core uses a system called **Streams** to facilitate this style of workflow. When creating a depot to work in, you need to set it up as a **stream depot type**. Then, you can use the **Stream Graph view** to create new streams. Every stream (other than the mainline stream) will need to have a parent stream, so that changes can be copied back upstream.

There are different types of streams for different purposes. When you switch between streams on your local workstation or copy changes back upstream, only the metadata for changed files gets merged, making the context change quicker.

PLASTIC SCM CODE REVIEWS ARE INCLUDED IN THE GUI

## Pull requests

Once you’ve completed work on a feature branch, it’s good practice to use pull requests to get your changes back into the main stream of the repo. Pull requests are created by the developers of the feature or task. It’s usually the responsibility of a senior developer or DevOps to review the changes before accepting them into the mainline.

Plastic SCM and Perforce both have automated tools to help manage merging branches back into the mainline. Plastic SCM does this with the help of [Mergebot](https://www.plasticscm.com/mergebot-devops?utm_source=demand-gen&utm_medium=PDF&utm_campaign=asset-links-gmg-achieve-quality&utm_content=version-control-and-project-organization-ebook), which automatically merges branches of a repo once they’ve been reviewed and have passed validation. Perforce has an additional platform, [Helix Swarm](https://www.perforce.com/products/helix-swarm), used for managing code reviews that can also be set up with automated testing.

## Stick to your standards

Even if you’re working on a solo project, the principles of organization and version control can be really useful.

When working with a team, it’s crucial to prioritize clear communication. As a group, you need to agree on your guidelines: how you should structure your project, which version control system to use, and what your workflow in that system should look like.

This way, when you start integrating other tools like Jira, GitLab, build tools, or automated testing, the work you’ve already done structuring your project and workflow will come into its own.

## Want to learn more?

If you found this helpful, check out another [resource on best practices](https://unity.com/how-to/organizing-your-project) for organizing your projects or our [free e-book](https://resources.unity.com/games/version-control-project-organization-best-practices-ebook) on version control.

<a href="https://resources.unity.com/games/version-control-project-organization-best-practices-ebook" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[3.125rem] px-[2rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Read the e-book<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a><a href="https://unity.com/how-to/organizing-your-project" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border border-transparent bg-transparent text-mango-black data-[hovered]:border-mango-black data-[pressed]:border-mango-gray-300 dark:text-mango-white dark:data-[hovered]:border-mango-white dark:data-[pressed]:border-mango-gray-600 h-[3.125rem] px-[2rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Learn more<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

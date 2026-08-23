---
title: "Introducing new Prefab workflows"
page_title: "Introducing new Prefab workflows"
source_url: "https://unity.com/blog/technology/introducing-new-prefab-workflows"
final_url: "https://unity.com/blog/technology/introducing-new-prefab-workflows"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introducing new Prefab workflows

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">MADS NYHOLM / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Staff Software Engineer</span>

<span class="mr-2">Jun 20, 2018</span><span class="mr-2">\|</span><span class="mr-2">6 Min</span>

Programming and DevOps

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

One of the top requested additions to Unity is the ability to nest Prefabs. But we know a lot of you need many more changes to the Prefab workflows than that. Therefore, we’re improving the whole system with focus on reusability, control & safety. This is the first in a series of blog posts explaining the upcoming changes. If you haven’t done so already during yesterday’s [Unite Berlin keynote](https://blog.unity.com/community/connected-games-facial-mocap-new-prefabs-workflow-preview-and-more-unite-berlin), get the [preview Unity build with the new Prefab system here](https://unity3d.com/prefabs).

Let’s start by recapping the basics of what Prefabs are in Unity. Fundamentally, a Prefab Asset is like a template of a GameObject and its children. You can use instances of a Prefab Asset to create many copies of a GameObject throughout your Scenes. If the Prefab Asset is changed, all the Prefab instances are automatically updated accordingly.

We talked to a wide range of indie and AAA studios to dig deep into how you all work with Prefabs at the moment. An issue we found was that when you wanted to edit a Prefab Asset, you had to drag it to an open Scene in the Hierarchy to modify it, apply the changes and then remember to delete it again. Another big issue was the Apply button for Prefab instances in the Inspector. With this button, you could accidentally apply changes to the Prefab Asset that you had no good way of getting an overview of.

To address these issues we have introduced a range of new features. We have implemented a backwards compatible Prefab backend that now supports nesting and inheritance. We have improved the visualization of property and object overrides for Prefab instances, and added the ability to apply overrides on multiple levels of granularity: per property, per Component/GameObject, or, as before, the entire Prefab instance. Lastly, we have added Prefab Mode to be able to edit a Prefab Asset in isolation.

Prefab Mode

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Prefab Mode represents a fundamental change when working with Prefabs. It lets you decide whether you want to make changes to a Prefab instance or make changes directly to a Prefab Asset.

Prefab Mode gives you a more controlled Prefab Asset editing session because you can perform all changes to the Prefab Asset, including structural changes, without receiving dialogs asking you to break the connection to the Prefab. With Prefab Mode, you no longer need to make temporary changes to a Prefab instance with the sole purpose of applying these changes to the Asset later (with the possible side effect of applying other previous overrides that were meant to be kept as overrides). So we recommend you use Prefab Mode for Prefab Asset changes, and only make overrides on Prefab instances when needed. Note that we have also improved the Apply workflow tremendously. More information on this workflow in an upcoming blog post!

Prefab Mode takes over the Hierarchy and Scene View to show the Prefab Asset in isolation. You can recognize this mode by the new headers in the Hierarchy and Scene View. Also note that the Prefab Mode background color can be customized in the Preferences.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

You can enter Prefab Mode by doing one of the following:

-   Double-clicking the Prefab in the Project window.
-   Clicking the new arrow button in the Hierarchy window next to the root GameObject of the Prefab instance.
-   Clicking the Open button in the Inspector for the root GameObject of the Prefab Asset or Prefab instance.

Working with Prefab Assets

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

To enable Prefab nesting, we had to make technical changes to the Prefab backend. So, technically, Prefabs are now imported Assets. This means you can no longer edit Prefab GameObjects in the Project window. Compared to the old workflow of editing directly in the Project window, Prefab Mode lets you edit objects at any depth, and see what you’re doing in the Scene view too.

Working with Prefab instances

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Another consequence of providing Prefab nesting is that you can no longer disconnect a Prefab instance to make structural changes to that instance. This includes deleting GameObjects, reparenting GameObjects, or replacing a Transform with a RectTransform and vice versa. You can now do all of this in Prefab Mode. Alternatively, you can now unpack a Prefab instance if you want to entirely remove its link to its Prefab Asset and thus restructure the resulting plain GameObjects as you please.

Prefab Stage

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We have introduced the term ‘stage’ in the Editor as a concept for a set of GameObjects isolated from other GameObjects. When you are in Prefab Mode, the breadcrumbs at the top of the Scene view each represent a different stage. Each stage is like a separate ‘world’. By default, we have the Main Stage, which is the stage where all your Scenes are (the Scenes you have loaded and can see in the Hierarchy). When opening a Prefab in Prefab Mode, we create a Prefab Stage for the contents of the Prefab. We do not unload the Main Stage GameObjects when a Prefab Stage is opened, and this means you can still see them in the Game view.

The Scene view and Hierarchy always show the current stage, which is the one corresponding to the rightmost breadcrumb. To go back to the Main Stage with your Scenes, either click the ‘Scenes’ button in the breadcrumbs of the Scene view or the Back arrow button in the Hierarchy.

To see the new workflows in action check out the video below:

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

To try the new Prefab features, download the preview build from [our Prefab page](https://unity3d.com/prefabs). Also check out [our dedicated forum for Improved Prefabs](https://forum.unity.com/forums/improved-prefabs.158/) for more information, questions and feedback.

Stay tuned for upcoming blog posts with more in depth information about other parts of the improved Prefab workflows.

Improved Prefabs at Unite Berlin: Live Today

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

If you want to see the improved prefab workflows in action, we highly recommend tuning into the live stream from Unite Berlin today on YouTube or Twitch. Starting from 5pm Berlin time, you can catch [Improved Prefab Workflow](https://www.youtube.com/watch?v=BW9qSy6ZB0A) with Ciro Continisio. After that, Rune Skovbo Johansen and Steen Lund will help you better understand the pros and cons of our implementation decisions in their [Technical Deep Dive into the New Prefab System](https://www.youtube.com/watch?v=BW9qSy6ZB0A) (6pm). We’ll work on editing the talks later and upload them to our YouTube channel within a month after the conference.

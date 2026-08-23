---
title: "Optimize your game with the Unity Profile Analyzer"
page_title: "Optimize your game with the Unity Profile Analyzer"
source_url: "https://unity.com/how-to/optimize-your-game-unity-profile-analyzer"
final_url: "https://unity.com/how-to/optimize-your-game-unity-profile-analyzer"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# How to optimize your game with the Profile Analyzer

This page provides an in-depth introduction to adding the Profile Analyzer to your arsenal of Unity and native platform profiling tools.

The Profile Analyzer is one of the many features covered in the e-book [*Ultimate guide to profiling Unity games (Unity 6 edition)*](https://unity.com/resources/ultimate-guide-to-profiling-unity-games-unity-6). This guide brings together advanced knowledge and advice from external and in-house Unity experts on how to profile an application in Unity, manage its memory, and optimize its power consumption from start to finish.

<span class="absolute inset-0 flex items-center justify-center"><span class="dark:bg-mango-black/90 flex h-14 w-14 items-center justify-center rounded-full bg-white/90 text-black shadow-md transition-transform group-hover:scale-110 group-focus-visible:scale-110 dark:text-white"></span></span>

## Profile Analyzer walkthrough

Do you want to know where to improve performance? Do you need to compare performance before and after a change? Are you aware of the impact that a Unity version update has on your game? The Profile Analyzer will help you answer these sorts of questions. While the standard Unity Profiler allows you to do single-frame analysis, the Profile Analyzer can aggregate and visualize profiling marker data captured from a set of Unity Profiler frames.

Overview

Get started

Profile Analyzer views

The Marker Summary pane

The Single view

The Compare view

Compare performance changes

Profile Analyzer quick tips

## Overview of the Profile Analyzer

While the standard Unity Profiler enables detailed analysis of individual frames, the [Profile Analyzer](https://docs.unity3d.com/Packages/com.unity.performance.profile-analyzer@1.2/manual/index.html) aggregates and visualizes marker data captured from multiple Unity Profiler frames, providing a broader, “'big picture” overview. This makes it easy to compare and analyze performance data across multiple frames or across different profiling sessions.

To get started with the Profile Analyzer:  
  
1. Install the Profile Analyze Package via **Window \> Package Management \> Package Manager**.  
  
2. Go to the Unity Registry and browse or use the search filter to find the Profile Analyzer package.

The Profile Analyzer pulls a set of frames captured in the Unity Profiler and performs statistical analysis on them. The data it displays provides useful performance timing information for each function, such as Min, Max, Mean, and Median timings.

As the Profile Analyzer is great for performing comparisons of data sets, consider using it throughout your game development to get clarity on performance and optimization challenges. You can also use it to A/B test a game scenario for performance differences, compare before and after profiling data for code refactoring and optimization, new features, or even Unity version upgrades.One useful tip is to save profiling sessions to compare before and after performance optimization work when using the Profile Analyzer.

The Profile Analyzer helps you identify where to focus your efforts. It provides you with a way to compare two Unity performance profiling captures side by side, and inspect the impacts of your changes.

The Profile Analyzer complements the single frame analysis already available in the Unity Profiler. It aggregates and visualizes frame and marker data from a range of Unity Profiler frames to help you see high-level, performance-over-time patterns over many frames.

Profile Analyzer conducts CPU performance analysis on multiple frames from the current Profiler session frames or from previously saved captures. The tool comes with statistics and visualizations to help you parse information stored in captures quickly. Its **Comprehensive Filtering** feature also lets you drill down into the sections that you’re interested in. You can use it to compare two data sets, or you can export raw data for analysis with other tools.

You can install the Profile Analyzer via **Window \> Package Manager**.

Install the Profile Analyzer from the Package Manager.

## Get started

To start, you first need to capture data using the Profiler and then [populate](https://docs.unity3d.com/Packages/com.unity.performance.profile-analyzer@1.2/manual/collecting-and-viewing-data.html) the Profile Analyzer with that data to perform an analysis.

Using aggregated data gives you a more informed way of looking at what’s going on in your game, rather than viewing only one frame at a time. For example, in a 300-frame (10-second) gameplay capture or a 20-second loading sequence you might need to know:

\- What are the biggest CPU costs on the main and render threads?

\- What is the mean/median/total cost of each of those markers?

Answering these essential questions can help you locate the biggest problems and prioritize their optimizations.

The statistics and detail available with Profile Analyzer allow you to delve deeper into the performance characteristics of your code when running across multiple frames, or even compared with previous profile capture sessions.

A great companion to the Unity Profiler, the Profile Analyzer aggregates and compares multiple frames captured in profiling sessions. This is a screenshot of the Single view.

## Profile Analyzer views

Notice the **Mode** selection in the top of the window. The Profile Analyzer has multiple views and approaches for analyzing profiling data. Use the different views to select, sort, view, and compare sets of profiling data.

You can select between different modes in the top of the panel.

## The Marker Summary pane

Use the [Frame Control panel](https://docs.unity3d.com/Packages/com.unity.performance.profile-analyzer@1.2/manual/frame-range-selection.html) to select one, or a range, of frames. When selected, the [Marker Details](https://docs.unity3d.com/Packages/com.unity.performance.profile-analyzer@1.2/manual/single-view.html#marker-details-list) pane updates to show aggregated data for the selection with a sortable list of markers containing useful statistics.

The [Marker Summary pane](https://docs.unity3d.com/Packages/com.unity.performance.profile-analyzer@1.2/manual/marker-summary.html) displays in-depth information on selected markers. Each marker in the list is an aggregation of all the instances of that marker, across all filtered threads in the range of selected frames.

The Marker Summary panel contains detailed information about each marker aggregation selected in the Marker Details panel.

## The Single view

The [Single](https://docs.unity3d.com/Packages/com.unity.performance.profile-analyzer@1.2/manual/single-view.html) [view](https://docs.unity3d.com/Packages/com.unity.performance.profile-analyzer@1.2/manual/single-view.html) is the default starting point of the Profile Analyzer, providing answers to high-level performance-over-time questions up front. The Single view displays information about a single set of captured profile data. Use it to analyze how profile markers perform across frames. This view is divided into several panels, which contain information on timings, as well as min, max, median, mean, and lower/upper quartile values for frames, threads, and markers.

The Single view shows profile marker statistics and timings for a single or range of frames.

## The Compare view

The [Compare view](https://docs.unity3d.com/Packages/com.unity.performance.profile-analyzer@1.2/manual/compare-view.html) is particularly effective for analyzing performance variations, as it allows you to load two distinct data sets which are then displayed in different colors for clear, side-by-side comparison.

Data set marker timings can be easily compared in the Compare view using the Marker Comparison pane and its color coding.

## Compare performance changes

Use the following steps to compare performance changes using the Profile Analyzer. You can either use the **Pull Data** option from an active Unity Profiler capture or the **Load Data** option from a saved session. When loading, files must be in the Profile Analyzer's .pdata format. For Unity Profiler .data files, open them first in the Profiler window, then use Pull Data in the Profile Analyzer. It's also recommended to save your original .data files from the Profiler.

1\. **Prepare a test:** Choose a consistent section of your game to profile for a meaningful benchmark comparison. A scripted or repeatable manual playthrough works best so you minimize random side effects that impact performance.

2\. **Capture "before" data:  
**- Open Profile Analyzer (**Window \> Analysis \> Profile Analyzer**).  
- In the Unity Profiler, record a profiling session of your chosen gameplay before making any optimizations.  
- In the Analyzer's **Compare** tab, click the first **Pull Data** button. This loads the current capture from the Profiler or, alternatively, you can save the session.

3\. **Optimize and capture "after" data:  
**- Apply your code or performance improvements.  
- Clear the Unity Profiler's previous data, then record a new profiling session of the same gameplay.  
- In Profile Analyzer, click the second Pull Data button to load this new session.

4\. **Analyze differences:  
**- The **Marker Comparison** pane shows how marker timings differ between your "before" (left) and "after" (right) captures.  
- Columns marked with **\<** or **\>** indicate which capture had a larger value for that metric.  
- You can change which metrics are compared using the **Marker Columns** filter.

Refer to the [Compare view entry page](https://docs.unity3d.com/Packages/com.unity.performance.profile-analyzer@1.2/manual/compare-view.html) for more details on each Marker Comparison column.

**Comparing median and longest frames**

Compare the median and longest frames within a single Profiler capture to pinpoint things happening in the latter that do not appear in the former, or to see what is taking longer than average to complete.

Open the Profile Analyzer Compare view and load the same data set for both the left and right sides. You can also load a data set in the Single view, then switch to Compare.

Right-click the top **Frame Control** graph, and choose **Select Median Frame**. Right-click the bottom graph, and choose **Select Longest Frame**.

The Profile Analyzer Marker Comparison panel updates to display the differences.

Another useful trick for comparing data is to sort both graphs by frame duration (**Right-click \> Order By Frame Duration**), then select a range in each set, either focusing on, or excluding, the outlier frames (frames that are disproportionately long or short).

This lets you compare the most typical frames against the most extreme ones. The data is then displayed in the Marker Comparison table for the selected range, making it easier to analyze what contributes to performance spikes or inconsistencies.

Comparing the median and longest frames from a capture

## Profile Analyzer quick tips

\- Drill into user scripts (ignoring Unity Engine API levels) by selecting a **Depth level** of **4**. After filtering to this level and looking at the Unity Profiler in **Timeline mode**, you can correlate the call stack depth to make a selection here – Monobehaviour scripts will appear in blue on the fourth level down. This is a quick way to see if your specific logic and gameplay scripts are taxing by themselves without any other “noise.”

\- Filter data in the same way for other areas of the Unity engine, such as animators or engine physics.

\- On the right side in the **Frame Summary** section, you’ll find the highlighted method’s performance range histogram. Hover over the **Max Frame** number (the exact frame in which max timing was found) to get a clickable link to view the frame selection in the Unity Profiler. Use this view to analyze other factors that potentially contribute to the high maximum frame time.

\- If you have a widescreen or two monitors available it can be useful to open the Profile Analyzer and the Unity Profiler side by side. This setup enables you to double-click a frame in the Profile Analyzer to automatically select the same frame in the Unity Profiler, from where you can further investigate it using the Timeline or Hierarchy views.

**Learn more about the Profiler Analyzer with these resources**:

\- [Profile Analyzer Walkthrough & Tutorial](https://www.youtube.com/watch?v=Ypg84Fr20Sw)

\- [CPU performance analysis with Unity’s Profile Analyzer](https://www.youtube.com/watch?v=0lzqdDdE9Tc)

\- [Introduction to profiling](https://youtu.be/uXRURWwabF4)

## More tips for Unity 6

You can find many more best practices and tips for advanced Unity developers and creators from the Unity best practices hub. Choose from over 30 guides, created by industry experts, and Unity engineers and technical artists, that will help you develop efficiently with Unity’s toolsets and systems.

<a href="https://unity.com/how-to" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[3.125rem] px-[2rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">More best practices<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

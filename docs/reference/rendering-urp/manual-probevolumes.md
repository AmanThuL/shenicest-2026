---
title: "Adaptive Probe Volumes (APV) in URP"
page_title: "Unity - Manual: Adaptive Probe Volumes (APV) in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Adaptive Probe Volumes (APV) in URP

Adaptive Probe Volumes make [Light Probes](https://docs.unity3d.com/Manual/LightProbes.html) easier to use by automating placement. They also provide higher quality, more accurate lighting, because they light per-pixel not per-object.

| Topic                                                                                                                                                           | Description                                                                                                      |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------|
| [Introduction to Adaptive Probe Volumes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-concept.html)                                    | The purpose of Adaptive Probe Volumes and what you can do with them.                                             |
| [Use Adaptive Probe Volumes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-use.html)                                                    | Add Adaptive Probe Volumes to your project and configure them.                                                   |
| [Display Adaptive Probe Volumes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-showandadjust.html)                                      | Visualize the structure of Adaptive Probe Volumes.                                                               |
| [Configure the size and density of Adaptive Probe Volumes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-changedensity.html)            | Change the size of an Adaptive Probe Volume, or increase the density of Light Probes.                            |
| [Bake multiple scenes together with Baking Sets](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-usebakingsets.html)                      | Add scenes to a Baking Set so you can bake the lighting for all the scenes together.                             |
| [Light management with rendering layer masks](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-layer-masks-apv-landing.html)         | Learn how to prevent light leaks across boundaries, even with a low light probe density.                         |
| [Optimize loading Adaptive Probe Volume data](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-streaming.html)                             | Stream lighting data to provide lighting for large open worlds, or load data from AssetBundles or Addressables.  |
| [Changing lighting at runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probe-volumes-change-lighting-at-runtime.html)                          | Use Lighting Scenarios or sky occlusion to change how objects use the data in Adaptive Probe Volumes at runtime. |
| [Troubleshooting Adaptive Probe Volumes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-fixissues.html)                                  | Solve common issues with Adaptive Probe Volumes, such as light leaks and seams.                                  |
| [Adaptive Probe Volume Inspector window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-inspector-reference.html)              | Reference for the Adaptive Probe Volume Inspector window.                                                        |
| [Adaptive Probe Volumes panel reference](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-lighting-panel-reference.html)                   | Reference for the Adaptive Probe Volumes panel in the Lighting settings.                                         |
| [Probe Volumes Options Override reference](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-options-override-reference.html)               | Reference for the Probe Volumes Options Override.                                                                |
| [Probe Adjustment Volume component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-adjustment-volume-component-reference.html) | Reference for the Probe Adjustment Volume component.                                                             |

## Additional resources

-   [Light Probes](https://docs.unity3d.com/Manual/LightProbes.html)
-   [Light Probes for moving objects](https://docs.unity3d.com/Manual/LightProbes-MovingObjects.html)
-   [Light Probe Group](https://docs.unity3d.com/Manual/class-LightProbeGroup.html)
-   [Rendering Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-debugger.html)

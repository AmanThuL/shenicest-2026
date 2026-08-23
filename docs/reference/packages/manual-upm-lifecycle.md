---
title: "Package states and lifecycle"
page_title: "Unity - Manual: Package states and lifecycle"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-lifecycle.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-lifecycle.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Package states and lifecycle

Starting from Unity Editor version 2021.1, a package can travel through the following states during its lifecycle:

![Package lifecycle with Unity Package Manager](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/upm-lifecycle_v2.svg)

The Package Manager window displays a [label](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-details.html#Tags) that corresponds to some of these states.

**Note**: These package states only apply to packages that Unity develops internally. Contact third-party package developers to ask about their specific processes.

<span id="Develop"></span>

## Birth (A)

While the package developer creates the package, it’s in the **Custom** state.

When it’s ready for Unity users to test it and provide feedback, a package enters the [Experimental](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-exp.html) state. Unity doesn’t support experimental packages and doesn’t guarantee that experimental packages will be fully released and verified to be safe to use in production until they enter the release track.

Experimental packages either use `0` as the major part of their version or the `-exp.#` suffix on the patch part of their version. For example, `mypackage@0.1.2` or `mypackage@1.2.3-exp.1`.

## Release track

When a package passes quality testing and contains no experimental features or functionality (including dependencies on experimental packages), it enters the [Pre-release](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-preview.html) state, which is on the release track. Unity fully supports packages on the release track and commits to officially releasing them by the end of the current LTS cycle (for example, 2021.3) at the latest. For a list of pre-release packages available for this version, refer to [Pre-release packages](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-preview.html).

Unity’s release management only grants a package the [Released](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-safe.html) status after it passes several testing stages and validation procedures, which also include checks for appropriate documentation, changelog, and license files. Packages in this state never use non-numeric suffixes as part of their version. For a list of released packages available for this version, refer to [Released packages](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-safe.html).

If the package developer updates or changes a released package, that package might return to another state depending on the severity:

| **Phase** | **Type of change**                                                                                                                                                        | **New state**         | **Version bump**       |
|:----------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------|:-----------------------|
| **(B)**   | Major changes that [break an API](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-semver.html#semver-guidelines).                                                | Experimental          | `1.2.3` => `2.0.0-exp` |
| **(C)**   | Minor changes that [don’t break the API but affect usage](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-semver.html#semver-guidelines).                        | Pre-release           | `1.2.3` => `1.3.0-pre` |
| **(D)**   | Bug fixes, trivial changes, and documentation updates typical of [patch updates](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-semver.html#semver-guidelines). | Released (same state) | `1.2.3` => `1.2.4`     |

## Death (E)

Packages that reach their end of life are no longer supported in Editors where they’re marked **Deprecated**. Avoid using packages in a **Deprecated** state because they might be nonfunctional or unsafe.

For more information, refer to [Deprecated packages](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-deprecated.html).

Some experimental packages go directly to the deprecated state without passing through the release cycle track.

## Additional information

-   [Package versioning](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-semver.html)

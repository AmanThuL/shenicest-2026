---
title: "Enable the correct input system"
page_title: "Enable the correct input system | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/enable-correct-input-system.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/enable-correct-input-system.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Enable the correct input system

When installing the new Input System, Unity prompts you to enable the new input system and disable the old one. You can change this setting at any time later, by going to **Edit \> Project Settings \> Player \> Other Settings \> Active Input Handling**, [as described here](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Installation.html#enable-the-new-input-backends).

There are scripting symbols defined which allow you to use conditional compilation based on which system is enabled, as shown in the example below.

``` lang-CSharp
#if ENABLE_INPUT_SYSTEM
    // New input system backends are enabled.
#endif

#if ENABLE_LEGACY_INPUT_MANAGER
    // Old input backends are enabled.
#endif
```

##### Note

It is possible to have both systems enabled at the same time, in which case both sets of code in the example above above will be active.

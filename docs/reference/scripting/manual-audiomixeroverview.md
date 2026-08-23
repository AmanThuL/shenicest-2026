---
title: "Introduction to the Audio Mixer"
page_title: "Unity - Manual: Introduction to the Audio Mixer"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AudioMixerOverview.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AudioMixerOverview.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to the Audio Mixer

The Audio Mixer is an asset that Audio Sources reference to apply complex routing and mixing to the audio signal they generate. The Audio Mixer performs this category-based mixing through a hierarchy of groups that you construct inside the asset.

You can apply digital signal processing (DSP) effects and other audio mastering to the signal as Unity routes it from the Audio Source to the Audio Listener.

## Audio Mixer view

![The Audio Mixer view, including the Audio Mixer asset (1), Hierarchy view (2), Mixer views (3), Snapshots panel (4), output Audio Mixer (5), Audio group strip view (6), Edit in Play Mode toggle (7), and Exposed Parameters (8).](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AudioMixerView.jpg)

The Audio Mixer window contains the following areas:

1.  Audio Mixer asset: Contains all groups and snapshots as subassets.
2.  **Hierarchy** view: Shows the entire mixing hierarchy of groups within the Audio Mixer.
3.  **Mixer Views**: Lists cached visibility settings for the mixer. Each view shows only a subset of the hierarchy in the main mixer window.
4.  **Snapshots**: Lists all snapshots within the Audio Mixer asset. Snapshots capture the state of every parameter setting in an Audio Mixer, and you can transition between them at runtime.
5.  **Output** Audio Mixer: Routes this Audio Mixer’s signal into a group of another Audio Mixer. Use this property to define the output group.
6.  AudioGroup strip view: Shows an overview of an AudioGroup, including the volume unit (VU) levels, attenuation (volume) settings, **Mute**, **Solo**, and **Effect Bypass** settings, and the list of DSP effects within the group.
7.  **Edit in Play Mode** toggle: Lets you edit the Audio Mixer during Play mode or prevent edits, so the application runtime controls the state of the Audio Mixer.
8.  **Exposed Parameters**: Lists the exposed parameters and their string names. You can expose any parameter within an Audio Mixer to a script through a string name.

## Audio Mixer Inspector window

![The Audio Mixer Inspector window displays a list of configurable Audio Mixer components, including Pitch and Ducking settings (1), Send effect (2), Attenuation effect (3), and Reverb effect (4).](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AudioMixerInspector.png)

The Audio Mixer Inspector displays the configurable components of a group:

1.  **Pitch** and **Ducking** settings: Appear at the top of every group.
2.  **Send**: An example send effect, positioned before the point where Unity applies attenuation.
3.  **Attenuation**: Sets the volume for a group. You can apply attenuation anywhere in the effect stack. The VU meter shows the volume level at that point in the stack, which differs from the VU meters in the Audio Mixer view that show the level of the signal as it leaves the group.
4.  **SFX Reverb**: An example effect with parameters, in this case a reverb. To expose a parameter, right-click it, and select the option.

## Routing and mixing

Audio routing is the process of taking input audio signals and producing one or more output signals. A signal is a continuous stream of digital audio data, which you can break down into digital audio channels, such as stereo or 5.1 (six channels).

You can use the Audio Mixer to perform important audio processing work on these signals. Examples include mixing, applying effects, and attenuation.

With the exception of sends and returns, the Audio Mixer contains groups that accept any number of input signals, mix those signals, and produce exactly one output.

![The relationship between different audio entities. One Audio Mixer receives input signals from two different Audio Sources. A second Audio Mixer receives input signals from the first Audio Mixer and a third Audio Source. An Audio Listener receives input signals from the second Audio Mixer and a fourth Audio Source.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AudioMixerSignalPath.png)

In audio processing, this routing and mixing usually happens independently of the scene graph hierarchy because audio behaves differently from the objects and concepts shown in the scene. You interact with it differently too.

Without an Audio Mixer, the signal that each Audio Source produces (through audio clips, for example) routes directly to the Audio Listener, where Unity mixes all the audio signals at a single point. This mixing happens independently of the scene graph, regardless of where your Audio Sources are in the scene.

An Audio Mixer sits between the Audio Source and the Audio Listener in the audio signal processing chain. It takes the output signal from the Audio Source and performs the routing and mixing operations you want, until Unity outputs all audio to the Audio Listener and plays it through the speakers.

### Benefits of routing and mixing

With mixing and routing, you can categorize the audio in your application into the categories you want. After you mix sound into these categories, you can apply effects and other operations to each category as a whole. This is powerful for applying logic changes to sound categories. You also can tweak aspects of the mix to perform what’s known as mastering of the entire soundscape dynamically at runtime.

### Relationship to 3D spatial attenuation

Some sound concepts relate to the scene graph and the 3D world. The most obvious examples are attenuation based on 3D distance, relative speed to the Audio Listener, and environmental reverb effects.

Because these operations relate to the scene rather than to the categories of sounds in an Audio Mixer, Unity applies the effects at the Audio Source, before the signal enters an Audio Mixer. For example, Unity applies the distance-based attenuation for an Audio Source to the signal before the signal leaves the Audio Source and routes into an Audio Mixer.

## Sound categories

With an Audio Mixer, you can categorize types of sounds and apply operations to those categories. This categorization is important. Without it, every sound plays back equally and without any mixing, and the soundscape becomes difficult to distinguish. With techniques such as ducking (automatically lowering the volume of one category when another plays), categories of sounds can influence each other, which adds richness to the mix.

You might want to perform the following operations on a category:

-   Apply attenuation to a group of ambient sounds.
-   Trigger a low-pass filter on all the foley sounds in your application to simulate being underwater.
-   Attenuate all sounds except the menu music and interaction sounds.
-   Reduce the volume of all the gun and explosion sounds so the user can hear a non-player character (NPC) speaking.

These categories are application-specific and vary between projects. The following is an example of one such categorization:

-   All sounds route into the **Master** group.
-   The Master group contains categories for music, menu sounds, and all application sounds.
-   The application sounds group breaks down into dialogue from NPCs, environmental sounds from ambient sources, and other foley sounds such as gunshots and footsteps.
-   These categories break down further as required.

The following image shows the category hierarchy of this layout:

![The group hierarchy panel displays the configurable hierarchy of groups within an Audio Mixer.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AudioMixerHierarchy.png)

The scene graph layout differs significantly from the layout for sound categories.

## Moods and themes of the mix

You can also use mixing and routing to create the immersion you want. For example, you can apply reverb to all the application sounds and attenuate the music to create the feeling of being in a cave.

You can use the Audio Mixer to create moods in your application. With techniques such as snapshots and multiple mixers, your application can transition its mood and evoke the feelings you want the user to experience, which strengthens immersion.

## The global mix

The Audio Mixer controls the overall mix of all the sounds in your application. An Audio Mixer controls the global mix. It’s the static, persistent mix that sound instances route through.

In other words, an Audio Mixer is always present throughout the lifetime of a scene. Unity creates and destroys sound instances as your application runs, and those instances play through these global Audio Mixers.

## Snapshots

Snapshots capture the state of an Audio Mixer and transition between those states as your application runs. Use snapshots to define moods or themes for the mix and change those moods as the user progresses through your application.

Snapshots capture the values of all the parameters in the Audio Mixer:

-   Volume
-   Pitch
-   Send level
-   Wet mix level
-   Effect parameters

Combine snapshots with application logic to change many aspects of the soundscape.

## Additional resources

-   [Audio Mixer](https://docs.unity3d.com/6000.3/Documentation/Manual/audio-mixer-landing.html)
-   [Overview of Usage and API](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioMixerUsage.html)
-   [AudioMixer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.html)

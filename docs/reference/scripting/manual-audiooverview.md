---
title: "Audio overview"
page_title: "Unity - Manual: Audio overview"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AudioOverview.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AudioOverview.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Audio overview

A game would be incomplete without some kind of audio, be it background music or sound effects. Unity’s audio system can import most standard audio file formats, play sounds in 3D space, and apply optional effects such as echo and filtering. Unity can also record audio from any available microphone on your machine for use during gameplay or for storage and transmission.

## Basic theory

In real life, objects emit sounds that listeners hear. The way a sound is perceived depends on many factors. A listener can tell roughly which direction a sound is coming from and may also get some sense of its distance from its loudness and quality. A fast-moving sound source (such as a falling bomb or a passing police car) changes in pitch as it moves as a result of the Doppler Effect. Surroundings also affect the way sound is reflected. A voice inside a cave has an echo, but the same voice in the open air doesn’t.

![Audio Sources and Listener](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AudioSourceListDiagram.png)

To simulate the effects of position, Unity requires sounds to originate from Audio Sources attached to objects. The sounds emitted are then picked up by an Audio Listener attached to another object, most often the main camera. Unity can then simulate the effects of a source’s distance and position from the listener object and play them to you accordingly. You can also use the relative speed of the source and listener objects to simulate the Doppler Effect for added realism.

Unity can’t calculate echoes purely from scene geometry, but you can simulate them by adding Audio Filters to objects. For example, you could apply the Echo filter to a sound that is supposed to be coming from inside a cave. In situations where objects can move in and out of a place with a strong echo, you can add a Reverb Zone to the scene. For example, your game might involve cars driving through a tunnel. If you place a reverb zone inside the tunnel, the cars’ engine sounds start to echo as they enter. The echo quiets as the cars emerge from the other side.

With the Unity Audio Mixer, you can mix various audio sources, apply effects to them, and perform mastering.

## Working with audio assets

Unity can import audio files in **AIFF**, **WAV**, **MP3**, and **Ogg** formats in the same way as other assets. Drag the files into the Project panel. Import an audio file to create an Audio Clip that you can then drag to an Audio Source or use from a script. The Audio Clip reference page has more details about the import options available for audio files.

For music, Unity also supports tracker modules, which use short audio samples as “instruments” that you can arrange to play tunes. You can import tracker modules from **.xm**, **.mod**, **.it**, and **.s3m** files and use them the same way you use other audio clips.

## Audio recording

Unity can access the computer’s microphones from a script and create Audio Clips by direct recording. The Microphone class provides an API to find available microphones, query their capabilities, and start and end a recording session. The script reference page for [Microphone](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Microphone.html) has further information and code samples for audio recording.

## Additional resources

-   [Audio Source](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioSource.html)
-   [Audio Listener](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioListener.html)
-   [Audio Mixer](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioMixer.html)
-   The [audio effects](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioEffect.html)
-   [Reverb Zones](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioReverbZone.html)

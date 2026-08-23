---
title: "Introduction to audio files"
page_title: "Unity - Manual: Introduction to audio files"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles-introduction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles-introduction.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to audio files

As with Meshes or Textures, the workflow for **Audio File** assets is designed to be smooth and simple. Unity can import almost every common file format, but there are a few details that are useful to be aware of when you work with audio files.

For an extensive description of the compression formats and other options available for encoding audio data, refer to [Audio Clip](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioClip.html).

## Audio data and Audio Clips

Unity audio data is separate from the actual Audio Clips. Audio data is the raw information about an audio file. It contains information such as length, channel count, sample rate, and compression format.

Audio Clips are assets that contain the audio data and processes the audio data for use with Unity Engine. Audio Clips contain the audio data used by [Audio Sources](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioSource.html).

## Alter the settings of your audio file

Use the settings in the [Audio Clip Import Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioClip.html) to determine how the clips will load at runtime. These settings let you decide which audio assets will stay in memory. This is ideal for frequent or unpredictable sounds like footsteps, weapons, or impacts.

For other assets, such as speech, background music, or ambient loops, you can set them to load on-demand or as the player progresses. This approach optimizes memory usage and improves performance.

## Use audio files in your scripts

Any audio file imported into Unity is available from scripts as an AudioClip instance. This provides a way for the game runtime of the audio system to access the encoded audio data. The game might access meta-information about the audio data via the AudioClip even before the actual audio data loads.

The import process extracts information such as length, channel count and sample rate from the encoded audio data and stores these details in the AudioClip. This information can be useful for automatic dialog or music sequencing systems, because the music engine can use the length to schedule music playback before the data loads. It also helps to reduce memory usage because it only keeps the audio clips in memory the application needs at a certain time.

For more information and code examples, refer to [the API documentation for AudioClip](https://docs.unity3d.com/ScriptReference/AudioClip.html).

## Additional resources

-   [Audio files](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles.html)
-   [Audio file type compatibility](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles-compatibility.html)
-   [Audio file compression in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles-compression.html)
-   [Import audio files into Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles-import.html)
-   [Audio Clip Import Settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioClip.html)

---
title: "Audio file compression in Unity"
page_title: "Unity - Manual: Audio file compression in Unity"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles-compression.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles-compression.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Audio file compression in Unity

Audio file compression is an essential way to optimize your application’s performance. When you [import an audio file](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles-import.html), Unity transcodes the file to a format suitable for the build target and the type of sound.

This page gives an overview of some of the different compression formats and their impact on file size, performance, and audio quality.

To change the compression format of an audio file, use the **Compression Format** setting in the [Audio Clip Import Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioClip.html).

## Audio file compression format types

When Unity encodes audio, the main compression formats for how Unity stores the audio on disk are the following:

-   PCM
-   ADPCM
-   Compressed

Additionally there are a few platform-specific formats but they work in similar ways.

The default mode is **Compressed**, where Unity compresses the audio data with either the Vorbis or MP3 format for standalone and mobile platforms.

## PCM or Vorbis/MP3

PCM and Vorbis/MP3 formats keep audio as close as possible to the original sound.

PCM is an uncompressed compression format. PCM is easy for the CPU to handle because the sound is uncompressed, so it plays directly from memory without extra processing.

The Vorbis or MP3 formats are compressed formats. These formats let you use the Quality slider to adjust the compression, which removes less noticeable audio to save space but keeps the sound as clear as possible.

## ADPCM

ADPCM uses slightly more CPU than the uncompressed PCM option, but yields a constant 3.5 compression factor, which is usually about 3 times worse than the compression that can be achieved with Vorbis or MP3 compression. Like PCM, ADPCM lets you automatically optimize or manually adjust the sample rate to further reduce file size, depending on the sound’s frequency content and the acceptable loss of quality.

ADPCM is less suitable for smooth signals like music or ambient sounds because it introduces noticeable artefacts that affect audio quality.

## Module files

Module files (.mod,.it,.s3m..xm) can deliver high quality sounds with a low footprint. When you use module files, make sure that the **Load Type** is set to **Compressed In Memory** in the Audio Clip Import Settings. If it’s set to **Decompress On Load**, the whole song will be decompressed.

## Compressed audio

Compressed audio (or modules) are best for long files like background music or dialog. Use the **Quality** slider to change the amount of compression. Start with high-quality compression and gradually reduce the setting to the point where the loss of sound quality is perceptible. Then, increase it again slightly until the perceived loss of quality disappears.

## Platform-specific formats

Unity lets you import a variety of source format sound files. However, when you import non-tracker files, Unity re-encodes the files to the build target format. By default, this format is Vorbis, though this can be overridden per platform to other formats (ADPCM, MP3 etc) if required.

For audio clip support on Linux, make sure you install the [ffmpeg](https://ffmpeg.org/) package.

## Additional resources

-   [Audio files](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles.html)
-   [Introduction to audio files](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles-introduction.html)
-   [Audio file type compatibility](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles-compatibility.html)
-   [Import audio files into Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles-import.html)
-   [Audio Clip Import Settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioClip.html)

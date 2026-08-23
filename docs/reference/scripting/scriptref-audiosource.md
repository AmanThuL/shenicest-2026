---
title: "Scripting API: AudioSource"
page_title: "Unity - Scripting API: AudioSource"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# AudioSource

class in UnityEngine

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour.html" class="cl">Behaviour</a>

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.AudioModule.html" class="cl">UnityEngine.AudioModule</a>

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioSource.html" class="switch-link gray-btn sbtn left show" title="Go to AudioSource Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

### Description

A representation of audio sources in 3D.

Attach an AudioSource to a [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) to play back sounds in a 3D environment. To play 3D sounds you also need to have an [AudioListener](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioListener.html). Usually, you can find the audio listener attached to the camera in your scene. If you set [AudioSource.spatialBlend](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-spatialBlend.html) to 0.0f, then Unity will treat the audio clip as a 2D sound. If you set it to 1.0f, the clip is fully 3D. Anything in between is a blend of 2D and 3D.  
  
To play, pause, and stop a single audio clip, use [Play](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Play.html), [Pause](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Pause.html) and [Stop](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Stop.html). To adjust its volume while playing, use the [volume](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-volume.html) property. Use [time](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-time.html) to seek through the audio track. To play multiple sounds on one AudioSource, use [PlayOneShot](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayOneShot.html). To play a clip at a static position in 3D space, use [PlayClipAtPoint](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayClipAtPoint.html).  
  
Additional resources: [AudioListener](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioListener.html), [AudioClip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioClip.html), AudioRandomContainer, [IAudioGenerator](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.IAudioGenerator.html) and [AudioSource component](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioSource.html).

``` codeExampleCS
//This script allows you to toggle music to play and stop.
//Assign an AudioSource to a GameObject and attach an Audio Clip in the Audio Source. Attach this script to the GameObject.

using UnityEngine;

public class Example : MonoBehaviour

    void Update()
    
        //Check if you just set the toggle to false
        if (m_Play == false && m_ToggleChange == true)
        
    }

    void OnGUI()
    
    }
}
```

### Properties

| Property                                                                                                                            | Description                                                                                                                                                                            |
|-------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [bypassEffects](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-bypassEffects.html)                       | Bypass effects (Applied from filter components or global listener filters).                                                                                                            |
| [bypassListenerEffects](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-bypassListenerEffects.html)       | When set, global effects on the AudioListener doesn't apply to the audio signal generated by the AudioSource. It also doesn't apply, if the AudioSource is playing into a mixer group. |
| [bypassReverbZones](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-bypassReverbZones.html)               | When set, it doesn't route the signal from an AudioSource into the global reverb associated with reverb zones.                                                                         |
| [clip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-clip.html)                                         | The default AudioClip to play.                                                                                                                                                         |
| [dopplerLevel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-dopplerLevel.html)                         | Sets the Doppler scale for this AudioSource.                                                                                                                                           |
| [gamepadSpeakerOutputType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-gamepadSpeakerOutputType.html) | Gets or sets the gamepad audio output type for this audio source.                                                                                                                      |
| [generator](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-generator.html)                               | The default IAudioGenerator to play next.                                                                                                                                              |
| [generatorInstance](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-generatorInstance.html)               | A handle to the currently playing Generator, if it can be controlled by scripting.                                                                                                     |
| [ignoreListenerPause](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-ignoreListenerPause.html)           | Allows AudioSource to play even though AudioListener.pause is set to true. This is useful for the menu element sounds or background music in pause menus.                              |
| [ignoreListenerVolume](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-ignoreListenerVolume.html)         | This makes the audio source not take into account the volume of the audio listener.                                                                                                    |
| [isPlaying](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-isPlaying.html)                               | Returns whether the AudioSource is currently playing an AudioResource(Read Only).                                                                                                      |
| [isVirtual](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-isVirtual.html)                               | True if all sounds played by the AudioSource, such as main sound started by Play() or playOnAwake, and one-shots are culled by the audio system.                                       |
| [loop](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-loop.html)                                         | Checks if the audio clip is looping                                                                                                                                                    |
| [maxDistance](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-maxDistance.html)                           | The distance where sound either becomes inaudible or stops attenuation, depending on the rolloff mode.                                                                                 |
| [minDistance](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-minDistance.html)                           | Within the Min distance the AudioSource will cease to grow louder in volume.                                                                                                           |
| [mute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-mute.html)                                         | Un- / Mutes the AudioSource. Mute sets the volume=0, Un-Mute restore the original volume.                                                                                              |
| [outputAudioMixerGroup](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-outputAudioMixerGroup.html)       | The target group to which the AudioSource should route its signal.                                                                                                                     |
| [panStereo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-panStereo.html)                               | Pans a playing sound in a stereo way (left or right). This only applies to sounds that are Mono or Stereo.                                                                             |
| [pitch](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-pitch.html)                                       | The pitch of the audio source.                                                                                                                                                         |
| [playOnAwake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-playOnAwake.html)                           | Enable this property to automatically play the audio source when the component or GameObject becomes active.                                                                           |
| [priority](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-priority.html)                                 | Sets the priority of the AudioSource.                                                                                                                                                  |
| [resource](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-resource.html)                                 | The default AudioResource to play.                                                                                                                                                     |
| [reverbZoneMix](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-reverbZoneMix.html)                       | The amount by which the signal from the AudioSource will be mixed into the global reverb associated with the Reverb Zones.                                                             |
| [rolloffMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-rolloffMode.html)                           | Sets/Gets how the AudioSource attenuates over distance.                                                                                                                                |
| [spatialBlend](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-spatialBlend.html)                         | Sets how much this AudioSource is affected by 3D spatialisation calculations (attenuation, doppler etc). 0.0 makes the sound full 2D, 1.0 makes it full 3D.                            |
| [spatialize](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-spatialize.html)                             | Enables or disables spatialization.                                                                                                                                                    |
| [spatializePostEffects](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-spatializePostEffects.html)       | Determines if the spatializer effect is inserted before or after the effect filters.                                                                                                   |
| [spread](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-spread.html)                                     | Sets the spread angle (in degrees) of a 3d stereo or multichannel sound in speaker space.                                                                                              |
| [time](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-time.html)                                         | Audio source playback position in seconds.                                                                                                                                             |
| [timeSamples](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-timeSamples.html)                           | The current playback position of the AudioSource in PCM samples.                                                                                                                       |
| [velocityUpdateMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-velocityUpdateMode.html)             | Whether the Audio Source should be updated in the fixed or dynamic update.                                                                                                             |
| [volume](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-volume.html)                                     | The volume of the audio source (0.0 to 1.0).                                                                                                                                           |

### Public Methods

| Method                                                                                                                              | Description                                                                                                                                                                                                                      |
|-------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [DisableGamepadOutput](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.DisableGamepadOutput.html)         | Disables audio output to a gamepad for this audio source.                                                                                                                                                                        |
| [GetAmbisonicDecoderFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.GetAmbisonicDecoderFloat.html) | Reads a user-defined parameter of a custom ambisonic decoder effect that is attached to an AudioSource.                                                                                                                          |
| [GetCustomCurve](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.GetCustomCurve.html)                     | Get the current custom curve for the given AudioSourceCurveType.                                                                                                                                                                 |
| [GetOutputData](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.GetOutputData.html)                       | Provides a block of the currently playing source's output data.                                                                                                                                                                  |
| [GetSpatializerFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.GetSpatializerFloat.html)           | Reads a user-defined parameter of a custom spatializer effect that is attached to an AudioSource.                                                                                                                                |
| [GetSpectrumData](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.GetSpectrumData.html)                   | Provides the block of audio frequencies (spectrum data) of the AudioSource that is currently playing.                                                                                                                            |
| [Pause](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Pause.html)                                       | Pauses playing the clip.                                                                                                                                                                                                         |
| [Play](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Play.html)                                         | Plays the clip.                                                                                                                                                                                                                  |
| [PlayDelayed](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayDelayed.html)                           | Plays the clip with a delay specified in seconds. Users are advised to use this function instead of the old Play(delay) function that took a delay specified in samples relative to a reference rate of 44.1 kHz as an argument. |
| [PlayOneShot](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayOneShot.html)                           | Plays an AudioClip, and scales the AudioSource volume by volumeScale.                                                                                                                                                            |
| [PlayOnGamepad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayOnGamepad.html)                       | Enable the audio source to play through a specific gamepad.                                                                                                                                                                      |
| [PlayScheduled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayScheduled.html)                       | Plays the clip at a specific time on the absolute time-line that AudioSettings.dspTime reads from.                                                                                                                               |
| [SetAmbisonicDecoderFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.SetAmbisonicDecoderFloat.html) | Sets a user-defined parameter of a custom ambisonic decoder effect that is attached to an AudioSource.                                                                                                                           |
| [SetCustomCurve](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.SetCustomCurve.html)                     | Set the custom curve for the given AudioSourceCurveType.                                                                                                                                                                         |
| [SetScheduledEndTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.SetScheduledEndTime.html)           | Changes the time at which a sound that has already been scheduled to play will end. Notice that depending on the timing not all rescheduling requests can be fulfilled.                                                          |
| [SetScheduledStartTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.SetScheduledStartTime.html)       | Changes the time at which a sound that has already been scheduled to play will start.                                                                                                                                            |
| [SetSpatializerFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.SetSpatializerFloat.html)           | Sets a user-defined parameter of a custom spatializer effect that is attached to an AudioSource.                                                                                                                                 |
| [Stop](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Stop.html)                                         | Stops playing the clip.                                                                                                                                                                                                          |
| [UnPause](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.UnPause.html)                                   | Unpause the paused playback of this AudioSource.                                                                                                                                                                                 |

### Static Methods

| Method                                                                                                                                              | Description                                                      |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|
| [GamepadSpeakerSupportsOutputType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.GamepadSpeakerSupportsOutputType.html) | Check if the platform supports an audio output type on gamepads. |
| [PlayClipAtPoint](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayClipAtPoint.html)                                   | Plays an AudioClip at a given position in world space.           |

### Inherited Members

### Properties

| Property                                                                                                              | Description                                                                                                                                    |
|-----------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| [enabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-enabled.html)                       | True if this Behaviour is enabled, otherwise false.                                                                                            |
| [isActiveAndEnabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-isActiveAndEnabled.html) | Checks whether a component is enabled, attached to a GameObject that is active in the hierarchy, and the component's OnEnable has been called. |
| [gameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-gameObject.html)                 | The game object this component is attached to. A component is always attached to a game object.                                                |
| [tag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-tag.html)                               | The tag of this game object.                                                                                                                   |
| [transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-transform.html)                   | The Transform attached to this GameObject.                                                                                                     |
| [transformHandle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-transformHandle.html)       | The TransformHandle of this GameObject.                                                                                                        |
| [hideFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-hideFlags.html)                      | Controls whether the object is hidden, saved with the scene, and editable by the user.                                                         |
| [name](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-name.html)                                | The name of the object.                                                                                                                        |

### Public Methods

| Method                                                                                                                          | Description                                                                                                                      |
|---------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| [BroadcastMessage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.BroadcastMessage.html)               | Calls the method named methodName on every MonoBehaviour in this game object or any of its children.                             |
| [CompareTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.CompareTag.html)                           | Checks the GameObject's tag against the defined tag.                                                                             |
| [GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponent.html)                       | Gets a reference to a component of type T on the same GameObject as the component specified.                                     |
| [GetComponentInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentInChildren.html)   | Gets a reference to a component of type T on the same GameObject as the component specified, or any child of the GameObject.     |
| [GetComponentIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentIndex.html)             | Gets the index of the component on its parent GameObject.                                                                        |
| [GetComponentInParent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentInParent.html)       | Gets a reference to a component of type T on the same GameObject as the component specified, or any parent of the GameObject.    |
| [GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponents.html)                     | Gets references to all components of type T on the same GameObject as the component specified.                                   |
| [GetComponentsInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentsInChildren.html) | Gets references to all components of type T on the same GameObject as the component specified, and any child of the GameObject.  |
| [GetComponentsInParent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentsInParent.html)     | Gets references to all components of type T on the same GameObject as the component specified, and any parent of the GameObject. |
| [SendMessage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.SendMessage.html)                         | Calls the method named methodName on every MonoBehaviour in this game object.                                                    |
| [SendMessageUpwards](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.SendMessageUpwards.html)           | Calls the method named methodName on every MonoBehaviour in this game object and on every ancestor of the behaviour.             |
| [TryGetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.TryGetComponent.html)                 | Gets the component of the specified type, if it exists.                                                                          |
| [GetHashCode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetHashCode.html)                            | Returns the hash code for the object.                                                                                            |
| [GetInstanceID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetInstanceID.html)                        | Gets the instance ID of the object.                                                                                              |
| [ToString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.ToString.html)                                  | Returns the name of the object.                                                                                                  |

### Static Methods

| Method                                                                                                                   | Description                                                                                                                                                 |
|--------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html)                             | Removes a GameObject, component, or asset.                                                                                                                  |
| [DestroyImmediate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DestroyImmediate.html)           | Destroys the specified object immediately. Use with caution and in Edit mode only.                                                                          |
| [DontDestroyOnLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html)         | Do not destroy the target Object when loading a new Scene.                                                                                                  |
| [FindAnyObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html)     | Retrieves any active loaded object of Type T.                                                                                                               |
| [FindFirstObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html) | Retrieves the first active loaded object of Type type.                                                                                                      |
| [FindObjectsByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html)         | Retrieves a list of all loaded objects of Type type and sorts the results according to sortMode.                                                            |
| [Instantiate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Instantiate.html)                     | Clones the object original and returns the clone.                                                                                                           |
| [InstantiateAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.InstantiateAsync.html)           | Captures a snapshot of the original object that's related to another GameObject and obtains an AsyncInstantiateOperation instance of the resulting objects. |

### Operators

| Operator                                                                                             | Description                                                             |
|------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [bool](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_Object.html)    | Determines whether the object exists.                                   |
| [operator !=](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_ne.html) | Compares if two objects refer to a different object.                    |
| [operator ==](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_eq.html) | Compares two object references to see if they refer to the same object. |

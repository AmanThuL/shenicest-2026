---
title: "Scripting API: Mathf"
page_title: "Unity - Scripting API: Mathf"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Mathf

struct in UnityEngine

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Mathf.html" class="switch-link gray-btn sbtn left show" title="Go to Mathf Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

### Description

A collection of common math functions.

### Static Properties

| Property                                                                                                      | Description                                                      |
|---------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|
| [Deg2Rad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Deg2Rad.html)                   | Degrees-to-radians conversion constant (Read Only).              |
| [Epsilon](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Epsilon.html)                   | The smallest positive non-zero value that a float can represent. |
| [Infinity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Infinity.html)                 | A representation of positive infinity (Read Only).               |
| [NegativeInfinity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.NegativeInfinity.html) | A representation of negative infinity (Read Only).               |
| [PI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.PI.html)                             | The well-known 3.14159265358979... value (Read Only).            |
| [Rad2Deg](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Rad2Deg.html)                   | Radians-to-degrees conversion constant (Read Only).              |

### Static Methods

| Method                                                                                                                                      | Description                                                                                                                                                                              |
|---------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Abs](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Abs.html)                                                         | Returns the absolute value of f.                                                                                                                                                         |
| [Acos](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Acos.html)                                                       | Returns the arc-cosine of f - the angle in radians whose cosine is f.                                                                                                                    |
| [Approximately](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Approximately.html)                                     | Compares two floating point values and returns true if they are similar.                                                                                                                 |
| [Asin](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Asin.html)                                                       | Returns the arc-sine of f - the angle in radians whose sine is f.                                                                                                                        |
| [Atan](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Atan.html)                                                       | Returns the arc-tangent of f - the angle in radians whose tangent is f.                                                                                                                  |
| [Atan2](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Atan2.html)                                                     | Returns the angle in radians whose Tan is y/x.                                                                                                                                           |
| [Ceil](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Ceil.html)                                                       | Returns the smallest integer number greater than or equal to f.                                                                                                                          |
| [CeilToInt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.CeilToInt.html)                                             | Returns the smallest integer number (cast as int) greater than or equal to f.                                                                                                            |
| [Clamp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Clamp.html)                                                     | Clamps the given value between the given minimum float and maximum float values. Returns the given value if it is within the minimum and maximum range.                                  |
| [Clamp01](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Clamp01.html)                                                 | Clamps value between 0 and 1 and returns value.                                                                                                                                          |
| [ClosestPowerOfTwo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.ClosestPowerOfTwo.html)                             | Returns the closest power of two value.                                                                                                                                                  |
| [CorrelatedColorTemperatureToRGB](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.CorrelatedColorTemperatureToRGB.html) | Convert a color temperature in Kelvin to RGB color.                                                                                                                                      |
| [Cos](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Cos.html)                                                         | Returns the cosine for the input angle f.                                                                                                                                                |
| [DeltaAngle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.DeltaAngle.html)                                           | Calculates the shortest difference between two angles.                                                                                                                                   |
| [Exp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Exp.html)                                                         | Returns the result of raising euler's number (e) to the power power.                                                                                                                     |
| [FloatToHalf](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.FloatToHalf.html)                                         | Encode a floating point value into a 16-bit representation.                                                                                                                              |
| [Floor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Floor.html)                                                     | Returns the greatest integer number smaller than or equal to f.                                                                                                                          |
| [FloorToInt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.FloorToInt.html)                                           | Returns the greatest integer number (cast as int) smaller than or equal to f.                                                                                                            |
| [GammaToLinearSpace](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.GammaToLinearSpace.html)                           | Converts the given value from gamma (sRGB) to linear color space.                                                                                                                        |
| [HalfToFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.HalfToFloat.html)                                         | Convert a half precision float to a 32-bit floating point value.                                                                                                                         |
| [InverseLerp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.InverseLerp.html)                                         | Determines where a value lies between two points.                                                                                                                                        |
| [IsPowerOfTwo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.IsPowerOfTwo.html)                                       | Returns true if the value is power of two.                                                                                                                                               |
| [Lerp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Lerp.html)                                                       | Linearly interpolates between a and b by t.                                                                                                                                              |
| [LerpAngle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.LerpAngle.html)                                             | Same as Lerp but makes sure the values interpolate correctly when they wrap around 360 degrees.                                                                                          |
| [LerpUnclamped](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.LerpUnclamped.html)                                     | Linearly interpolates between a and b by t with no limit to t.                                                                                                                           |
| [LinearToGammaSpace](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.LinearToGammaSpace.html)                           | Converts the given value from linear to gamma (sRGB) color space.                                                                                                                        |
| [Log](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Log.html)                                                         | Returns the logarithm of a specified number in a specified base.                                                                                                                         |
| [Log10](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Log10.html)                                                     | Returns the base 10 logarithm of a specified number.                                                                                                                                     |
| [Max](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Max.html)                                                         | Returns the maximum of two or more values.                                                                                                                                               |
| [Min](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Min.html)                                                         | Returns the minimum of two or more values.                                                                                                                                               |
| [MoveTowards](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.MoveTowards.html)                                         | Moves a value current towards target.                                                                                                                                                    |
| [MoveTowardsAngle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.MoveTowardsAngle.html)                               | Same as MoveTowards but makes sure the values interpolate correctly when they wrap around 360 degrees.                                                                                   |
| [NextPowerOfTwo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.NextPowerOfTwo.html)                                   | Returns the next power of two that is equal to, or greater than, the argument.                                                                                                           |
| [PerlinNoise](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.PerlinNoise.html)                                         | Generate 2D Perlin noise.                                                                                                                                                                |
| [PerlinNoise1D](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.PerlinNoise1D.html)                                     | Generates a 1D pseudo-random pattern of float values across a 2D plane.                                                                                                                  |
| [PingPong](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.PingPong.html)                                               | PingPong returns a value that increments and decrements between zero and the length. It follows the triangle wave formula where the bottom is set to zero and the peak is set to length. |
| [Pow](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Pow.html)                                                         | Returns the result of raising f to the power p.                                                                                                                                          |
| [Repeat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Repeat.html)                                                   | Loops the value t, so that it is never larger than length and never smaller than 0.                                                                                                      |
| [Round](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Round.html)                                                     | Returns f rounded to the nearest integer number.                                                                                                                                         |
| [RoundToInt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.RoundToInt.html)                                           | Returns f rounded to the nearest integer number (cast as int).                                                                                                                           |
| [Sign](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Sign.html)                                                       | Returns the mathematical sign of f.                                                                                                                                                      |
| [Sin](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Sin.html)                                                         | Returns the sine for the input angle f.                                                                                                                                                  |
| [SmoothDamp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.SmoothDamp.html)                                           | Gradually moves the current value towards a target value, over a specified time and at a specified velocity.                                                                             |
| [SmoothDampAngle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.SmoothDampAngle.html)                                 | Gradually changes an angle given in degrees towards a desired goal angle over time.                                                                                                      |
| [SmoothStep](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.SmoothStep.html)                                           | Interpolates between from and to with smoothing at the limits.                                                                                                                           |
| [Sqrt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Sqrt.html)                                                       | Returns square root of f (real number whose square equals f).                                                                                                                            |
| [Tan](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Tan.html)                                                         | Returns the tangent of angle f in radians.                                                                                                                                               |

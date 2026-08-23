---
title: "UnityCsReference 6000.3: Rigidbody.deprecated.cs"
source_url: "https://raw.githubusercontent.com/Unity-Technologies/UnityCsReference/6000.3/Modules/Physics/ScriptBindings/Rigidbody.deprecated.cs"
final_url: "https://raw.githubusercontent.com/Unity-Technologies/UnityCsReference/6000.3/Modules/Physics/ScriptBindings/Rigidbody.deprecated.cs"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "source"
---

# UnityCsReference 6000.3: Rigidbody.deprecated.cs

```cs
// Unity C# reference source
// Copyright (c) Unity Technologies. For terms of use, see
// https://unity3d.com/legal/licenses/Unity_Reference_Only_License

using System;
using System.ComponentModel;

namespace UnityEngine
{
    public partial class Rigidbody
    {
        [EditorBrowsable(EditorBrowsableState.Never)]
        [Obsolete("Please use Rigidbody.linearDamping instead. (UnityUpgradable) -> linearDamping")]
        public float drag { get => linearDamping; set => linearDamping = value; }

        [EditorBrowsable(EditorBrowsableState.Never)]
        [Obsolete("Please use Rigidbody.angularDamping instead. (UnityUpgradable) -> angularDamping")]
        public float angularDrag { get => angularDamping; set => angularDamping = value; }

        [EditorBrowsable(EditorBrowsableState.Never)]
        [Obsolete("Please use Rigidbody.linearVelocity instead. (UnityUpgradable) -> linearVelocity")]
        public Vector3 velocity { get => linearVelocity; set => linearVelocity = value; }

        [EditorBrowsable(EditorBrowsableState.Never)]
        [Obsolete("Please use Rigidbody.mass instead. Setting density on a Rigidbody no longer has any effect.", false)]
        public void SetDensity(float density) { }
    }
}
```

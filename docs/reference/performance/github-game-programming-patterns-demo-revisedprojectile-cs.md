---
title: "game-programming-patterns-demo: RevisedProjectile.cs (pooled object example)"
source_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/_DesignPatterns/2_ObjectPool/Scripts/ExampleUsage/RevisedProjectile.cs"
final_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/_DesignPatterns/2_ObjectPool/Scripts/ExampleUsage/RevisedProjectile.cs"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "source"
---

# game-programming-patterns-demo: RevisedProjectile.cs (pooled object example)

```cs
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pool;

namespace DesignPatterns.ObjectPool
{
    // Projectile revised to use UnityEngine.Pool in Unity 2021
    public class RevisedProjectile : MonoBehaviour
    {
        // Deactivate after delay
        [SerializeField] private float timeoutDelay = 3f;

        private IObjectPool<RevisedProjectile> objectPool;

        // Public property to give the projectile a reference to its ObjectPool
        public IObjectPool<RevisedProjectile> ObjectPool { set => objectPool = value; }

        public void Deactivate()
        {
            StartCoroutine(DeactivateRoutine(timeoutDelay));
        }

        IEnumerator DeactivateRoutine(float delay)
        {
            yield return new WaitForSeconds(delay);

            // Reset the moving Rigidbody
            Rigidbody rBody = GetComponent<Rigidbody>();
            rBody.linearVelocity = new Vector3(0f, 0f, 0f);
            rBody.angularVelocity = new Vector3(0f, 0f, 0f);

            // Release the projectile back to the pool
            objectPool.Release(this);
        }
    }
}

```

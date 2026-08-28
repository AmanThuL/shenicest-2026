using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Walls the wreck's cabin in Main_Environment_2 so the player, who starts the level sitting in
    /// it, can only climb out through the open door on the driver's side.
    /// </summary>
    /// <remarks>
    /// <para>
    /// The FBX imports with no collider — the profile turns them off, because a mesh collider on a
    /// 7 000-vertex wreck would be both expensive and full of holes the player could fall through.
    /// A cage of boxes is cheaper and, more to the point, is the only way to say "this gap is the
    /// way out and the other three sides are not", which no automatic collider can express.
    /// </para>
    /// <para>
    /// The numbers are the cabin measured off an orthographic top-down of the placed car, in metres
    /// relative to its pivot, on world axes — <see cref="TempPlaceEnvironment2"/> parks the wreck
    /// square to them, so the cage needs no rotation of its own and stays readable. Both front doors
    /// hang open on the model; the right-hand one is walled off, so only the driver's side lets the
    /// player out.
    /// </para>
    /// <para>
    /// Idempotent, and rebuilt by <see cref="TempPlaceEnvironment2"/>: re-placing the car destroys
    /// the cage along with it.
    /// </para>
    /// Menu: RootsDance > Build Car Cabin Collider.
    /// </remarks>
    public static class CarCabinColliderBuilder
    {
        private const string k_Scene = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_2.unity";
        private const string k_CarName = "CarRustyOpenDoor";
        private const string k_CageName = "CabinCollision";

        // Cabin box, in metres from the car's pivot on world axes.
        private const float k_Left = -0.70f;    // driver's side; the open side, so only an extent
        private const float k_Right = 0.72f;    // passenger's side
        private const float k_Rear = -1.02f;    // towards the boot
        private const float k_Front = 0.91f;    // towards the windscreen

        /// <summary>Wall thickness. Thin enough not to eat the cabin, thick enough not to tunnel.</summary>
        private const float k_Thickness = 0.12f;

        /// <summary>
        /// How far the walls rise above the car's floor. Taller than the wreck, so the player cannot
        /// step over a wall where the roof has rusted through.
        /// </summary>
        private const float k_Height = 1.8f;

        /// <summary>Floor of the cage, from the pivot. The car is levelled onto the ground at its pivot.</summary>
        private const float k_Floor = -0.02f;

        [MenuItem("RootsDance/Build Car Cabin Collider")]
        public static void Build()
        {
            Scene scene = EditorSceneManager.OpenScene(k_Scene, OpenSceneMode.Single);
            GameObject car = Find(scene, k_CarName);

            if (car == null)
            {
                Debug.LogError($"CarCabinColliderBuilder: no '{k_CarName}' in {k_Scene}. Run "
                    + "RootsDance > Place Environment 2 Props first.");
                return;
            }

            GameObject cage = Rebuild(car);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);

            Debug.Log($"CarCabinColliderBuilder: {cage.GetComponents<BoxCollider>().Length} walls on "
                + $"{k_CageName}; the driver's side is the way out.");
        }

        private static GameObject Rebuild(GameObject car)
        {
            Transform existing = car.transform.Find(k_CageName);

            if (existing != null)
            {
                Object.DestroyImmediate(existing.gameObject);
            }

            GameObject cage = new GameObject(k_CageName);
            cage.layer = car.layer;
            cage.transform.SetParent(car.transform, false);

            // Square to the world, not to the car: the cabin was measured on world axes and the
            // placer parks the wreck square to them, so a rotation here would only skew the boxes.
            cage.transform.SetPositionAndRotation(car.transform.position, Quaternion.identity);

            float centreY = k_Floor + k_Height * 0.5f;
            float width = k_Right - k_Left;
            float length = k_Front - k_Rear;

            // Front and rear: the windscreen and the rear bench. Overlapped by half a wall at each
            // end so the corners have no seam for a capsule to squeeze through.
            AddWall(cage, new Vector3((k_Left + k_Right) * 0.5f, centreY, k_Front),
                new Vector3(width + k_Thickness, k_Height, k_Thickness));
            AddWall(cage, new Vector3((k_Left + k_Right) * 0.5f, centreY, k_Rear),
                new Vector3(width + k_Thickness, k_Height, k_Thickness));

            // Passenger's side: shut, even though that door hangs open on the model.
            AddWall(cage, new Vector3(k_Right, centreY, (k_Rear + k_Front) * 0.5f),
                new Vector3(k_Thickness, k_Height, length + k_Thickness));

            // Driver's side: no wall at all. The cabin is 1.4 m across and 1.9 m long and the
            // player's capsule is a metre wide, so a doorway with a stub of wall at either end
            // would leave gaps narrower than the player and wedge them in the seat. Leaving the
            // whole side open is the same thing in play — that side has one open door and three
            // walls elsewhere — without the pathological case.

            GameObjectUtility.SetStaticEditorFlags(cage, StaticEditorFlags.BatchingStatic);

            return cage;
        }

        private static void AddWall(GameObject cage, Vector3 centre, Vector3 size)
        {
            BoxCollider wall = cage.AddComponent<BoxCollider>();
            wall.center = centre;
            wall.size = size;
        }

        private static GameObject Find(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == name)
                {
                    return root;
                }
            }

            return null;
        }
    }
}

using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Gives the wreck in Main_Environment_2 the collision it has no way to import: solid where the
    /// car is solid, and open only at the driver's door, which the player starts the level behind.
    /// </summary>
    /// <remarks>
    /// <para>
    /// The FBX imports with no collider — the profile turns them off, because a mesh collider on a
    /// 7 000-vertex wreck would be both expensive and full of holes. Boxes are cheaper and, more to
    /// the point, are the only way to say "this gap is the way out and nothing else is", which no
    /// automatic collider can express.
    /// </para>
    /// <para>
    /// Three pieces: the engine bay and the boot are filled solid, so the car cannot be walked
    /// through from outside; the passenger's flank is a wall along the cabin. The driver's flank is
    /// deliberately left open along the whole cabin rather than cut to the door's real width — the
    /// cabin is 1.4 m across and the player's capsule is a metre wide, so stubs of wall at either
    /// end of a door-sized gap would wedge the player in the seat. In play it reads the same: that
    /// side has an open door, and every other way out is shut.
    /// </para>
    /// <para>
    /// The numbers are the car measured off an orthographic top-down of the placed wreck, in metres
    /// from its pivot on world axes — <see cref="TempPlaceEnvironment2"/> parks it square to them,
    /// so the boxes need no rotation of their own and stay readable.
    /// </para>
    /// <para>
    /// Idempotent, and rebuilt by <see cref="TempPlaceEnvironment2"/>: re-placing the car destroys
    /// this along with it.
    /// </para>
    /// Menu: RootsDance > Build Car Cabin Collider.
    /// </remarks>
    public static class CarCabinColliderBuilder
    {
        private const string k_Scene = "Assets/RootsDance/Scenes/Levels/Main/Main_Environment_2.unity";
        private const string k_CarName = "CarRustyOpenDoor";
        private const string k_CageName = "CabinCollision";

        // Body shell, from the pivot on world axes. The open doors hang outside this: they are
        // sheet metal the player is welcome to walk through.
        private const float k_BodyLeft = -0.91f;    // driver's side
        private const float k_BodyRight = 0.90f;    // passenger's side
        private const float k_BodyRear = -2.13f;    // tail
        private const float k_BodyFront = 2.17f;    // nose

        // Where the cabin begins and ends along the same axis: everything forward of the front is
        // engine bay, everything behind the rear is boot, and both are filled in solid.
        private const float k_CabinRear = -1.02f;
        private const float k_CabinFront = 0.91f;

        /// <summary>Flank thickness. Thin enough not to eat the cabin, thick enough not to tunnel.</summary>
        private const float k_Thickness = 0.12f;

        /// <summary>
        /// How far the collision rises above the car's floor. Taller than the wreck itself, so the
        /// player can neither step over a flank nor stand on the bonnet.
        /// </summary>
        private const float k_Height = 1.8f;

        /// <summary>Floor of the collision, from the pivot. The car is levelled onto the ground there.</summary>
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

            Debug.Log($"CarCabinColliderBuilder: {cage.GetComponents<BoxCollider>().Length} boxes on "
                + $"{k_CageName}; the driver's flank is the only way through.");
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

            // Square to the world, not to the car: the shell was measured on world axes and the
            // placer parks the wreck square to them, so a rotation here would only skew the boxes.
            cage.transform.SetPositionAndRotation(car.transform.position, Quaternion.identity);

            // And unscaled. The wreck imports at 1.377, so every box below would come out 38 per
            // cent oversized on inherited scale — enough to close the doorway the player leaves by.
            // The compensation is uniform, so it cannot skew the boxes the way a non-uniform one
            // would on a child this heavily rotated.
            Vector3 scale = car.transform.lossyScale;

            if (!Mathf.Approximately(scale.x, scale.y) || !Mathf.Approximately(scale.y, scale.z))
            {
                Debug.LogWarning($"CarCabinColliderBuilder: '{car.name}' is scaled non-uniformly "
                    + $"({scale:F3}); the collision boxes will be skewed.", car);
            }

            cage.transform.localScale = new Vector3(1f / scale.x, 1f / scale.y, 1f / scale.z);

            float centreY = k_Floor + k_Height * 0.5f;
            float bodyWidth = k_BodyRight - k_BodyLeft;
            float bodyCentreX = (k_BodyLeft + k_BodyRight) * 0.5f;

            // Engine bay and boot, filled solid. These also close the cabin off fore and aft, so
            // the player cannot walk out through the windscreen or the rear bench.
            AddBox(cage, new Vector3(bodyCentreX, centreY, (k_CabinFront + k_BodyFront) * 0.5f),
                new Vector3(bodyWidth, k_Height, k_BodyFront - k_CabinFront));
            AddBox(cage, new Vector3(bodyCentreX, centreY, (k_BodyRear + k_CabinRear) * 0.5f),
                new Vector3(bodyWidth, k_Height, k_CabinRear - k_BodyRear));

            // Passenger's flank along the cabin; the two blocks above already cover the rest of it.
            AddBox(cage, new Vector3(k_BodyRight - k_Thickness * 0.5f, centreY,
                    (k_CabinRear + k_CabinFront) * 0.5f),
                new Vector3(k_Thickness, k_Height, k_CabinFront - k_CabinRear));

            // Driver's flank: nothing. See the class remarks.

            GameObjectUtility.SetStaticEditorFlags(cage, StaticEditorFlags.BatchingStatic);

            return cage;
        }

        private static void AddBox(GameObject cage, Vector3 centre, Vector3 size)
        {
            BoxCollider box = cage.AddComponent<BoxCollider>();
            box.center = centre;
            box.size = size;
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

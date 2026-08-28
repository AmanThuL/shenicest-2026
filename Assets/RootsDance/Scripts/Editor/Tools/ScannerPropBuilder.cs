using RootsDance.Scanner;
using RootsDance.UI;
using Unity.Cinemachine;
using UnityEditor;
using UnityEngine;
using Object = UnityEngine.Object;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Assembles the scanner prop prefab: the imported mesh, an anchor sitting on the middle of its
    /// screen, the world-space report canvas on that anchor, and the camera that flies in to read
    /// it.
    /// <para>
    /// The anchor's orientation is measured from the mesh rather than typed in. The screen was
    /// separated out of the Body mesh in Blender as its own object with its origin on the centre of
    /// the lit area, so the plate's own geometry says which way is out and which way is up, and the
    /// builder does not have to know how the FBX axis conversion came out. See
    /// <see cref="ResolveScreenAxes"/> for the three cues it uses.
    /// </para>
    /// Menu: RootsDance > Build Scanner Prop.
    /// </summary>
    public static class ScannerPropBuilder
    {
        private const string k_Model = "Assets/RootsDance/Meshes/Props/Scanner.fbx";
        private const string k_Prefab = "Assets/RootsDance/Prefabs/Props/Scanner.prefab";
        private const string k_ScreenObject = "Screen";
        private const string k_AnchorName = "ScreenAnchor";
        private const string k_CameraName = "InspectCamera";

        [MenuItem("RootsDance/Build Scanner Prop")]
        public static void Build()
        {
            GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(k_Model);

            if (model == null)
            {
                Debug.LogError($"ScannerPropBuilder: {k_Model} not found. Export it first — the "
                    + "command is in docs/architecture/tooling/Blender到Unity导出管线.md.");
                return;
            }

            GameObject screenPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(
                ScannerReportScreenBuilder.k_ScreenPrefab);

            if (screenPrefab == null)
            {
                Debug.LogError("ScannerPropBuilder: build the report screen first "
                    + "(RootsDance > Build Scanner Report Screen).");
                return;
            }

            GameObject root = (GameObject)PrefabUtility.InstantiatePrefab(model);
            root.name = "Scanner";

            Transform screen = FindScreen(root.transform);

            if (screen == null)
            {
                Debug.LogError($"ScannerPropBuilder: no '{k_ScreenObject}' object under the model. "
                    + "Has the screen been separated out of the Body mesh in Scanner.blend?");
                Object.DestroyImmediate(root);
                return;
            }

            MeshFilter filter = screen.GetComponent<MeshFilter>();

            if (filter == null || filter.sharedMesh == null)
            {
                Debug.LogError("ScannerPropBuilder: the Screen object carries no mesh.");
                Object.DestroyImmediate(root);
                return;
            }

            ResolveScreenAxes(filter.sharedMesh, out Vector3 forward, out Vector3 up);

            GameObject anchorGo = new GameObject(k_AnchorName);
            Transform anchor = anchorGo.transform;
            anchor.SetParent(screen, false);
            anchor.localPosition = Vector3.zero;
            // Forward is the reading direction, into the plate, not the outward normal: that is
            // the direction a world-space canvas with an identity rotation is read from, and
            // getting it the other way round renders the whole screen mirrored.
            anchor.localRotation = Quaternion.LookRotation(-forward, up);
            anchor.localScale = Vector3.one;

            GameObject canvas = (GameObject)PrefabUtility.InstantiatePrefab(screenPrefab);
            canvas.transform.SetParent(anchor, false);
            canvas.GetComponent<ScannerScreenSurface>().Apply();

            GameObject cameraGo = new GameObject(k_CameraName);
            cameraGo.transform.SetParent(anchor, false);
            CinemachineCamera camera = cameraGo.AddComponent<CinemachineCamera>();
            camera.Priority = 30;

            ScannerInspectFraming framing = root.AddComponent<ScannerInspectFraming>();
            SerializedObject framingSerialized = new SerializedObject(framing);
            framingSerialized.FindProperty("m_screenAnchor").objectReferenceValue = anchor;
            framingSerialized.FindProperty("m_camera").objectReferenceValue = camera;
            framingSerialized.FindProperty("m_surface").objectReferenceValue =
                canvas.GetComponent<ScannerScreenSurface>();
            framingSerialized.ApplyModifiedPropertiesWithoutUndo();
            framing.Apply();

            ScannerInspectController controller = root.AddComponent<ScannerInspectController>();
            SerializedObject controllerSerialized = new SerializedObject(controller);
            controllerSerialized.FindProperty("m_screenBehaviour").objectReferenceValue =
                FindPresenter(canvas);
            controllerSerialized.FindProperty("m_inspectCamera").objectReferenceValue = camera;
            controllerSerialized.FindProperty("m_framing").objectReferenceValue = framing;
            controllerSerialized.ApplyModifiedPropertiesWithoutUndo();

            root.AddComponent<ScannerDebugTrigger>();

            ElectronicUIKitBuilder.EnsureFolder("Assets/RootsDance/Prefabs/Props");
            PrefabUtility.SaveAsPrefabAsset(root, k_Prefab);
            Object.DestroyImmediate(root);
            AssetDatabase.SaveAssets();

            Debug.Log($"ScannerPropBuilder: {k_Prefab} built. Outward normal {forward}, up {up}. "
                + "Wire the arms view and the suspended player components on the controller once "
                + "the prop is attached to the hand socket.");
        }

        private static Transform FindScreen(Transform root)
        {
            Transform[] children = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < children.Length; i++)
            {
                if (children[i].name == k_ScreenObject)
                {
                    return children[i];
                }
            }

            return null;
        }

        private static ScannerReportPresenter FindPresenter(GameObject canvas)
        {
            return canvas.GetComponentInChildren<ScannerReportPresenter>(true);
        }

        /// <summary>
        /// Works out which way the screen faces and which way is up, from the plate mesh alone.
        /// <list type="number">
        /// <item>The plate is flat, so the axis with the smallest extent is its normal; the mesh's
        /// own normals give that axis its sign.</item>
        /// <item>Of the two remaining axes the plate is wider than it is tall, so the shorter one
        /// is the vertical one.</item>
        /// <item>The object's origin is the centre of the <i>lit</i> area, not of the plate, and
        /// the plate reaches further below the lit area (the button legends) than above it — so on
        /// the vertical axis, the side with the larger extent is down.</item>
        /// </list>
        /// </summary>
        private static void ResolveScreenAxes(Mesh mesh, out Vector3 forward, out Vector3 up)
        {
            Bounds bounds = mesh.bounds;
            Vector3 size = bounds.size;

            int normalAxis = 0;

            for (int i = 1; i < 3; i++)
            {
                if (size[i] < size[normalAxis])
                {
                    normalAxis = i;
                }
            }

            int first = (normalAxis + 1) % 3;
            int second = (normalAxis + 2) % 3;
            int upAxis = size[first] < size[second] ? first : second;

            forward = Axis(normalAxis, 1f);
            Vector3[] normals = mesh.normals;
            float sum = 0f;

            for (int i = 0; i < normals.Length; i++)
            {
                sum += normals[i][normalAxis];
            }

            if (sum < 0f)
            {
                forward = -forward;
            }

            float below = Mathf.Abs(bounds.min[upAxis]);
            float above = Mathf.Abs(bounds.max[upAxis]);
            up = Axis(upAxis, below > above ? 1f : -1f);
        }

        private static Vector3 Axis(int index, float sign)
        {
            Vector3 axis = Vector3.zero;
            axis[index] = sign;

            return axis;
        }
    }
}

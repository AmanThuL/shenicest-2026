// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;

namespace TheVisualEngine
{
    [HelpURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.q4fstlrr3cw4")]
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Visual Engine/TVE Prefab")]
    public class TVEPrefab : StyledMonoBehaviour
    {
#if UNITY_EDITOR
        [HideInInspector]
        public bool lockInAssetConverter;
        [HideInInspector]
        public string storedPrefabBackupGUID = "";
        [HideInInspector]
        public string storedPrefabParentGUID = "";
        [HideInInspector]
        public string storedPreset = "";
        [HideInInspector]
        public string storedOverrides = "";

        [ContextMenu("Lock In Asset Converter")]
        void LockPrefab()
        {
            lockInAssetConverter = true;
        }

        [ContextMenu("Unlock In Asset Converter")]
        void UnlockPrefab()
        {
            lockInAssetConverter = false;
        }
#endif
    }
}





using System.Collections.Generic;
using UnityEngine;

namespace RootsDance.Data
{
    [CreateAssetMenu(fileName = "Level", menuName = "RootsDance/Levels/Level")]
    public class LevelSO : ScriptableObject
    {
        [Tooltip("Full asset paths in load order. The FIRST entry becomes the active scene, so list "
            + "the _Environment (or _Lighting) part first.")]
        [SerializeField] private string[] m_scenePaths;

        public IReadOnlyList<string> ScenePaths => m_scenePaths;
    }
}

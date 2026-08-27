using System.Collections.Generic;
using System.Reflection;
using RootsDance.Core;

namespace RootsDance.Editor.DevPlay
{
    /// <summary>
    /// Every flag id declared on <see cref="WorldFlags"/>, read once by reflection so the checkpoint
    /// Inspector dropdown never drifts from the constants gameplay code actually raises.
    /// </summary>
    public static class WorldFlagCatalog
    {
        private static IReadOnlyList<string> s_all;

        public static IReadOnlyList<string> All
        {
            get
            {
                if (s_all == null)
                {
                    s_all = Collect();
                }

                return s_all;
            }
        }

        private static IReadOnlyList<string> Collect()
        {
            List<string> ids = new List<string>();
            FieldInfo[] fields = typeof(WorldFlags).GetFields(BindingFlags.Public | BindingFlags.Static);

            for (int i = 0; i < fields.Length; i++)
            {
                FieldInfo field = fields[i];

                if (field.IsLiteral && field.FieldType == typeof(string))
                {
                    ids.Add((string)field.GetRawConstantValue());
                }
            }

            ids.Sort(string.CompareOrdinal);
            return ids;
        }
    }
}

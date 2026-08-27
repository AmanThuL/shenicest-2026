using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Editor.DevPlay;

namespace RootsDance.Tests.EditMode.DevPlay
{
    /// <summary>The checkpoint Inspector dropdown must offer every flag the game knows, and nothing else.</summary>
    public class WorldFlagCatalogTests
    {
        [Test]
        public void All_ListsEveryWorldFlagsConstant()
        {
            IReadOnlyList<string> all = WorldFlagCatalog.All;

            CollectionAssert.AreEquivalent(
                new[]
                {
                    WorldFlags.k_LeftStartArea,
                    WorldFlags.k_RadioBriefingStarted,
                    WorldFlags.k_RadioBriefingFinished,
                    WorldFlags.k_HelmetRemovable,
                    WorldFlags.k_HelmetRemoved,
                    WorldFlags.k_EnteredGrassBelt,
                    WorldFlags.k_FirstInvestigationDone,
                },
                all);
        }

        [Test]
        public void All_IsSortedForTheDropdown()
        {
            List<string> sorted = new List<string>(WorldFlagCatalog.All);
            sorted.Sort(string.CompareOrdinal);

            CollectionAssert.AreEqual(sorted, WorldFlagCatalog.All);
        }
    }
}

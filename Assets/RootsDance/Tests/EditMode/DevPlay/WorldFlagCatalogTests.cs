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
                    WorldFlags.k_MainEntranceBlocked,
                    WorldFlags.k_MainEntranceSignRead,
                    WorldFlags.k_ResearchFacilityPosterRead,
                    WorldFlags.k_AshleafVineScanned,
                    WorldFlags.k_FineVeinedVineScanned,
                    WorldFlags.k_VineGrowthDirectionObserved,
                    WorldFlags.k_MaintenanceEntranceRevealed,

                    // Chapter 02.
                    WorldFlags.k_SawUndergroundNetwork,
                    WorldFlags.k_MetFlowerSprite,
                    WorldFlags.k_HeardAboutHer,
                    WorldFlags.k_EnteredGreenhouse,
                    WorldFlags.k_SawStaffPhotograph,
                    WorldFlags.k_CirculationCore,
                    WorldFlags.k_CirculationRing,
                    WorldFlags.k_CirculationOuter,

                    // The chase.
                    WorldFlags.k_ChaseStarted,
                    WorldFlags.k_ChaseEscaped,
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

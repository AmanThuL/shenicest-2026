namespace RootsDance.Editor.DevPlay
{
    /// <summary>
    /// What a checkpoint does to the world's time of day when it is applied. This is not
    /// <see cref="RootsDance.Core.TimeOfDay"/>: it adds the "say nothing" case, and that case is
    /// deliberately value 0 — every checkpoint asset serialized before time of day existed reads back as
    /// <see cref="LevelDefault"/>, which means "leave the level's default alone" and keeps those assets
    /// behaving exactly as they did. <see cref="DevCheckpointSeed"/> maps the other two onto the runtime
    /// enum and emits a <see cref="RootsDance.Core.Commands.SetTimeOfDayCommand"/>.
    /// </summary>
    public enum CheckpointTimeOfDay
    {
        /// <summary>Emit no command; whatever the level seeded (its TimeOfDayController) stays.</summary>
        LevelDefault = 0,

        /// <summary>Force the world into <see cref="RootsDance.Core.TimeOfDay.Day"/>.</summary>
        Day = 1,

        /// <summary>Force the world into <see cref="RootsDance.Core.TimeOfDay.Night"/>.</summary>
        Night = 2
    }
}

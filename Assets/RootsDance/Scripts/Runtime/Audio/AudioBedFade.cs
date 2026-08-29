namespace RootsDance.Audio
{
    /// <summary>
    /// How loud a looping bed is this frame, on its way to where it is going. Pure arithmetic, so
    /// the one rule every bed shares can be tested without a scene or an <c>AudioSource</c>.
    /// <para>
    /// It is a move-towards rather than a tween because a fade is routinely interrupted half-way —
    /// the player steps back over a threshold, the helmet goes back on — and re-targeting a value
    /// is exactly what a move-towards already does, while a tween would have to be killed and
    /// restarted from wherever it had got to.
    /// </para>
    /// </summary>
    public static class AudioBedFade
    {
        /// <summary>
        /// The bed's volume after <paramref name="deltaTime"/>. <paramref name="fullVolume"/> sets
        /// the rate: a fade takes <paramref name="fadeSeconds"/> to cross the bed's whole range,
        /// so a quiet bed does not take longer to come up than a loud one.
        /// </summary>
        public static float Step(float current, float target, float fullVolume, float deltaTime,
            float fadeSeconds)
        {
            // A stopped clock: a paused game holds its beds where they are rather than snapping
            // them to wherever they were headed.
            if (deltaTime <= 0f)
            {
                return current;
            }

            // A zero-length fade, or a bed mixed to silence — where the per-frame step would be 0
            // and the value would sit between the two for ever.
            if (fadeSeconds <= 0f || fullVolume <= 0f)
            {
                return target;
            }

            float step = fullVolume * deltaTime / fadeSeconds;
            float distance = target - current;

            if (distance > step)
            {
                return current + step;
            }

            if (distance < -step)
            {
                return current - step;
            }

            return target;
        }
    }
}

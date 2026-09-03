"""Tests for the Unity log follower and the phase tracker."""
import os
import tempfile
import unittest

import progress


class LogFollowerTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.path = os.path.join(self.tmp.name, "build.log")

    def test_poll_returns_only_new_complete_lines(self):
        follower = progress.LogFollower(self.path)
        self.assertEqual(follower.poll(), [])
        with open(self.path, "w") as handle:
            handle.write("one\ntwo\nthr")
        self.assertEqual(follower.poll(), ["one", "two"])
        with open(self.path, "a") as handle:
            handle.write("ee\n")
        self.assertEqual(follower.poll(), ["three"])
        self.assertEqual(follower.poll(), [])

    def test_poll_survives_truncation(self):
        follower = progress.LogFollower(self.path)
        with open(self.path, "w") as handle:
            handle.write("a long first line\n")
        follower.poll()
        with open(self.path, "w") as handle:
            handle.write("x\n")
        self.assertEqual(follower.poll(), ["x"])

    def test_poll_replaces_undecodable_bytes(self):
        follower = progress.LogFollower(self.path)
        with open(self.path, "wb") as handle:
            handle.write(b"ok \xff\xfe bad\n")
        self.assertEqual(follower.poll(), ["ok �� bad"])

    def test_tail_returns_last_lines_without_reading_whole_file(self):
        with open(self.path, "w") as handle:
            for i in range(1000):
                handle.write("line {0}\n".format(i))
        follower = progress.LogFollower(self.path)
        text = follower.tail(max_bytes=200, lines=3)
        self.assertEqual(text.splitlines(), ["line 997", "line 998", "line 999"])


class FakeClock:
    def __init__(self):
        self.now = 100.0

    def __call__(self):
        return self.now


def make_tracker(clock):
    weights = {"Launching Editor": 10, "Compiling scripts": 10, "Preprocessing": 20,
               "Building scenes": 30, "Packing player data": 100, "Compiling native code": 10,
               "Finishing": 10, "Done": 0}
    return progress.PhaseTracker(weights=weights, clock=clock)


class PhaseTrackerTests(unittest.TestCase):
    def test_starts_in_first_phase_with_zero_percent(self):
        clock = FakeClock()
        tracker = make_tracker(clock)
        self.assertEqual(tracker.current, "Launching Editor")
        self.assertEqual(tracker.percent(), 0.0)

    def test_marker_advances_phase(self):
        clock = FakeClock()
        tracker = make_tracker(clock)
        tracker.feed("[ScriptCompilation] Requested script compilation because: player build")
        self.assertEqual(tracker.current, "Compiling scripts")
        tracker.feed("[BuildScript] build start profile=macOS-Release dev=False")
        self.assertEqual(tracker.current, "Preprocessing")

    def test_marker_can_skip_phases_forward_but_never_back(self):
        clock = FakeClock()
        tracker = make_tracker(clock)
        tracker.feed("[BuildScript] scene 1/16 Assets/RootsDance/Scenes/Bootstrap.unity")
        self.assertEqual(tracker.current, "Building scenes")
        tracker.feed("[ScriptCompilation] Requested script compilation because: late")
        self.assertEqual(tracker.current, "Building scenes")

    def test_strict_markers_only_fire_from_the_previous_phase(self):
        clock = FakeClock()
        tracker = make_tracker(clock)
        # Script compilation also runs bee_backend/Tundra before the player build starts.
        tracker.feed("Starting: /Unity/bee_backend --dagfile=Library/Bee/1.dag")
        tracker.feed("*** Tundra build success (0.37 seconds), 5 items updated")
        self.assertEqual(tracker.current, "Launching Editor")
        tracker.feed("[BuildScript] scenes done")
        tracker.feed("Starting: /Unity/bee_backend --dagfile=Library/Bee/Player.dag")
        self.assertEqual(tracker.current, "Compiling native code")
        tracker.feed("*** Tundra build success (2.65 seconds), 751 items updated")
        self.assertEqual(tracker.current, "Finishing")

    def test_scene_progress_is_captured(self):
        tracker = make_tracker(FakeClock())
        tracker.feed("[BuildScript] scene 9/16 Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity")
        self.assertEqual(tracker.scene, (9, 16))

    def test_percent_uses_weights_and_caps_within_phase(self):
        clock = FakeClock()
        tracker = make_tracker(clock)  # total weight 190
        tracker.feed("[BuildScript] build start profile=macOS-Release dev=False")  # Preprocessing, done=20
        clock.now += 5
        self.assertAlmostEqual(tracker.percent(), 100.0 * 25 / 190, places=3)
        clock.now += 1000
        self.assertAlmostEqual(tracker.percent(), 100.0 * (20 + 19) / 190, places=3)

    def test_percent_is_100_when_done(self):
        tracker = make_tracker(FakeClock())
        tracker.feed("[BuildScript] macOS-Release: result=Succeeded size=1 bytes errors=0 time=00:03:12")
        self.assertEqual(tracker.current, "Done")
        self.assertEqual(tracker.percent(), 100.0)
        self.assertIn("result=Succeeded", tracker.success_marker)

    def test_eta_counts_remaining_weight(self):
        clock = FakeClock()
        tracker = make_tracker(clock)
        tracker.feed("[BuildScript] scenes done")  # Packing, weight 100; remaining after = 20
        clock.now += 40
        self.assertAlmostEqual(tracker.eta_seconds(), 60 + 20)

    def test_eta_is_none_without_weights(self):
        tracker = progress.PhaseTracker(weights={p.name: 0 for p in progress.DEFAULT_PHASES}, clock=FakeClock())
        self.assertIsNone(tracker.eta_seconds())
        self.assertEqual(tracker.percent(), 0.0)

    def test_errors_are_collected(self):
        tracker = make_tracker(FakeClock())
        tracker.feed("Assets/X.cs(3,5): error CS0103: The name 'y' does not exist")
        tracker.feed("UnityEditor.Build.BuildFailedException: Build Failed with 1 error(s).")
        tracker.feed("Aborting batchmode due to failure:")
        tracker.feed("just a normal line")
        self.assertEqual(len(tracker.errors), 3)

    def test_finish_reports_durations_per_phase(self):
        clock = FakeClock()
        tracker = make_tracker(clock)
        clock.now += 8
        tracker.feed("[ScriptCompilation] Requested script compilation because: x")
        clock.now += 4
        tracker.feed("[BuildScript] build start profile=macOS-Release dev=False")
        clock.now += 20
        durations = tracker.finish()
        self.assertEqual(durations["Launching Editor"], 8)
        self.assertEqual(durations["Compiling scripts"], 4)
        self.assertEqual(durations["Preprocessing"], 20)

    def test_timestamp_prefixed_lines_still_match(self):
        tracker = make_tracker(FakeClock())
        tracker.feed("2026-09-03T02:10:33.123Z|0x1f6b0b|[BuildScript] build start profile=macOS-Release dev=False")
        self.assertEqual(tracker.current, "Preprocessing")

    def test_success_marker_pattern_is_profile_specific(self):
        pattern = progress.success_marker_pattern("macOS-Release")
        tracker = make_tracker(FakeClock())
        tracker.feed("[BuildScript] Windows-Release: result=Succeeded size=1 bytes errors=0 time=0")
        self.assertIsNotNone(tracker.success_marker)
        import re
        self.assertIsNone(re.search(pattern, tracker.success_marker))


if __name__ == "__main__":
    unittest.main()

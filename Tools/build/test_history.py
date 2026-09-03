"""Tests for build timings/report history and delta computation."""
import json
import os
import tempfile
import unittest

import history


def report(total, by_type, assets):
    return {
        "result": "Succeeded", "totalSeconds": 10.0, "totalBytes": total, "outputPath": "x",
        "warnings": 0, "errors": 0, "steps": [],
        "byType": [{"type": t, "bytes": b, "count": 1} for t, b in by_type],
        "topAssets": [{"path": p, "type": "Mesh", "bytes": b} for p, b in assets],
        "files": [],
    }


class HistoryFileTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.repo = self.tmp.name

    def test_timings_round_trip(self):
        self.assertEqual(history.load_timings(self.repo, "macOS-Release"), {})
        history.save_timings(self.repo, "macOS-Release", {"Packing player data": 134.8})
        self.assertEqual(history.load_timings(self.repo, "macOS-Release"), {"Packing player data": 134.8})
        self.assertTrue(os.path.exists(os.path.join(self.repo, "Builds", ".history", "macOS-Release", "timings.json")))

    def test_save_timings_with_unwritable_dir_returns_false(self):
        # Put a regular file where the history dir needs to be, so os.makedirs fails.
        blocker = os.path.join(self.repo, "Builds", ".history")
        os.makedirs(os.path.dirname(blocker))
        with open(blocker, "w") as handle:
            handle.write("not a directory")
        self.assertFalse(history.save_timings(self.repo, "macOS-Release", {"x": 1.0}))

    def test_corrupt_timings_are_ignored(self):
        path = os.path.join(history.history_dir(self.repo, "p"), "timings.json")
        os.makedirs(os.path.dirname(path))
        with open(path, "w") as handle:
            handle.write("{not json")
        self.assertEqual(history.load_timings(self.repo, "p"), {})

    def test_archive_then_load_previous_report(self):
        src = os.path.join(self.repo, "build-report.json")
        with open(src, "w") as handle:
            json.dump(report(5, [], []), handle)
        self.assertIsNone(history.load_previous_report(self.repo, "p"))
        self.assertTrue(history.archive_report(self.repo, "p", src))
        self.assertEqual(history.load_previous_report(self.repo, "p")["totalBytes"], 5)

    def test_archive_report_with_missing_source_returns_false_and_does_not_raise(self):
        missing = os.path.join(self.repo, "does-not-exist.json")
        self.assertFalse(history.archive_report(self.repo, "p", missing))
        self.assertIsNone(history.load_previous_report(self.repo, "p"))

    def test_load_report_returns_none_for_missing_or_invalid(self):
        self.assertIsNone(history.load_report(os.path.join(self.repo, "nope.json")))
        bad = os.path.join(self.repo, "bad.json")
        with open(bad, "w") as handle:
            handle.write("[]")
        self.assertIsNone(history.load_report(bad))


class DeltaTests(unittest.TestCase):
    def test_delta_by_type_and_assets(self):
        previous = report(1000, [("Mesh", 800), ("Texture2D", 200)],
                          [("A.fbx", 500), ("B.png", 100), ("Gone.fbx", 50)])
        current = report(700, [("Mesh", 400), ("Texture2D", 250), ("AudioClip", 50)],
                         [("A.fbx", 200), ("B.png", 100), ("New.wav", 50)])
        delta = history.report_delta(previous, current)
        self.assertEqual(delta["total_before"], 1000)
        self.assertEqual(delta["total_after"], 700)
        self.assertEqual(delta["by_type"], [("Mesh", 800, 400), ("Texture2D", 200, 250), ("AudioClip", 0, 50)])
        self.assertEqual(delta["assets"][0], ("A.fbx", 500, 200))
        self.assertIn(("Gone.fbx", 50, 0), delta["assets"])
        self.assertIn(("New.wav", 0, 50), delta["assets"])
        self.assertNotIn(("B.png", 100, 100), delta["assets"])

    def test_delta_without_previous(self):
        current = report(700, [("Mesh", 400)], [("A.fbx", 200)])
        delta = history.report_delta(None, current)
        self.assertEqual(delta["total_before"], 0)
        self.assertEqual(delta["by_type"], [("Mesh", 0, 400)])
        self.assertEqual(delta["assets"], [("A.fbx", 0, 200)])


if __name__ == "__main__":
    unittest.main()

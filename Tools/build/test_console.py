"""Tests for the terminal output helpers."""
import io
import os
import sys
import unittest
from unittest import mock

import console


class FakeTty(io.StringIO):
    def isatty(self):
        return True


class ConsoleColorTests(unittest.TestCase):
    def test_non_tty_stream_has_no_escape_codes(self):
        out = io.StringIO()
        con = console.Console(stream=out)
        con.ok("done")
        self.assertEqual(out.getvalue(), "done\n")

    def test_tty_stream_gets_escape_codes(self):
        out = FakeTty()
        with mock.patch.dict(os.environ, {}, clear=True):
            con = console.Console(stream=out)
        con.ok("done")
        self.assertIn("\x1b[", out.getvalue())
        self.assertIn("done", out.getvalue())

    def test_no_color_env_disables_color_on_tty(self):
        out = FakeTty()
        with mock.patch.dict(os.environ, {"NO_COLOR": "1"}):
            con = console.Console(stream=out)
        con.error("bad")
        self.assertEqual(out.getvalue(), "bad\n")

    def test_no_color_env_set_to_empty_string_disables_color(self):
        out = FakeTty()
        with mock.patch.dict(os.environ, {"NO_COLOR": ""}):
            con = console.Console(stream=out)
        con.error("bad")
        self.assertEqual(out.getvalue(), "bad\n")

    def test_explicit_color_false_wins(self):
        out = FakeTty()
        con = console.Console(stream=out, color=False)
        con.header("Build")
        self.assertEqual(out.getvalue(), "Build\n")


class ErrorStreamTests(unittest.TestCase):
    def test_errors_and_warnings_go_to_the_error_stream_only(self):
        out, err = io.StringIO(), io.StringIO()
        con = console.Console(stream=out, error_stream=err, color=False)
        con.info("progress")
        con.error("x")
        con.warn("careful")
        self.assertEqual(out.getvalue(), "progress\n")
        self.assertEqual(err.getvalue(), "x\ncareful\n")

    def test_a_single_stream_still_captures_everything(self):
        out = io.StringIO()
        con = console.Console(stream=out, color=False)
        con.info("progress")
        con.error("x")
        self.assertEqual(out.getvalue(), "progress\nx\n")

    def test_default_error_stream_is_stderr(self):
        self.assertIs(console.Console().error_stream, sys.stderr)

    def test_an_error_closes_an_open_status_line_on_the_status_stream(self):
        out, err = FakeTty(), io.StringIO()
        con = console.Console(stream=out, error_stream=err, color=False, interactive=True)
        con.status("working")
        con.error("boom")
        self.assertEqual(out.getvalue(), "\rworking\n")
        self.assertEqual(err.getvalue(), "boom\n")


class StatusLineTests(unittest.TestCase):
    def test_status_is_silent_when_not_interactive(self):
        out = io.StringIO()
        con = console.Console(stream=out, interactive=False)
        con.status("50%")
        self.assertEqual(out.getvalue(), "")

    def test_status_overwrites_previous_line_and_pads(self):
        out = FakeTty()
        con = console.Console(stream=out, color=False, interactive=True)
        con.status("phase A 10%")
        con.status("B 20%")
        self.assertEqual(out.getvalue(), "\rphase A 10%\rB 20%      ")

    def test_println_ends_an_open_status_line(self):
        out = FakeTty()
        con = console.Console(stream=out, color=False, interactive=True)
        con.status("working")
        con.println("finished")
        self.assertEqual(out.getvalue(), "\rworking\nfinished\n")


class TableTests(unittest.TestCase):
    def test_table_aligns_columns(self):
        out = io.StringIO()
        con = console.Console(stream=out, color=False)
        con.table(["name", "MB"], [["Mesh", "1840.9"], ["Texture2D", "632.3"]], align="lr")
        self.assertEqual(out.getvalue(),
                         "name           MB\n"
                         "Mesh       1840.9\n"
                         "Texture2D   632.3\n")


class FormatTests(unittest.TestCase):
    def test_fmt_duration(self):
        self.assertEqual(console.fmt_duration(4), "4s")
        self.assertEqual(console.fmt_duration(65), "1m 05s")
        self.assertEqual(console.fmt_duration(3725), "1h 02m 05s")

    def test_fmt_bytes(self):
        self.assertEqual(console.fmt_bytes(512), "512 B")
        self.assertEqual(console.fmt_bytes(5 * 1024 * 1024), "5.0 MB")
        self.assertEqual(console.fmt_bytes(int(2.5 * 1024 ** 3)), "2.50 GB")

    def test_bar(self):
        self.assertEqual(console.bar(0.5, width=4), "[##--]")
        self.assertEqual(console.bar(1.2, width=4), "[####]")
        self.assertEqual(console.bar(-1, width=4), "[----]")


if __name__ == "__main__":
    unittest.main()

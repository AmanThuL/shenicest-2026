"""Terminal output for build.py: colours when it is safe, an in-place status line, tables.

Colour is on only when the stream is a TTY and NO_COLOR is unset (https://no-color.org).
The status line is used only on a TTY; a CI log gets one printed line per phase instead.
Warnings and errors go to `error_stream` (stderr by default) so a caller piping stdout to a
file or another process still sees them; everything else goes to `stream`.
"""
import os
import platform
import sys

_CODES = {
    "header": "1;36",
    "ok": "32",
    "warn": "33",
    "error": "1;31",
    "dim": "2",
    "phase": "36",
}


def _enable_windows_vt():
    if platform.system() == "Windows":
        # Enables ANSI processing in the classic console; a no-op elsewhere.
        os.system("")


class Console:
    def __init__(self, stream=None, color=None, interactive=None, error_stream=None):
        self.stream = stream if stream is not None else sys.stdout
        # A caller that passed only `stream` wants everything in that one stream (tests capture
        # a single buffer that way); only the default, or an explicit error_stream, splits them.
        if error_stream is not None:
            self.error_stream = error_stream
        elif stream is not None:
            self.error_stream = stream
        else:
            self.error_stream = sys.stderr
        is_tty = bool(getattr(self.stream, "isatty", lambda: False)())
        if color is None:
            color = is_tty and "NO_COLOR" not in os.environ
        self.color = bool(color)
        self.interactive = is_tty if interactive is None else bool(interactive)
        self._status_len = 0
        if self.color:
            _enable_windows_vt()

    def paint(self, style, text):
        if not self.color:
            return text
        return "\x1b[{0}m{1}\x1b[0m".format(_CODES[style], text)

    def dim(self, text):
        return self.paint("dim", text)

    def header(self, text):
        self.println(self.paint("header", text))

    def info(self, text):
        self.println(text)

    def ok(self, text):
        self.println(self.paint("ok", text))

    def warn(self, text):
        self._println_to(self.error_stream, self.paint("warn", text))

    def error(self, text):
        self._println_to(self.error_stream, self.paint("error", text))

    def status(self, text):
        """Overwrite the current terminal line. Silent when not interactive."""
        if not self.interactive:
            return
        padding = " " * max(0, self._status_len - len(text))
        self.stream.write("\r" + text + padding)
        self.stream.flush()
        self._status_len = len(text)

    def end_status(self):
        if self.interactive and self._status_len:
            self.stream.write("\n")
            self.stream.flush()
        self._status_len = 0

    def println(self, text=""):
        self._println_to(self.stream, text)

    def _println_to(self, stream, text):
        # The status line always lives on self.stream, so close it there first whichever
        # stream this line is going to; otherwise a warning lands mid-status-line.
        self.end_status()
        stream.write(text + "\n")
        stream.flush()

    def table(self, headers, rows, align=None):
        """Print aligned columns. align is one 'l'/'r' per column, default left."""
        columns = len(headers)
        align = (align or "l" * columns).ljust(columns, "l")
        cells = [[str(cell) for cell in row] for row in rows]
        widths = [len(str(headers[i])) for i in range(columns)]
        for row in cells:
            for i, cell in enumerate(row):
                widths[i] = max(widths[i], len(cell))

        def render(row):
            parts = []
            for i, cell in enumerate(row):
                parts.append(cell.rjust(widths[i]) if align[i] == "r" else cell.ljust(widths[i]))
            return "  ".join(parts)

        self.println(render([str(h) for h in headers]))
        for row in cells:
            self.println(render(row))


def fmt_duration(seconds):
    total = int(round(seconds))
    hours, rest = divmod(total, 3600)
    minutes, secs = divmod(rest, 60)
    if hours:
        return "{0}h {1:02d}m {2:02d}s".format(hours, minutes, secs)
    if minutes:
        return "{0}m {1:02d}s".format(minutes, secs)
    return "{0}s".format(secs)


def fmt_bytes(count):
    count = float(count)
    if count >= 1024 ** 3:
        return "{0:.2f} GB".format(count / 1024 ** 3)
    if count >= 1024 ** 2:
        return "{0:.1f} MB".format(count / 1024 ** 2)
    if count >= 1024:
        return "{0:.0f} KB".format(count / 1024)
    return "{0:.0f} B".format(count)


def bar(fraction, width=20):
    fraction = min(1.0, max(0.0, float(fraction)))
    filled = int(round(fraction * width))
    return "[" + "#" * filled + "-" * (width - filled) + "]"

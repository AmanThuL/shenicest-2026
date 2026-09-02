"""Follow a Unity batch-build log and turn known marker lines into phase progress.

Markers are searched (not anchored) so a -timestamps prefix or a thread id never hides them.
Phases whose marker also appears earlier in a build (bee_backend / Tundra run for script
compilation too) are `strict`: they only fire when the tracker is in the immediately
preceding phase.
"""
import collections
import os
import re
import time

Phase = collections.namedtuple("Phase", "name marker weight strict")

# Default weights are the seconds measured on the 2026-08-30 macOS-Release run.
DEFAULT_PHASES = [
    Phase("Launching Editor", None, 8, False),
    Phase("Compiling scripts", r"\[ScriptCompilation\] Requested script compilation", 5, False),
    Phase("Preprocessing", r"\[BuildScript\] build start", 20, False),
    Phase("Building scenes", r"\[BuildScript\] scene 1/", 30, False),
    Phase("Packing player data", r"\[BuildScript\] scenes done", 135, False),
    Phase("Compiling native code", r"bee_backend", 5, True),
    Phase("Finishing", r"Tundra build success", 5, True),
    Phase("Done", r"\[BuildScript\] \S+: result=", 0, False),
]

ERROR_PATTERNS = [
    r"error CS\d+",
    r"BuildFailedException",
    r"Error building Player",
    r"Aborting batchmode",
    r"\[BuildScript\] \S+: result=(Failed|Cancelled|Unknown)",
]

SCENE_PROGRESS = re.compile(r"\[BuildScript\] scene (\d+)/(\d+)")
SUCCESS_MARKER = re.compile(r"\[BuildScript\] \S+: result=Succeeded")


def success_marker_pattern(profile):
    return r"\[BuildScript\] {0}: result=Succeeded".format(re.escape(profile))


class LogFollower:
    """Incrementally reads complete lines from a file that another process appends to."""

    def __init__(self, path):
        self.path = path
        self._offset = 0
        self._partial = b""

    def poll(self):
        try:
            size = os.path.getsize(self.path)
        except OSError:
            return []
        if size < self._offset:
            # Truncated or recreated: start over.
            self._offset = 0
            self._partial = b""
        if size == self._offset:
            return []
        with open(self.path, "rb") as handle:
            handle.seek(self._offset)
            chunk = handle.read(size - self._offset)
        self._offset = size
        data = self._partial + chunk
        pieces = data.split(b"\n")
        self._partial = pieces.pop()
        return [piece.decode("utf-8", errors="replace").rstrip("\r") for piece in pieces]

    def tail(self, max_bytes=65536, lines=40):
        try:
            with open(self.path, "rb") as handle:
                handle.seek(0, os.SEEK_END)
                size = handle.tell()
                handle.seek(max(0, size - max_bytes))
                data = handle.read()
        except OSError:
            return "(no log at {0})".format(self.path)
        text = data.decode("utf-8", errors="replace")
        return "\n".join(text.splitlines()[-lines:])


class PhaseTracker:
    def __init__(self, phases=None, weights=None, clock=time.monotonic):
        self.phases = list(phases or DEFAULT_PHASES)
        self._clock = clock
        overrides = weights or {}
        self.weights = [float(overrides.get(p.name, p.weight)) for p in self.phases]
        self.index = 0
        self._started = [None] * len(self.phases)
        self._started[0] = clock()
        self._origin = self._started[0]
        self.durations = {}
        self.scene = None
        self.errors = []
        self.success_marker = None

    @property
    def current(self):
        return self.phases[self.index].name

    def feed_lines(self, lines):
        for line in lines:
            self.feed(line)

    def feed(self, line):
        for i in range(self.index + 1, len(self.phases)):
            phase = self.phases[i]
            if phase.marker is None or not re.search(phase.marker, line):
                continue
            if phase.strict and i != self.index + 1:
                continue
            self._advance_to(i)
            break

        match = SCENE_PROGRESS.search(line)
        if match:
            self.scene = (int(match.group(1)), int(match.group(2)))

        for pattern in ERROR_PATTERNS:
            if re.search(pattern, line):
                self.errors.append(line.strip())
                break

        if SUCCESS_MARKER.search(line):
            self.success_marker = line.strip()

    def _advance_to(self, target):
        now = self._clock()
        for j in range(self.index, target):
            start = self._started[j] if self._started[j] is not None else now
            self.durations[self.phases[j].name] = now - start
        self.index = target
        self._started[target] = now

    def elapsed(self):
        return self._clock() - self._origin

    def _elapsed_in_phase(self):
        start = self._started[self.index]
        return 0.0 if start is None else self._clock() - start

    def percent(self):
        total = sum(self.weights)
        if self.index == len(self.phases) - 1:
            return 100.0
        if total <= 0:
            return 0.0
        done = sum(self.weights[:self.index])
        weight = self.weights[self.index]
        within = min(self._elapsed_in_phase(), 0.95 * weight) if weight > 0 else 0.0
        return 100.0 * (done + within) / total

    def eta_seconds(self):
        if sum(self.weights) <= 0:
            return None
        remaining_here = max(0.0, self.weights[self.index] - self._elapsed_in_phase())
        return remaining_here + sum(self.weights[self.index + 1:])

    def finish(self):
        now = self._clock()
        start = self._started[self.index]
        self.durations[self.current] = 0.0 if start is None else now - start
        return dict(self.durations)

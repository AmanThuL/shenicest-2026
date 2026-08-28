"""Machine-checkable stage reports.

Every stage produces one Report.  A Report is written twice:

* to stdout as a human-readable block, for the person watching;
* to a JSON file, which is the thing CI / the next stage / an agent reads.

Verification is filesystem + JSON, never screenshots.  Screenshots are allowed
as optional human-readable evidence attached to a Report, never as the check.

Severity contract (this is what "fail loudly" means here):

    ERROR  -- the stage did not achieve its stated output, or the asset
              violates a hard rule.  Exit code 1.  Never auto-fixed.
    WARN   -- something a human should look at; the stage still produced its
              output.  Exit code 0.
    INFO   -- measurements worth recording (counts, densities, sizes).
"""

import json
import os
import sys
import hashlib

ERROR = "ERROR"
WARN = "WARN"
INFO = "INFO"

_ORDER = {ERROR: 0, WARN: 1, INFO: 2}


class Finding(object):
    __slots__ = ("severity", "code", "subject", "message", "data")

    def __init__(self, severity, code, subject, message, data=None):
        self.severity = severity
        self.code = code          # stable machine id, e.g. "uv.missing"
        self.subject = subject    # what it is about, e.g. "Helmet_Placeholder"
        self.message = message    # one human sentence
        self.data = data or {}    # numbers a machine may want

    def as_dict(self):
        return {
            "severity": self.severity,
            "code": self.code,
            "subject": self.subject,
            "message": self.message,
            "data": self.data,
        }


class Report(object):
    def __init__(self, stage, asset=None, inputs=None):
        self.stage = stage
        self.asset = asset
        self.inputs = inputs or {}
        self.outputs = {}
        self.findings = []

    # -- recording -------------------------------------------------------
    def error(self, code, subject, message, **data):
        self.findings.append(Finding(ERROR, code, subject, message, data))

    def warn(self, code, subject, message, **data):
        self.findings.append(Finding(WARN, code, subject, message, data))

    def info(self, code, subject, message, **data):
        self.findings.append(Finding(INFO, code, subject, message, data))

    def output(self, key, path):
        """Record a produced file and hash it, so a later stage can tell
        whether it is looking at the same bytes it was handed."""
        rec = {"path": path, "exists": os.path.isfile(path)}
        if rec["exists"]:
            rec["bytes"] = os.path.getsize(path)
            h = hashlib.sha256()
            with open(path, "rb") as fh:
                for chunk in iter(lambda: fh.read(1 << 20), b""):
                    h.update(chunk)
            rec["sha256"] = h.hexdigest()
        else:
            self.error(
                "output.missing", key,
                "stage claims to have written %s but the file is not there" % path,
                path=path,
            )
        self.outputs[key] = rec
        return rec

    # -- querying --------------------------------------------------------
    @property
    def errors(self):
        return [f for f in self.findings if f.severity == ERROR]

    @property
    def ok(self):
        return not self.errors

    def counts(self):
        c = {ERROR: 0, WARN: 0, INFO: 0}
        for f in self.findings:
            c[f.severity] += 1
        return c

    # -- emitting --------------------------------------------------------
    def as_dict(self):
        return {
            "stage": self.stage,
            "asset": self.asset,
            "ok": self.ok,
            "counts": self.counts(),
            "inputs": self.inputs,
            "outputs": self.outputs,
            "findings": [f.as_dict() for f in
                         sorted(self.findings, key=lambda f: _ORDER[f.severity])],
        }

    def to_json(self, path):
        d = os.path.dirname(os.path.abspath(path))
        if d and not os.path.isdir(d):
            os.makedirs(d)
        with open(path, "w") as fh:
            json.dump(self.as_dict(), fh, indent=2, sort_keys=True)
            fh.write("\n")
        return path

    def to_text(self):
        c = self.counts()
        lines = []
        lines.append("=" * 72)
        lines.append("stage: %s   asset: %s   -> %s"
                     % (self.stage, self.asset, "OK" if self.ok else "FAILED"))
        lines.append("%d error / %d warn / %d info"
                     % (c[ERROR], c[WARN], c[INFO]))
        lines.append("=" * 72)
        for f in sorted(self.findings, key=lambda f: _ORDER[f.severity]):
            lines.append("[%-5s] %-28s %s" % (f.severity, f.code, f.subject))
            lines.append("         %s" % f.message)
        for key, rec in sorted(self.outputs.items()):
            lines.append("[out  ] %-28s %s (%s bytes)"
                         % (key, rec["path"], rec.get("bytes", "MISSING")))
        return "\n".join(lines)

    def emit(self, json_path=None, exit_on_error=False):
        """Print the human block, write the JSON, optionally exit non-zero."""
        sys.stdout.write(self.to_text() + "\n")
        sys.stdout.flush()
        if json_path:
            self.to_json(json_path)
            sys.stdout.write("report written: %s\n" % json_path)
        if exit_on_error and not self.ok:
            sys.exit(1)
        return self.ok

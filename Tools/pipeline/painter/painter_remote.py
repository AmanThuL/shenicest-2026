"""Drive Substance 3D Painter over its remote-scripting HTTP server.

No GUI automation: this speaks to the JSON server Painter starts when it is
launched with --enable-remote-scripting, and every call is an ordinary HTTP
request whose result comes back as JSON.

Protocol
--------
The server is NOT described in the Python or JavaScript reference bundled with
Painter; the details below were established by probing a running 12.1.2 build
(2026-08-26) and are re-checked by ``painter_probe.py`` on every run.

    POST http://<host>:<port>/run.json
    Content-Type: application/json
    {"python": "<base64 of one Python expression>"}
    {"js":     "<base64 of JavaScript>"}

Three things are easy to get wrong and cost an afternoon each:

1. **The payload is base64.** Send the script as plain text and the server
   base64-*decodes* it anyway, so ``alg`` arrives as ``jX`` and you get a
   baffling ``ReferenceError: jX is not defined``.
2. **The Python channel evaluates a single expression**, like ``eval``. A
   multi-statement script still *runs*, but returns ``null``. To run real code
   and get a value back, use :func:`run_python`, which wraps the script in
   ``exec(...)`` and hands back whatever the script puts in ``RESULT``.
3. **Content-Type must be application/json.** Anything else is a bare 415.

Requires Painter started as::

    "<Painter>.app/Contents/MacOS/Adobe Substance 3D Painter" --enable-remote-scripting

Standard library only.
"""

import base64
import json
import socket
import urllib.error
import urllib.request

DEFAULT_HOST = "127.0.0.1"

# Painter's built-in default; it reports "jsonServerPort: 60041" at startup.
DEFAULT_PORT = 60041

DEFAULT_TIMEOUT = 60.0


class PainterError(RuntimeError):
    """Painter reached, but the script it ran failed."""


class PainterUnavailable(RuntimeError):
    """Painter's remote-scripting server could not be reached at all."""


class PainterRemote:
    """A connection to one running Painter instance."""

    def __init__(self, host=DEFAULT_HOST, port=DEFAULT_PORT, timeout=DEFAULT_TIMEOUT):
        self.host = host
        self.port = port
        self.timeout = timeout

    @property
    def url(self):
        return "http://{}:{}/run.json".format(self.host, self.port)

    # -- transport ---------------------------------------------------------

    def _post(self, language, source, timeout=None):
        payload = json.dumps(
            {language: base64.b64encode(source.encode("utf-8")).decode("ascii")}
        ).encode("utf-8")

        request = urllib.request.Request(
            self.url,
            data=payload,
            headers={"Content-Type": "application/json"},
        )

        try:
            with urllib.request.urlopen(
                request, timeout=timeout or self.timeout
            ) as response:
                body = response.read().decode("utf-8")
        except urllib.error.HTTPError as error:
            # 415 means the Content-Type was wrong; 404 means the route moved.
            raise PainterUnavailable(
                "{} returned HTTP {} — is this really Painter's JSON server?".format(
                    self.url, error.code
                )
            ) from error
        except (urllib.error.URLError, socket.timeout, OSError) as error:
            raise PainterUnavailable(
                "cannot reach Painter at {}: {}. Start Painter with "
                "--enable-remote-scripting.".format(self.url, error)
            ) from error

        if not body.strip():
            return None

        try:
            result = json.loads(body)
        except ValueError:
            return body

        if isinstance(result, dict) and "error" in result:
            error = result["error"]
            description = (
                error.get("description") if isinstance(error, dict) else str(error)
            )
            raise PainterError(description)

        return result

    # -- public API --------------------------------------------------------

    def is_available(self):
        """True when the server answers. Never raises."""
        try:
            return self._post("python", "1", timeout=5) == 1
        except (PainterUnavailable, PainterError):
            return False

    def eval_python(self, expression, timeout=None):
        """Evaluate ONE Python expression and return its value."""
        return self._post("python", expression, timeout=timeout)

    def run_js(self, source, timeout=None):
        """Evaluate JavaScript (the ``alg`` API) and return its value."""
        return self._post("js", source, timeout=timeout)

    def run_python(self, script, timeout=None):
        """Run a multi-statement Python script inside Painter.

        The script runs with ``exec``. To return something, assign it to
        ``RESULT``; it comes back parsed from JSON when it is a JSON string,
        and as-is otherwise. Errors inside the script propagate as
        :class:`PainterError` with the traceback, rather than the bare
        ``null`` the raw channel would give.
        """
        wrapper = (
            "exec(compile({script!r}, '<rd-pipeline>', 'exec'), globals()) "
            "or globals().pop('RESULT', None)"
        ).format(script=_PREAMBLE + script)

        try:
            result = self._post("python", wrapper, timeout=timeout)
        except PainterError:
            raise
        except PainterUnavailable:
            raise

        if isinstance(result, str):
            # Scripts that hand back json.dumps(...) get parsed here so callers
            # do not each repeat it; plain strings pass through unchanged.
            try:
                return json.loads(result)
            except ValueError:
                return result

        return result

    def version(self):
        """Painter's version string, e.g. "12.1.2"."""
        return self.eval_python(
            "__import__('substance_painter.application', "
            "fromlist=['x']).version()"
        )


# Scripts run through run_python() get their exceptions turned into a real
# error instead of a silent null, which is otherwise indistinguishable from
# "the script returned nothing".
_PREAMBLE = (
    "import traceback as _rd_tb\n"
    "def _rd_fail(exc):\n"
    "    raise RuntimeError(''.join(_rd_tb.format_exception("
    "type(exc), exc, exc.__traceback__)))\n"
)


def connect(host=DEFAULT_HOST, port=DEFAULT_PORT, timeout=DEFAULT_TIMEOUT, required=True):
    """Return a :class:`PainterRemote`, failing loudly when Painter is absent."""
    remote = PainterRemote(host=host, port=port, timeout=timeout)

    if required and not remote.is_available():
        raise PainterUnavailable(
            "No Substance Painter remote-scripting server on {}:{}.\n"
            "Start Painter with:\n"
            '  "<Painter install>/Adobe Substance 3D Painter.app/Contents/MacOS/'
            'Adobe Substance 3D Painter" --enable-remote-scripting'.format(host, port)
        )

    return remote


if __name__ == "__main__":
    painter = connect()
    print("Substance 3D Painter {} reachable at {}".format(painter.version(), painter.url))

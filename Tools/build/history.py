"""Per-profile build history under Builds/.history/<profile>/: phase timings (ETA weights)
and the previous build-report.json (size deltas). Everything here is best-effort — a
missing or corrupt file never fails a build."""
import json
import os
import shutil

TIMINGS_FILE = "timings.json"
PREVIOUS_REPORT_FILE = "previous-report.json"


def history_dir(repo, profile):
    return os.path.join(repo, "Builds", ".history", profile)


def _read_json(path):
    try:
        with open(path, encoding="utf-8") as handle:
            return json.load(handle)
    except (OSError, ValueError):
        return None


def load_timings(repo, profile):
    data = _read_json(os.path.join(history_dir(repo, profile), TIMINGS_FILE))
    if not isinstance(data, dict):
        return {}
    return {str(k): float(v) for k, v in data.items() if isinstance(v, (int, float))}


def save_timings(repo, profile, durations):
    """Best-effort like every other write here: an unwritable history dir never fails a build."""
    try:
        folder = history_dir(repo, profile)
        os.makedirs(folder, exist_ok=True)
        with open(os.path.join(folder, TIMINGS_FILE), "w", encoding="utf-8") as handle:
            json.dump(durations, handle, indent=2)
            handle.write("\n")
        return True
    except OSError:
        return False


def load_report(path):
    data = _read_json(path)
    if not isinstance(data, dict) or not isinstance(data.get("byType"), list):
        return None
    return data


def load_report_any(path):
    """Read any JSON object report (e.g. the asset audit), without build-report shape checks."""
    data = _read_json(path)
    return data if isinstance(data, dict) else None


def load_previous_report(repo, profile):
    return load_report(os.path.join(history_dir(repo, profile), PREVIOUS_REPORT_FILE))


def archive_report(repo, profile, report_path):
    try:
        folder = history_dir(repo, profile)
        os.makedirs(folder, exist_ok=True)
        shutil.copyfile(report_path, os.path.join(folder, PREVIOUS_REPORT_FILE))
        return True
    except OSError:
        return False


def _bytes_by(entries, key):
    result = {}
    for entry in entries or []:
        name = entry.get(key)
        if isinstance(name, str):
            result[name] = result.get(name, 0) + int(entry.get("bytes", 0))
    return result


def report_delta(previous, current, max_assets=10):
    prev_types = _bytes_by((previous or {}).get("byType"), "type")
    cur_types = _bytes_by(current.get("byType"), "type")
    by_type = []
    for name in list(cur_types) + [n for n in prev_types if n not in cur_types]:
        by_type.append((name, prev_types.get(name, 0), cur_types.get(name, 0)))

    prev_assets = _bytes_by((previous or {}).get("topAssets"), "path")
    cur_assets = _bytes_by(current.get("topAssets"), "path")
    assets = []
    for path in set(prev_assets) | set(cur_assets):
        before, after = prev_assets.get(path, 0), cur_assets.get(path, 0)
        if before != after:
            assets.append((path, before, after))
    assets.sort(key=lambda row: (-abs(row[2] - row[1]), row[0]))

    return {
        "total_before": int((previous or {}).get("totalBytes", 0)),
        "total_after": int(current.get("totalBytes", 0)),
        "by_type": by_type,
        "assets": assets[:max_assets],
    }

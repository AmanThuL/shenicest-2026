"""Tests for the build zip naming convention."""
import unittest

from naming import (BASE_NAME, PLATFORM_BY_PROFILE, parse_bundle_version,
                    platform_for_profile, zip_stem)


class ZipStemTests(unittest.TestCase):
    def test_plain_release_uses_all_five_fields(self):
        self.assertEqual(
            zip_stem("macOS", "0.1.0", "20260828", "fb56640", dirty=False, dev=False),
            "RootsDance_macOS_v0.1.0_20260828_fb56640")

    def test_dirty_tree_appends_dirty(self):
        self.assertEqual(
            zip_stem("macOS", "0.1.0", "20260828", "fb56640", dirty=True, dev=False),
            "RootsDance_macOS_v0.1.0_20260828_fb56640-dirty")

    def test_dev_build_appends_dev(self):
        self.assertEqual(
            zip_stem("Windows", "0.1.0", "20260828", "fb56640", dirty=False, dev=True),
            "RootsDance_Windows_v0.1.0_20260828_fb56640-dev")

    def test_dirty_dev_appends_both_dirty_first(self):
        self.assertEqual(
            zip_stem("macOS", "1.2.3", "20261231", "abc1234", dirty=True, dev=True),
            "RootsDance_macOS_v1.2.3_20261231_abc1234-dirty-dev")

    def test_base_name_is_not_the_temp_product_name(self):
        self.assertEqual(BASE_NAME, "RootsDance")


class PlatformForProfileTests(unittest.TestCase):
    def test_macos_release_maps_to_macos(self):
        self.assertEqual(platform_for_profile("macOS-Release"), "macOS")

    def test_windows_release_maps_to_windows(self):
        self.assertEqual(platform_for_profile("Windows-Release"), "Windows")

    def test_unknown_profile_raises_listing_known_profiles(self):
        with self.assertRaises(ValueError) as ctx:
            platform_for_profile("Linux-Release")
        self.assertIn("macOS-Release", str(ctx.exception))

    def test_every_known_profile_has_a_platform(self):
        for profile in PLATFORM_BY_PROFILE:
            self.assertTrue(platform_for_profile(profile))


class ParseBundleVersionTests(unittest.TestCase):
    def test_reads_bundle_version_from_project_settings_text(self):
        text = "PlayerSettings:\n  productName: she-nicest-temp-proj\n  bundleVersion: 0.1.0\n  foo: 1\n"
        self.assertEqual(parse_bundle_version(text), "0.1.0")

    def test_reads_multi_segment_version(self):
        self.assertEqual(parse_bundle_version("  bundleVersion: 1.2.3-rc1\n"), "1.2.3-rc1")

    def test_missing_bundle_version_raises(self):
        with self.assertRaises(ValueError):
            parse_bundle_version("PlayerSettings:\n  productName: x\n")


if __name__ == "__main__":
    unittest.main()

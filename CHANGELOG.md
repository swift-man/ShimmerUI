# CHANGELOG

All notable changes to ShimmerUI are documented in this file.

## Unreleased

### Changed
- Improved CI platform build log visibility by allowing `xcodebuild` to emit full diagnostics.

## [1.1.0] - 2026-07-08

### Added
- Added internal rendering regression coverage for the default gradient profile and representative shimmer band sizes.
- Added collapsed-size shimmer band geometry coverage.
- Added GitHub Actions Swift Package CI for pull requests and `main` pushes.
- Added CI platform build verification for iOS and tvOS.

### Changed
- Increased the default `bandWidthRatio` to `4.0` for a stronger AI loading shimmer.
- Made the shimmer highlight band more visible by adding softer shoulder stops around the center highlight.
- Centralized internal shimmer band geometry sizing from view size.

### Fixed
- Preserved the highlight color hue for fully transparent shimmer gradient stops.
- Kept large finite shimmer geometry sizes from falling back to the minimum diagonal.

## [1.0.0] - 2026-06-28

### Added
- Added SwiftUI shimmer text and placeholder components through `ShimmerText` and `ShimmerLoadingUI`.
- Added reusable loading placeholders including `Block`, `Multiline`, `ListPlaceholder`, `ScreenPlaceholder`, `Container`, and `Loading`.
- Added `View.shimmer(_:)` for applying shimmer effects to custom SwiftUI views.
- Added shimmer color presets and direction configuration through `ShimmerConfigurationColorPreset` and `ShimmerDirection`.
- Added DocC documentation deployment support.

### Changed
- Tuned the default shimmer animation for a calmer AI app loading feel.
- Set the default shimmer duration to `1.6` seconds.
- Set the default `bandWidthRatio` to `3.4`.
- Expanded the `bandWidthRatio` normalization range to `0.1...6`.

### Fixed
- Documented `bandWidthRatio` normalization in README, DocC, and public API comments.
- Added tests for default shimmer values and exact upper-bound normalization.

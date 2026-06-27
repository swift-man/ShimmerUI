# ShimmerUI

SwiftUI shimmer components for loading text and shimmer placeholder layouts.

## Overview

Use ``ShimmerText`` for lightweight shimmering labels.

Use ``ShimmerLoadingUI`` when a view needs reusable shimmer placeholders or a loading wrapper that keeps real content and placeholder content in the same layout.

```swift
ShimmerText("Loading")

ShimmerText(
  "Thinking",
  configuration: .init(bandWidthRatio: 2.6)
)

ShimmerLoadingUI.Container {
  ShimmerLoadingUI.ScreenPlaceholder(rowCount: 3)
}

ShimmerLoadingUI.Loading(isLoading: isLoading) {
  LoadedContentView()
} placeholder: {
  ShimmerLoadingUI.ScreenPlaceholder(rowCount: 3)
}
```

Customize shimmer behavior with ``ShimmerConfiguration`` and ``ShimmerDirection``. Use `bandWidthRatio` to control the shimmer sweep width; values are clamped to the `0.1...6` range.

# ShimmerUI

SwiftUI shimmer components for loading text and shimmer placeholder layouts.

## Overview

Use ``ShimmerText`` for lightweight shimmering labels.

Use ``ShimmerLoadingUI`` when a view needs reusable shimmer placeholders or a loading wrapper that keeps real content and placeholder content in the same layout.

```swift
ShimmerText("Loading")

ShimmerText(
  "Thinking",
  configuration: .init(bandWidthRatio: 4.2)
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

Customize shimmer behavior with ``ShimmerConfiguration`` and ``ShimmerDirection``. The default uses a 1.6-second sweep with a wider `4.0` band ratio for a calm AI loading effect. Use `bandWidthRatio` to control the shimmer sweep width; values are clamped to the `0.1...6` range.

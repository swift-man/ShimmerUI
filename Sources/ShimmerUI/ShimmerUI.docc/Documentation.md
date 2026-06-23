# ShimmerUI

SwiftUI shimmer components for loading text and skeleton placeholder layouts.

## Overview

Use ``ShimmerText`` for lightweight shimmering labels.

Use ``ShimmerLoadingUI`` when a view needs reusable skeleton placeholders or a loading wrapper that keeps real content and placeholder content in the same layout.

```swift
ShimmerText("Loading")

ShimmerLoadingUI.Loading(isLoading: isLoading) {
  LoadedContentView()
} placeholder: {
  ShimmerLoadingUI.ScreenPlaceholder(rowCount: 3)
}
```

Customize shimmer behavior with ``ShimmerConfiguration`` and ``ShimmerDirection``.

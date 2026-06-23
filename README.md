# ShimmerUI

SwiftUI shimmer components distributed as a Swift Package.

## Requirements

- Swift 6.0 or later
- iOS 15.0+
- macOS 12.0+
- tvOS 15.0+
- watchOS 8.0+

## Installation

Add this package to your Swift Package dependencies:

```swift
.package(url: "https://github.com/<owner>/ShimmerUI.git", from: "0.1.0")
```

Then add `ShimmerUI` to your target dependencies:

```swift
.product(name: "ShimmerUI", package: "ShimmerUI")
```

## Usage

```swift
import SwiftUI
import ShimmerUI

struct ContentView: View {
  var body: some View {
    VStack(spacing: 24) {
      ShimmerText("Loading")

      ShimmerLoadingUI.Skeleton {
        ShimmerLoadingUI.ScreenPlaceholder(rowCount: 3)
      }
    }
    .padding()
  }
}
```

Use `ShimmerLoadingUI.Loading` to keep the real content and placeholder in the same layout while loading:

```swift
ShimmerLoadingUI.Loading(isLoading: isLoading) {
  LoadedContentView()
} placeholder: {
  ShimmerLoadingUI.ScreenPlaceholder(rowCount: 3)
}
```

## Public API

- `ShimmerText`
- `ShimmerLoadingUI`
- `ShimmerConfiguration`
- `ShimmerConfigurationColorPreset`
- `ShimmerDirection`
- `View.shimmer(_:)`

`ShimmerUI` is retained as a compatibility typealias for `ShimmerLoadingUI`.

## Testing

```sh
swift test
```

## Documentation Deployment

Generate the DocC static site locally:

```sh
./GeneratingDocumentationSite
```

The `Deploy DocC` GitHub Actions workflow publishes the generated `docs` output to `swift-man/docs` under `ShimmerUI`. The repository needs a `DOCS_DEPLOY_KEY` secret with write access to the docs repository.

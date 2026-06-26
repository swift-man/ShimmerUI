# ShimmerUI

![Badge](https://img.shields.io/badge/swift-6.0-white.svg?style=flat-square&logo=Swift)
![Badge](https://img.shields.io/badge/SwiftUI-001b87.svg?style=flat-square&logo=Swift&logoColor=black)
![Badge - Version](https://img.shields.io/badge/Version-0.1.0-1177AA?style=flat-square)
![Badge - Swift Package Manager](https://img.shields.io/badge/SPM-compatible-orange?style=flat-square)
![Badge - Platform](https://img.shields.io/badge/platform-mac_12|ios_15|watchOS_8|tvos_15-yellow?style=flat-square)
![Badge - License](https://img.shields.io/badge/license-MIT-black?style=flat-square)

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
.package(url: "https://github.com/swift-man/ShimmerUI.git", from: "0.1.0")
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

      ShimmerLoadingUI.Container {
        ShimmerLoadingUI.ScreenPlaceholder(rowCount: 3)
      }
    }
    .padding()
  }
}
```

Use `bandWidthRatio` to tune the shimmer sweep width. The default is tuned for a wider AI loading effect, and you can increase it further when needed:

```swift
ShimmerText(
  "Thinking",
  configuration: .init(bandWidthRatio: 2.6)
)
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
- `ShimmerLoadingUI.Container`
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

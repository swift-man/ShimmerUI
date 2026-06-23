import SwiftUI

public extension View {
  @MainActor
  func shimmer(
    _ configuration: ShimmerConfiguration = .init()
  ) -> some View {
    modifier(ShimmerModifier(configuration: configuration))
  }
}

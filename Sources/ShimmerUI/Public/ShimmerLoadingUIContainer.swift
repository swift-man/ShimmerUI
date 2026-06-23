import SwiftUI

public extension ShimmerLoadingUI {
  /// 플레이스홀더 전체에 shimmer를 한 번만 적용합니다.
  struct Container<Placeholder: View>: View {
    private let configuration: ShimmerConfiguration
    private let placeholder: Placeholder

    public init(
      configuration: ShimmerConfiguration = .init(),
      @ViewBuilder placeholder: () -> Placeholder
    ) {
      self.configuration = configuration
      self.placeholder = placeholder()
    }

    public var body: some View {
      placeholder
        .environment(\.shimmerBaseColor, configuration.baseColor)
        .shimmer(configuration)
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }
  }
}

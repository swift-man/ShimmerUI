import Foundation
import SwiftUI

public extension ShimmerLoadingUI {
  /// 실제 콘텐츠와 스켈레톤을 같은 레이아웃에 유지해 자연스럽게 교차 전환합니다.
  struct Loading<Content: View, Placeholder: View>: View {
    private let isLoading: Bool
    private let configuration: ShimmerConfiguration
    private let transitionDuration: TimeInterval
    private let content: Content
    private let placeholder: Placeholder

    @Environment(\.accessibilityReduceMotion)
    private var reduceMotion

    public init(
      isLoading: Bool,
      configuration: ShimmerConfiguration = .init(),
      transitionDuration: TimeInterval = 0.28,
      @ViewBuilder content: () -> Content,
      @ViewBuilder placeholder: () -> Placeholder
    ) {
      self.isLoading = isLoading
      self.configuration = configuration
      self.transitionDuration = max(0, transitionDuration)
      self.content = content()
      self.placeholder = placeholder()
    }

    public var body: some View {
      ZStack {
        content
          .opacity(isLoading ? 0 : 1)
          .scaleEffect(
            reduceMotion ? 1 : (isLoading ? 0.995 : 1)
          )
          .allowsHitTesting(!isLoading)
          .accessibilityHidden(isLoading)
          .zIndex(isLoading ? 0 : 1)

        placeholder
          .environment(\.shimmerBaseColor, configuration.baseColor)
          .shimmer(
            configuration.active(
              configuration.isActive && isLoading
            )
          )
          .opacity(isLoading ? 1 : 0)
          .scaleEffect(
            reduceMotion ? 1 : (isLoading ? 1 : 0.995)
          )
          .allowsHitTesting(false)
          .accessibilityHidden(true)
          .zIndex(isLoading ? 1 : 0)
      }
      .animation(
        .easeInOut(duration: transitionDuration),
        value: isLoading
      )
    }
  }
}

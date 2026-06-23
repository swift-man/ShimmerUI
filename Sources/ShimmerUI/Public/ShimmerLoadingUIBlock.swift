import CoreGraphics
import SwiftUI

public extension ShimmerLoadingUI {
  /// 모든 스켈레톤 레이아웃을 만드는 기본 도형입니다.
  struct Block: View {
    public enum Shape {
      case roundedRectangle(cornerRadius: CGFloat)
      case capsule
      case circle
    }

    private let shape: Shape

    @Environment(\.shimmerBaseColor)
    private var baseColor

    public init(_ shape: Shape = .roundedRectangle(cornerRadius: 8)) {
      self.shape = shape
    }

    @ViewBuilder
    public var body: some View {
      switch shape {
      case .roundedRectangle(let cornerRadius):
        RoundedRectangle(
          cornerRadius: max(0, cornerRadius),
          style: .continuous
        )
        .fill(baseColor)

      case .capsule:
        Capsule()
          .fill(baseColor)

      case .circle:
        Circle()
          .fill(baseColor)
      }
    }
  }
}

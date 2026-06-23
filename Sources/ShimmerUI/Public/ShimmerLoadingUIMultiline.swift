import CoreGraphics
import SwiftUI

public extension ShimmerLoadingUI {
  /// multiline_corner.png 형태의 텍스트 스켈레톤입니다.
  struct Multiline: View {
    private let lineCount: Int
    private let lineHeight: CGFloat
    private let lineSpacing: CGFloat
    private let cornerRadius: CGFloat
    private let lastLineFillRatio: CGFloat

    public init(
      lineCount: Int = 3,
      lineHeight: CGFloat = 15,
      lineSpacing: CGFloat = 10,
      cornerRadius: CGFloat = 6,
      lastLineFillRatio: CGFloat = 0.7
    ) {
      self.lineCount = max(1, lineCount)
      self.lineHeight = max(1, lineHeight)
      self.lineSpacing = max(0, lineSpacing)
      self.cornerRadius = max(0, cornerRadius)
      self.lastLineFillRatio = min(max(lastLineFillRatio, 0.05), 1)
    }

    public var body: some View {
      GeometryReader { proxy in
        VStack(alignment: .leading, spacing: lineSpacing) {
          ForEach(0..<lineCount, id: \.self) { index in
            Block(.roundedRectangle(cornerRadius: cornerRadius))
              .frame(
                width: proxy.size.width * widthRatio(for: index),
                height: lineHeight
              )
          }
        }
      }
      .frame(height: totalHeight)
    }

    private var totalHeight: CGFloat {
      CGFloat(lineCount) * lineHeight +
      CGFloat(max(0, lineCount - 1)) * lineSpacing
    }

    private func widthRatio(for index: Int) -> CGFloat {
      index == lineCount - 1 ? lastLineFillRatio : 1
    }
  }
}

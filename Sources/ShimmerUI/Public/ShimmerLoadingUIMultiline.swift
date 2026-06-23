//
//  ShimmerLoadingUIMultiline.swift
//  ShimmerUI
//
//  Created by Gorani on 6/23/26.
//

import CoreGraphics
import SwiftUI

private struct ShimmerMultilineWidthPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = 0

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}

public extension ShimmerLoadingUI {
  /// multiline_corner.png 형태의 텍스트 스켈레톤입니다.
  struct Multiline: View {
    private let lineCount: Int
    private let lineHeight: CGFloat
    private let lineSpacing: CGFloat
    private let cornerRadius: CGFloat
    private let lastLineFillRatio: CGFloat
    @State private var measuredWidth: CGFloat = 0

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
      VStack(alignment: .leading, spacing: lineSpacing) {
        ForEach(0..<lineCount, id: \.self) { index in
          Block(.roundedRectangle(cornerRadius: cornerRadius))
            .frame(
              width: lineWidth(for: index),
              height: lineHeight
            )
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .frame(height: totalHeight, alignment: .top)
      .opacity(measuredWidth > 0 ? 1 : 0)
      .background {
        GeometryReader { proxy in
          Color.clear
            .preference(
              key: ShimmerMultilineWidthPreferenceKey.self,
              value: proxy.size.width
            )
        }
      }
      .onPreferenceChange(ShimmerMultilineWidthPreferenceKey.self) { width in
        measuredWidth = max(0, width)
      }
    }

    private var totalHeight: CGFloat {
      CGFloat(lineCount) * lineHeight +
      CGFloat(max(0, lineCount - 1)) * lineSpacing
    }

    private func lineWidth(for index: Int) -> CGFloat? {
      guard measuredWidth.isFinite, measuredWidth > 0 else { return nil }
      return measuredWidth * widthRatio(for: index)
    }

    private func widthRatio(for index: Int) -> CGFloat {
      index == lineCount - 1 ? lastLineFillRatio : 1
    }
  }
}

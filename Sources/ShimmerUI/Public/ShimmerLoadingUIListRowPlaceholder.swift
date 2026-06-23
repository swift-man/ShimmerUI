//
//  ShimmerLoadingUIListRowPlaceholder.swift
//  ShimmerUI
//
//  Created by Gorani on 6/23/26.
//

import CoreGraphics
import SwiftUI

public extension ShimmerLoadingUI {
  /// 원형 이미지 자리 + 여러 줄 텍스트로 구성된 한 행입니다.
  struct ListRowPlaceholder: View {
    private let avatarSize: CGFloat
    private let titleWidth: CGFloat
    private let textLineCount: Int

    public init(
      avatarSize: CGFloat = 52,
      titleWidth: CGFloat = 118,
      textLineCount: Int = 2
    ) {
      self.avatarSize = max(1, avatarSize)
      self.titleWidth = max(1, titleWidth)
      self.textLineCount = max(1, textLineCount)
    }

    public var body: some View {
      HStack(alignment: .top, spacing: 14) {
        Block(.circle)
          .frame(width: avatarSize, height: avatarSize)

        VStack(alignment: .leading, spacing: 10) {
          Block(.capsule)
            .frame(width: titleWidth, height: 14)

          Multiline(
            lineCount: textLineCount,
            lineHeight: 11,
            lineSpacing: 8,
            cornerRadius: 5.5,
            lastLineFillRatio: 0.58
          )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}

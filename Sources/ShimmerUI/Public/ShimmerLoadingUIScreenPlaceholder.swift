import CoreGraphics
import SwiftUI

public extension ShimmerLoadingUI {
  /// 헤더, 이미지, 본문, 리스트를 포함하는 전체 로딩 화면 예시입니다.
  struct ScreenPlaceholder: View {
    private let rowCount: Int

    public init(rowCount: Int = 3) {
      self.rowCount = max(1, rowCount)
    }

    public var body: some View {
      VStack(alignment: .leading, spacing: 22) {
        HStack(spacing: 12) {
          Block(.circle)
            .frame(width: 44, height: 44)

          VStack(alignment: .leading, spacing: 8) {
            Block(.capsule)
              .frame(width: 124, height: 15)

            Block(.capsule)
              .frame(width: 82, height: 11)
          }

          Spacer(minLength: 12)

          Block(.roundedRectangle(cornerRadius: 10))
            .frame(width: 38, height: 38)
        }

        Block(.roundedRectangle(cornerRadius: 16))
          .frame(maxWidth: .infinity)
          .frame(height: 168)

        Multiline(
          lineCount: 4,
          lineHeight: 14,
          lineSpacing: 10,
          cornerRadius: 7,
          lastLineFillRatio: 0.62
        )

        ListPlaceholder(rowCount: rowCount)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}

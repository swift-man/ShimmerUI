import CoreGraphics
import SwiftUI

public extension ShimmerLoadingUI {
  /// all_skeletonables_result.png처럼 여러 요소가 함께 움직이는 리스트형 레이아웃입니다.
  struct ListPlaceholder: View {
    private let rowCount: Int
    private let rowSpacing: CGFloat

    public init(
      rowCount: Int = 5,
      rowSpacing: CGFloat = 20
    ) {
      self.rowCount = max(1, rowCount)
      self.rowSpacing = max(0, rowSpacing)
    }

    public var body: some View {
      VStack(alignment: .leading, spacing: rowSpacing) {
        ForEach(0..<rowCount, id: \.self) { index in
          ListRowPlaceholder(
            avatarSize: index == 0 ? 58 : 50,
            titleWidth: index.isMultiple(of: 2) ? 132 : 104,
            textLineCount: 2
          )
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}

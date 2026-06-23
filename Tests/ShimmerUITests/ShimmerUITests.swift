import Foundation
import SwiftUI
import Testing

import ShimmerUI

struct ShimmerUITests {
  @Test
  func shimmerConfigurationActiveToggle() {
    let original = ShimmerConfiguration()
    #expect(original.isActive)

    let inactive = original.active(false)
    #expect(!inactive.isActive)

    let activeAgain = inactive.active(true)
    #expect(activeAgain.isActive)
  }

  @Test
  func shimmerDirectionCases() {
    #expect(ShimmerDirection.allCases.count == 6)
    #expect(ShimmerDirection.leftRight.id == .leftRight)
  }

  @Test
  func publicTypesCanBeInstantiated() {
    let text = ShimmerText("테스트")
    let block = ShimmerLoadingUI.Block()
    let multiline = ShimmerLoadingUI.Multiline(lineCount: 2)
    let container = ShimmerLoadingUI.Container {
      multiline
    }
    let loading = ShimmerLoadingUI.Loading(
      isLoading: true,
      configuration: .init(),
      content: {
        block
      },
      placeholder: {
        multiline
      }
    )

    #expect(type(of: text) == ShimmerText.self)
    #expect(type(of: block) == ShimmerLoadingUI.Block.self)
    #expect(type(of: multiline) == ShimmerLoadingUI.Multiline.self)
    #expect(type(of: container) == ShimmerLoadingUI.Container<ShimmerLoadingUI.Multiline>.self)
    #expect(type(of: loading) == ShimmerLoadingUI.Loading<ShimmerLoadingUI.Block, ShimmerLoadingUI.Multiline>.self)
  }

  @Test
  func legacyTypeAliasStillWorks() {
    let legacyName: ShimmerUI.Type = ShimmerLoadingUI.self
    #expect(legacyName == ShimmerLoadingUI.self)
  }
}

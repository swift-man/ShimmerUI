//
//  ShimmerUITests.swift
//  ShimmerUITests
//
//  Created by Gorani on 6/23/26.
//

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
  func shimmerConfigurationUsesAiLoadingDefaults() {
    let configuration = ShimmerConfiguration()
    #expect(configuration.duration == 1.6)
    #expect(configuration.bandWidthRatio == 3.4)
  }

  @Test
  func shimmerConfigurationNormalizesInvalidValues() {
    let nonFinite = ShimmerConfiguration(
      duration: .nan,
      bandWidthRatio: .infinity
    )
    #expect(nonFinite.duration == 1.6)
    #expect(nonFinite.bandWidthRatio == 3.4)

    let belowMinimum = ShimmerConfiguration(
      duration: -1,
      bandWidthRatio: -2
    )
    #expect(belowMinimum.duration == 0.1)
    #expect(belowMinimum.bandWidthRatio == 0.1)

    let aboveMaximum = ShimmerConfiguration(
      duration: 2,
      bandWidthRatio: 10
    )
    #expect(aboveMaximum.duration == 2)
    #expect(aboveMaximum.bandWidthRatio == 6)
  }

  @Test
  func legacyTypeAliasStillWorks() {
    let legacyName: ShimmerUI.Type = ShimmerLoadingUI.self
    #expect(legacyName == ShimmerLoadingUI.self)
  }
}

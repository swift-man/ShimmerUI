//
//  ShimmerUITests.swift
//  ShimmerUITests
//
//  Created by Gorani on 6/23/26.
//

import Foundation
import SwiftUI
import Testing

@testable import ShimmerUI

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
    #expect(configuration.bandWidthRatio == 4.0)
  }

  @Test
  func shimmerConfigurationNormalizesInvalidValues() {
    let nonFinite = ShimmerConfiguration(
      duration: .nan,
      bandWidthRatio: .infinity
    )
    #expect(nonFinite.duration == 1.6)
    #expect(nonFinite.bandWidthRatio == 4.0)

    let belowMinimum = ShimmerConfiguration(
      duration: -1,
      bandWidthRatio: -2
    )
    #expect(belowMinimum.duration == 0.1)
    #expect(belowMinimum.bandWidthRatio == 0.1)

    let upperBoundary = ShimmerConfiguration(
      duration: 2,
      bandWidthRatio: 6
    )
    #expect(upperBoundary.duration == 2)
    #expect(upperBoundary.bandWidthRatio == 6)

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

  @Test
  func shimmerGradientProfileMatchesAiLoadingSnapshot() {
    let stops = ShimmerBandGradientProfile.defaultStops
    let highlightColor = Color.white
    let gradientStops = ShimmerBandGradientProfile.gradientStops(
      highlightColor: highlightColor
    )
    let expectedOpacities = [0, 0.35, 0.85, 1, 0.85, 0.35, 0]
    let expectedLocations: [CGFloat] = [0, 0.22, 0.4, 0.5, 0.6, 0.78, 1]

    #expect(stops.map(\.opacity) == expectedOpacities)
    #expect(stops.map(\.location) == expectedLocations)
    #expect(gradientStops.count == stops.count)
    #expect(gradientStops.map(\.location) == expectedLocations)
    #expect(
      gradientStops.map(\.color) == expectedOpacities.map {
        highlightColor.opacity($0)
      }
    )
    #expect(gradientStops.first?.color != Color.clear)
    #expect(gradientStops.last?.color != Color.clear)
    #expect(zip(stops, stops.dropFirst()).allSatisfy { $0.location < $1.location })

    for index in 0..<stops.count / 2 {
      let leading = stops[index]
      let trailing = stops[stops.count - index - 1]
      #expect(leading.opacity == trailing.opacity)
      #expect(abs(leading.location + trailing.location - 1) < 0.001)
    }
  }

  @Test
  func shimmerBandStylePrecomputesFrameInvariantStops() {
    let highlightColor = Color.blue
    let configuration = ShimmerConfiguration(
      highlightColor: highlightColor,
      direction: .topLeftBottomRight,
      bandWidthRatio: 4.2
    )
    let style = ShimmerBandStyle(configuration: configuration)
    let expectedStops = ShimmerBandGradientProfile.gradientStops(
      highlightColor: highlightColor
    )

    #expect(style.direction == .topLeftBottomRight)
    #expect(style.bandWidthRatio == 4.2)
    #expect(style.gradientStops.count == expectedStops.count)
    #expect(style.gradientStops.map(\.location) == expectedStops.map(\.location))
    #expect(style.gradientStops.map(\.color) == expectedStops.map(\.color))
  }

  @Test
  func shimmerBandGeometryMatchesRepresentativeVisualSnapshots() {
    struct VisualSnapshot {
      let size: CGSize
      let bandWidth: CGFloat
      let crossLength: CGFloat
    }

    let configuration = ShimmerConfiguration()
    let snapshots = [
      VisualSnapshot(
        size: .init(width: 160, height: 24),
        bandWidth: 116.4887908770625,
        crossLength: 763.6487401940764
      ),
      VisualSnapshot(
        size: .init(width: 320, height: 180),
        bandWidth: 264.3488604098758,
        crossLength: 1732.9536404647415
      ),
      VisualSnapshot(
        size: .init(width: 390, height: 844),
        bandWidth: 669.4203630007082,
        crossLength: 4388.4223796713095
      )
    ]

    for snapshot in snapshots {
      let geometry = ShimmerBandGeometry(
        size: snapshot.size,
        bandWidthRatio: configuration.bandWidthRatio
      )

      #expect(abs(geometry.bandWidth - snapshot.bandWidth) < 0.001)
      #expect(abs(geometry.crossLength - snapshot.crossLength) < 0.001)
    }
  }

  @Test
  func shimmerBandGeometryPreservesCollapsedSizeCoverage() {
    let configuration = ShimmerConfiguration()
    let collapsedSizes: [CGSize] = [
      .zero,
      .init(width: 0.1, height: 0.2)
    ]

    for size in collapsedSizes {
      let geometry = ShimmerBandGeometry(
        size: size,
        bandWidthRatio: configuration.bandWidthRatio
      )

      #expect(ShimmerBandGeometry.diagonal(for: size) == 1)
      #expect(geometry.bandWidth == 18)
      #expect(geometry.crossLength == 22)
    }
  }

  @Test
  func shimmerBandGeometryFallsBackForInvalidDiagonal() {
    let geometry = ShimmerBandGeometry(
      diagonal: .nan,
      bandWidthRatio: ShimmerConfiguration().bandWidthRatio
    )

    #expect(geometry.bandWidth == 18)
    #expect(geometry.crossLength == 22)
  }

  @Test
  func shimmerBandGeometryKeepsLargeFiniteSizes() {
    let size = CGSize(width: 1e155, height: 1e155)
    let geometry = ShimmerBandGeometry(
      size: size,
      bandWidthRatio: ShimmerConfiguration().bandWidthRatio
    )

    #expect(ShimmerBandGeometry.diagonal(for: size).isFinite)
    #expect(ShimmerBandGeometry.diagonal(for: size) > 1)
    #expect(geometry.bandWidth > 18)
    #expect(geometry.crossLength.isFinite)
  }
}

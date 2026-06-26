//
//  ShimmerBandGeometry.swift
//  ShimmerUI
//
//  Created by Gorani on 6/23/26.
//

import CoreGraphics

struct ShimmerBandGeometry: Equatable {
  private static let minimumBandWidth: CGFloat = 18
  private static let bandWidthScaleFactor: CGFloat = 0.18
  private static let minimumCrossLengthMultiplier = ShimmerConfiguration.defaultBandWidthRatio

  let bandWidth: CGFloat
  let crossLength: CGFloat

  init(diagonal: CGFloat, bandWidthRatio: CGFloat) {
    let bandWidth = max(
      Self.minimumBandWidth,
      diagonal * Self.bandWidthScaleFactor * bandWidthRatio
    )
    let crossLengthMultiplier = max(
      Self.minimumCrossLengthMultiplier,
      bandWidthRatio
    )

    self.bandWidth = bandWidth
    crossLength = diagonal * crossLengthMultiplier + bandWidth
  }
}

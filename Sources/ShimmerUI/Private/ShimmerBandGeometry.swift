//
//  ShimmerBandGeometry.swift
//  ShimmerUI
//
//  Created by Gorani on 6/23/26.
//

import CoreGraphics

struct ShimmerBandGeometry: Equatable {
  private static let minimumDiagonal: CGFloat = 1
  private static let minimumBandWidth: CGFloat = 18
  private static let bandWidthScaleFactor: CGFloat = 0.18
  private static let minimumCrossLengthMultiplier: CGFloat = 2.2

  let bandWidth: CGFloat
  let crossLength: CGFloat

  init(size: CGSize, bandWidthRatio: CGFloat) {
    self.init(
      diagonal: Self.diagonal(for: size),
      bandWidthRatio: bandWidthRatio
    )
  }

  init(diagonal: CGFloat, bandWidthRatio: CGFloat) {
    let diagonal = Self.normalizedDiagonal(diagonal)
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

  static func diagonal(for size: CGSize) -> CGFloat {
    normalizedDiagonal(hypot(size.width, size.height))
  }

  private static func normalizedDiagonal(_ diagonal: CGFloat) -> CGFloat {
    guard diagonal.isFinite else { return minimumDiagonal }
    return max(diagonal, minimumDiagonal)
  }
}

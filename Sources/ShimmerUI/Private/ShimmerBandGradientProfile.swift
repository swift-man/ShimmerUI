//
//  ShimmerBandGradientProfile.swift
//  ShimmerUI
//
//  Created by Gorani on 7/8/26.
//

import CoreGraphics
import SwiftUI

struct ShimmerBandGradientProfile {
  struct Stop: Equatable {
    let opacity: Double
    let location: CGFloat
  }

  static let defaultStops: [Stop] = [
    .init(opacity: 0, location: 0),
    .init(opacity: 0.35, location: 0.22),
    .init(opacity: 0.85, location: 0.4),
    .init(opacity: 1, location: 0.5),
    .init(opacity: 0.85, location: 0.6),
    .init(opacity: 0.35, location: 0.78),
    .init(opacity: 0, location: 1)
  ]

  static func gradientStops(highlightColor: Color) -> [Gradient.Stop] {
    defaultStops.map { stop in
      .init(
        color: highlightColor.opacity(stop.opacity),
        location: stop.location
      )
    }
  }
}

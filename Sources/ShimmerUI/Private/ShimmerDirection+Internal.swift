//
//  ShimmerDirection+Internal.swift
//  ShimmerUI
//
//  Created by Gorani on 6/23/26.
//

import CoreGraphics
import Foundation
import SwiftUI

extension ShimmerDirection {
  var unitVector: CGVector {
    switch self {
    case .leftRight:
      return CGVector(dx: 1, dy: 0)
    case .rightLeft:
      return CGVector(dx: -1, dy: 0)
    case .topBottom:
      return CGVector(dx: 0, dy: 1)
    case .bottomTop:
      return CGVector(dx: 0, dy: -1)
    case .topLeftBottomRight:
      return CGVector(dx: 0.70710678, dy: 0.70710678)
    case .bottomRightTopLeft:
      return CGVector(dx: -0.70710678, dy: -0.70710678)
    }
  }

  var angle: Angle {
    let vector = unitVector
    return .radians(atan2(Double(vector.dy), Double(vector.dx)))
  }
}

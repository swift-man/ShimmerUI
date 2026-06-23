//
//  ShimmerDirection.swift
//  ShimmerUI
//
//  Created by Gorani on 6/23/26.
//

public enum ShimmerDirection: String, CaseIterable, Identifiable, Hashable {
  case leftRight
  case rightLeft
  case topBottom
  case bottomTop
  case topLeftBottomRight
  case bottomRightTopLeft

  public var id: Self { self }

  public var title: String {
    switch self {
    case .leftRight:
      return "Left → Right"
    case .rightLeft:
      return "Right → Left"
    case .topBottom:
      return "Top → Bottom"
    case .bottomTop:
      return "Bottom → Top"
    case .topLeftBottomRight:
      return "Top Left ↘ Bottom Right"
    case .bottomRightTopLeft:
      return "Bottom Right ↖ Top Left"
    }
  }
}

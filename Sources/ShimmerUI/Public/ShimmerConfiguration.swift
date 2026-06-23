//
//  ShimmerConfiguration.swift
//  ShimmerUI
//
//  Created by Gorani on 6/23/26.
//

import CoreGraphics
import Foundation
import SwiftUI

public struct ShimmerConfiguration {
  public var baseColor: Color
  public var highlightColor: Color
  public var duration: TimeInterval
  public var direction: ShimmerDirection

  /// 1.0을 기준으로 빛띠의 폭을 조절합니다.
  public var bandWidthRatio: CGFloat

  public var isActive: Bool

  public init(
    baseColor: Color = ShimmerConfigurationColorPreset.light.baseColor,
    highlightColor: Color = ShimmerConfigurationColorPreset.light.highlightColor,
    duration: TimeInterval = 1.2,
    direction: ShimmerDirection = .leftRight,
    bandWidthRatio: CGFloat = 1.4,
    isActive: Bool = true
  ) {
    self.baseColor = baseColor
    self.highlightColor = highlightColor
    self.duration = Self.normalizedDuration(duration)
    self.direction = direction
    self.bandWidthRatio = Self.normalizedBandWidthRatio(bandWidthRatio)
    self.isActive = isActive
  }

  public init(
    preset: ShimmerConfigurationColorPreset,
    duration: TimeInterval = 1.2,
    direction: ShimmerDirection = .leftRight,
    bandWidthRatio: CGFloat = 1.4,
    isActive: Bool = true
  ) {
    self.init(
      baseColor: preset.baseColor,
      highlightColor: preset.highlightColor,
      duration: duration,
      direction: direction,
      bandWidthRatio: bandWidthRatio,
      isActive: isActive
    )
  }

  public func active(_ value: Bool) -> Self {
    var copy = self
    copy.isActive = value
    return copy
  }
}

private extension ShimmerConfiguration {
  static let defaultDuration: TimeInterval = 1.2
  static let minimumDuration: TimeInterval = 0.1
  static let defaultBandWidthRatio: CGFloat = 1.4
  static let minimumBandWidthRatio: CGFloat = 0.1
  static let maximumBandWidthRatio: CGFloat = 3

  static func normalizedDuration(_ duration: TimeInterval) -> TimeInterval {
    guard duration.isFinite else { return defaultDuration }
    return max(duration, minimumDuration)
  }

  static func normalizedBandWidthRatio(_ bandWidthRatio: CGFloat) -> CGFloat {
    guard bandWidthRatio.isFinite else { return defaultBandWidthRatio }
    return min(max(bandWidthRatio, minimumBandWidthRatio), maximumBandWidthRatio)
  }
}

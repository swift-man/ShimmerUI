//
//  ShimmerEffect.swift
//  ShimmerUI
//
//  Created by Gorani on 6/23/26.
//

import CoreGraphics
import Foundation
import SwiftUI

private struct ShimmerAnimationToken: Hashable {
  let isActive: Bool
  let direction: ShimmerDirection
  let duration: TimeInterval
  let bandWidthRatio: CGFloat
}

struct ShimmerBandStyle {
  let direction: ShimmerDirection
  let unitVector: CGVector
  let angle: Angle
  let bandWidthRatio: CGFloat
  let gradientStops: [Gradient.Stop]

  init(configuration: ShimmerConfiguration) {
    direction = configuration.direction
    unitVector = configuration.direction.unitVector
    angle = configuration.direction.angle
    bandWidthRatio = configuration.bandWidthRatio
    gradientStops = ShimmerBandGradientProfile.gradientStops(
      highlightColor: configuration.highlightColor
    )
  }
}

@MainActor
struct ShimmerModifier: ViewModifier {
  let configuration: ShimmerConfiguration

  @State private var animationStart = Date()

  @Environment(\.accessibilityReduceMotion)
  private var reduceMotion

  func body(content: Content) -> some View {
    let shouldAnimate = configuration.isActive && !reduceMotion
    let token = ShimmerAnimationToken(
      isActive: shouldAnimate,
      direction: configuration.direction,
      duration: configuration.duration,
      bandWidthRatio: configuration.bandWidthRatio
    )

    content
      .overlay {
        if shouldAnimate {
          let bandStyle = ShimmerBandStyle(configuration: configuration)

          GeometryReader { proxy in
            let size = proxy.size
            let geometry = ShimmerBandGeometry(
              size: size,
              bandWidthRatio: bandStyle.bandWidthRatio
            )

            TimelineView(.animation) { timeline in
              ShimmerBand(
                size: size,
                geometry: geometry,
                progress: progress(at: timeline.date),
                style: bandStyle
              )
            }
          }
          // Keep the source view mounted once; sourceAtop confines the shimmer to visible pixels.
          .blendMode(.sourceAtop)
          .allowsHitTesting(false)
          .accessibilityHidden(true)
        }
      }
      .compositingGroup()
      .task(id: token) {
        guard shouldAnimate else { return }
        animationStart = Date()
      }
  }

  private func progress(at date: Date) -> CGFloat {
    let duration = configuration.duration
    guard duration.isFinite, duration > 0 else { return 0 }

    let elapsed = max(0, date.timeIntervalSince(animationStart))
    guard elapsed.isFinite else { return 0 }

    let cycle = elapsed.truncatingRemainder(dividingBy: duration)
    return CGFloat(cycle / duration)
  }
}

@MainActor
private struct ShimmerBand: View {
  let size: CGSize
  let geometry: ShimmerBandGeometry
  let progress: CGFloat
  let style: ShimmerBandStyle

  var body: some View {
    let vector = style.unitVector

    // 진행 방향으로 뷰를 투영한 길이를 이용해 시작/종료 지점을 화면 밖으로 배치합니다.
    let projectedHalfLength = (
      abs(vector.dx) * size.width +
      abs(vector.dy) * size.height
    ) / 2

    let travelDistance = projectedHalfLength + geometry.bandWidth
    let phase = min(max(progress, 0), 1) * 2 - 1

    LinearGradient(
      stops: style.gradientStops,
      startPoint: .leading,
      endPoint: .trailing
    )
    .frame(width: geometry.bandWidth, height: geometry.crossLength)
    .rotationEffect(style.angle)
    .position(
      x: size.width / 2 + vector.dx * phase * travelDistance,
      y: size.height / 2 + vector.dy * phase * travelDistance
    )
  }
}

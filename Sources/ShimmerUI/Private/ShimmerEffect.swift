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
          GeometryReader { proxy in
            TimelineView(.animation) { timeline in
              ShimmerBand(
                size: proxy.size,
                progress: progress(at: timeline.date),
                configuration: configuration
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
  let progress: CGFloat
  let configuration: ShimmerConfiguration

  var body: some View {
    let vector = configuration.direction.unitVector
    let diagonal = max(
      (size.width * size.width + size.height * size.height).squareRoot(),
      1
    )

    // 기존 1.4 기본값을 유지하면서 실제 밴드는 화면 대각선의 약 25%가 되도록 계산합니다.
    let safeRatio = min(max(configuration.bandWidthRatio, 0.1), 3)
    let bandWidth = max(18, diagonal * 0.18 * safeRatio)
    let crossLength = diagonal * 2.2 + bandWidth

    // 진행 방향으로 뷰를 투영한 길이를 이용해 시작/종료 지점을 화면 밖으로 배치합니다.
    let projectedHalfLength = (
      abs(vector.dx) * size.width +
      abs(vector.dy) * size.height
    ) / 2

    let travelDistance = projectedHalfLength + bandWidth
    let phase = min(max(progress, 0), 1) * 2 - 1

    LinearGradient(
      stops: [
        .init(color: .clear, location: 0),
        .init(color: configuration.highlightColor.opacity(0.18), location: 0.28),
        .init(color: configuration.highlightColor, location: 0.5),
        .init(color: configuration.highlightColor.opacity(0.18), location: 0.72),
        .init(color: .clear, location: 1)
      ],
      startPoint: .leading,
      endPoint: .trailing
    )
    .frame(width: bandWidth, height: crossLength)
    .rotationEffect(configuration.direction.angle)
    .position(
      x: size.width / 2 + vector.dx * phase * travelDistance,
      y: size.height / 2 + vector.dy * phase * travelDistance
    )
  }
}

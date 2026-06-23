//
//  View+Shimmer.swift
//  ShimmerUI
//
//  Created by Gorani on 6/23/26.
//

import SwiftUI

public extension View {
  @MainActor
  func shimmer(
    _ configuration: ShimmerConfiguration = .init()
  ) -> some View {
    modifier(ShimmerModifier(configuration: configuration))
  }
}

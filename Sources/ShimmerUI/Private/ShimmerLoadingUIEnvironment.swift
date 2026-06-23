//
//  ShimmerLoadingUIEnvironment.swift
//  ShimmerUI
//
//  Created by Gorani on 6/23/26.
//

import SwiftUI

private struct ShimmerBaseColorKey: EnvironmentKey {
  static let defaultValue = ShimmerConfigurationColorPreset.light.baseColor
}

extension EnvironmentValues {
  var shimmerBaseColor: Color {
    get { self[ShimmerBaseColorKey.self] }
    set { self[ShimmerBaseColorKey.self] = newValue }
  }
}

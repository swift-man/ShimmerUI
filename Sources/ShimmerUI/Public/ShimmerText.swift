//
//  ShimmerText.swift
//  ShimmerUI
//
//  Created by Gorani on 6/23/26.
//

import SwiftUI

public struct ShimmerText: View {
  private let text: String
  private let font: Font
  private let configuration: ShimmerConfiguration

  public init(
    _ text: String,
    font: Font = .system(size: 16, weight: .semibold),
    configuration: ShimmerConfiguration = .init()
  ) {
    self.text = text
    self.font = font
    self.configuration = configuration
  }

  public var body: some View {
    Text(text)
      .font(font)
      .foregroundStyle(configuration.baseColor)
      .shimmer(configuration)
  }
}

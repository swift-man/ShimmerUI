import SwiftUI

public enum ShimmerConfigurationColorPreset {
  case light
  case dark
  case black
  case white

  public var baseColor: Color {
    switch self {
    case .light:
      return .gray.opacity(0.35)
    case .dark:
      return .white.opacity(0.25)
    case .black:
      return .black.opacity(0.35)
    case .white:
      return .white.opacity(0.35)
    }
  }

  public var highlightColor: Color {
    switch self {
    case .light:
      return .white.opacity(0.9)
    case .dark:
      return .white.opacity(0.75)
    case .black:
      return .black.opacity(0.75)
    case .white:
      return .white.opacity(0.9)
    }
  }
}

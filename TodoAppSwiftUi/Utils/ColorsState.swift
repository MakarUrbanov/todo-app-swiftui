import SwiftUI

struct ColorsState {
  enum Scheme: String {
    case lightBackground = "3450a1"
    case darkBackground = "031956"
    case lightGray = "ededed"
  }

  static func getColor(_ color: Scheme) -> Color {
    return Color(hex: color.rawValue)
  }

  static func getUIColor(_ color: Scheme) -> UIColor {
    return UIColor(hex: color.rawValue)
  }
}

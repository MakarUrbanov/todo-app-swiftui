import SwiftUI

struct ColorsState {
  enum Scheme: String {
    case lightBackground = "3450a1"
    case darkBackground = "031956"
  }

  static func get(_ color: Scheme) -> String {
    return color.rawValue
  }
}

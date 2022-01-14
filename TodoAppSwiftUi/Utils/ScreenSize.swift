import SwiftUI

struct ScreenSize {
  static func width(_ percents: CGFloat) -> CGFloat {
    let screenWidth = UIScreen.main.bounds.width
    return screenWidth / 100 * percents
  }

  static func height(_ percents: CGFloat) -> CGFloat {
    let screenHeight = UIScreen.main.bounds.height
    return screenHeight / 100 * percents
  }
}

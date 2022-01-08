import Foundation
import SwiftUI

func NavigationBarSettings(titleColor: UIColor, backgroundColor: UIColor, tintColor: UIColor, shadowColor: UIColor) {
  let coloredAppearance = UINavigationBarAppearance()
  coloredAppearance.configureWithOpaqueBackground()
  coloredAppearance.backgroundColor = backgroundColor
  coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor]
  coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
  coloredAppearance.shadowColor = shadowColor

  UINavigationBar.appearance().standardAppearance = coloredAppearance
  UINavigationBar.appearance().compactAppearance = coloredAppearance
  UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance

  UINavigationBar.appearance().tintColor = tintColor
}

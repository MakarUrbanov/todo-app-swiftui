import SwiftUI

struct CustomTextField: View {
  @Binding var text: String
  var label: Text
  var isSecure: Bool

  init(text: Binding<String>, label: Text, isSecure: Bool = false) {
    self._text = text
    self.label = label
    self.isSecure = isSecure
  }

  var body: some View {
    ZStack(alignment: .leading) {
      if text.isEmpty {
        label
      }

      if isSecure {
        SecureField(text: $text, label: {
          label
        })
      } else {
        TextField(text: $text, label: {
          label
        })
      }
    }
  }
}

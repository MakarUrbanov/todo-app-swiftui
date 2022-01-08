import SwiftUI

struct CustomTextField: View {
  @Binding var text: String
  var label: Text
  @State var isSecure: Bool

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

import SwiftUI

struct TodoInputField: View {
  @Binding var text: String

  var body: some View {
    HStack {
      CustomTextField(text: $text,
        label: Text("Text your todo")
          .foregroundColor(Color(hex: ColorsState.Scheme.lightGray.rawValue))
      )
        .padding(.horizontal)
        .frame(height: 40)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(.black.opacity(0.2), lineWidth: 1)
        )
    }
  }
}

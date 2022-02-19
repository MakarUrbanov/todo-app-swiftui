import SwiftUI

struct TodoInputField: View {
  @Binding var text: String

  var body: some View {
    HStack {
      CustomTextField(text: $text,
        label: Text("Text your todo")
          .foregroundColor(ColorsState.getColor(.lightGray))
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

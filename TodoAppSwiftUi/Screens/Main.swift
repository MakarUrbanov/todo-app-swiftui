import SwiftUI

struct Main: View {
  @ObservedObject var user: User

  init(user: User) {
    self.user = user

    NavigationBarSettings(titleColor: .white, backgroundColor: .systemCyan, tintColor: .white, shadowColor: .clear)
  }

  var body: some View {
    NavigationView {
      VStack {
        Text("TODOS HERE!")
        Button(action: {
          user.logOut()
        }, label: {
          Text("Log out")
        })
      }.frame(maxWidth: .infinity, maxHeight: .infinity)

        .navigationBarTitle("My ToDo", displayMode: .inline)
    }
  }
}

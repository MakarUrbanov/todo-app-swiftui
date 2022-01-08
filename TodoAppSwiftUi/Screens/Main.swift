import SwiftUI

struct Main: View {
  @ObservedObject var user: User

  init(user: User) {
    self.user = user

    NavigationBarSettings(
      titleColor: .white,
      backgroundColor: UIColor(hex: ColorsState.get(.darkBackground)),
      tintColor: .white,
      shadowColor: .clear
    )
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
        .background(Color(hex: ColorsState.get(.lightBackground)))

        .navigationBarTitle("My ToDo", displayMode: .inline)
    }
  }
}

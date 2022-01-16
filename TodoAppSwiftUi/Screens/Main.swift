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
        
        TodosList()

      }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)

        .navigationBarTitle("My ToDo", displayMode: .large)
        .toolbar {
          Button(action: {
            user.logOut()
          }, label: {
            Image(systemName: "arrow.left.to.line")
          })
        }
    }
  }
}

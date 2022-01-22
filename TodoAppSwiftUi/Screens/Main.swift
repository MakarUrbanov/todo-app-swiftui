import SwiftUI

struct Main: View {
  @EnvironmentObject var user: User

  init() {
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
        .ignoresSafeArea(edges: .bottom)

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

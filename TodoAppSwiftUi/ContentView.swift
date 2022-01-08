import SwiftUI

struct ContentView: View {
  @ObservedObject var user: User = User()

  var body: some View {
    let isAuth = user.isAuth

    VStack {
      if isAuth {
        Main(user: user)
      } else {
        SignIn(user: user)
      }
    }.animation(.spring(), value: isAuth)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .preferredColorScheme(.light)
  }
}

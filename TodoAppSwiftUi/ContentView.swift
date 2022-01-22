import SwiftUI

struct ContentView: View {
  @StateObject var user: User = User()

  var body: some View {
    let isAuth = user.isAuth

    VStack {
      if isAuth {
        Main()
      } else {
        SignIn()
      }
    }.animation(.spring(), value: isAuth)
    .environmentObject(user)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

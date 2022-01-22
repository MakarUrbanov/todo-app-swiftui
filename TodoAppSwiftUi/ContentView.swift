import SwiftUI

struct ContentView: View {
  @StateObject var user: User = User()

  init() {
    UITabBar.appearance().backgroundColor = UIColor(hex: ColorsState.Scheme.darkBackground.rawValue)
    UITabBar.appearance().barTintColor = UIColor(.white)
  }

  var body: some View {
    let isAuth = user.isAuth

    VStack {
      if isAuth {
        TabView {
          TodosScreen()
            .tabItem {
              Image(systemName: "checklist")
              Text("TODOS")
            }

          Text("Old todos")
            .tabItem {
              Image(systemName: "folder")
              Text("COMPLETE")
            }
        }.accentColor(.white)
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

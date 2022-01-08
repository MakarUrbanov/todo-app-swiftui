import SwiftUI

struct Main: View {
  @ObservedObject var user: User

  var body: some View {
    Text("TODOS HERE!")
    Button(action: {
      user.logOut()
    }, label: {
      Text("Log out")
    })
  }
}

import SwiftUI

struct Registration: View {
  @ObservedObject var user: User

  var body: some View {
    Text("REGISTRATION HERE! \(user.username)")
  }
}

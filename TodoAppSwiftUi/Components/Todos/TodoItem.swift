import SwiftUI

struct TodoItem: View {
  var todo: Todo

  init(_ todo: Todo) {
    self.todo = todo
  }

  var body: some View {
    VStack {

    }.frame(width: 50, height: 60).background(.red)
  }
}

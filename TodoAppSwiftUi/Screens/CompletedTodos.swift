import SwiftUI

struct CompletedTodos: View {
  @StateObject var todos = Todos()

  init() {
    NavigationBarSettings(
      titleColor: .white,
      backgroundColor: ColorsState.getUIColor(.darkBackground),
      tintColor: .white,
      shadowColor: .clear
    )
  }

  var body: some View {
    NavigationView {

      VStack {
        ForEach(todos.completedTodos) { todo in
          Text(todo.name)
        }
      }
        
        .navigationTitle(Text("Completed ToDo's"))
    }
  }
}

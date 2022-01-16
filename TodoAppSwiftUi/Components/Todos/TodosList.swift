import SwiftUI

struct TodosList: View {
  @ObservedObject var todoModel: TodosViewModel
  @State var todos: [Todo]

  @State var newTodoName = ""

  init() {
    let todoModel = TodosViewModel()
    todos = todoModel.todos
    self.todoModel = todoModel
  }

  var body: some View {
    let isDisabledButton = newTodoName.count < 3

    VStack {
      TodoInputField(text: $newTodoName)
        .padding(.top)
        .font(Font.callout.weight(.black))

      Button(action: {

      }, label: {
        Text("Add")
          .foregroundColor(.white).font(Font.body.weight(.black))
          .frame(maxWidth: .infinity).frame(height: 60)
          .background(isDisabledButton
            ? Color(hex: ColorsState.Scheme.lightBackground.rawValue).opacity(0.5).cornerRadius(8)
            : Color(hex: ColorsState.Scheme.lightBackground.rawValue).cornerRadius(8))
      }).disabled(isDisabledButton)
        .animation(.easeInOut, value: isDisabledButton)
        .padding(.top, 20)

      ForEach(todos) { todo in
        TodoItem(todo)
      }

      Spacer()
    }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.horizontal)

  }
}

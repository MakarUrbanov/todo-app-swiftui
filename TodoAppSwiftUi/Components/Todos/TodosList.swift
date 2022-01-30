import SwiftUI

struct TodosList: View {
  @ObservedObject var todoModel: TodosViewModel

  @State var newTodoName = ""

  init() {
    let todoModel = TodosViewModel()
    self.todoModel = todoModel
  }

  var body: some View {
    let isDisabledButton = newTodoName.count < 3
    VStack {
      VStack {
        TodoInputField(text: $newTodoName)
          .padding(.top)
          .font(Font.callout.weight(.black))
          .onSubmit {
            if !isDisabledButton {
              addNewTodo()
              newTodoName = ""
            }
          }

        Button(action: {
          addNewTodo()
          newTodoName = ""
        }, label: {
          Text("Add")
            .foregroundColor(.white).font(Font.body.weight(.black))
            .frame(maxWidth: .infinity).frame(height: 60)
            .background(isDisabledButton
              ? Color(hex: ColorsState.Scheme.lightBackground.rawValue).opacity(0.5).cornerRadius(8)
              : Color(hex: ColorsState.Scheme.lightBackground.rawValue).cornerRadius(8))
        }).disabled(isDisabledButton)
          .animation(.easeInOut, value: isDisabledButton)
          .padding(.top, 10)
      }.padding(.horizontal)

      if todoModel.isLoading {
        ProgressView("Loading...").frame(maxWidth: .infinity, maxHeight: 200)
      } else if todoModel.todos.isEmpty {
        Text("Add your first todo")
          .fontWeight(.black)
          .font(.system(size: 26))
          .frame(maxHeight: 200)
      } else {
        List {
          ForEach(todoModel.todos) { todo in
            TodoItem(todo: todo, todosViewModel: todoModel)
              .listRowSeparator(.hidden)
              .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
          }
            .onDelete(perform: { index in
              todoModel.removeTodo(atOffsets: index)
            })
        }.listStyle(.plain)
          .padding(.top).padding(.horizontal)
      }

      Spacer()
    }.frame(maxWidth: .infinity, maxHeight: .infinity)

  }

  func addNewTodo() {
    let newTodo = Todo(name: newTodoName)
    todoModel.todos.append(newTodo)
  }
}

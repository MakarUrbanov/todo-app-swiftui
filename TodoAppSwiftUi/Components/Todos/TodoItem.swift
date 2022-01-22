import SwiftUI

struct TodoItem: View {
  var todo: Todo
  @State var todoName: String
  @State var isCompleted: Bool

  let todosViewModel = TodosViewModel()

  init(_ todo: Todo) {
    self.todo = todo
    _todoName = State(initialValue: todo.name)
    _isCompleted = State(initialValue: todo.isCompleted ?? false)
  }

  @State var isPresentedSuccessModal: Bool = false

  var body: some View {
    let background = Color(.gray).opacity(0.15)

    HStack {
      Spacer()

      ZStack {
        Circle()
          .foregroundColor(.white)
          .frame(width: 35, height: 35)

          .overlay {
            Circle()
              .frame(width: 20, height: 20)
              .foregroundColor(isCompleted ? Color(hex: ColorsState.Scheme.lightBackground.rawValue) : .clear)
          }
          .animation(.easeInOut(duration: 0.2), value: isCompleted)
      }.onTapGesture(perform: {
        todosViewModel.changeComplete(id: todo.id, isComplete: !isCompleted) { newValue in
          isCompleted = newValue
        }
      })

      Spacer()

      VStack(alignment: .leading) {
        CustomTextField(text: $todoName, label: Text(todoName))
          .onSubmit {
            todosViewModel.editTodoName(newName: todoName, id: todo.id) { bool in
              if bool {
                isPresentedSuccessModal = true
              }
            }
          }

        Text(todo.dateFrom, style: .date)
          .frame(height: 5)
          .font(.system(size: 10)).foregroundColor(.gray.opacity(0.7))
      }.padding(.horizontal)

      Spacer()

      Image(systemName: "checkmark")
        .foregroundColor(.blue.opacity(isPresentedSuccessModal ? 1 : 0))
        .onChange(of: isPresentedSuccessModal) { _ in
          if isPresentedSuccessModal {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
              isPresentedSuccessModal = false
            })
          }
        }
        .animation(.easeInOut, value: isPresentedSuccessModal)

      Spacer()

    }.frame(maxWidth: .infinity).frame(height: 50)
      .background(background)
      .cornerRadius(8)
  }
}

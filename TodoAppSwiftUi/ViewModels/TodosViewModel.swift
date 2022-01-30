import Foundation

class TodosViewModel: Todos {
  override init() {
    super.init()
  }

  func addNewTodo(name: String) -> Todo {
    let newTodo = Todo(name: name)

    let newTodos = todos + [newTodo]
    todos = newTodos

    return newTodo
  }

  func overrideTodos(_ todos: [Todo]) {
    super.todos = todos
  }

  func editTodoName(newName: String, id: String, isSuccess: @escaping (Bool) -> Void) {
    guard
      let todoIndex = todos.firstIndex(where: { $0.id == id })
      else {
      isSuccess(false)
      return
    }

    super.todos[todoIndex].name = newName
    isSuccess(true)
  }

  func removeTodo(atOffsets: IndexSet) {
    todos.remove(atOffsets: atOffsets)
  }

  func changeComplete(id: String, isComplete: Bool, newValue: @escaping (Bool) -> Void) {
    guard
      let todoIndex = todos.firstIndex(where: { $0.id == id })
      else {
      newValue(!isComplete)
      return
    }

    var todo = todos[todoIndex]
    todo.isCompleted = isComplete

    if isComplete {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
        self.completedTodos.append(todo)
        let todoIndexSet: IndexSet = [todoIndex]
        self.removeTodo(atOffsets: todoIndexSet)
      })
    }

    newValue(isComplete)
  }

  func removeAll() { // TODO DELETE
    UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.todos.rawValue)
  }
}

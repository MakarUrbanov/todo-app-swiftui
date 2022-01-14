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

  func removeTodo(id: Date) {
//    let newArray = todos.filter {
//      $0.id != id
//    }

//    todos = newArray
  }

  func removeAll() { // TODO DELETE
    UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.todos.rawValue)
  }
}

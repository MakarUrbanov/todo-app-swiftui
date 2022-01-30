import Foundation

struct Todo: Codable, Identifiable {
  var name: String
  var dateFrom: Date = Date()
  var isCompleted: Bool? = false
  var id: String = UUID().uuidString
}

class Todos: ObservableObject {
  @Published var todos: [Todo] = [] {
    didSet {
      saveTodosToUserDefaults()
    }
  }
  @Published var completedTodos: [Todo] = [] {
    didSet {
      saveCompletedTodosToUserDefaults()
    }
  }

  @Published var isLoading: Bool = true

  enum UserDefaultsKeys: String {
    case todos
    case completedTodos
  }

  init() {
    setTodosFromUserDefaults()
  }

  private func saveTodosToUserDefaults() {
    guard let data = try? JSONEncoder().encode(todos) else {
      return
    }

    UserDefaults.standard.set(data, forKey: UserDefaultsKeys.todos.rawValue)
  }

  private func saveCompletedTodosToUserDefaults() {
    guard let data = try? JSONEncoder().encode(completedTodos) else {
      return
    }

    UserDefaults.standard.set(data, forKey: UserDefaultsKeys.completedTodos.rawValue)
  }

  private func setTodosFromUserDefaults() {
    isLoading = true
    guard
      let todosData = try? UserDefaults.standard.data(forKey: UserDefaultsKeys.todos.rawValue),
      let encodedTodosData = try? JSONDecoder().decode([Todo].self, from: todosData),

      let completedTodosData = try? UserDefaults.standard.data(forKey: UserDefaultsKeys.completedTodos.rawValue),
      let encodedCompletedTodosData = try? JSONDecoder().decode([Todo].self, from: completedTodosData)
      else {
      return
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { // api simulation
      self.todos = encodedTodosData
      self.completedTodos = encodedCompletedTodosData
      self.isLoading = false
    })
  }
}

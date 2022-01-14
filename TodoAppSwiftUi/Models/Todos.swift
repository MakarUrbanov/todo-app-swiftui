import Foundation

struct Todo: Codable, Identifiable {
  var name: String
  var dateFrom: Date = Date()
  var isCompleted: Bool? = false
  var id: String = UUID().uuidString
}

class Todos: ObservableObject {
  @Published var todos: [Todo] = Array() {
    didSet {
      saveItemsUserDefaults()
    }
  }

  enum UserDefaultsKeys: String {
    case todos
  }

  init() {
    setTodosFromUserDefaults()
  }

  private func saveItemsUserDefaults() {
    guard let data = try? JSONEncoder().encode(todos) else {
      return
    }

    UserDefaults.standard.set(data, forKey: UserDefaultsKeys.todos.rawValue)
  }

  private func setTodosFromUserDefaults() {
    guard
      let data = try? UserDefaults.standard.data(forKey: UserDefaultsKeys.todos.rawValue),
      let encodedData = try? JSONDecoder().decode([Todo].self, from: data)
      else {
      return
    }

    todos = encodedData
  }


}

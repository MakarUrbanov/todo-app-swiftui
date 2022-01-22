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
  @Published var isLoading: Bool = true

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
    isLoading = true
    guard
      let data = try? UserDefaults.standard.data(forKey: UserDefaultsKeys.todos.rawValue),
      let encodedData = try? JSONDecoder().decode([Todo].self, from: data)
      else {
      return
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { // api simulation
      self.todos = encodedData
      self.isLoading = false
    })
  }
}

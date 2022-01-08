import Foundation

enum RegistrationErrors: String {
  case shortPass = "Password is too short"
  case shortUsername = "Username is too short"
  case allowed = ""
}

func checkRegistration(username: String, password: String) -> RegistrationErrors {
  switch true {
  case username.count < 3:
    return .shortUsername
  case password.count < 3:
    return .shortPass
  default:
    return .allowed
  }
}

class User: ObservableObject {
  @Published private(set) var isAuth: Bool = false
  @Published var username: String = ""
  @Published private var password: String = ""

  init() {
    let storageUsername = UserDefaults.standard.object(forKey: "username") as? String ?? ""
    let storagePassword = UserDefaults.standard.object(forKey: "userPassword") as? String ?? ""
    username = storageUsername
    password = storagePassword
  }

  func register(username: String, password: String, completion: @escaping (Bool, RegistrationErrors) -> Void) {
    let registrationStatus: RegistrationErrors = checkRegistration(username: username, password: password)

    if registrationStatus != .allowed {
      completion(false, registrationStatus)
      return
    }

    self.username = username
    self.password = password
  }
}

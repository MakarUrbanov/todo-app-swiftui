import Foundation

enum SignInErrors: String {
  case doesNotMatch = "Password or login does not match"
  case allowed = ""
}

enum SignUpErrors: String {
  case shortPass = "Password is too short"
  case shortUsername = "Username is too short"
  case allowed = ""
}

func checkRegistration(username: String, password: String) -> SignUpErrors {
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
    let storageIsAuth = UserDefaults.standard.object(forKey: "isAuth") as? Bool ?? false
    username = storageUsername
    password = storagePassword
    isAuth = storageIsAuth
  }

  func setUserDefaults(username: String, password: String, isAuth: Bool) {
    UserDefaults.standard.set(username, forKey: "username")
    self.username = username
    UserDefaults.standard.set(password, forKey: "password")
    self.password = password
    UserDefaults.standard.set(isAuth, forKey: "isAuth")
    self.isAuth = isAuth
  }

  func signUp(username: String, password: String, completion: @escaping (Bool, SignUpErrors) -> Void) {
    let registrationStatus: SignUpErrors = checkRegistration(username: username, password: password)

    if registrationStatus != .allowed {
      completion(false, registrationStatus)
      return
    }

    setUserDefaults(username: username, password: password, isAuth: true)
    completion(true, registrationStatus)
  }

  func signIn(username: String, password: String, completion: @escaping (Bool, SignInErrors) -> Void) {
    let isPassMatch: Bool = password == self.password && !password.isEmpty
    let isUsernameMatch: Bool = username == self.username && !username.isEmpty

    if isPassMatch && isUsernameMatch {
      setUserDefaults(username: username, password: password, isAuth: true)
      completion(true, .allowed)
      return
    }

    completion(false, .doesNotMatch)
  }

  func logOut() {
    setUserDefaults(username: username, password: password, isAuth: false)
  }
}

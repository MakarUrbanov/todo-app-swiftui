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

  enum UserDefaultsKeys: String {
    case username, password, isAuth
  }

  init() {
    let storageUsername = UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue) ?? ""
    let storagePassword = UserDefaults.standard.string(forKey: UserDefaultsKeys.password.rawValue) ?? ""
    let storageIsAuth = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isAuth.rawValue)
    username = storageUsername
    password = storagePassword
    isAuth = storageIsAuth
  }

  func setUserDefaults(username: String, password: String, isAuth: Bool) {
    UserDefaults.standard.set(username, forKey: UserDefaultsKeys.username.rawValue)
    self.username = username

    UserDefaults.standard.set(password, forKey: UserDefaultsKeys.password.rawValue)
    self.password = password

    UserDefaults.standard.set(isAuth, forKey: UserDefaultsKeys.isAuth.rawValue)
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

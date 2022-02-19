import SwiftUI

struct FieldsSignIn: View {
  @Binding var username: String
  @Binding var password: String
  @ObservedObject var user: User
  @Binding var isOpenSignUp: Bool
  @State var errorMessage: String = ""
  @FocusState var isFocusPasswordField: Bool

  let lightBackground = ColorsState.getColor(.lightBackground)
  let darkBackground = ColorsState.getColor(.darkBackground)

  func signIn() {
    user.signIn(username: username, password: password) { _, errorMode in
      errorMessage = errorMode.rawValue
    }
  }

  var body: some View {

    VStack {
      VStack {
        Text("Sing In").fontWeight(.bold).font(.system(size: 35)).foregroundColor(.white)

        // Username field
        CustomTextField(text: $username, label: Text("Username").foregroundColor(.white), isSecure: false)
          .padding(.horizontal, 4)
          .foregroundColor(.white)
          .disableAutocorrection(true)
          .autocapitalization(.none)
          .onChange(of: username, perform: { _ in
            errorMessage = ""
          })
          .onSubmit(of: .text) {
            isFocusPasswordField = true
          }

        Divider().frame(height: 2).background(errorMessage.isEmpty ? .white : .red)

        // Password field
        CustomTextField(text: $password, label: Text("Password").foregroundColor(.white), isSecure: true)
          .padding(.horizontal, 4)
          .foregroundColor(.white)
          .padding(.top, 20)
          .disableAutocorrection(true)
          .autocapitalization(.none)
          .onChange(of: password, perform: { _ in
            errorMessage = ""
          })
          .onSubmit(of: .text) {
            signIn()
          }
          .focused($isFocusPasswordField)

        Divider().frame(height: 2).background(errorMessage.isEmpty ? .white : .red)

      }
        .padding(.horizontal, 28)
        .frame(height: 250)
        .background(lightBackground)
        .cornerRadius(12)
    }
      .padding(.horizontal, 20)

      .accentColor(.white)

    Text(errorMessage + " ").fontWeight(.light).foregroundColor(.red)

    Button(action: {
      signIn()
    }, label: {
      Text("Sign In")
        .frame(width: 250, height: 50)
        .background(errorMessage.isEmpty ? darkBackground : darkBackground.opacity(0.4))
        .cornerRadius(12)
        .foregroundColor(.white)
        .font(.system(size: 20, weight: .bold, design: .default))
    })
      .padding(.top, 6).disabled(!errorMessage.isEmpty)

    HStack {
      Text("Don't have an account?").fontWeight(.thin)
      Button(action: {
        isOpenSignUp = true
      }, label: {
        Text("Sign up").foregroundColor(darkBackground)
          .fontWeight(.thin)
          .padding(.horizontal, 5)
          .padding(.vertical, 2)
          .background(.white)
          .cornerRadius(8)
      })
    }
      .padding(.top, 10)
  }
}

struct SignIn: View {
  @EnvironmentObject var user: User
  @State var username: String = ""
  @State var password: String = ""
  @State var isOpenSignUp: Bool = false

  init() {
    NavigationBarSettings(titleColor: .white, backgroundColor: .clear, tintColor: .clear, shadowColor: .clear)
  }

  var body: some View {
    NavigationView {
      VStack {
        FieldsSignIn(username: $username, password: $password, user: user, isOpenSignUp: $isOpenSignUp)
      }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitle(Text("Todo App"), displayMode: .large)
        .onAppear {
          if !user.username.isEmpty {
            username = user.username
          }
        }
        .background {
          Image("back2")
            .resizable()
            .edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: $isOpenSignUp, content: {
          ZStack {
            SignUp(isOpenSignUp: $isOpenSignUp)
          }
            .overlay(alignment: .top, content: {
              RoundedRectangle(cornerRadius: 6)
                .frame(width: 55, height: 5)
                .foregroundColor(.white)
                .padding(.top, 10)
                .opacity(0.5)
            })
        })
    }

  }
}

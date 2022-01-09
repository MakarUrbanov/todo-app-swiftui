import Foundation
import SwiftUI

struct SignUp: View {
  enum FocusFields {
    case username
    case password
  }

  @ObservedObject var user: User
  @Binding var isOpenSignUp: Bool
  @State var username: String = ""
  @State var password: String = ""
  @State var errorMessage: String = ""
  @FocusState private var focusedField: FocusFields?

  let lightBackground = Color(hex: ColorsState.get(.lightBackground))
  let darkBackground = Color(hex: ColorsState.get(.darkBackground))


  func signUp() {
    user.signUp(username: username, password: password) { isSuccess, errorMode in
      errorMessage = errorMode.rawValue
      if isSuccess {
        isOpenSignUp = false
      }
    }
  }

  var body: some View {
    VStack {


      VStack {
        VStack {
          Text("Sing Up").fontWeight(.bold).font(.system(size: 35)).foregroundColor(.white)

          // Username field
          CustomTextField(text: $username, label: Text("Username").foregroundColor(.white), isSecure: false)
            .padding(.horizontal, 4)
            .foregroundColor(.white)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .onChange(of: username, perform: { _ in
              errorMessage = ""
            })
            .focused($focusedField, equals: .username)
            .onAppear {
              focusedField = .username
            }
            .onSubmit(of: .text) {
              focusedField = .password
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
            }).onSubmit(of: .text) {
              signUp()
            }.focused($focusedField, equals: .password)

          Divider().frame(height: 2).background(errorMessage.isEmpty ? .white : .red)

        }.padding(.horizontal, 28)
          .frame(height: 250)
          .background(lightBackground)
          .cornerRadius(12)
      }.padding(.horizontal, 20)

        .accentColor(.white)

      Text(errorMessage + " ").fontWeight(.light).foregroundColor(.red)

      Button(action: {
        signUp()
      }, label: {
        Text("Sign Up")
          .frame(width: 250, height: 50)
          .background(errorMessage.isEmpty ? darkBackground : darkBackground.opacity(0.4))
          .cornerRadius(12)
          .foregroundColor(.white)
          .font(.system(size: 20, weight: .bold, design: .default))
      }).padding(.top, 6).disabled(!errorMessage.isEmpty)
    }.frame(maxWidth: .infinity, maxHeight: .infinity).background {
      ZStack {
        Image("back2")
          .resizable()
          .edgesIgnoringSafeArea(.all)
          .opacity(0.8)
      }.background(.white)
    }
  }
}

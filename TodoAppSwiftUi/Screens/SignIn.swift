import SwiftUI

struct FieldsSignIn: View {
  @Binding var username: String
  @Binding var password: String
  @ObservedObject var user: User
  @Binding var isOpenSignUp: Bool
  @State var errorMessage: String = ""

  var body: some View {
    VStack {
      VStack {
        Text("Sing In").fontWeight(.bold).font(.system(size: 35)).foregroundColor(.white)

        CustomTextField(text: $username, label: Text("Username").foregroundColor(.white), isSecure: false)
          .padding(.horizontal, 4)
          .foregroundColor(.white)
          .disableAutocorrection(true)
          .onChange(of: username, perform: { _ in
            errorMessage = ""
          })

        Divider().frame(height: 2).background(errorMessage.isEmpty ? .white : .red)

        CustomTextField(text: $password, label: Text("Password").foregroundColor(.white), isSecure: true)
          .padding(.horizontal, 4)
          .foregroundColor(.white)
          .padding(.top, 20)
          .disableAutocorrection(true)
          .onChange(of: password, perform: { _ in
            errorMessage = ""
          })

        Divider().frame(height: 2).background(errorMessage.isEmpty ? .white : .red)

      }.padding(.horizontal, 28)
        .frame(height: 250)
        .background(.blue)
        .cornerRadius(12)
    }.padding(.horizontal, 20)

      .accentColor(.white)

    Text(errorMessage + " ").fontWeight(.light).foregroundColor(.red)

    Button(action: {
      user.signIn(username: username, password: password) { _, errorMode in
        errorMessage = errorMode.rawValue
      }
    }, label: {
      Text("Sign In")
        .frame(width: 250, height: 50)
        .background(errorMessage.isEmpty ? .blue : .gray)
        .cornerRadius(12)
        .foregroundColor(.white)
        .font(.system(size: 20, weight: .bold, design: .default))
    }).padding(.top, 6).disabled(!errorMessage.isEmpty)

    HStack {
      Text("Don't have an account?").fontWeight(.thin)
      Button(action: {
        isOpenSignUp = true
      }, label: { Text("Sign up").foregroundColor(.blue).fontWeight(.thin) })
    }.padding(.top, 10)
  }
}

struct SignIn: View {
  @ObservedObject var user: User
  @State var username: String = ""
  @State var password: String = ""
  @State var isOpenSignUp: Bool = false

  var body: some View {
    NavigationView {
      VStack {
        FieldsSignIn(username: $username, password: $password, user: user, isOpenSignUp: $isOpenSignUp)
          .sheet(isPresented: $isOpenSignUp, content: {
            SignUp(user: user)
          })
      }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitle("Todo App", displayMode: .large)
        .offset(y: -60)
        .onAppear {
          if !user.username.isEmpty {
            username = user.username
          }
        }
    }

  }
}

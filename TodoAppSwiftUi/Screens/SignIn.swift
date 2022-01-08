import SwiftUI

struct FieldsSignIn: View {
  @Binding var username: String
  @Binding var password: String
  @ObservedObject var user: User
  @Binding var isOpenSignUp: Bool

  var body: some View {
    VStack {
      VStack {
        Text("Sing In").fontWeight(.bold).font(.system(size: 35)).foregroundColor(.white)

        CustomTextField(text: $username, label: Text("Username").foregroundColor(.white), isSecure: false)
          .padding(.horizontal, 4)
          .foregroundColor(.white)
          .disableAutocorrection(true)

        Divider().background(.white)

        CustomTextField(text: $password, label: Text("Password").foregroundColor(.white), isSecure: true)
          .padding(.horizontal, 4)
          .foregroundColor(.white)
          .padding(.top, 20)
          .disableAutocorrection(true)

        Divider().background(.white)

      }.padding(.horizontal, 28)
        .frame(height: 250)
        .background(.blue)
        .cornerRadius(12)
    }.padding(.horizontal, 20)

      .accentColor(.white)

    Button(action: {
      user.signIn(username: username, password: password) { isSuccess, errorMode in
        print(isSuccess)
        print(errorMode)
      }
    }, label: {
      Text("Sign In")
        .frame(width: 250, height: 50)
        .background(.blue)
        .cornerRadius(12)
        .foregroundColor(.white)
        .font(.system(size: 20, weight: .bold, design: .default))
    }).padding(.top, 16)

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
            Text("Hello")
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

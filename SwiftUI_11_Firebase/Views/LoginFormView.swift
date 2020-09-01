

import SwiftUI
import FirebaseAuth

struct LoginFormView: View {
    
    @State private var email = ""
    @State private var password = ""
    @Binding var isLogged: Bool
    
    var body: some View {
        VStack {
            Text("Inicio de Session")
                .font(.system(.title, design: .rounded))
                .bold()
                .foregroundColor(Color(.cyan))
            VStack{
                TextField("Email", text: self.$email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Password", text: self.$password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding()
            VStack (alignment: .center, spacing: 20) {
                Button(action: {
                    Auth.auth().signIn(withEmail: self.email, password: self.password) { (user, error) in
                        if error != nil {
                            print(error)
                        } else if user != nil {
                            print("************* Usuario Logado *************")
                            self.isLogged = true
                            
                            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
                        } else {
                            print("Algo ha salido mal")
                        }
                    }
                }) {
                    Text("Entrar")
                }
                Button(action: {
                    Auth.auth().createUser(withEmail: self.email, password: self.password) { (user, error) in
                        if error != nil {
                            print(error)
                        } else if user != nil {
                            print("************* Usuario Registrado *************")
                        } else {
                            print("Algo ha salido mal")
                        }
                    }
                }) {
                    Text("Registrar")
                }
            }
        }
    }
}

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView(isLogged: .constant(false))
    }
}

//
//  LoginFormView.swift
//  SwiftUI_11_Firebase
//
//  Created by Everis on 01/09/2020.
//  Copyright © 2020 Alan. All rights reserved.
//

import SwiftUI

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
                    
                }) {
                    Text("Entrar")
                }
                Button(action: {
                    
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

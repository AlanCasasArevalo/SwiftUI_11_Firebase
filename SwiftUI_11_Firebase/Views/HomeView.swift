//
//  HomeView.swift
//  SwiftUI_11_Firebase
//
//  Created by Everis on 01/09/2020.
//  Copyright © 2020 Alan. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @Binding var isLogged: Bool
    
    var body: some View {
        NavigationView{
            ZStack {
                List {
                    ForEach(1..<10) { item in
                        Text("Post \(item)")
                    }
                }
            }.navigationBarTitle("Inicio")
                .navigationBarItems(leading: Button(action: {
                    self.loggout()
                }, label: {
                    Text("Salir")
                }))
        }
    }
}

extension HomeView {
    private func loggout () {
        do {
            try Auth.auth().signOut()
            self.isLogged = false
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isLogged: .constant(false))
    }
}

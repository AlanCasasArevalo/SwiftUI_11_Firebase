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
    @State var showModal: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack {
                List {
                    ForEach(1..<10) { item in
                        Text("Post \(item)")
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image(systemName: "plus")
                                .font(.system(.title, design: .rounded))
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .background(Color(.blue))
                                .clipShape(Circle())
                                .padding(16)
                                .shadow(color: Color(.black), radius: 6, x: 5, y: 5)
                        }
                    }
                }
            }.navigationBarTitle("Inicio")
                .navigationBarItems(leading: Button(action: {
                    self.loggout()
                }, label: {
                    Text("Salir")
                }))
        }
        .sheet(isPresented: self.$showModal) {
            PostNewView(showModal: self.$showModal)
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

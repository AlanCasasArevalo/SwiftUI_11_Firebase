//
//  HomeView.swift
//  SwiftUI_11_Firebase
//
//  Created by Everis on 01/09/2020.
//  Copyright © 2020 Alan. All rights reserved.
//

import SwiftUI

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
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isLogged: .constant(false))
    }
}

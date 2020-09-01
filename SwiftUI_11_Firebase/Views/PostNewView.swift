//
//  PostNewView.swift
//  SwiftUI_11_Firebase
//
//  Created by Everis on 01/09/2020.
//  Copyright © 2020 Alan. All rights reserved.
//

import SwiftUI

struct PostNewView: View {
    
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                HStack (alignment: .center, spacing: 40) {
                    Button(action: {
                        self.showModal.toggle()
                    }) {
                        Text("Cancelar")
                    }
                    Button(action: {
                        print("Publicar")
                    }) {
                        Text("Publicar")
                    }
                }
            }
        }
    }
}

struct PostNewView_Previews: PreviewProvider {
    static var previews: some View {
        PostNewView(showModal: .constant(false))
    }
}

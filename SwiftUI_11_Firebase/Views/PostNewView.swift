

import SwiftUI

struct PostNewView: View {
    
    @Binding var showModal: Bool
    @State private var title = ""
    @State private var resume = ""
    
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
                TextField("Title", text: self.$title)
                MultilineTextAreaView(text: self.$resume)
            }
        }
    }
}

struct PostNewView_Previews: PreviewProvider {
    static var previews: some View {
        PostNewView(showModal: .constant(false))
    }
}

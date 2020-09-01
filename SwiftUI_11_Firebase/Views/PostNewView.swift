

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

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
                        self.saveNewPost()
                        self.showModal.toggle()
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

extension PostNewView {
    private func saveNewPost () {
        let db = Firestore.firestore()
        
        db.collection("Posts").addDocument(data: createFields()) { (error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("***** Se ha guardado todo bien *****")
            }
        }
    }
    
    private func createFields () -> [String: Any] {
        let fields: [String: Any] = [
            "Title": self.title,
            "Text": self.resume,
            "Email": getCurrentUserEmail(),
        ]
        return fields
    }
    
    private func getCurrentUserEmail () -> String {
        let email = Auth.auth().currentUser?.email ?? ""
        return email
    }
        
}

struct PostNewView_Previews: PreviewProvider {
    static var previews: some View {
        PostNewView(showModal: .constant(false))
    }
}

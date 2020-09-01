
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct EditView: View {
    
    var post: PostModel
    
    @State private var title: String = ""
    @State private var resume: String = ""
    
    @Environment(\.presentationMode) var back
    
    var body: some View {
        VStack (alignment: .center, spacing: 24) {
            TextField("Title", text: self.$title)
            MultilineTextAreaView(text: self.$resume)
                .frame(height: 300)
            Button(action: {
                self.editPost()
            }) {
                Text("Editar")
            }
        }.onAppear {
            self.title = self.post.title
            self.resume = self.post.resume
        }
    }
}

extension EditView {
    private func editPost () {
        let db = Firestore.firestore()
        
        let id = self.post.id
        
        db.collection("Posts").document(id).updateData(createFields()) { (error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("Se edito correctamente")
                self.back.wrappedValue.dismiss()
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

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(post: .init(id: "1", title: "Menorca", resume: "Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin,  Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin", email: "hhh@hh.com"))
    }
}

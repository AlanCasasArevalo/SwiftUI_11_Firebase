

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

struct PostNewView: View {
    
    @Binding var showModal: Bool
    @State private var title = ""
    @State private var resume = ""
    
    @State private var imageData: Data = .init(capacity: 0)
    @State private var showMenu: Bool = false
    @State private var imagePicker: Bool = false
    @State private var source: UIImagePickerController.SourceType = .camera
    
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ImagePicker(show: self.$imagePicker, image: self.$imageData, source: self.source), isActive: self.$imagePicker) {
                    Text("")
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                
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
                    .frame(height: 250)
                
                if self.imageData.count != 0 {
                    Image(uiImage: UIImage(data: self.imageData) ?? UIImage())
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(15)
                }
                
                Button(action: {
                    self.showMenu.toggle()
                }) {
                    Text("Cargar imagen")
                }
                .actionSheet(isPresented: self.$showMenu) {
                    ActionSheet(title: Text("Mennu"), message: Text("Selecciona una opcion"), buttons: [
                        .default(Text("Camara"), action: {
                            self.source = .camera
                            self.imagePicker.toggle()
                        }),
                        .default(Text("Libreria"), action: {
                            self.source = .photoLibrary
                            self.imagePicker.toggle()
                        }),
                        .default(Text("Cancelar"))
                    ])
                }
                Spacer()
            }
            .padding(24)
        }
    }
}

extension PostNewView {
    private func saveNewPost () {
        
        // Guardar en el storage (imagenes por ejemplo)
        let storage = Storage.storage().reference()
        let imageName = UUID()
        let folder = storage.child("postImage/\(imageName)")
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        folder.putData(self.imageData, metadata: metaData) { (metaData, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("***** Se ha guardado correctamente la imagen *****")
            }
        }
        
        // Guarda Texto
        let db = Firestore.firestore()
        
        db.collection("Posts").addDocument(data: createFields()) { (error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
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

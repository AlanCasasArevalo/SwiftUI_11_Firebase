
import Combine
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class PostsModel: ObservableObject {
    @Published var posts = [PostModel]()
    
    init() {
        let db = Firestore.firestore()
        db.collection("Posts").addSnapshotListener { (QuerySnapshot, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                self.posts.removeAll()
                for document in QuerySnapshot?.documents ?? [] {
                    let value = document.data()
                    let id = document.documentID
                    let title = value["Title"] as? String ?? ""
                    let resume = value["Text"] as? String ?? ""
                    let email = value["Email"] as? String ?? ""
                    let image = value["Image"] as? String ?? ""
                    DispatchQueue.main.async {
                        let post = PostModel(id: id, title: title, resume: resume, email: email, image: image)
                        self.posts.append(post)
                    }
                }
            }
        }        
    }
}

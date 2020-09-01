
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct HomeView: View {
    
    @Binding var isLogged: Bool
    @State var showModal: Bool = false
    
    @ObservedObject var posts = PostsModel()
    
    var body: some View {
        NavigationView{
            ZStack {
                List {
                    ForEach(self.posts.posts) { item in
                        CardView(post: item)
                    }
                    .onDelete { (index) in
                        self.deletePost(index: index)
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            self.showModal.toggle()
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

extension HomeView {
    private func deletePost (index: IndexSet) {
        let id = self.posts.posts[index.first ?? 0].id
        let db = Firestore.firestore()
        db.collection("Posts").document(id).delete()
        self.posts.posts.remove(atOffsets: index)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isLogged: .constant(false))
    }
}

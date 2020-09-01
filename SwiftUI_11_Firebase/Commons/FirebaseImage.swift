
import SwiftUI
import UIKit

let defaultImage = UIImage(systemName: "person.fill")

struct FirebaseImage: View {
    @ObservedObject var imageLoader: Loader
    
    init(imageUrl: String) {
        self.imageLoader = Loader(imageUrl: imageUrl)
    }
    
    var image: UIImage? {
        self.imageLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        Image(uiImage: image ?? defaultImage!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .background(Color(.systemGray5))
            .cornerRadius(25)
            .cornerRadius(25)
            .shadow(radius: 5)
    }
}

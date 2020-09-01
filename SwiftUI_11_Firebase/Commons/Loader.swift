
import Foundation
import FirebaseStorage
import Combine

class Loader: ObservableObject {
    
    var didChange = PassthroughSubject<Data?, Never>()
    
    @Published var data: Data? = nil {
        didSet {
            didChange.send(data)
        }
    }
 
    init(imageUrl: String) {
        let storageImage = Storage.storage().reference(forURL: imageUrl)
        storageImage.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                DispatchQueue.main.async {
                    self.data = data
                }
            }
        }
    }
    
}

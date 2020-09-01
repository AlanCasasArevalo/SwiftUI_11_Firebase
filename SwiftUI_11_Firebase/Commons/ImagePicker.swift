

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var show: Bool
    @Binding var image: Data
    var source: UIImagePickerController.SourceType

    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(conection: self)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imageController = UIImagePickerController()
        imageController.sourceType = source
        imageController.allowsEditing = true
        imageController.delegate = context.coordinator
        
        return imageController
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
       
        var conection: ImagePicker
        
        init(conection: ImagePicker) {
            self.conection = conection
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.conection.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            guard let data = image.jpegData(compressionQuality: 0.7) else { return }
            self.conection.image = data
            self.conection.show.toggle()
        }
        
    }

}

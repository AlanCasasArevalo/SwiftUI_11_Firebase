
import SwiftUI

struct MultilineTextAreaView: UIViewRepresentable {

    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        return MultilineTextAreaView.Coordinator.init(connection: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let text = UITextView()
        text.isEditable = true
        text.isUserInteractionEnabled = true
        text.text = self.text.isEmpty ? "Escribe algo ...." : self.text
        text.textColor = .gray
        text.font = .systemFont(ofSize: 15)
        text.delegate = context.coordinator
        return text
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var connection: MultilineTextAreaView
        init(connection: MultilineTextAreaView) {
            self.connection = connection
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .black
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.connection.text = textView.text
        }
    }
    
}


import SwiftUI

struct ContentView: View {
    
    @State var isLogged = false
    
    var body: some View {
        return Group {
            if isLogged {
                HomeView(isLogged: self.$isLogged)
            } else {
                LoginFormView(isLogged: self.$isLogged)
            }
        }.onAppear{
            if UserDefaults.standard.bool(forKey: "isLogged") {
                self.isLogged = UserDefaults.standard.bool(forKey: "isLogged")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

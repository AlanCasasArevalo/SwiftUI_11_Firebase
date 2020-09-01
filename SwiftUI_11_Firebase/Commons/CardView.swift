

import SwiftUI

struct CardView: View {
    
    var post: PostModel
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (alignment: .top) {
                Image(systemName: "person.fill")
                    .font(.largeTitle)
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(.cyan))
                    .background(Color(.systemGray5))
                    .cornerRadius(25)
                
                VStack (alignment: .leading) {
                    Text(post.email)
                        .font(.system(.caption, design: .rounded))
                    Text(post.title)
                        .font(.system(.title, design: .rounded))
                }
            }
            VStack (alignment: .leading) {
                Text(post.resume)
                    .font(.system(.headline, design: .rounded))
            }.padding()
        }.padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(post: .init(id: "1", title: "Menorca", resume: "Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin,  Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin, Aqui de relax en menorca de vacaciones por fin", email: "hhh@hh.com"))
    }
}


import SwiftUI

struct RepositoryCell: View {
    
    var repoItem: RepositoryItem
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: repoItem.owner.avatarURL.absoluteString)) { image in
                    image.resizable()
                } placeholder: {
                    Color.red
                }
                .frame(width: 25, height: 25)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                
                Text(repoItem.owner.login)
            }
            repoItem.description
                .map(Text.init)?
                .lineLimit(nil)
            
            HStack {
                Image(systemName: "star")
                Text("\(repoItem.stars)")
            }
        }
    }
}

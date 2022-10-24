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
                
                Text("\(repoItem.owner.login)/\(repoItem.name)").bold()
            }
            repoItem.description
                .map(Text.init)?
                .lineLimit(nil)
                .padding(.vertical, 5)
            
            HStack {
                Image(systemName: "star")
                
                Text("\(repoItem.stars)")
                
                if (repoItem.language != nil) {
                    Text(repoItem.language ?? "")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 1)
                        .foregroundColor(Color.theme.accent)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
                }
            }
        }
    }
}

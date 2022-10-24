import Foundation

public struct User: Codable, Hashable, Identifiable {
    public var id: Int
    public var login: String
    public var avatarURL: URL
    
    public enum CodingKeys: String, CodingKey {
        case id, login
        case avatarURL = "avatar_url"
    }
}

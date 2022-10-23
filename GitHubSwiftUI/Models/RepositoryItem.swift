
import Foundation

public struct RepositoryItem: Codable, Identifiable, Hashable {
    
    public var id: Int
    public var name: String
    public var description: String?
    public var language: String?
    public var fullName: String
    public var stars: Int = 0
    public var repositoryURL: URL
    public var owner: User
    
    public enum CodingKeys: String, CodingKey {
        case id, name, description, language
        case fullName = "full_name"
        case stars = "stargazers_count"
        case repositoryURL = "html_url"
        case owner
    }
}

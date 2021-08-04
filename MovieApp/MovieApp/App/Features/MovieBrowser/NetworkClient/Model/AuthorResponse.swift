struct AuthorResponse: Decodable {
    
    let name: String
    let username: String
    let avatarPath: String
    let rating: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }
    
}

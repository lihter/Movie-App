struct CastWrapperResponse: Decodable {
    
    let cast: [CastResponse]?
    
}

struct CastResponse: Decodable {
    
    let identifier: Int
    let name: String
    let characterName: String?
    let posterPath: String?
    let popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case characterName = "character"
        case posterPath = "profile_path"
        case popularity
    }
    
}


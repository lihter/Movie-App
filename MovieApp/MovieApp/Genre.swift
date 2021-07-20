struct GenreResponse: Decodable {

    let genres: [Genre]
    
}

struct Genre: Decodable {
    
    let identifier: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }
    
}

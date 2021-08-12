struct GenreResponse: Decodable {
    
    let identifier: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }
    
}

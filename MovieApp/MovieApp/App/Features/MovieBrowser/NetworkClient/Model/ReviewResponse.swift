struct ReviewWrapperResponse: Decodable {
    
    let reviews: [ReviewResponse]?
    
    enum CodingKeys: String, CodingKey {
        case reviews = "results"
    }
    
}

struct ReviewResponse: Decodable {
    
    let identifier: String
    let author: String
    let authorDetails: AuthorResponse
    let content: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
    }
    
}

struct WrapperTVShowResponse: Decodable {
    
    let shows: [TVShowResponse]?
    
    enum CodingKeys: String, CodingKey {
        case shows = "results"
    }
    
}

struct TVShowResponse: Decodable {
    
    let identifier: Int
    let title: String
    let backdropPath: String?
    let posterPath: String
    let overview: String
    let voteAverage: Double
    let voteCount: Double
    let releaseDate: String?
    let genreIds: [Int]?
    
    private enum CodingKeys: String, CodingKey {
        case title = "original_name"
        case overview
        case identifier = "id"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
    }
    
}

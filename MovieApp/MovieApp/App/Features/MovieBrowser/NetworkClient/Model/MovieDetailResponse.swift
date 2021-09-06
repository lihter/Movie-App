struct MovieDetailResponse: Decodable {

    let identifier: Int
    let title: String
    let backdropPath: String?
    let posterPath: String
    let overview: String
    let voteAverage: Double
    let voteCount: Double
    let releaseDate: String?
    let genreIds: [GenreResponse]
    let runtime: Int?

    private enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case overview
        case identifier = "id"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case genreIds = "genres"
        case runtime
    }

}

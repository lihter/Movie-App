import Foundation

struct MovieDataRepositoryModel {
    
    let identifier: Int
    let title: String
    let backdropPath: String?
    let posterPath: URL?
    let overview: String
    let voteAverage: Double
    let voteCount: Double
    let releaseDate: String?
    let genreIds: [Int]?
    let budget: Int?
    
}

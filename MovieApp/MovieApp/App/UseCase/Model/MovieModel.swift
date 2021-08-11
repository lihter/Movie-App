import Foundation

struct MovieModel {
    
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
    let runtime: Int?
    var isFavorite: Bool
    
}

extension MovieModel {
    
    init(fromModel model: MovieRepoModel) {
        self.init(
            identifier: model.identifier,
            title: model.title,
            backdropPath: model.backdropPath,
            posterPath: model.posterPath,
            overview: model.overview,
            voteAverage: model.voteAverage,
            voteCount: model.voteCount,
            releaseDate: model.releaseDate,
            genreIds: model.genreIds,
            budget: model.budget,
            runtime: model.runtime,
            isFavorite: model.isFavorite)
    }
    
}

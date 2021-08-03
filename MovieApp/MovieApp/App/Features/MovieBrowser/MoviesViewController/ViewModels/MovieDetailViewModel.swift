import Foundation

struct MovieDetailViewModel {
    
    let identifier: Int
    let title: String
    let backdropPath: String?
    let posterPath: URL?
    let overview: String
    let voteAverage: Double
    let voteCount: Double
    let releaseDate: String?
    let genreIds: [Int]?
    let runtime: Int?
    
}

extension MovieDetailViewModel {
    
    init(fromModel model: MovieModel) {
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
            runtime: model.runtime)
    }
    
}

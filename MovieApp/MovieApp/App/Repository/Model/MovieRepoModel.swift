import Foundation

struct MovieRepoModel {
    
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

extension MovieRepoModel {
    
    init(fromModel model: MovieDataModel, isFavorite favorite: Bool = true) {
        self.init(
            identifier: model.identifier,
            title: model.title,
            backdropPath: model.backdropPath,
            posterPath: URL(string: "https://image.tmdb.org/t/p/w500\(model.posterPath)"),
            overview: model.overview,
            voteAverage: model.voteAverage,
            voteCount: model.voteCount,
            releaseDate: model.releaseDate,
            genreIds: model.genreIds,
            budget: model.budget,
            runtime: model.runtime,
            isFavorite: favorite)
    }
    
    init(fromModel model: MovieDataModel, isFavorite favorite: Bool = true, withGenre genreId: Int) {
        self.init(
            identifier: model.identifier,
            title: model.title,
            backdropPath: model.backdropPath,
            posterPath: URL(string: "https://image.tmdb.org/t/p/w500\(model.posterPath)"),
            overview: model.overview,
            voteAverage: model.voteAverage,
            voteCount: model.voteCount,
            releaseDate: model.releaseDate,
            genreIds: [genreId],
            budget: model.budget,
            runtime: model.runtime,
            isFavorite: favorite)
    }
    
}

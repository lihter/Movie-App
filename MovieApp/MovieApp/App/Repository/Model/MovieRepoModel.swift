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
    let isFavorite: Bool
    
}

extension MovieRepoModel {
    
    init(fromModel model: MovieDataModel, isFavorite: Bool = true) {
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
            isFavorite: isFavorite)
    }
    
    init(fromModel model: MovieDataModel, isFavorite: Bool = true, withGenre genreId: Int) {
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
            isFavorite: isFavorite)
    }
    
    func copy(
        identifier: Int? = nil,
        title: String? = nil,
        backdropPath: String? = nil,
        posterPath: URL? = nil,
        overview: String? = nil,
        voteAverage: Double? = nil,
        voteCount: Double? = nil,
        releaseDate: String? = nil,
        genreIds: [Int]? = nil,
        budget: Int? = nil,
        runtime: Int? = nil,
        isFavorite: Bool? = nil
    ) -> MovieRepoModel {
        MovieRepoModel(
            identifier: identifier ?? self.identifier,
            title: title ?? self.title,
            backdropPath: backdropPath ?? self.backdropPath,
            posterPath: posterPath ?? self.posterPath,
            overview: overview ?? self.overview,
            voteAverage: voteAverage ?? self.voteAverage,
            voteCount: voteCount ?? self.voteCount,
            releaseDate: releaseDate ?? self.releaseDate,
            genreIds: genreIds ?? self.genreIds,
            budget: budget ?? self.budget,
            runtime: runtime ?? self.runtime,
            isFavorite: isFavorite ?? self.isFavorite)
    }
    
}

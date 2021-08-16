struct MovieDataModel {
    
    let identifier: Int
    let title: String
    let backdropPath: String?
    let posterPath: String
    let overview: String
    let voteAverage: Double
    let voteCount: Double
    let releaseDate: String?
    let genreIds: [Int]?
    let budget: Int?
    let runtime: Int?
    
}

extension MovieDataModel {
    
    init(fromModel model: MovieResponse) {
        self.init(
            identifier: model.identifier,
            title: model.title,
            backdropPath: model.backdropPath,
            posterPath: model.posterPath ?? "",
            overview: model.overview,
            voteAverage: model.voteAverage,
            voteCount: model.voteCount,
            releaseDate: model.releaseDate,
            genreIds: model.genreIds,
            budget: nil,
            runtime: model.runtime)
    }
    
    init(fromModel model: TVShowResponse) {
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
            budget: nil,
            runtime: model.runtime)
    }
    
    init(fromModel model: MovieDetailResponse) {
        self.init(
            identifier: model.identifier,
            title: model.title,
            backdropPath: model.backdropPath,
            posterPath: model.posterPath,
            overview: model.overview,
            voteAverage: model.voteAverage,
            voteCount: model.voteCount,
            releaseDate: model.releaseDate,
            genreIds: model.genreIds.map { $0.identifier },
            budget: nil,
            runtime: model.runtime)
    }
    
}

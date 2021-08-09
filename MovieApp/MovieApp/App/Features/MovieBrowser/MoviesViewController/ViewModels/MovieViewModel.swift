import Foundation

struct MovieViewModel {
    
    let identifier: Int
    let title: String
    let overview: String
    let posterPath: URL?
    let genreIds: [Int]?
    let isFavourite: Bool

}

extension MovieViewModel {
    
    init(fromModel model: MovieModel) {
        self.init(
            identifier: model.identifier,
            title: model.title,
            overview: model.overview,
            posterPath: model.posterPath,
            genreIds: model.genreIds,
            isFavourite: false)
    }
    
    init(fromModel model: MovieModel, withGenre genreId: Int) {
        self.init(
            identifier: model.identifier,
            title: model.title,
            overview: model.overview,
            posterPath: model.posterPath,
            genreIds: [genreId],
            isFavourite: false)
    }
    
}

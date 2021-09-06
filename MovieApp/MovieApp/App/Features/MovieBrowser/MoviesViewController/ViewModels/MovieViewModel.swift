import Foundation

struct MovieViewModel {
    
    let identifier: Int
    let title: String
    let overview: String
    let posterPath: URL?
    let genreIds: [Int]?
    let isFavorite: Bool

}

extension MovieViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        lhs.identifier == rhs.identifier && lhs.isFavorite == rhs.isFavorite
    }
    
}

extension MovieViewModel {
    
    init(fromModel model: MovieModel) {
        self.init(
            identifier: model.identifier,
            title: model.title,
            overview: model.overview,
            posterPath: model.posterPath,
            genreIds: model.genreIds,
            isFavorite: model.isFavorite)
    }
    
}

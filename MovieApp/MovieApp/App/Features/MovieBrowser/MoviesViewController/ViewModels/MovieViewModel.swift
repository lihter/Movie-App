import Foundation

struct MovieViewModel {
    
    let identifier: Int
    let title: String
    let overview: String
    let posterPath: URL?

}

extension MovieViewModel {
    
    init(fromModel model: MovieModel) {
        self.init(
            identifier: model.identifier,
            title: model.title,
            overview: model.overview,
            posterPath: model.posterPath)
    }
    
}

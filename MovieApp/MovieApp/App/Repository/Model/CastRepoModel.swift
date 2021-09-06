import Foundation

struct CastRepoModel {

    let identifier: Int
    let name: String
    let characterName: String
    let posterPath: URL?
    let popularity: Double

}

extension CastRepoModel {

    init(fromModel model: CastDataModel) {
        self.init(
            identifier: model.identifier,
            name: model.name,
            characterName: model.characterName,
            posterPath: URL(string: "https://image.tmdb.org/t/p/w500\(model.posterPath)"),
            popularity: model.popularity)
    }

}

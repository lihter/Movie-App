import Foundation

struct CastModel {

    let identifier: Int
    let name: String
    let characterName: String
    let posterPath: URL?
    let popularity: Double

}

extension CastModel {

    init(fromModel model: CastRepoModel) {
        self.init(
            identifier: model.identifier,
            name: model.name,
            characterName: model.characterName,
            posterPath: model.posterPath,
            popularity: model.popularity)
    }

}

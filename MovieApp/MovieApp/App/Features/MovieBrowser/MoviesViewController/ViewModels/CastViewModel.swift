import Foundation

struct CastViewModel {

    let name: String
    let characterName: String
    let posterPath: URL?

}

extension CastViewModel: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine("\(name)\(characterName)")
    }

    static func == (lhs: CastViewModel, rhs: CastViewModel) -> Bool {
        lhs.name == rhs.name && lhs.characterName == rhs.characterName
    }

}

extension CastViewModel {

    init(fromModel model: CastModel) {
        self.init(
            name: model.name,
            characterName: model.characterName,
            posterPath: model.posterPath)
    }

}

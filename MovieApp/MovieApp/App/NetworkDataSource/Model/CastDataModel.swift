struct CastDataModel {

    let identifier: Int
    let name: String
    let characterName: String
    let posterPath: String
    let popularity: Double

}

extension CastDataModel {

    init(fromModel model: CastResponse) {
        self.init(
            identifier: model.identifier,
            name: model.name,
            characterName: model.characterName ?? "",
            posterPath: model.posterPath ?? "",
            popularity: model.popularity ?? 0)
    }

}

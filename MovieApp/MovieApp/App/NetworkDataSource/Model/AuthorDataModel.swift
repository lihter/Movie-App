struct AuthorDataModel {

    let name: String
    let username: String
    let avatarPath: String
    let rating: Double?

}

extension AuthorDataModel {

    init(fromModel model: AuthorResponse) {
        self.init(
            name: model.name,
            username: model.username,
            avatarPath: model.avatarPath ?? "",
            rating: model.rating)
    }

}

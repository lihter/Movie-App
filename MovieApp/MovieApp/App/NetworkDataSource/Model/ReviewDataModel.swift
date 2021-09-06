struct ReviewDataModel {

    let identifier: String
    let author: String
    let authorDetails: AuthorDataModel
    let content: String
    let createdAt: String

}

extension ReviewDataModel {

    init(fromModel model: ReviewResponse) {
        self.init(
            identifier: model.identifier,
            author: model.author,
            authorDetails: AuthorDataModel(fromModel: model.authorDetails),
            content: model.content,
            createdAt: model.createdAt)
    }

}

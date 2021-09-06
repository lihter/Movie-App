struct ReviewRepoModel {

    let identifier: String
    let author: String
    let authorDetails: AuthorRepoModel
    let content: String
    let createdAt: String

}

extension ReviewRepoModel {

    init(fromModel model: ReviewDataModel) {
        self.init(
            identifier: model.identifier,
            author: model.author,
            authorDetails: AuthorRepoModel(fromModel: model.authorDetails),
            content: model.content,
            createdAt: model.createdAt)
    }

}

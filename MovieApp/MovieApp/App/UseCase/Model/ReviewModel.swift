struct ReviewModel {

    let identifier: String
    let author: String
    let authorDetails: AuthorModel
    let content: String
    let createdAt: String

}

extension ReviewModel {

    init(fromModel model: ReviewRepoModel) {
        self.init(
            identifier: model.identifier,
            author: model.author,
            authorDetails: AuthorModel(fromModel: model.authorDetails),
            content: model.content,
            createdAt: model.createdAt)
    }

}

import Foundation

struct ReviewViewModel {
    
    let author: String
    let createdAt: String
    let content: String
    let profileImagePath: URL?
    
}

extension ReviewViewModel {
    
    init(fromModel model: ReviewModel) {
        self.init(
            author: model.author,
            createdAt: String(model.createdAt
                                .prefix(10)
                                .split(separator: "-")
                                .joined(separator: "/")),
            content: model.content,
            profileImagePath: model.authorDetails.avatarPath)
    }
    
}

import Foundation

struct ReviewViewModel {
    
    let author: String
    let createdAt: String
    let content: String
    let profileImagePath: URL?
    
}

extension ReviewViewModel {
    
    init(fromModel model: ReviewModel) {
        let date = model
            .createdAt
            .prefix(10)
            .split(separator: "-")
            .joined(separator: "/")
        
        self.init(
            author: model.author,
            createdAt: date,
            content: model.content,
            profileImagePath: model.authorDetails.avatarPath)
    }
    
}

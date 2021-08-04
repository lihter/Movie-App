import Foundation

struct AuthorModel {
    
    let name: String
    let username: String
    let avatarPath: URL?
    let rating: Int?
    
}

extension AuthorModel {
    
    init(fromModel model: AuthorRepoModel) {
        self.init(
            name: model.name,
            username: model.username,
            avatarPath: model.avatarPath,
            rating: model.rating)
    }
    
}

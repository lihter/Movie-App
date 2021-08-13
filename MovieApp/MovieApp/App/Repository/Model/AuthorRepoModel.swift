import Foundation

struct AuthorRepoModel {
    
    let name: String
    let username: String
    let avatarPath: URL?
    let rating: Double?
    
}

extension AuthorRepoModel {
    
    init(fromModel model: AuthorDataModel) {
        self.init(
            name: model.name,
            username: model.username,
            avatarPath: URL(string: "https://image.tmdb.org/t/p/w500\(model.avatarPath)"),
            rating: model.rating)
    }
    
}

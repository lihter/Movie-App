import Foundation

struct CastViewModel {
    
    let name: String
    let characterName: String
    let posterPath: URL?
    
}

extension CastViewModel {
    
    init(fromModel model: CastModel) {
        self.init(
            name: model.name,
            characterName: model.characterName,
            posterPath: model.posterPath)
    }
    
}

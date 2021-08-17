import Foundation

struct CrewViewModel {
    
    let identifier: Int
    let name: String
    let job: String
    
}

extension CrewViewModel {
    
    init(fromModel model: CrewModel) {
        self.init(
            identifier: model.identifier,
            name: model.name,
            job: model.job)
    }
    
}

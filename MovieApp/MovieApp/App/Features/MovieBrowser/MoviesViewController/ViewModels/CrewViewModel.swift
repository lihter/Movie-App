import Foundation

struct CrewViewModel {
    
    let identifier: Int
    let name: String
    let job: String
    
}

extension CrewViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(identifier)\(name)\(job)")
    }
    
    static func == (lhs: CrewViewModel, rhs: CrewViewModel) -> Bool {
        lhs.identifier == rhs.identifier && lhs.name == rhs.name && lhs.job == rhs.job
    }
    
}

extension CrewViewModel {
    
    init(fromModel model: CrewModel) {
        self.init(
            identifier: model.identifier,
            name: model.name,
            job: model.job)
    }
    
}

struct CrewDataModel {
    
    let identifier: Int
    let name: String
    let job: String
    
}

extension CrewDataModel {
    
    init(fromModel model: CrewResponse) {
        self.init(
            identifier: model.identifier,
            name: model.name,
            job: model.job ?? "")
    }
    
}

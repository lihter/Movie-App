struct CrewRepoModel {
    
    let identifier: Int
    let name: String
    let job: String
    
}

extension CrewRepoModel {
    
    init(fromModel model: CrewDataModel) {
        self.init(
            identifier: model.identifier,
            name: model.name,
            job: model.job)
    }
    
}

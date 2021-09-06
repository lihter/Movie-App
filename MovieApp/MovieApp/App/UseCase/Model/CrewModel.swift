struct CrewModel {

    let identifier: Int
    let name: String
    let job: String

}

extension CrewModel {

    init(fromModel model: CrewRepoModel) {
        self.init(
            identifier: model.identifier,
            name: model.name,
            job: model.job)
    }

}

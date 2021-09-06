struct CrewWrapperResponse: Decodable {

    let crew: [CrewResponse]?

}

struct CrewResponse: Decodable {

    let identifier: Int
    let name: String
    let job: String?

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case job
    }

}

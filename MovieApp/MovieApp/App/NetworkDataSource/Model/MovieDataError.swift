enum MovieDataError: Error {

    case general
    case noData

}

extension MovieDataError {

    static func map(from model: RequestError) -> MovieDataError {
        switch model {
        case .noData:
            return .noData
        default:
            return .general
        }
    }

}

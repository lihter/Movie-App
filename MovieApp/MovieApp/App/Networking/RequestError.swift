enum RequestError: Error {

    case general
    case apiError
    case invalidRequest
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodingError

}

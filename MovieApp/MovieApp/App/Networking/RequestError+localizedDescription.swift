extension RequestError {
    
    var localizedDescription: String {
        switch self {
        case .general:
            return "Unknown error"
        case .invalidRequest:
            return "Invalid request"
        case .apiError:
            return "Failed to fetch data"
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .invalidResponse:
            return "Invalid response"
        case .noData:
            return "No data"
        case .decodingError:
            return "Failed to decode data"
        }
    }
    
}

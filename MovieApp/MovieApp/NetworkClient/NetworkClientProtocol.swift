import Alamofire

protocol NetworkClientProtocol {
    
    func executeUrlRequest<T>(
        _ urlPath: String,
        method: HTTPMethod,
        parameters: Parameters,
        completion: @escaping (Result<T, RequestError>) -> Void
    ) where T : Decodable
    
}

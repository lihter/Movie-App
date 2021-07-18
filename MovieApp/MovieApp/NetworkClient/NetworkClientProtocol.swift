import Alamofire

protocol NetworkClientProtocol {
    
    func executeUrlRequest<T>(
        _ urlPath: String,
        method: HTTPMethod,
        parameters: Parameters,
        completionHandler: @escaping (Result<T, RequestError>) -> Void) where T : Decodable
    
}

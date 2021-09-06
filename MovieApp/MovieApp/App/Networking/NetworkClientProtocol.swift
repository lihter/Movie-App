import Combine
import Alamofire

protocol NetworkClientProtocol {

    func executeUrlRequest<T>(
        _ urlPath: String,
        method: HTTPMethod,
        parameters: Parameters,
        completion: @escaping (Result<T, RequestError>) -> Void
    ) where T: Decodable

    func executeUrlRequestPublisher<T: Decodable>(
        _ urlPath: String,
        method: HTTPMethod,
        parameters: [String: String]?
    ) -> AnyPublisher<T, RequestError>

}

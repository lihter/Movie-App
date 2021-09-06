import Combine
import Alamofire

protocol NetworkClientProtocol {

    func executeUrlRequestPublisher<T: Decodable>(
        _ urlPath: String,
        method: HTTPMethod,
        parameters: [String: String]?
    ) -> AnyPublisher<T, RequestError>

}

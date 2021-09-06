import Combine
import Foundation
import Alamofire

class NetworkClient: NetworkClientProtocol {

    static let shared: NetworkClientProtocol = NetworkClient()

    func executeUrlRequestPublisher<T: Decodable>(
        _ urlPath: String,
        method: HTTPMethod = .get,
        parameters: [String: String]? = nil
    ) -> AnyPublisher<T, RequestError> {
        var components = URLComponents(string: "https://api.themoviedb.org/3/\(urlPath)")

        if let parameters = parameters {
            components?.queryItems = []

            for parameter in parameters {
                components?.queryItems?.append(URLQueryItem(name: parameter.key, value: parameter.value))
            }
        }

        guard let url = components?.url else {
            return Fail(error: RequestError.invalidEndpoint)
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { [weak self] in
                self?.mapError($0) ?? .general
            }
            .eraseToAnyPublisher()
    }

}

extension NetworkClient {

    private func mapError(_ error: AFError) -> RequestError {
        switch error {
        case .createURLRequestFailed(error: _),
             .urlRequestValidationFailed(reason: _):
            return .invalidRequest
        case .invalidURL(url: _):
            return .invalidEndpoint
        case .responseValidationFailed(reason: _),
             .responseSerializationFailed(reason: _):
            return .invalidResponse
        case .serverTrustEvaluationFailed(reason: _),
             .sessionDeinitialized,
             .sessionInvalidated(error: _),
             .sessionTaskFailed(error: _):
            return .apiError
        default:
            return .general
        }
    }

    private func mapError(_ error: Error) -> RequestError {
        .general
    }

}

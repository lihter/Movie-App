import Foundation
import Alamofire

class NetworkClient: NetworkClientProtocol {
    
    static let shared: NetworkClientProtocol = NetworkClient()

    func executeUrlRequest<T>(
        _ urlPath: String,
        method: HTTPMethod = .get,
        parameters: Parameters,
        completion: @escaping (Result<T, RequestError>) -> Void
    ) where T : Decodable {
        AF.request("https://api.themoviedb.org/3/\(urlPath)", method: method, parameters: parameters).responseJSON { (data) in
            guard let data = data.data else { return }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch {
                completion(.failure(.decodingError))
                return
            }
        }
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
    
}

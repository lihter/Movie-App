import Foundation
import Alamofire

class NetworkClient: NetworkClientProtocol {
    
    static let shared: NetworkClientProtocol = NetworkClient()

    func executeUrlRequest<T>(
        _ urlPath: String,
        method: HTTPMethod = .get,
        parameters: Parameters,
        completionHandler: @escaping (Result<T, RequestError>) -> Void) where T : Decodable {
        AF.request("https://api.themoviedb.org/3/\(urlPath)", method: method, parameters: parameters).responseJSON { (data) in
            guard let data = data.data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(RequestError.decodingError))
            }
        }
    }
    
}

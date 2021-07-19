import Foundation
import Alamofire

class MovieClient: MovieClientProtocol {
    
    static let shared: MovieClientProtocol = MovieClient()
        
    func fetchPopularMovies(completion: @escaping(Result<[Movie]?, RequestError>) -> Void) {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] else { return }
        
        let urlPath = "movie/popular"

        let parameters: Parameters = [
            "api_key": apiKey,
            "language": "en-US",
            "page": 1
        ]
        
        NetworkClient.shared.executeUrlRequest(urlPath, method: .get, parameters: parameters) { (result: Result<PopularMoviesResponse, RequestError>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let value):
                completion(.success(value.movies))
            }
        }
    }

}

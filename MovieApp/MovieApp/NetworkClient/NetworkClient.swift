import Foundation
import Alamofire

class NetworkClient {
    
    static let movieNetworkClient = NetworkClient()
    
    func fetchPopularMovies(completionHandler: @escaping(Result<[Movie]?, RequestError>) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/popular"
        
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] else { return }
        
        let parameters: Parameters = [
            "api_key": apiKey,
            "language": "en-US",
            "page": 1
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { (data) in
            guard let data = data.data else { return }
            
            do {
                let popular = try JSONDecoder().decode(PopularMoviesResponse.self, from: data)
                completionHandler(.success(popular.movies))
            } catch {
                completionHandler(.failure(RequestError.decodingError))
            }
        }
    }

}

import Foundation
import Alamofire

class MovieClient: MovieClientProtocol {
    
    static let shared: MovieClientProtocol = MovieClient()
        
    func fetchPopularMovies(completion: @escaping(Result<[MovieResponse]?, RequestError>) -> Void) {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] else { return }
        
        let urlPath = "movie/popular"

        let parameters: Parameters = [
            "api_key": apiKey,
            "language": "en-US",
            "page": 1
        ]
        
        NetworkClient.shared.executeUrlRequest(urlPath, method: .get, parameters: parameters) { (result: Result<WrapperMovieResponse, RequestError>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let value):
                completion(.success(value.movies))
            }
        }
    }
    
    func fetchTrendingToday(completion: @escaping(Result<[MovieResponse]?, RequestError>) -> Void) {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] else { return }
        
        let urlPath = "trending/movie/day"
        
        let parameters: Parameters = [
            "api_key": apiKey,
            "language": "en-US",
            "page": 1
        ]
        
        NetworkClient.shared.executeUrlRequest(urlPath, method: .get, parameters: parameters) { (result: Result<WrapperMovieResponse, RequestError>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let value):
                completion(.success(value.movies))
            }
        }
    }
    
    func fetchTrendingThisWeek(completion: @escaping(Result<[MovieResponse]?, RequestError>) -> Void) {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] else { return }
        
        let urlPath = "trending/movie/week"
        
        let parameters: Parameters = [
            "api_key": apiKey,
            "language": "en-US",
            "page": 1
        ]
        
        NetworkClient.shared.executeUrlRequest(urlPath, method: .get, parameters: parameters) { (result: Result<WrapperMovieResponse, RequestError>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let value):
                completion(.success(value.movies))
            }
        }
    }
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieResponse]?, RequestError>) -> Void) {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] else { return }
        
        let urlPath = "movie/top_rated"
        
        let parameters: Parameters = [
            "api_key": apiKey,
            "language": "en-US",
            "page": 1
        ]
        
        NetworkClient.shared.executeUrlRequest(urlPath, method: .get, parameters: parameters) { (result: Result<WrapperMovieResponse, RequestError>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let value):
                completion(.success(value.movies))
            }
        }
    }
    
    func fetchTopRatedTV(completion: @escaping(Result<[TVShowResponse]?, RequestError>) -> Void) {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] else { return }
        
        let urlPath = "tv/top_rated"
        
        let parameters: Parameters = [
            "api_key": apiKey,
            "language": "en-US",
            "page": 1
        ]
        
        NetworkClient.shared.executeUrlRequest(urlPath, method: .get, parameters: parameters) { (result: Result<WrapperTVShowResponse, RequestError>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let value):
                completion(.success(value.shows))
            }
        }
    }

}

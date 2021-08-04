import Foundation
import Alamofire

class MovieClient: MovieClientProtocol {
    
    static let shared: MovieClientProtocol = MovieClient()
    
    func fetchPopularMovies(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void) {
        fetch(forUrl: "movie/popular") { (result: Result<MoviesWrapperResponse, RequestError>) in
            completion(result.map { $0.movies ?? [] })
        }
    }
    
    func fetchTrendingToday(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void) {
        fetch(forUrl: "trending/movie/day") { (result: Result<MoviesWrapperResponse, RequestError>) in
            completion(result.map { $0.movies ?? [] })
        }
    }
    
    func fetchTrendingThisWeek(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void) {
        fetch(forUrl: "trending/movie/week") { (result: Result<MoviesWrapperResponse, RequestError>) in
            completion(result.map { $0.movies ?? [] })
        }
    }
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void) {
        fetch(forUrl: "movie/top_rated") { (result: Result<MoviesWrapperResponse, RequestError>) in
            completion(result.map { $0.movies ?? [] })
        }
    }
    
    func fetchTopRatedTV(completion: @escaping(Result<[TVShowResponse], RequestError>) -> Void) {
        fetch(forUrl: "tv/top_rated") { (result: Result<TVShowsWrapperResponse, RequestError>) in
            completion(result.map { $0.shows ?? [] })
        }
    }
    
    func fetchMovieDetails(for movieId: Int, completion: @escaping(Result<MovieDetailResponse, RequestError>) -> Void) {
        fetch(forUrl: "/movie/\(movieId)") { (result: Result<MovieDetailResponse, RequestError>) in
            completion(result)
        }
    }
    
    func fetchCast(for movieId: Int, completion: @escaping(Result<[CastResponse], RequestError>) -> Void) {
        fetch(forUrl: "/movie/\(movieId)/credits") { (result: Result<CastWrapperResponse, RequestError>) in
            completion(result.map { $0.cast ?? [] })
        }
    }
    
    func fetchRecommendations(for movieId: Int, completion: @escaping(Result<[MovieResponse], RequestError>) -> Void) {
        fetch(forUrl: "/movie/\(movieId)/recommendations") { (result: Result<MoviesWrapperResponse, RequestError>) in
            completion(result.map { $0.movies ?? [] })
        }
    }
    
}

extension MovieClient {
    
    func fetch<T: Decodable>(forUrl urlPath: String, completion: @escaping (Result<T, RequestError>) -> Void) {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] else {
            completion(.failure(.general))
            return
        }
        
        let parameters: Parameters = [
            "api_key": apiKey,
            "language": "en-US",
            "page": 1
        ]
        
        NetworkClient.shared.executeUrlRequest(urlPath, method: .get, parameters: parameters) { (result: Result<T, RequestError>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let value):
                completion(.success(value))
            }
        }
    }
    
}

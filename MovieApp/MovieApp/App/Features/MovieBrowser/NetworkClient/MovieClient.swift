import Combine
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
    
    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieDetailResponse, Never> {
        fetch(forUrl: "movie/\(movieId)")
            .assertNoFailure()
            .eraseToAnyPublisher()
    }
    
    func fetchCast(for movieId: Int) -> AnyPublisher<[CastResponse], Never> {
        fetch(forUrl: "movie/\(movieId)/credits")
            .map { (result: CastWrapperResponse) in
                result.cast ?? []
            }
            .assertNoFailure()
            .eraseToAnyPublisher()
    }
    
    func fetchCrew(for movieId: Int) -> AnyPublisher<[CrewResponse], Never> {
        fetch(forUrl: "movie/\(movieId)/credits")
            .map { (result: CrewWrapperResponse) in
                result.crew ?? []
            }
            .assertNoFailure()
            .eraseToAnyPublisher()
    }
    
    func fetchRecommendations(for movieId: Int) -> AnyPublisher<[MovieResponse], Never> {
        fetch(forUrl: "movie/\(movieId)/recommendations")
            .map { (result: MoviesWrapperResponse) in
                result.movies ?? []
            }
            .assertNoFailure()
            .eraseToAnyPublisher()
    }
    
    func fetchReviews(for movieId: Int) -> AnyPublisher<[ReviewResponse], Never> {
        fetch(forUrl: "movie/\(movieId)/reviews")
            .map { (result: ReviewWrapperResponse) in
                result.reviews ?? []
            }
            .assertNoFailure()
            .eraseToAnyPublisher()
    }
    
    func fetchMovies(searchQuery: String, completion: @escaping(Result<[MovieResponse], RequestError>) -> Void) {
        let parameters: Parameters = [
            "query": searchQuery,
            "include_adult": "false",
        ]
        
        fetch(forUrl: "search/movie", additionalParameters: parameters) { (result: Result<MoviesWrapperResponse, RequestError>) in
            completion(result.map { $0.movies ?? [] })
        }
    }
    
}

extension MovieClient {
    
    func fetch<T: Decodable>(
        forUrl urlPath: String,
        additionalParameters: Parameters? = nil,
        completion: @escaping (Result<T, RequestError>) -> Void
    ) {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] else {
            completion(.failure(.general))
            return
        }
        
        var parameters: Parameters = [
            "api_key": apiKey,
            "language": "en-US",
            "page": 1
        ]
        
        if let additionalParameters = additionalParameters {
            parameters = parameters.merging(additionalParameters, uniquingKeysWith: { (_, last) in last })
        }
        
        NetworkClient.shared.executeUrlRequest(urlPath, method: .get, parameters: parameters) { (result: Result<T, RequestError>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let value):
                completion(.success(value))
            }
        }
    }
    
    func fetch<T: Decodable>(
        forUrl urlPath: String,
        additionalParameters: [String: String]? = nil
    ) -> AnyPublisher<T, RequestError> {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] else {
            return Fail(error: RequestError.general)
                .eraseToAnyPublisher()
        }
        
        var parameters: [String: String] = [
            "api_key": apiKey as? String ?? "",
            "language": "en-US",
            "page": "1"
        ]
        
        if let additionalParameters = additionalParameters {
            parameters = parameters.merging(additionalParameters, uniquingKeysWith: { (_, last) in last })
        }
        
        return NetworkClient.shared.executeUrlRequestPublisher(urlPath, method: .get, parameters: parameters)
    }
    
}

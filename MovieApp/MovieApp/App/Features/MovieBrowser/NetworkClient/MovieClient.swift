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
    
//    func fetchMovieDetails(for movieId: Int, completion: @escaping(Result<MovieDetailResponse, RequestError>) -> Void) {
//        fetch(forUrl: "movie/\(movieId)") { (result: Result<MovieDetailResponse, RequestError>) in
//            completion(result)
//        }
//    }
    
    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieDetailResponse, Never> {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=ca4ebd2878172f71e1cfb5b5f748f928&language=en-US")
        else {
            return .empty()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MovieDetailResponse.self, decoder: JSONDecoder())
            .assertNoFailure()
            .eraseToAnyPublisher()
    }
    
    func fetchCast(for movieId: Int, completion: @escaping(Result<[CastResponse], RequestError>) -> Void) {
        fetch(forUrl: "movie/\(movieId)/credits") { (result: Result<CastWrapperResponse, RequestError>) in
            completion(result.map { $0.cast ?? [] })
        }
    }
    
    func fetchCrew(for movieId: Int, completion: @escaping(Result<[CrewResponse], RequestError>) -> Void) {
        fetch(forUrl: "movie/\(movieId)/credits") { (result: Result<CrewWrapperResponse, RequestError>) in
            completion(result.map { $0.crew ?? [] })
        }
    }
    
    func fetchRecommendations(for movieId: Int, completion: @escaping(Result<[MovieResponse], RequestError>) -> Void) {
        fetch(forUrl: "movie/\(movieId)/recommendations") { (result: Result<MoviesWrapperResponse, RequestError>) in
            completion(result.map { $0.movies ?? [] })
        }
    }
    
    func fetchReviews(for movieId: Int, completion: @escaping(Result<[ReviewResponse], RequestError>) -> Void) {
        fetch(forUrl: "movie/\(movieId)/reviews") { (result: Result<ReviewWrapperResponse, RequestError>) in
            completion(result.map { $0.reviews ?? [] })
        }
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
    
}

extension MovieClient {
    
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
        .invalidRequest
    }
    
}

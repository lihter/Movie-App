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
//        fetch(forUrl: "movie/\(movieId)")
//            .assertNoFailure()
//            .eraseToAnyPublisher()
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
    
    func fetchCast(for movieId: Int) -> AnyPublisher<[CastResponse], Never> {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=ca4ebd2878172f71e1cfb5b5f748f928&language=en-US")
        else {
            return .empty()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CastWrapperResponse.self, decoder: JSONDecoder())
            .assertNoFailure()
            .map { $0.cast ?? [] }
            .eraseToAnyPublisher()
    }
    
    func fetchCrew(for movieId: Int) -> AnyPublisher<[CrewResponse], Never> {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=ca4ebd2878172f71e1cfb5b5f748f928&language=en-US")
        else {
            return .empty()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CrewWrapperResponse.self, decoder: JSONDecoder())
            .assertNoFailure()
            .map { $0.crew ?? [] }
            .eraseToAnyPublisher()
    }
    
    func fetchRecommendations(for movieId: Int) -> AnyPublisher<[MovieResponse], Never> {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/recommendations?api_key=ca4ebd2878172f71e1cfb5b5f748f928&language=en-US")
        else {
            return .empty()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MoviesWrapperResponse.self, decoder: JSONDecoder())
            .assertNoFailure()
            .map { $0.movies ?? [] }
            .eraseToAnyPublisher()
    }
    
    func fetchReviews(for movieId: Int) -> AnyPublisher<[ReviewResponse], Never> {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=ca4ebd2878172f71e1cfb5b5f748f928&language=en-US")
        else {
            return .empty()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ReviewWrapperResponse.self, decoder: JSONDecoder())
            .assertNoFailure()
            .map { $0.reviews ?? [] }
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

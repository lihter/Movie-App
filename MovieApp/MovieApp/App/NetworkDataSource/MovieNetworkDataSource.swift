import Combine

class MovieNetworkDataSource: MovieNetworkDataSourceProtocol {
    
    static let shared: MovieNetworkDataSourceProtocol = MovieNetworkDataSource()
    
    private let movieClient: MovieClientProtocol!
    
    init() {
        self.movieClient = MovieClient.shared
    }

    func fetchPopularMovies(completion: @escaping (Result<[MovieDataModel], RequestError>) -> Void) {
        movieClient.fetchPopularMovies { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func fetchTrendingToday(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void) {
        movieClient.fetchTrendingToday { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func fetchTrendingThisWeek(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void) {
        movieClient.fetchTrendingThisWeek { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void) {
        movieClient.fetchTopRatedMovies { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func fetchTopRatedTV(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void) {
        movieClient.fetchTopRatedTV { result in
            switch result {
            case .success(let shows):
                let mappedMovies = shows.map { MovieDataModel(fromModel: $0) }
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieDataModel, Never> {
        movieClient
            .fetchMovieDetails(for: movieId)
            .map { MovieDataModel(fromModel: $0) }
            .eraseToAnyPublisher()
    }
    
    func fetchCast(for movieId: Int) -> AnyPublisher<[CastDataModel], Never> {
        movieClient
            .fetchCast(for: movieId)
            .map { $0.map { CastDataModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }
    
    func fetchCrew(for movieId: Int) -> AnyPublisher<[CrewDataModel], Never> {
        movieClient
            .fetchCrew(for: movieId)
            .map { $0.map { CrewDataModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }
    
    func fetchRecommendations(for movieId: Int) -> AnyPublisher<[MovieDataModel], Never> {
        movieClient
            .fetchRecommendations(for: movieId)
            .map { $0.map { MovieDataModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }
    
    func fetchReviews(for movieId: Int) -> AnyPublisher<[ReviewDataModel], Never> {
        movieClient
            .fetchReviews(for: movieId)
            .map { $0.map { ReviewDataModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }
    
    func fetchMovies(searchQuery: String, completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void) {
        movieClient.fetchMovies(searchQuery: searchQuery) { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }

}

extension MovieNetworkDataSource {
    
    private func mapResult(result: Result<[MovieResponse], RequestError>, completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void) {
        switch result {
        case .success(let movies):
            let mappedMovies = movies.map { MovieDataModel(fromModel: $0) }
            completion(.success(mappedMovies))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func mapMovieDetailResult(result: Result<MovieDetailResponse, RequestError>, completion: @escaping(Result<MovieDataModel, RequestError>) -> Void) {
        switch result {
        case .success(let movie):
            let mappedMovie = MovieDataModel(fromModel: movie)
            completion(.success(mappedMovie))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
}

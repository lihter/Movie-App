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
    
    func fetchMovieDetails(for movieId: Int, completion: @escaping(Result<MovieDataModel, RequestError>) -> Void) {
        movieClient.fetchMovieDetails(for: movieId) { [weak self] result in
            self?.mapMovieDetailResult(result: result, completion: completion)
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

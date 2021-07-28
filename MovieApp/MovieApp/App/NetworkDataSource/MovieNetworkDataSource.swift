class MovieNetworkDataSource: MovieNetworkDataSourceProtocol {
    
    static let shared: MovieNetworkDataSourceProtocol = MovieNetworkDataSource()
    
    private let movieClient: MovieClientProtocol!
    
    init() {
        self.movieClient = MovieClient.shared
    }

    func fetchPopularMovies(completion: @escaping (Result<[MovieDataModel]?, RequestError>) -> Void) {
        movieClient.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                let mappedMovies = self?.mapMovies(movies)
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTrendingToday(completion: @escaping(Result<[MovieDataModel]?, RequestError>) -> Void) {
        movieClient.fetchTrendingToday { [weak self] result in
            switch result {
            case .success(let movies):
                let mappedMovies = self?.mapMovies(movies)
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTrendingThisWeek(completion: @escaping(Result<[MovieDataModel]?, RequestError>) -> Void) {
        movieClient.fetchTrendingThisWeek { [weak self] result in
            switch result {
            case .success(let movies):
                let mappedMovies = self?.mapMovies(movies)
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieDataModel]?, RequestError>) -> Void) {
        movieClient.fetchTopRatedMovies { [weak self] result in
            switch result {
            case .success(let movies):
                let mappedMovies = self?.mapMovies(movies)
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopRatedTV(completion: @escaping(Result<[MovieDataModel]?, RequestError>) -> Void) {
        movieClient.fetchTopRatedTV { [weak self] result in
            switch result {
            case .success(let movies):
                let mappedMovies = self?.mapShows(movies)
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

extension MovieNetworkDataSource {
    
    private func mapMovies(_ movies: [MovieResponse]?) -> [MovieDataModel]? {
        return movies?.map {
            return MovieDataModel(fromModel: $0)
        }
    }
    
    private func mapShows(_ shows: [TVShowResponse]?) -> [MovieDataModel]? {
        return shows?.map {
            return MovieDataModel(fromModel: $0)
        }
    }
    
}

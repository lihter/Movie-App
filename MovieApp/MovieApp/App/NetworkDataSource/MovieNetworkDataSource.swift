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
    
}

extension MovieNetworkDataSource {
    
    private func mapMovies(_ movies: [MovieResponse]?) -> [MovieDataModel]?{
        return movies?.map {
            return MovieDataModel(fromModel: $0)
        }
    }
    
}

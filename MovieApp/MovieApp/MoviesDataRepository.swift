class MoviesDataRepository {
    
    private let networkDataSource: MovieClientProtocol!
    
    init() {
        self.networkDataSource = MovieClient.shared
    }
    
    func fetchPopularMovie(completion: @escaping (Result<[Movie]?, RequestError>) -> Void) {
        networkDataSource.fetchPopularMovies { result in
            switch result {
            case .success(let movies):
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

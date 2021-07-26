class MoviesDataRepository: MoviesDataRepositoryProtocol {
    
    static let shared: MoviesDataRepositoryProtocol = MoviesDataRepository()
    
<<<<<<< HEAD
    private let networkDataSource: MovieNetworkDataSourceProtocol!
    
    init() {
        self.networkDataSource = MovieNetworkDataSource.shared
=======
    private let networkDataSource: MovieClientProtocol!
    
    init() {
        self.networkDataSource = MovieClient.shared
>>>>>>> develop
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie]?, RequestError>) -> Void) {
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

class MoviesUseCase: MoviesUseCaseProtocol {
    
    static let shared: MoviesUseCaseProtocol = MoviesUseCase()

    private let moviesDataRepo: MoviesDataRepositoryProtocol!
    
    init() {
        self.moviesDataRepo = MoviesDataRepository.shared
    }
    
    func getPopularMovies(completion: @escaping (Result<[Movie]?, RequestError>) -> Void) {
        moviesDataRepo.fetchPopularMovies { result in
            switch result {
            case .success(let movies):
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

class MoviesUseCase: MoviesUseCaseProtocol {

    private let moviesDataRepo: MoviesDataRepositoryProtocol!
    
    init(moviesDataRepository dataRepo: MoviesDataRepositoryProtocol) {
        self.moviesDataRepo = dataRepo
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

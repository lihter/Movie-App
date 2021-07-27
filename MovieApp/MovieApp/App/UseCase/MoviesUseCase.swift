class MoviesUseCase: MoviesUseCaseProtocol {
    
    static let shared: MoviesUseCaseProtocol = MoviesUseCase()

    private let moviesDataRepo: MovieRepositoryProtocol!
    
    init() {
        self.moviesDataRepo = MovieRepository.shared
    }
    
    func getPopularMovies(completion: @escaping (Result<[MovieModel]?, RequestError>) -> Void) {
        moviesDataRepo.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                let mapppedMovies = self?.mapMovies(movies)
                completion(.success(mapppedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

extension MoviesUseCase {
    
    private func mapMovies(_ movies: [MovieRepoModel]?) -> [MovieModel]? {
        return movies?.map {
            return MovieModel(fromModel: $0)
        }
    }
    
}


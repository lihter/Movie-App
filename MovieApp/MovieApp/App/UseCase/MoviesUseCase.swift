class MoviesUseCase: MoviesUseCaseProtocol {
    
    static let shared: MoviesUseCaseProtocol = MoviesUseCase()

    private let moviesDataRepo: MovieRepositoryProtocol!
    
    init() {
        self.moviesDataRepo = MovieRepository.shared
    }
    
    func getPopularMovies(completion: @escaping (Result<[MovieModel], RequestError>) -> Void) {
        moviesDataRepo.fetchPopularMovies { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func getTrendingMoviesToday(completion: @escaping (Result<[MovieModel], RequestError>) -> Void) {
        moviesDataRepo.fetchTrendingToday { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func getTrendingMoviesThisWeek(completion: @escaping (Result<[MovieModel], RequestError>) -> Void) {
        moviesDataRepo.fetchTrendingThisWeek { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[MovieModel], RequestError>) -> Void) {
        moviesDataRepo.fetchTopRatedMovies { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func getTopRatedTV(completion: @escaping (Result<[MovieModel], RequestError>) -> Void) {        moviesDataRepo.fetchTopRatedTV { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }

}

extension MoviesUseCase {
    
    private func mapResult(result: Result<[MovieRepoModel], RequestError>, completion:@escaping(Result<[MovieModel], RequestError>) -> Void) {
        switch result {
        case .success(let movies):
            let mappedMovies = movies.map { MovieModel(fromModel: $0) }
            completion(.success(mappedMovies))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
}


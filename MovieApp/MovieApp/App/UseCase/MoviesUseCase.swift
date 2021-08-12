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
    
    func getMovieDetails(for movieId: Int, completion: @escaping(Result<MovieModel, RequestError>) -> Void) {
        moviesDataRepo.fetchMovieDetails(for: movieId) { [weak self] result in
            self?.mapMovieDetailResult(result: result, completion: completion)
        }
    }
    
    func getMovieOverview(for movieId: Int, completion: @escaping(Result<String, RequestError>) -> Void) {
        moviesDataRepo.fetchMovieDetails(for: movieId) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let movie):
                completion(.success(movie.overview))
            }
        }
    }
    
    func getMostPopularCast(for movieId: Int, completion: @escaping(Result<[CastModel], RequestError>) -> Void) {
        moviesDataRepo.fetchCast(for: movieId) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let cast):
                let mappedCast = cast
                    .sorted { $0.popularity > $1.popularity }
                    .prefix(10)
                    .map { CastModel(fromModel: $0) }
                completion(.success(mappedCast))
            }
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
    
    private func mapMovieDetailResult(result: Result<MovieRepoModel, RequestError>, completion: @escaping(Result<MovieModel, RequestError>) -> Void) {
        switch result {
        case .success(let movie):
            let mappedMovie = MovieModel(fromModel: movie)
            completion(.success(mappedMovie))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
}


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
    
    func getTrendingMovies(completion: @escaping (Result<[MovieModel], RequestError>) -> Void) {
        moviesDataRepo.fetchTrending { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[MovieModel], RequestError>) -> Void) {
        moviesDataRepo.fetchTopRatedMovies { [weak self] result in
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
    
    func getCrew(for movieId: Int, completion: @escaping(Result<[CrewModel], RequestError>) -> Void) {
        moviesDataRepo.fetchCrew(for: movieId) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let crew):
                let mappedCrew = crew
                    .filter { !$0.job.isEmpty }
                    .prefix(6)
                    .map { CrewModel(fromModel: $0) }
                completion(.success(mappedCrew))
            }
        }
    }

    
    func getRecommendations(for movieId: Int, completion: @escaping(Result<[MovieModel], RequestError>) -> Void) {
        moviesDataRepo.fetchRecommendations(for: movieId) { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func getReview(for movieId: Int, completion: @escaping(Result<ReviewModel, RequestError>) -> Void) {
        moviesDataRepo.fetchReviews(for: movieId) { result in
            switch result {
            case .success(let reviews):
                guard reviews.count > 0 else {
                    completion(.failure(.noData))
                    return
                }
                
                let mappedReview = ReviewModel(fromModel: reviews[0])
                completion(.success(mappedReview))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getSearchedMovies(searchQuery: String, completion: @escaping(Result<[MovieModel], RequestError>) -> Void) {
        moviesDataRepo.fetchMovies(searchQuery: searchQuery) { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func toggleFavorite(_ movieId: Int) {
        moviesDataRepo.toggleFavorite(movieId)
    }
    
    func getMovies(for category: LocalCategory, genreId: Int) -> [MovieModel] {
        let repoMovies = moviesDataRepo.getMovies(for: category, genreId: genreId)
        return repoMovies.map { MovieModel(fromModel: $0) }
    }
    
    func getMovie(with movieId: Int) -> MovieModel? {
        guard let repoMovie = moviesDataRepo.getMovie(with: movieId) else { return nil }
        
        return MovieModel(fromModel: repoMovie)
    }
    
    func getFavoriteMovies(completion: @escaping(Result<[MovieModel], RequestError>) -> Void) {
        moviesDataRepo.getFavoriteMovies { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func checkIfFavorite(for movieId: Int) -> Bool {
        moviesDataRepo.checkIfFavorite(for: movieId)
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


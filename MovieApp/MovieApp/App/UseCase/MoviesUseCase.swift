import Combine

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
    
    func getMovieDetails(for movieId: Int) -> AnyPublisher<MovieModel, Never> {
        moviesDataRepo
            .fetchMovieDetails(for: movieId)
            .map { MovieModel(fromModel: $0) }
            .eraseToAnyPublisher()
    }

    func getMostPopularCast(for movieId: Int) -> AnyPublisher<[CastModel], Never> {
        moviesDataRepo
            .fetchCast(for: movieId)
            .map {
                $0
                    .sorted { $0.popularity > $1.popularity }
                    .prefix(10)
                    .map { CastModel(fromModel: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    func getCrew(for movieId: Int) -> AnyPublisher<[CrewModel], Never> {
        moviesDataRepo
            .fetchCrew(for: movieId)
            .map {
                $0
                    .filter { !$0.job.isEmpty }
                    .prefix(6)
                    .map { CrewModel(fromModel: $0) }
            }
            .eraseToAnyPublisher()
    }

    func getRecommendations(for movieId: Int) -> AnyPublisher<[MovieModel], Never> {
        moviesDataRepo
            .fetchRecommendations(for: movieId)
            .map { $0.map { MovieModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }
    
    func fetchReviews(for movieId: Int) -> AnyPublisher<ReviewModel?, Never> {
        moviesDataRepo
            .fetchReviews(for: movieId)
            .map { reviews in
                guard let review = reviews.first else {
                    print("No review available.")
                    return nil
                }

                return ReviewModel(fromModel: review)
            }
            .eraseToAnyPublisher()
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
    
    var favoriteMovies: AnyPublisher<[MovieModel], Never> {
        moviesDataRepo
            .favoriteMovies
            .map { $0.map { MovieModel(fromModel: $0) } }
            .eraseToAnyPublisher()
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


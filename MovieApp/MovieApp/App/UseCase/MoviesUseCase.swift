import Combine

class MoviesUseCase: MoviesUseCaseProtocol {

    static let shared: MoviesUseCaseProtocol = MoviesUseCase()

    private let moviesDataRepo: MovieRepositoryProtocol!

    init() {
        self.moviesDataRepo = MovieRepository.shared
    }

    func getMoviesArray(for category: LocalCategory, genreId: Int) -> AnyPublisher<[MovieModel], Never> {
        moviesDataRepo
            .getMoviesArray(for: category, genreId: genreId)
            .map { $0.filter { $0.genreIds?.contains(genreId) ?? false } }
            .map { $0.map { MovieModel(fromModel: $0) } }
            .eraseToAnyPublisher()
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

    func getSearchedMovies(searchQuery: String) -> AnyPublisher<[MovieModel], Never> {
        moviesDataRepo
            .fetchMovies(searchQuery: searchQuery)
            .map { $0.map { MovieModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

    func toggleFavorite(_ movieId: Int) {
        moviesDataRepo.toggleFavorite(movieId)
    }

    var favoriteMovies: AnyPublisher<[MovieModel], Never> {
        moviesDataRepo
            .favoriteMovies
            .map { $0.map { MovieModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

}

import Combine

protocol MovieRepositoryProtocol {

    var popularMovies: AnyPublisher<[MovieRepoModel], Never> { get }

    var trendingMovies: AnyPublisher<[MovieRepoModel], Never> { get }

    var topRatedMovies: AnyPublisher<[MovieRepoModel], Never> { get }

    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieRepoModel, Never>

    func fetchCast(for movieId: Int) -> AnyPublisher<[CastRepoModel], Never>

    func fetchCrew(for movieId: Int) -> AnyPublisher<[CrewRepoModel], Never>

    func fetchRecommendations(for movieId: Int) -> AnyPublisher<[MovieRepoModel], Never>

    func fetchReviews(for movieId: Int) -> AnyPublisher<[ReviewRepoModel], Never>

    func fetchMovies(searchQuery: String) -> AnyPublisher<[MovieRepoModel], Never>

    func toggleFavorite(_ movieId: Int)

    func getMoviesPublisher(for category: LocalCategory, genreId: Int) -> AnyPublisher<[MovieRepoModel], Never>

    var favoriteMovies: AnyPublisher<[MovieRepoModel], Never> { get }

}

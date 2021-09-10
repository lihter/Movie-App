import Combine

protocol MovieClientProtocol {

    var popularMovies: AnyPublisher<[MovieResponse], RequestError> { get }

    var trendingToday: AnyPublisher<[MovieResponse], RequestError> { get }

    var trendingWeek: AnyPublisher<[MovieResponse], RequestError> { get }

    var topRated: AnyPublisher<[MovieResponse], RequestError> { get }

    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieDetailResponse, Never>

    func fetchCast(for movieId: Int) -> AnyPublisher<[CastResponse], Never>

    func fetchCrew(for movieId: Int) -> AnyPublisher<[CrewResponse], Never>

    func fetchRecommendations(for movieId: Int) -> AnyPublisher<[MovieResponse], Never>

    func fetchReviews(for movieId: Int) -> AnyPublisher<[ReviewResponse], Never>

    func fetchMovies(searchQuery: String) -> AnyPublisher<[MovieResponse], Never>

}

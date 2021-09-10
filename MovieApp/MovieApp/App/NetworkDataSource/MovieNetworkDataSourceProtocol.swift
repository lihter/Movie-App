import Combine

protocol MovieNetworkDataSourceProtocol {

    var popularMovies: AnyPublisher<[MovieDataModel], RequestError> { get }

    var trendingToday: AnyPublisher<[MovieDataModel], RequestError> { get }

    var trendingWeek: AnyPublisher<[MovieDataModel], RequestError> { get }

    var topRated: AnyPublisher<[MovieDataModel], RequestError> { get }

    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieDataModel, Never>

    func fetchCast(for movieId: Int) -> AnyPublisher<[CastDataModel], Never>

    func fetchCrew(for movieId: Int) -> AnyPublisher<[CrewDataModel], Never>

    func fetchRecommendations(for movieId: Int) -> AnyPublisher<[MovieDataModel], Never>

    func fetchReviews(for movieId: Int) -> AnyPublisher<[ReviewDataModel], Never>

    func fetchMovies(searchQuery: String) -> AnyPublisher<[MovieDataModel], Never>

}

import Combine

class MovieNetworkDataSource: MovieNetworkDataSourceProtocol {

    private let movieClient: MovieClientProtocol!

    init(movieClient: MovieClientProtocol) {
        self.movieClient = movieClient
    }

    var popularMovies: AnyPublisher<[MovieDataModel], MovieDataError> {
        movieClient
            .popularMovies
            .mapError { MovieDataError.map(from: $0) }
            .map { $0.map { MovieDataModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

    var trendingToday: AnyPublisher<[MovieDataModel], MovieDataError> {
        movieClient
            .trendingToday
            .mapError { MovieDataError.map(from: $0) }
            .map { $0.map { MovieDataModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

    var trendingWeek: AnyPublisher<[MovieDataModel], MovieDataError> {
        movieClient
            .trendingWeek
            .mapError { MovieDataError.map(from: $0) }
            .map { $0.map { MovieDataModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

    var topRated: AnyPublisher<[MovieDataModel], MovieDataError> {
        movieClient
            .topRated
            .mapError { MovieDataError.map(from: $0) }
            .map { $0.map { MovieDataModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieDataModel, Never> {
        movieClient
            .fetchMovieDetails(for: movieId)
            .map { MovieDataModel(fromModel: $0) }
            .eraseToAnyPublisher()
    }

    func fetchCast(for movieId: Int) -> AnyPublisher<[CastDataModel], Never> {
        movieClient
            .fetchCast(for: movieId)
            .map { $0.map { CastDataModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

    func fetchCrew(for movieId: Int) -> AnyPublisher<[CrewDataModel], Never> {
        movieClient
            .fetchCrew(for: movieId)
            .map { $0.map { CrewDataModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

    func fetchRecommendations(for movieId: Int) -> AnyPublisher<[MovieDataModel], Never> {
        movieClient
            .fetchRecommendations(for: movieId)
            .map { $0.map { MovieDataModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

    func fetchReviews(for movieId: Int) -> AnyPublisher<[ReviewDataModel], Never> {
        movieClient
            .fetchReviews(for: movieId)
            .map { $0.map { ReviewDataModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

    func fetchMovies(searchQuery: String) -> AnyPublisher<[MovieDataModel], Never> {
        movieClient
            .fetchMovies(searchQuery: searchQuery)
            .map { $0.map { MovieDataModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

}

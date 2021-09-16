import Combine
import Foundation
import Alamofire

class MovieClient: MovieClientProtocol {

    let networkClient: NetworkClientProtocol!

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    var popularMovies: AnyPublisher<[MovieResponse], RequestError> {
        fetch(forUrl: "movie/popular")
            .map { (result: MoviesWrapperResponse) in
                result.movies ?? []
            }
            .eraseToAnyPublisher()
    }

    var trendingToday: AnyPublisher<[MovieResponse], RequestError> {
        fetch(forUrl: "trending/movie/day")
            .map { (result: MoviesWrapperResponse) in
                result.movies ?? []
            }
            .eraseToAnyPublisher()
    }

    var trendingWeek: AnyPublisher<[MovieResponse], RequestError> {
        fetch(forUrl: "trending/movie/week")
            .map { (result: MoviesWrapperResponse) in
                result.movies ?? []
            }
            .eraseToAnyPublisher()
    }

    var topRated: AnyPublisher<[MovieResponse], RequestError> {
        fetch(forUrl: "movie/top_rated")
            .map { (result: MoviesWrapperResponse) in
                result.movies ?? []
            }
            .eraseToAnyPublisher()
    }

    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieDetailResponse, Never> {
        fetch(forUrl: "movie/\(movieId)")
            .assertNoFailure()
            .eraseToAnyPublisher()
    }

    func fetchCast(for movieId: Int) -> AnyPublisher<[CastResponse], Never> {
        fetch(forUrl: "movie/\(movieId)/credits")
            .map { (result: CastWrapperResponse) in
                result.cast ?? []
            }
            .assertNoFailure()
            .eraseToAnyPublisher()
    }

    func fetchCrew(for movieId: Int) -> AnyPublisher<[CrewResponse], Never> {
        fetch(forUrl: "movie/\(movieId)/credits")
            .map { (result: CrewWrapperResponse) in
                result.crew ?? []
            }
            .assertNoFailure()
            .eraseToAnyPublisher()
    }

    func fetchRecommendations(for movieId: Int) -> AnyPublisher<[MovieResponse], Never> {
        fetch(forUrl: "movie/\(movieId)/recommendations")
            .map { (result: MoviesWrapperResponse) in
                result.movies ?? []
            }
            .assertNoFailure()
            .eraseToAnyPublisher()
    }

    func fetchReviews(for movieId: Int) -> AnyPublisher<[ReviewResponse], Never> {
        fetch(forUrl: "movie/\(movieId)/reviews")
            .map { (result: ReviewWrapperResponse) in
                result.reviews ?? []
            }
            .assertNoFailure()
            .eraseToAnyPublisher()
    }

    func fetchMovies(searchQuery: String) -> AnyPublisher<[MovieResponse], Never> {
        let parameters: [String: String] = [
            "query": searchQuery,
            "include_adult": "false"
        ]

        return fetch(forUrl: "search/movie", additionalParameters: parameters)
            .map { (result: MoviesWrapperResponse) in
                result.movies ?? []
            }
            .assertNoFailure()
            .eraseToAnyPublisher()
    }

}

extension MovieClient {

    func fetch<T: Decodable>(
        forUrl urlPath: String,
        additionalParameters: [String: String]? = nil
    ) -> AnyPublisher<T, RequestError> {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] else {
            return Fail(error: RequestError.general)
                .eraseToAnyPublisher()
        }

        var parameters: [String: String] = [
            "api_key": apiKey as? String ?? "",
            "language": "en-US",
            "page": "1"
        ]

        if let additionalParameters = additionalParameters {
            parameters = parameters.merging(additionalParameters, uniquingKeysWith: { (_, last) in last })
        }

        return networkClient.executeUrlRequestPublisher(urlPath, method: .get, parameters: parameters)
    }

}

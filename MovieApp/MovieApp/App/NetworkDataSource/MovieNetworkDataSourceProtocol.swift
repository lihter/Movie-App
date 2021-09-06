import Combine

protocol MovieNetworkDataSourceProtocol {
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchTrendingToday(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchTrendingThisWeek(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchTopRatedTV(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieDataModel, Never>
    
    func fetchCast(for movieId: Int) -> AnyPublisher<[CastDataModel], Never>
    
    func fetchCrew(for movieId: Int) -> AnyPublisher<[CrewDataModel], Never>
    
    func fetchRecommendations(for movieId: Int) -> AnyPublisher<[MovieDataModel], Never>
    
    func fetchReviews(for movieId: Int) -> AnyPublisher<[ReviewDataModel], Never>

    func fetchMovies(searchQuery: String, completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
}

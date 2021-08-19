import Combine

protocol MovieNetworkDataSourceProtocol {
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchTrendingToday(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchTrendingThisWeek(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchTopRatedTV(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
    //func fetchMovieDetails(for movieId: Int, completion: @escaping(Result<MovieDataModel, RequestError>) -> Void)
    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieDataModel, Never>
    
    func fetchCast(for movieId: Int, completion: @escaping(Result<[CastDataModel], RequestError>) -> Void)
    
    func fetchCrew(for movieId: Int, completion: @escaping(Result<[CrewDataModel], RequestError>) -> Void)
    
    func fetchRecommendations(for movieId: Int, completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchReviews(for movieId: Int, completion: @escaping(Result<[ReviewDataModel], RequestError>) -> Void)
    
    func fetchMovies(searchQuery: String, completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
}

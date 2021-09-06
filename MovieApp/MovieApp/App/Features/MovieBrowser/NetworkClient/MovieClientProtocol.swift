import Combine

protocol MovieClientProtocol {
    
    func fetchPopularMovies(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchTrendingToday(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchTrendingThisWeek(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchTopRatedTV(completion: @escaping(Result<[TVShowResponse], RequestError>) -> Void)
    
    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieDetailResponse, Never>
    
    func fetchCast(for movieId: Int) -> AnyPublisher<[CastResponse], Never>
    
    func fetchCrew(for movieId: Int) -> AnyPublisher<[CrewResponse], Never>
    
    func fetchRecommendations(for movieId: Int) -> AnyPublisher<[MovieResponse], Never>
    
    func fetchReviews(for movieId: Int) -> AnyPublisher<[ReviewResponse], Never>
    
    func fetchMovies(searchQuery: String, completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)

}

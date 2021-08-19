import Combine

protocol MovieClientProtocol {
    
    func fetchPopularMovies(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchTrendingToday(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchTrendingThisWeek(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchTopRatedTV(completion: @escaping(Result<[TVShowResponse], RequestError>) -> Void)
    
    //func fetchMovieDetails(for movieId: Int, completion: @escaping(Result<MovieDetailResponse, RequestError>) -> Void)
    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieDetailResponse, Never>
    
    func fetchCast(for movieId: Int, completion: @escaping(Result<[CastResponse], RequestError>) -> Void)
    
    func fetchCrew(for movieId: Int, completion: @escaping(Result<[CrewResponse], RequestError>) -> Void)
    
    func fetchRecommendations(for movieId: Int, completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchReviews(for movieId: Int, completion: @escaping(Result<[ReviewResponse], RequestError>) -> Void)
    
    func fetchMovies(searchQuery: String, completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)

}

protocol MovieClientProtocol {
    
    func fetchPopularMovies(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchTrendingToday(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchTrendingThisWeek(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchTopRatedTV(completion: @escaping(Result<[TVShowResponse], RequestError>) -> Void)
    
    func fetchMovieDetails(for movieId: Int, completion: @escaping(Result<MovieDetailResponse, RequestError>) -> Void)
    
    func fetchCast(for movieId: Int, completion: @escaping(Result<[CastResponse], RequestError>) -> Void)
    
    func fetchRecommendations(for movieId: Int, completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)
    
    func fetchReviews(for movieId: Int, completion: @escaping(Result<[ReviewResponse], RequestError>) -> Void)
    
    func fetchMovies(searchQuery: String, completion: @escaping(Result<[MovieResponse], RequestError>) -> Void)

}

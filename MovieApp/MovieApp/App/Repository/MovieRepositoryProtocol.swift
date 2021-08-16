protocol MovieRepositoryProtocol {
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieRepoModel], RequestError>) -> Void)
    
    func fetchTrending(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void)
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void)
        
    func fetchMovieDetails(for movieId: Int, completion: @escaping(Result<MovieRepoModel, RequestError>) -> Void)
    
    func fetchCast(for movieId: Int, completion: @escaping(Result<[CastRepoModel], RequestError>) -> Void)
    
    func fetchRecommendations(for movieId: Int, completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void)
    
    func fetchReviews(for movieId: Int, completion: @escaping(Result<[ReviewRepoModel], RequestError>) -> Void)
    
    func fetchMovies(searchQuery: String, completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void)
    
    func toggleFavorite(_ movieId: Int)
    
    func getMovies(for category: LocalCategory, genreId: Int) -> [MovieRepoModel]
    
    func getMovie(with movieId: Int) -> MovieRepoModel?
    
    func getFavoriteMovies() -> [MovieRepoModel]
    
}

protocol MovieRepositoryProtocol {
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieRepoModel], RequestError>) -> Void)
    
    func fetchTrendingToday(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void)
    
    func fetchTrendingThisWeek(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void)
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void)
    
    func fetchTopRatedTV(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void)
    
    func fetchMovieDetails(for movieId: Int, completion: @escaping(Result<MovieRepoModel, RequestError>) -> Void)

}

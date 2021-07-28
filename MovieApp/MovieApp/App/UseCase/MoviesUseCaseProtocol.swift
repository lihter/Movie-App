protocol MoviesUseCaseProtocol {
    
    func getPopularMovies(completion: @escaping(Result<[MovieModel]?, RequestError>) -> Void)
    func getTrendingMoviesToday(completion: @escaping (Result<[MovieModel]?, RequestError>) -> Void)
    func getTrendingMoviesThisWeek(completion: @escaping (Result<[MovieModel]?, RequestError>) -> Void)
    func getTopRatedMovies(completion: @escaping (Result<[MovieModel]?, RequestError>) -> Void)
    func getTopRatedTV(completion: @escaping (Result<[MovieModel]?, RequestError>) -> Void)

}

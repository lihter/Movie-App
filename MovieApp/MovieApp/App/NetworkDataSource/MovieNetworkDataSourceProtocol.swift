protocol MovieNetworkDataSourceProtocol {
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchTrendingToday(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchTrendingThisWeek(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
    func fetchTopRatedTV(completion: @escaping(Result<[MovieDataModel], RequestError>) -> Void)
    
}

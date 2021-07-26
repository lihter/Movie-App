protocol MovieNetworkDataSourceProtocol {
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieDataModel]?, RequestError>) -> Void)
    
}

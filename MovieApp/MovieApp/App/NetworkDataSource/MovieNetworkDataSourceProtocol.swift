protocol MovieNetworkDataSourceProtocol {
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieNetworkDataSourceModel]?, RequestError>) -> Void)
    
}

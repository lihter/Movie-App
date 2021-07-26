protocol MovieNetworkDataSourceProtocol {
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie]?, RequestError>) -> Void)
    
}

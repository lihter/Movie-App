protocol MovieClientProtocol {
    
    func fetchPopularMovies(completion: @escaping(Result<[MovieNetworkModel]?, RequestError>) -> Void)

}

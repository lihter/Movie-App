protocol NetworkClientProtocol {
    
    func fetchPopularMovies(completionHandler: @escaping(Result<[Movie]?, RequestError>) -> Void)

}

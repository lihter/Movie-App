protocol MovieClientProtocol {
    
    func fetchPopularMovies(completionHandler: @escaping(Result<[Movie]?, RequestError>) -> Void)

}

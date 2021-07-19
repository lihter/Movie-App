protocol MovieClientProtocol {
    
    func fetchPopularMovies(completion: @escaping(Result<[Movie]?, RequestError>) -> Void)

}

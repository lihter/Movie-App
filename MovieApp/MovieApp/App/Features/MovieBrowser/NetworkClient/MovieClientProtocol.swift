protocol MovieClientProtocol {
    
    func fetchPopularMovies(completion: @escaping(Result<[MovieResponse]?, RequestError>) -> Void)

}

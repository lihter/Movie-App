protocol MoviesUseCaseProtocol {
    
    func getPopularMovies(completion: @escaping(Result<[Movie]?, RequestError>) -> Void)
    
}

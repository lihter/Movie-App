protocol MoviesUseCaseProtocol {
    
    func getPopularMovies(completion: @escaping(Result<[MovieUseCaseModel]?, RequestError>) -> Void)
    
}

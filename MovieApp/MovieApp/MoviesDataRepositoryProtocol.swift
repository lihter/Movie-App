protocol MoviesDataRepositoryProtocol {
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie]?, RequestError>) -> Void)
    
}

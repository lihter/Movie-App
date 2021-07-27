protocol MoviesDataRepositoryProtocol {
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieDataRepositoryModel]?, RequestError>) -> Void)
    
}

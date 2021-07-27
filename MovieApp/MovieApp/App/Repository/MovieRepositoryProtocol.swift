protocol MovieRepositoryProtocol {
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieRepoModel]?, RequestError>) -> Void)
    
}

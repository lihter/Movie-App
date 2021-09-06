import Combine

protocol MovieRepositoryProtocol {
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieRepoModel], RequestError>) -> Void)
    
    func fetchTrending(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void)
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void)
        
    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieRepoModel, Never>
    
    func fetchCast(for movieId: Int) -> AnyPublisher<[CastRepoModel], Never>
    
    func fetchCrew(for movieId: Int) -> AnyPublisher<[CrewRepoModel], Never>
    
    func fetchRecommendations(for movieId: Int) -> AnyPublisher<[MovieRepoModel], Never>
    
    func fetchReviews(for movieId: Int) -> AnyPublisher<[ReviewRepoModel], Never>

    func fetchMovies(searchQuery: String, completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void)
    
    func toggleFavorite(_ movieId: Int)
    
    func getMovies(for category: LocalCategory, genreId: Int) -> [MovieRepoModel]
    
    func getMovie(with movieId: Int) -> MovieRepoModel?
    
    var favoriteMovies: AnyPublisher<[MovieRepoModel], Never> { get }
        
}

import Combine

protocol MoviesUseCaseProtocol {
    
    func getPopularMovies(completion: @escaping(Result<[MovieModel], RequestError>) -> Void)
    
    func getTrendingMovies(completion: @escaping (Result<[MovieModel], RequestError>) -> Void)
        
    func getTopRatedMovies(completion: @escaping (Result<[MovieModel], RequestError>) -> Void)
        
    func getMovieDetails(for movieId: Int) -> AnyPublisher<MovieModel, Never>
    
    func getMostPopularCast(for movieId: Int) -> AnyPublisher<[CastModel], Never>
    
    func getCrew(for movieId: Int) -> AnyPublisher<[CrewModel], Never>
    
    func getRecommendations(for movieId: Int) -> AnyPublisher<[MovieModel], Never> 

    func fetchReviews(for movieId: Int) -> AnyPublisher<ReviewModel?, Never>

    func getSearchedMovies(searchQuery: String, completion: @escaping(Result<[MovieModel], RequestError>) -> Void)
    
    func toggleFavorite(_ movieId: Int)
    
    func getMovies(for category: LocalCategory, genreId: Int) -> [MovieModel]
    
    func getMovie(with movieId: Int) -> MovieModel?
    
    var favoriteMovies: AnyPublisher<[MovieModel], Never> { get }

}

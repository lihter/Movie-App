import Combine

protocol MoviesUseCaseProtocol {
    
    func getPopularMovies(completion: @escaping(Result<[MovieModel], RequestError>) -> Void)
    
    func getTrendingMovies(completion: @escaping (Result<[MovieModel], RequestError>) -> Void)
        
    func getTopRatedMovies(completion: @escaping (Result<[MovieModel], RequestError>) -> Void)
        
    func getMovieDetails(for movieId: Int) -> AnyPublisher<MovieModel, Never>
    
    func getMostPopularCast(for movieId: Int, completion: @escaping(Result<[CastModel], RequestError>) -> Void)
    
    func getCrew(for movieId: Int, completion: @escaping(Result<[CrewModel], RequestError>) -> Void)
    
    func getRecommendations(for movieId: Int, completion: @escaping(Result<[MovieModel], RequestError>) -> Void)
    
    func getReview(for movieId: Int, completion: @escaping(Result<ReviewModel, RequestError>) -> Void)
    
    func getSearchedMovies(searchQuery: String, completion: @escaping(Result<[MovieModel], RequestError>) -> Void)
    
    func toggleFavorite(_ movieId: Int)
    
    func getMovies(for category: LocalCategory, genreId: Int) -> [MovieModel]
    
    func getMovie(with movieId: Int) -> MovieModel?
    
    var favoriteMovies: AnyPublisher<[MovieModel], Never> { get }

}

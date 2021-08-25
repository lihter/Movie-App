import Combine

protocol MoviesUseCaseProtocol {
        
    func getMovieDetails(for movieId: Int) -> AnyPublisher<MovieModel, Never>
    
    func getMostPopularCast(for movieId: Int) -> AnyPublisher<[CastModel], Never>
    
    func getCrew(for movieId: Int) -> AnyPublisher<[CrewModel], Never>
    
    func getRecommendations(for movieId: Int) -> AnyPublisher<[MovieModel], Never> 

    func fetchReviews(for movieId: Int) -> AnyPublisher<ReviewModel?, Never>

    func getSearchedMovies(searchQuery: String) -> AnyPublisher<[MovieModel], Never>
    
    func toggleFavorite(_ movieId: Int)
        
    func getMoviesPublisher(for category: LocalCategory, genreId: Int) -> AnyPublisher<[MovieModel], Never>
        
    var favoriteMovies: AnyPublisher<[MovieModel], Never> { get }

}

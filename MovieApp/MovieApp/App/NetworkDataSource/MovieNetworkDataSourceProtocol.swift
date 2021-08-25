import Combine

protocol MovieNetworkDataSourceProtocol {
    
    var popularMovies: AnyPublisher<[MovieDataModel], Never> { get }
        
    var trendingToday: AnyPublisher<[MovieDataModel], Never> { get }
    
    var trendingWeek: AnyPublisher<[MovieDataModel], Never> { get }
    
    var topRated: AnyPublisher<[MovieDataModel], Never> { get }
    
    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieDataModel, Never>
    
    func fetchCast(for movieId: Int) -> AnyPublisher<[CastDataModel], Never>
    
    func fetchCrew(for movieId: Int) -> AnyPublisher<[CrewDataModel], Never>
    
    func fetchRecommendations(for movieId: Int) -> AnyPublisher<[MovieDataModel], Never>
    
    func fetchReviews(for movieId: Int) -> AnyPublisher<[ReviewDataModel], Never>

    func fetchMovies(searchQuery: String) -> AnyPublisher<[MovieDataModel], Never>
    
}

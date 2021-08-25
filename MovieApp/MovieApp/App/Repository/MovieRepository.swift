import Combine
import Foundation

class MovieRepository: MovieRepositoryProtocol {

    static let shared: MovieRepositoryProtocol = MovieRepository()
    
    private let networkDataSource: MovieNetworkDataSourceProtocol!
    private let userDefaultsDataSource: UserDefaultsDataSourceProtocol!
    
    var categoryMovies: [LocalCategory: [MovieRepoModel]]!
        
    init() {
        self.networkDataSource = MovieNetworkDataSource.shared
        self.userDefaultsDataSource = UserDefaultsDataSource.shared
        
        categoryMovies = [:]
    }
    
    private var userDefaultsPublisher: AnyPublisher<[Int], Never> {
        userDefaultsDataSource
            .favorites
            .eraseToAnyPublisher()
    }
    
    var popularMovies: AnyPublisher<[MovieRepoModel], Never> {
        networkDataSource
            .popularMovies
            .combineLatest(userDefaultsPublisher)
            .map { movies, favoriteIds -> [MovieRepoModel] in
                movies.map { movie in
                    let isFavorite = favoriteIds.contains(movie.identifier)
                    return MovieRepoModel(fromModel: movie, isFavorite: isFavorite)
                }
            }
            .eraseToAnyPublisher()
    }
    
    var trendingMovies: AnyPublisher<[MovieRepoModel], Never> {
        let today = networkDataSource
            .trendingToday
            .eraseToAnyPublisher()
        
        let week = networkDataSource
            .trendingWeek
            .eraseToAnyPublisher()
        
        return Publishers
            .CombineLatest3(today, week, userDefaultsPublisher)
            .map { todayMovies, weekMovies, favoriteIds -> [MovieRepoModel] in
                var combinedMovies = todayMovies
                combinedMovies.append(contentsOf: weekMovies)
                
                return combinedMovies
                    .uniqued()
                    .map {
                        let isFavorite = favoriteIds.contains($0.identifier)
                        var genres: [Int] = []
                        if todayMovies.contains($0) {
                            genres.append(Genre.day.rawValue)
                        }
                        if weekMovies.contains($0) {
                            genres.append(Genre.week.rawValue)
                        }
                        
                        return MovieRepoModel(fromModel: $0, isFavorite: isFavorite, withGenres: genres)
                    }
            }
            .eraseToAnyPublisher()
    }
    
    var topRatedMovies: AnyPublisher<[MovieRepoModel], Never> {
        networkDataSource
            .topRated
            .combineLatest(userDefaultsPublisher)
            .map { movies, favoriteIds -> [MovieRepoModel] in
                movies.map { movie in
                    let isFavorite = favoriteIds.contains(movie.identifier)
                    return MovieRepoModel(fromModel: movie, isFavorite: isFavorite)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<MovieRepoModel, Never> {
        networkDataSource
            .fetchMovieDetails(for: movieId)
            .combineLatest(userDefaultsPublisher)
            .map { movie, favoriteArray -> MovieRepoModel in
                let isFavorite = favoriteArray.contains(movie.identifier)
                return MovieRepoModel(fromModel: movie, isFavorite: isFavorite)
            }
            .eraseToAnyPublisher()
    }

    func fetchCast(for movieId: Int) -> AnyPublisher<[CastRepoModel], Never> {
        networkDataSource
            .fetchCast(for: movieId)
            .map { $0.map { CastRepoModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }
    
    func fetchCrew(for movieId: Int) -> AnyPublisher<[CrewRepoModel], Never> {
        networkDataSource
            .fetchCrew(for: movieId)
            .map { $0.map { CrewRepoModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }
    
    func fetchRecommendations(for movieId: Int) -> AnyPublisher<[MovieRepoModel], Never> {
        networkDataSource
            .fetchRecommendations(for: movieId)
            .map { $0.map { MovieRepoModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }
    
    func fetchReviews(for movieId: Int) -> AnyPublisher<[ReviewRepoModel], Never> {
        networkDataSource
            .fetchReviews(for: movieId)
            .map { $0.map { ReviewRepoModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }
    
    func fetchMovies(searchQuery: String) -> AnyPublisher<[MovieRepoModel], Never> {
        networkDataSource
            .fetchMovies(searchQuery: searchQuery)
            .map { $0.map { MovieRepoModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }
    
    func toggleFavorite(_ movieId: Int) {
        userDefaultsDataSource.toggleFavorite(movieId)
    }
    
    func getMoviesPublisher(for category: LocalCategory, genreId: Int) -> AnyPublisher<[MovieRepoModel], Never> {
        switch category {
        case .popular:
            return popularMovies
                .map { $0.filter { $0.genreIds?.contains(genreId) ?? false } }
                .eraseToAnyPublisher()
        case .topRated:
            return topRatedMovies
                .map { $0.filter { $0.genreIds?.contains(genreId) ?? false } }
                .eraseToAnyPublisher()
        case .trending:
            return trendingMovies
                .map { $0.filter { $0.genreIds?.contains(genreId) ?? false } }
                .eraseToAnyPublisher()
        }
    }
    
    func getMovie(with movieId: Int) -> MovieRepoModel? {
        categoryMovies
            .values
            .flatMap { $0 }
            .first(where: { $0.identifier == movieId })
    }
    
    var favoriteMovies: AnyPublisher<[MovieRepoModel], Never> {
        userDefaultsDataSource
            .favorites
            .flatMap { [weak self] favoriteMovieIds -> AnyPublisher<[MovieDataModel], Never> in
                guard let self = self else { return .empty() }
                
                let movieDataModelPublishers = favoriteMovieIds.map {
                    self.networkDataSource.fetchMovieDetails(for: $0)
                }
                return Publishers
                    .MergeMany(movieDataModelPublishers)
                    .collect()
                    .eraseToAnyPublisher()
            }
            .map { $0.map { MovieRepoModel(fromModel: $0, isFavorite: true) } }
            .eraseToAnyPublisher()
    }
    
}
